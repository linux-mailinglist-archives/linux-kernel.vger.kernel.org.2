Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6D13D04FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 01:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhGTW0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231670AbhGTW0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626822437;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztgVvJxRpaDFgXRdUSCFV+ku7s6Onq7aqmb9J+83zrg=;
        b=XTmVbD1kIueT+bIKStqc8zDc+ru76wI/7HgvkKNTobkKdNgVUZaHbUf+8n3D6oidGELDQZ
        evF+DlvZm9MEQARFj38hW+uyFnmtgoaxBIQ6RlTVLLaK972xfvnPYf1gC14YjRzyQFHNwT
        5b3JJr4XhbKTGsqPg/HGxzLF35yK25U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-8IeK1yH4PqCH-JylQYHArw-1; Tue, 20 Jul 2021 19:07:14 -0400
X-MC-Unique: 8IeK1yH4PqCH-JylQYHArw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08D4818D6A25;
        Tue, 20 Jul 2021 23:07:13 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECAD419C59;
        Tue, 20 Jul 2021 23:07:10 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 01/12] mm/debug_vm_pgtable: Introduce struct
 vm_pgtable_debug
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, shan.gavin@gmail.com,
        chuhu@redhat.com
References: <20210706061748.161258-1-gshan@redhat.com>
 <20210706061748.161258-2-gshan@redhat.com>
 <a74549ac-6794-25a0-7238-2591745e6810@arm.com>
 <65dbdc03-dd34-570c-6beb-7497855b5c8e@redhat.com>
 <1e39cb49-21d8-7114-4ffa-237c6fa19de9@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <fc9eaaf0-cf3d-b4d4-70de-57e14f42f0bd@redhat.com>
Date:   Wed, 21 Jul 2021 09:07:26 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1e39cb49-21d8-7114-4ffa-237c6fa19de9@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/20/21 5:02 PM, Anshuman Khandual wrote:
> On 7/19/21 11:09 AM, Gavin Shan wrote:
>> On 7/14/21 4:24 PM, Anshuman Khandual wrote:
>>> On 7/6/21 11:47 AM, Gavin Shan wrote:
>>
>> Thanks for your review. I will take all your suggestion if it's applicable.
>> Otherwise, I will explain as below. All changes will be included in v2,
>> which will be posted pretty soon.
> 
> You revised the series couple of times before I could even respond
> here :) Anyways, I will jump to V3 directly and continue reviewing
> from there.
> 

Yep. Sorry for the noises. Please review v3 directly. By the way,
It seems Andrew start to integrate (v3) series. I personally still
hope v3 (or perhaps v4) is going to be merged in 5.14 cycle :)

Thanks,
Gavin

