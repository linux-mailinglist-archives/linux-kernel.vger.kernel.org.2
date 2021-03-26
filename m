Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0B634A8F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 14:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhCZNuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 09:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229976AbhCZNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616766583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OEnn8bd6lr+qtup9/k0dDhgruQ7f47v/nXPyuUZSu18=;
        b=IKjx64FMI/V2jGNjj7Hz99yv3PuKa/P3gxmO1v/JT7r/TpygipRUFvAq9orFRJemHrulE1
        1GxyiMaRFgsk0KuCNScnLCAq2JmKK6Xnx9aPu2aWp9RPC47DHUVn+nTkoIIsJMapsjeVSr
        iVBtNODT0/t3fBQ4Ozb+KsMM07J764I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-I31qHe6AMs6npWBWj5dXkQ-1; Fri, 26 Mar 2021 09:49:39 -0400
X-MC-Unique: I31qHe6AMs6npWBWj5dXkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1216110925AB;
        Fri, 26 Mar 2021 13:48:53 +0000 (UTC)
Received: from [10.36.112.81] (ovpn-112-81.ams2.redhat.com [10.36.112.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABCC479445;
        Fri, 26 Mar 2021 13:48:51 +0000 (UTC)
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Andrey Konovalov <andreyknvl@gmail.com>
References: <20210326112650.307890-1-slyfox@gentoo.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH] mm: page_alloc: ignore init_on_free=1 for page alloc
Message-ID: <4e23d404-5125-6c9c-4aa7-5eff0fa1ba33@redhat.com>
Date:   Fri, 26 Mar 2021 14:48:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210326112650.307890-1-slyfox@gentoo.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.21 12:26, Sergei Trofimovich wrote:
> init_on_free=1 does not guarantee that free pages contain only zero bytes.
> 
> Some examples:
> 1. page_poison=on takes presedence over init_on_alloc=1 / ini_on_free=1

s/ini_on_free/init_on_free/

> 2. free_pages_prepare() always poisons pages:
> 
>         if (want_init_on_free())
>             kernel_init_free_pages(page, 1 << order);
>         kernel_poison_pages(page, 1 << order

In next/master, it's the other way around already.

commit 855a9c4018f3219db8be7e4b9a65ab22aebfde82
Author: Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu Mar 18 17:01:40 2021 +1100

     kasan, mm: integrate page_alloc init with HW_TAGS


> 
> I observed use of poisoned pages as the crash on ia64 booted with
> init_on_free=1 init_on_alloc=1 (CONFIG_PAGE_POISONING=y config).
> There pmd page contained 0xaaaaaaaa poison pages and led to early crash.
> 
> The change drops the assumption that init_on_free=1 guarantees free
> pages to contain zeros.
> 
> Alternative would be to make interaction between runtime poisoning and
> sanitizing options and build-time debug flags like CONFIG_PAGE_POISONING
> more coherent. I took the simpler path.
> 

I thought latest work be Vlastimil tried to tackle that. To me, it feels 
like page_poison=on  and init_on_free=1 should bail out and disable one 
of both things. Having both at the same time doesn't sound helpful.

> Tested the fix on rx3600.

Fixes: ?


-- 
Thanks,

David / dhildenb

