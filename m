Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB6E34AE84
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhCZSYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230316AbhCZSYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616783070;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sqgoE7oUkWi10dRfiKf4O0yLFX/FHCjCOBZ7f/F44Jg=;
        b=GnF/CX+duq4rPTvkvMHH2MqB8L5Et/Tu/5f1W5DismnmoN2tViw1NC+TaP3E9nyTwlB6lb
        c6/FLqJ2/o7H3mDQxy2H6OopYC4r9TWNvvjUq5jgpqLwgPKeXJPLDltCuP7Z/JeLYpEMEa
        5ybRTYMsxHnCXXb02ATikhe9NPD7lU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-9o3difxnMi2VTAOjuBaKEA-1; Fri, 26 Mar 2021 14:23:45 -0400
X-MC-Unique: 9o3difxnMi2VTAOjuBaKEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AFC58A2A15;
        Fri, 26 Mar 2021 18:23:40 +0000 (UTC)
Received: from crecklin.bos.csb (ovpn-112-25.rdu2.redhat.com [10.10.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0500819C71;
        Fri, 26 Mar 2021 18:23:39 +0000 (UTC)
Reply-To: crecklin@redhat.com
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Chris von Recklinghausen <crecklin@redhat.com>
Subject: tools/testing/radix-tree/idr-test gets a failed assertion on single
 cpu systems
Organization: Red Hat
Message-ID: <def0fd33-da11-6283-d98f-66eb9a8dd201@redhat.com>
Date:   Fri, 26 Mar 2021 14:23:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

I made the observation that while tools/testing/radix-tree/idr-test runs 
and passes just fine on a system with more than one cpu, it gets an 
assertion failure when run on a single cpu system. My test system is 
Fedora 34 running on an x86_64 system. It can be easily reproduced by 
offlining all cpus but cpu0.

[root@hpe-ml110g7-01 linux]# tools/testing/radix-tree/idr-test
vvv Ignore these warnings
assertion failed at idr.c:250
assertion failed at idr.c:206
^^^ Warnings over
idr-test: idr-test.c:320: idr_find_test_1: Assertion `!(entry != 
xa_mk_value(id))' failed.
Aborted (core dumped)

I bisected the change to 5c089fd0c734 ("idr: Fix idr_get_next race with 
idr_remove").

Since idr_get_next can return NULL, I stuck a BUG_ON(!entry) just above 
the failing assert, and in this case idr_get_next is returning NULL.

Next, I stuck a BUG_ON in the place that idr_get_next_ul returns NULL 
and commented out the contents of idr_u32_test1 so we're not knowingly 
passing it bad values, and we seem to fail because the list has been 
gone through.

void *idr_get_next_ul(struct idr *idr, unsigned long *nextid)
{
     struct radix_tree_iter iter;
     void __rcu **slot;
     void *entry = NULL;
     unsigned long base = idr->idr_base;
     unsigned long id = *nextid;

     id = (id < base) ? 0 : id - base;
     radix_tree_for_each_slot(slot, &idr->idr_rt, &iter, id) {
         entry = rcu_dereference_raw(*slot);
         if (!entry)
             continue;
         if (!xa_is_internal(entry))
             break;
         if (slot != &idr->idr_rt.xa_head && !xa_is_retry(entry))
             break;
         slot = radix_tree_iter_retry(&iter);
     }
     if (!slot)
         return NULL; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

     *nextid = iter.index + base;
     return entry;
}
EXPORT_SYMBOL(idr_get_next_ul);

I'm not sure if this is a test issue or possibly an issue with user 
level RCU when there's only a single cpu in the system, but I figured it 
was worth bringing it to your attention. If there's anything I can do to 
help to further analyze this or try out a fix, I'm happy to help.

Thanks,

Chris von Recklinghausen

Red Hat

