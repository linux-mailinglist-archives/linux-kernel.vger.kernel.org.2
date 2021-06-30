Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A219D3B7E04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhF3H3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232785AbhF3H3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625037998;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w01xQoKIk2OT2hjqFE0H+ABHTU1Y/cIH/ehDlw87LCU=;
        b=b3JjjRLlVhCCYYG2rduBJMcnTQ2YPA4V9nvqVnq28C+XwhImFjQfGgPeKypE+AgMU/n0Ig
        wYDmwSV4p1Dr9M7b1nF86kqXPoTwgPC0wYpjqV7NQr1Mea7KvEyDOQ/kfOTIRQsKPmyiiK
        yx0kQxjT6nuMiLxG9HHDe+bt6dfCXno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-E5ZGt5ylOBKKgwIq1BVj0g-1; Wed, 30 Jun 2021 03:26:36 -0400
X-MC-Unique: E5ZGt5ylOBKKgwIq1BVj0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35F42804144;
        Wed, 30 Jun 2021 07:26:35 +0000 (UTC)
Received: from [10.64.54.132] (vpn2-54-132.bne.redhat.com [10.64.54.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9B8960854;
        Wed, 30 Jun 2021 07:26:33 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5] Documentation, dt, numa: Add note to empty NUMA node
To:     Randy Dunlap <rdunlap@infradead.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, drjones@redhat.com,
        robh+dt@kernel.org, shan.gavin@gmail.com
References: <20210628093411.88805-1-gshan@redhat.com>
 <89e25fd7-b323-2092-4151-faba060d4c10@infradead.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <84bdacaa-ad54-9452-122a-0fb98c805953@redhat.com>
Date:   Wed, 30 Jun 2021 17:26:30 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <89e25fd7-b323-2092-4151-faba060d4c10@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/21 2:15 AM, Randy Dunlap wrote:
> On 6/28/21 2:34 AM, Gavin Shan wrote:
>> The empty memory nodes, where no memory resides in, are allowed.
>> For these empty memory nodes, the 'len' of 'reg' property is zero.
>> The NUMA node IDs are still valid and parsed, but memory may be
>> added to them through hotplug afterwards. I finds difficulty to
>> get where it's properly documented.
>>
>> So lets add a section for empty memory nodes in NUMA binding
>> document. Also, the 'unit-address', equivalent to 'base-address'
>> in the 'reg' property of these empty memory nodes is suggested to
>> be the summation of highest memory address plus the NUMA node ID.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> v5: Separate section for empty memory node
>> ---
>>   Documentation/devicetree/bindings/numa.txt | 61 +++++++++++++++++++++-
>>   1 file changed, 60 insertions(+), 1 deletion(-)
>>
> 
> LGTM. Thanks.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 

Thanks, Randy. Rob, could you help to review? Thanks in advance.

Thanks,
Gavin

