Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8021644A985
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 09:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244428AbhKIIpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 03:45:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239772AbhKIIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636447380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nt9J4fSLMdODsCSzLW6IzJ8wlO7x+msZNl8HGhlgsR4=;
        b=TWoEWksqC/U7RrMwCg9fFSdEhM+68keUXiGFrcEPuO0Aij6G36SS1v4g+4hXZjOL7Cr909
        eIfVAy0Nkec0CNFKVWmm9zYUel5pxv4jYBFpyfLYt6Jo+KfqJJIN8Q4mEHmt6I5zBxdShl
        PkJ+7bmOUoCHq4F9ixmEISthgvIndKE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-EnNI4BJMOqWeOp8xQPrFiA-1; Tue, 09 Nov 2021 03:42:59 -0500
X-MC-Unique: EnNI4BJMOqWeOp8xQPrFiA-1
Received: by mail-wr1-f69.google.com with SMTP id p3-20020a056000018300b00186b195d4ddso4618060wrx.15
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 00:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nt9J4fSLMdODsCSzLW6IzJ8wlO7x+msZNl8HGhlgsR4=;
        b=WeJXOTR0lKJkvGvHc+Eu2HwJFqdVGTLwcI4fit5v3zK6PKUzo+L6DjExAuMKXB3wHO
         izE+E5wOC/h2lwfOtVvcUOt42g9j5mk6fhRkOwCr82SRDBgDsGx+GnV9zLDD0mDV4jAq
         RgfA6/xflvDuIGr7W6l6kyoJn4HG3eC+EuyUFLPLUTubjw6Dx97IlZ2Iib7AV+rIv020
         8H/XEqsW1vtY6srWc7QklF0+xVzP2TA09bSYvjcrUjf3SSuuRNfxMGWxVX1MIoTa+0Ct
         JogthIMCstYJwVT1n8TZzeP9taHk57T8jEJRRQ7bS5zTa4K42+Rfuau+yIqF2Cm9HFyN
         N4bg==
X-Gm-Message-State: AOAM531l6iqUK//DIsGxBbvR6p4f85QsTLczkvpyKVUKTSDVh1D3bs7r
        lRuc8U5PjWyCBu/3N+x91Y16s5AlkmHQA4aiWZSLBLs5Y/AGfBQOlcmrboy/uKpe1EGBPKUGT28
        UPzDpV/BfMOD258NlB0QqyrAz
X-Received: by 2002:a1c:4b0b:: with SMTP id y11mr5346830wma.9.1636447378081;
        Tue, 09 Nov 2021 00:42:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMB1sjzQ+HNZw0Uz4mqMrEPdjYUCJm6Y7oZEMZ4cLwW68YXm/WhyrBj+TLfB5Fbie9DtRlCg==
X-Received: by 2002:a1c:4b0b:: with SMTP id y11mr5346808wma.9.1636447377873;
        Tue, 09 Nov 2021 00:42:57 -0800 (PST)
Received: from [192.168.3.132] (p4ff23c2b.dip0.t-ipconnect.de. [79.242.60.43])
        by smtp.gmail.com with ESMTPSA id h15sm1838544wml.9.2021.11.09.00.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 00:42:57 -0800 (PST)
Message-ID: <af7ab3ce-fed2-1ffc-13a8-f9acbd201841@redhat.com>
Date:   Tue, 9 Nov 2021 09:42:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: + mm-fix-panic-in-__alloc_pages.patch added to -mm tree
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Cc:     amakhalov@vmware.com, cl@linux.com, dennis@kernel.org,
        mm-commits@vger.kernel.org, osalvador@suse.de,
        stable@vger.kernel.org, tj@kernel.org
References: <20211108205031.UxDPHBZWa%akpm@linux-foundation.org>
 <YYozLsIECu0Jnv0p@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YYozLsIECu0Jnv0p@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.21 09:37, Michal Hocko wrote:
> I have opposed this patch http://lkml.kernel.org/r/YYj91Mkt4m8ySIWt@dhcp22.suse.cz
> There was no response to that feedback. I will not go as far as to nack
> it explicitly because pcp allocator is not an area I would nack patches
> but seriously, this issue needs a deeper look rather than a paper over
> patch. I hope we do not want to do a similar thing to all callers of
> cpu_to_mem.

While we could move it into the !HOLES version of cpu_to_mem(), calling
cpu_to_mem() on an offline (and eventually not even present) CPU (with
an offline node) is really a corner case.

Instead of additional runtime overhead for all cpu_to_mem(), my take
would be to just do it for the random special cases. Sure, we can
document that people should be careful when calling cpu_to_mem() on
offline CPUs. But IMHO it's really a corner case.

-- 
Thanks,

David / dhildenb

