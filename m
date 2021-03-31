Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1455C34F96B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhCaHFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233838AbhCaHFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617174314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6N7GiVmqEJRvoV1p5fz+NmwpWE3z9J1xqGS79m5DJhc=;
        b=Gl5QQl38QB96KsQ7qCDqKdOzqZJQhYku8QDH7BpGSk6i/gR3tiCDfidoqc6YXpDYjO2dXd
        fPqB06d8eI5OGBh3KEfdJXQTUwZS03uKtqBQYa9Ct23cdnctoROrDQ+uf0IBoqdRJ/YHjY
        rhDzXeyQ+0IvWqoYLEVMw1d2uyaJAfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-vEaS9JAPNlqxBAZtOciUbQ-1; Wed, 31 Mar 2021 03:05:12 -0400
X-MC-Unique: vEaS9JAPNlqxBAZtOciUbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBAB7817469;
        Wed, 31 Mar 2021 07:05:10 +0000 (UTC)
Received: from [10.36.113.60] (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8146C5044A;
        Wed, 31 Mar 2021 07:05:07 +0000 (UTC)
Subject: Re: [PATCH v5] mm/gup: check page hwposion status for coredump.
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Matthew Wilcox <willy@infradead.org>
Cc:     Aili Yao <yaoaili@kingsoft.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
 <20210318044600.GJ3420@casper.infradead.org>
 <20210318133412.12078eb7@alex-virtual-machine>
 <20210319104437.6f30e80d@alex-virtual-machine>
 <20210320003516.GC3420@casper.infradead.org>
 <20210322193318.377c9ce9@alex-virtual-machine>
 <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
 <f316ca3b-6f09-c51d-9661-66171f14ee33@redhat.com>
 <20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp>
 <20210331060739.GW351017@casper.infradead.org>
 <20210331065341.GA28793@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b209732d-25ce-2974-4637-7c4fdb297fc3@redhat.com>
Date:   Wed, 31 Mar 2021 09:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210331065341.GA28793@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.21 08:53, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, Mar 31, 2021 at 07:07:39AM +0100, Matthew Wilcox wrote:
>> On Wed, Mar 31, 2021 at 01:52:59AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
>>> If we successfully unmapped but failed in truncate_error_page() for example,
>>> the processes mapping the page would get -EFAULT as expected.  But even in
>>> this case, other processes could reach the error page via page cache and
>>> __get_user_pages_locked() for them could return the hwpoisoned page.
>>
>> How would that happen?  We check PageHWPoison before inserting a page
>> into the page tables.  See, eg, filemap_map_pages() and __do_fault().
> 
> Ah, you're right, that never happens. I misread the code.
> Thanks for correcting me.
> 

I'm wondering if there is a small race window, if we poison a page while 
inserting it.

-- 
Thanks,

David / dhildenb

