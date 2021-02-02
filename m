Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C780830B7F3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 07:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhBBGmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 01:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhBBGmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 01:42:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06FBC061573;
        Mon,  1 Feb 2021 22:41:28 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id b145so6885881pfb.4;
        Mon, 01 Feb 2021 22:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=rC09dL3t0JmuXKRGS11QfpT22mY/bCGC3yvB+dUe0fk=;
        b=PWite5q3ilvWPrNzABf1n2ObHEBeUkcRaH7O0mz9AUYo+3gOXj1emeuovYEtUxa40D
         Pprs3M/4nSbG5F422bG4VwKat8Yp6XPMULl2rGLdYqtHigSUo61/0wIy78mG+4EzglQp
         lVpv80EHwoEh1xUNYr4+xQm4xm1O4J5JMT974md8qoEZNixRctDEXLd3PlFg4Lo4Wm5U
         9GDmEgEdFw09Kn10gxC6lSyxDMixod5KD0FStaEkanlSCWPLmLZNDxsNG6BkKW+2qSG5
         ITkh8hkgQvpJ541DDIyNaR1Gmci80t/qg+3wM0UTKUpsB32nnu9zSJJOIw5EswRPmx1+
         o8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=rC09dL3t0JmuXKRGS11QfpT22mY/bCGC3yvB+dUe0fk=;
        b=JvePkou+chIngZKpNXDwvN/gRdBQ7Xgtft43N/IQzE3Z6bAasBSF/UrtLtkTZjUjuF
         8KuM09k0vnAObkpDP65BV3UAQewgFRfVx4kRnUvwLxyCG8cM3fNQpJ3NVjJuZPlrsM2x
         MoTErD7f4fjamobteMwL24wZCuBqQA06e8C3emI4o3CupOxYB7SKY+zkgAOxFSj2EFjT
         zyAcBCrKapULB/OO2pQa5E4F60lBgIJTUyJDBf0hfvLOYET94v6ZWBvlaU0NvOqhGE5P
         vXTTKRIlZY7diqt+njpW1PaGz0G4VIIWqo19y+jZMtV0bDTHnt6N1n4+tVG5wDaTfYg2
         yLnQ==
X-Gm-Message-State: AOAM533/az3aYpvWjggA0yYz9ovQecMU9H6Ezxyf9l9AEkWHNeFGY65c
        hYzRG4u/d5B4UWwlOFv05YQ=
X-Google-Smtp-Source: ABdhPJyaqrVbEaywPer83Q1yamTBUdgzhSLBAu5yKXicZ9+owt7LJ3m0errPFW51m0M7fMC12YcztQ==
X-Received: by 2002:a62:7694:0:b029:1b9:8d43:95af with SMTP id r142-20020a6276940000b02901b98d4395afmr20512354pfc.2.1612248088518;
        Mon, 01 Feb 2021 22:41:28 -0800 (PST)
Received: from localhost (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id k10sm20969227pfk.0.2021.02.01.22.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 22:41:27 -0800 (PST)
Date:   Tue, 02 Feb 2021 16:41:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC 11/20] mm/tlb: remove arch-specific tlb_start/end_vma()
To:     Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>
References: <20210131001132.3368247-1-namit@vmware.com>
        <20210131001132.3368247-12-namit@vmware.com>
        <YBfvh1Imz6RRTUDV@hirez.programming.kicks-ass.net>
In-Reply-To: <YBfvh1Imz6RRTUDV@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1612247956.0a1r1yjmm3.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Peter Zijlstra's message of February 1, 2021 10:09 pm:
> On Sat, Jan 30, 2021 at 04:11:23PM -0800, Nadav Amit wrote:
>=20
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index 427bfcc6cdec..b97136b7010b 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -334,8 +334,8 @@ static inline void __tlb_reset_range(struct mmu_gath=
er *tlb)
>> =20
>>  #ifdef CONFIG_MMU_GATHER_NO_RANGE
>> =20
>> -#if defined(tlb_flush) || defined(tlb_start_vma) || defined(tlb_end_vma=
)
>> -#error MMU_GATHER_NO_RANGE relies on default tlb_flush(), tlb_start_vma=
() and tlb_end_vma()
>> +#if defined(tlb_flush)
>> +#error MMU_GATHER_NO_RANGE relies on default tlb_flush()
>>  #endif
>> =20
>>  /*
>> @@ -362,10 +362,6 @@ static inline void tlb_end_vma(struct mmu_gather *t=
lb, struct vm_area_struct *vm
>> =20
>>  #ifndef tlb_flush
>> =20
>> -#if defined(tlb_start_vma) || defined(tlb_end_vma)
>> -#error Default tlb_flush() relies on default tlb_start_vma() and tlb_en=
d_vma()
>> -#endif
>=20
> #ifdef CONFIG_ARCH_WANT_AGGRESSIVE_TLB_FLUSH_BATCHING
> #error ....
> #endif
>=20
> goes here...
>=20
>=20
>>  static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_s=
truct *vma)
>>  {
>>  	if (tlb->fullmm)
>>  		return;
>> =20
>> +	if (IS_ENABLED(CONFIG_ARCH_WANT_AGGRESSIVE_TLB_FLUSH_BATCHING))
>> +		return;
>=20
> Also, can you please stick to the CONFIG_MMU_GATHER_* namespace?
>=20
> I also don't think AGRESSIVE_FLUSH_BATCHING quite captures what it does.
> How about:
>=20
> 	CONFIG_MMU_GATHER_NO_PER_VMA_FLUSH

Yes please, have to have descriptive names.

I didn't quite see why this was much of an improvement though. Maybe=20
follow up patches take advantage of it? I didn't see how they all fit=20
together.

Thanks,
Nick
