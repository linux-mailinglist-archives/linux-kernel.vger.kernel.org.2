Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B22399818
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFCCjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28298 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229620AbhFCCji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622687874;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eUYE0hKN7YEQF+2Ypg+MzgNttYvXIr9euaI0jYyales=;
        b=P06mWqCFou3A0CIwRwwS6iGb/fdK4MZxemDcmnREzyv6iBvI6fyF4MJGyvRfwZ+ny2GDdO
        f+b7gR5mKQ+/qOptW+RHSFfaJhouLW7VcgBBKxcFIncclIDV45pByKYXdXbJyRiIghCzty
        5GJNnJpKZseFpuzM5ZtIsBdlxtidzSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-ARxJlbgbO0yi7ZDTXMoQJA-1; Wed, 02 Jun 2021 22:37:50 -0400
X-MC-Unique: ARxJlbgbO0yi7ZDTXMoQJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B202C100945E;
        Thu,  3 Jun 2021 02:37:49 +0000 (UTC)
Received: from [10.64.54.205] (vpn2-54-205.bne.redhat.com [10.64.54.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F7CA163C3;
        Thu,  3 Jun 2021 02:37:47 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
To:     robh@kernel.org
Cc:     Andrew Jones <drjones@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shan Gavin <shan.gavin@gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Subject: [Question] Format of memory node name
Message-ID: <ed20264b-1fe3-59e2-7c95-d1a224d22b7f@redhat.com>
Date:   Thu, 3 Jun 2021 14:38:50 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Currently, I'm looking into one QEMU bug which is related to FDT memory
nodes. The story is 4 NUMA nodes are specified by the command line, which
is used to start the VM. QEMU needs to create 4 FDT memory nodes for them
and their names are following the format (memory@unit-address) as stated
in the device-tree specification. The 'unit-address' is base address in
'reg' property. Unfortunately, one NUMA node's base address is exactly
same to another one. It means there are two conflicting two memory node
because of their names. It leads to the FDT can't be populated successfully.

For example, the last memory node can't be created because of its conflicting
name in the following scheme.

    NUMA ID       Base address       End address      Memory node name
    -------------------------------------------------------------------
    0             0x00000000         0x20000000       memory@00000000
    1             0x20000000         0x40000000       memory@20000000
    2             0x40000000         0x40000000       memory@40000000
    3             0x40000000         0x40000000       memory@40000000

I'm trying to resolve the issue. There are two options as below. However,
it's not certain the solution will beak the device-tree specification. So
I'm checking with you on this.

(1) Replace the 'unit-address' with NUMA ID
     memory@0
     memory@1
     memory@2
     memory@3

(2) Add suffix to the conflicting memory node names
     memory@00000000
     memory@20000000
     memory@40000000
     memory@40000000-0

Thanks,
Gavin

[link] https://patchwork.kernel.org/project/qemu-devel/patch/20210601073004.106490-1-gshan@redhat.com/

