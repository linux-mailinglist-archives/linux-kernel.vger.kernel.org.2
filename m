Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3436343614
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 01:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhCVAzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 20:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhCVAzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 20:55:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F52EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 17:55:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w11so5661520ply.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 17:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=YhjptOa1YLY02YG0NxjiEXQDPMTypn5KHITe161ubW8=;
        b=XjyhafFAg3wXva8WM5LObDDfgCIfrUS6S3ztJ28AyYH/b2GPcOTLtgLxtWECmkpr7l
         vGJZHDY1tif2FC7KyD8ToeYPd4bK/ePagyiqCdBq4UAIjnJF50hIlo6EayblM8ugIYFx
         GZ9LLX+CzSqud+1wJjwvebJKayc9NoySTnoh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YhjptOa1YLY02YG0NxjiEXQDPMTypn5KHITe161ubW8=;
        b=Gjn4crdQ0n2kY9yUJK0B+nSUDFKD1wdV9jqI/5+y8vOpXMiyjQCWtLNoNqXwdZLU4p
         Pw/b8I86v1NfLV9HBmeq0ReaMrnzMFBORC1tFGQKDtBg1S6oD3/HFRmngjkv2neKux8A
         L2UjTKqzer+nrml1AMQMHB4bFdWcw4EXh93klX3YiBoRw3zWqPVDVSRLlwBFFGvpb0Ru
         vR2jp6H0udGk6hdYOFG8zRnMhUW9w1EHBmn0SPEsK1lPp/9XGaKROyjLhPPmbSgouVfU
         9wa0jahzLxfI56zT4kAryf+mHSIxw9UHcGQ+Dg2cjyyfqW1W6TkoTNKp1hstpKaXmIlM
         SXTg==
X-Gm-Message-State: AOAM5329/xHB/+vsZ1ozRtWUMz3d4JJAvLVJThR6CnopYffQPXTiGizU
        Y02ujJxHppyYeTaQeHCgELF6Fg==
X-Google-Smtp-Source: ABdhPJzRcD3yNsaQ3jmRQ0MduvBzp8dYAxJ2WA2adD1Mh26gwWUxEkRCqKjrQfqNc13bL5NgiJ09qg==
X-Received: by 2002:a17:902:e546:b029:e5:ec5e:6bf4 with SMTP id n6-20020a170902e546b02900e5ec5e6bf4mr24400618plf.41.1616374511814;
        Sun, 21 Mar 2021 17:55:11 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-b0f2-84a1-ce9a-a0fd.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b0f2:84a1:ce9a:a0fd])
        by smtp.gmail.com with ESMTPSA id j21sm11603072pfc.114.2021.03.21.17.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 17:55:11 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v11 6/6] powerpc: Book3S 64-bit outline-only KASAN support
In-Reply-To: <20210320060259.GF77072@balbir-desktop>
References: <20210319144058.772525-1-dja@axtens.net> <20210319144058.772525-7-dja@axtens.net> <20210320060259.GF77072@balbir-desktop>
Date:   Mon, 22 Mar 2021 11:55:08 +1100
Message-ID: <87o8fcatxv.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

> Could you highlight the changes from
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20170729140901.5887-1-bsingharora@gmail.com/?
>
> Feel free to use my signed-off-by if you need to and add/update copyright
> headers if appropriate.

There's not really anything in common any more:

 - ppc32 KASAN landed, so there was already a kasan.h for powerpc, the
   explicit memcpy changes, the support for non-instrumented files,
   prom_check.sh, etc. all already landed.

 - I locate the shadow region differently and don't resize any virtual
   memory areas.

 - The ARCH_DEFINES_KASAN_ZERO_PTE handling changed upstream and our
   handling for that is now handled more by patch 3.

 - The outline hook is now an inline function rather than a #define.

 - The init function has been totally rewritten as it's gone from
   supporting real mode to not supporting real mode and back.

 - The list of non-instrumented files has grown a lot.

 - There's new stuff: stack walking is now safe, KASAN vmalloc support
   means modules are better supported now, ptdump works, and there's
   documentation.

It's been a while now, but I don't think when I started this process 2
years ago that I directly reused much of your code. So I'm not sure that
a signed-off-by makes sense here? Would a different tag (Originally-by?)
make more sense?

>> + * The shadow ends before the highest accessible address
>> + * because we don't need a shadow for the shadow. Instead:
>> + * c00e000000000000 << 3 + a80e 0000 0000 0000 000 = c00fc00000000000
>
> The comment has one extra 0 in a80e.., I did the math and had to use
> the data from the defines :)

3 extra 0s, even! Fixed.

>> +void __init kasan_init(void)
>> +{
>> +	/*
>> +	 * We want to do the following things:
>> +	 *  1) Map real memory into the shadow for all physical memblocks
>> +	 *     This takes us from c000... to c008...
>> +	 *  2) Leave a hole over the shadow of vmalloc space. KASAN_VMALLOC
>> +	 *     will manage this for us.
>> +	 *     This takes us from c008... to c00a...
>> +	 *  3) Map the 'early shadow'/zero page over iomap and vmemmap space.
>> +	 *     This takes us up to where we start at c00e...
>> +	 */
>> +
>
> assuming we have
> #define VMEMMAP_END R_VMEMMAP_END
> and ditto for hash we probably need
>
> 	BUILD_BUG_ON(VMEMMAP_END + KASAN_SHADOW_OFFSET != KASAN_SHADOW_END);

Sorry, I'm not sure what this is supposed to be testing? In what
situation would this trigger?

Kind regards,
Daniel

>
> Looks good otherwise, I've not been able to test it yet
>
> Balbir Singh.
