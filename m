Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B02D3D5B75
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhGZNfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbhGZNfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:35:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE8C0619D0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 07:14:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so153225pji.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tqcfKku5K+eKMzm3aYDMoAoIervJKFFLo6d93VoXYDk=;
        b=B5mv7NbuM+bJ4uOSp6pSJmB18zx7GeFdn7xwAzYShskM4NsJ09S8WdJELexxrgbF3X
         I6kIpQ2vIAoacFW/4frb/g0BmSDgLb1Uv7YfOT7cvgetOzWPH6N5VKc2A28huUYxgd6E
         dMHYIw0TTZI787yyl40eLUqByk4IHn4Lx7ueGZOfL+eP1Ir0RbbVO4UOQqNKwhEM6Yo0
         YM9nZioh/yw5A/ZVIZmS39sAmDHDGjoqb3MV7zvYu/7PguikkpzVU16WbiRNnm0CN1Xm
         aCB8Zngl8mCcZ5uCrNiQAWaC+fznmqU0T9hmQ6XwcL+au+VCA0qfJA037yKFMVBd/MbM
         fRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tqcfKku5K+eKMzm3aYDMoAoIervJKFFLo6d93VoXYDk=;
        b=OhLMZHiE0HGOhMeb8eeVneE1hk2Q7c1s14TSKS4oxR3p/zdUQutWY4CrR5xKWuhAaS
         C9JWJS5DyOIeI+YUNIlKkOmEOEpN+OaxYr0iWhFNxHKvzCyAarA2Gjubk9eVm0Kush9b
         IOFtqOXSC+3Vnes1wLIBkCCfvBYmTs08ZWyiDpz5Xb+7tFlAEfC3fFJbbsUabxzihW7J
         NlUVvsRTcw8aU0Ah/f2nhj9/nT5xja4uJT48DxqB9NVfaXJ9QbnWBBGS7x+2JbQXPW7K
         iIKOlpmG+v/WhMewb5OxCvzWVVoefuLKOIvX11bjTKXYdZ59d4IH5LT2oKQ52JbsBUdc
         GJSQ==
X-Gm-Message-State: AOAM531SnJJMZz1bZkbD/HXeAAzuMO9x5lHBEbHuL3KpTqUGeUlUoE/e
        h/uxFwkGnUtivlybh5luyeI=
X-Google-Smtp-Source: ABdhPJzsvhz+FApIdsOFnzCDjuFiU5Nxw25rZAPrAKaxEERtMHP8FJdg+aTEHwGt2Xh3auhDUhzhXw==
X-Received: by 2002:a63:149:: with SMTP id 70mr927166pgb.413.1627308851703;
        Mon, 26 Jul 2021 07:14:11 -0700 (PDT)
Received: from [0.0.0.0] (jp.bgp.twd2.net. [2a0c:b641:571::1])
        by smtp.gmail.com with ESMTPSA id n12sm47958388pgr.2.2021.07.26.07.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 07:14:11 -0700 (PDT)
Subject: Re: [PATCH] m68k: Remove redefinitions of `PMD_SIZE`, `PMD_MASK`,
 etc.
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
References: <20210721104318.1070133-1-twd2.me@gmail.com>
 <CAMuHMdUWvnz4jCyPctZevq8MdFtCD8MCNSfDbCVR+__rP_=gvw@mail.gmail.com>
From:   twd2 <twd2.me@gmail.com>
Message-ID: <117080be-e587-a734-bc6f-8c57488db9dc@gmail.com>
Date:   Mon, 26 Jul 2021 22:14:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUWvnz4jCyPctZevq8MdFtCD8MCNSfDbCVR+__rP_=gvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/26 17:23, Geert Uytterhoeven wrote:
> Hi Wende,
>
> On Wed, Jul 21, 2021 at 12:44 PM Wende Tan <twd2.me@gmail.com> wrote:
>> Remove redefinitions of `PMD_SIZE`, `PMD_MASK`, `PTRS_PER_PMD`,
>> and `__PAGETABLE_PMD_FOLDED` when PGTABLE_LEVELS == 2 (i.e. SUN3 ||
>> COLDFIRE).  They have already been defined in
>> `asm-generic/pgtable-nopmd.h`.
> Thanks for your patch!
>
>> See also https://lore.kernel.org/lkml/202107201907.lqC6B3dF-lkp@intel.com/#t
> I'm a bit confused: is this a new issue introduced by the patch from
> the above thread, or is this a pre-existing issue?
> If the latter, do you know when it was introduced, and how to reproduce it?


I think this is a pre-existing issue, introduced in
commit 60e50f34b13e ("m68k: mm: use pgtable-nopXd instead of 4level-fixup") .
This commit replaced the usage of `4level-fixup.h` in `pgtable_mm.h` to
`pgtable-nop*d.h` and removed the redundent definition of `PMD_SHIFT` but
forgot to clean up other macros like `PMD_SIZE` (it should be moved into
the `#if` condition) [1].

And, GCC will not complain until two definitions of a macro with the same
name differ (as the above thread changes `1UL` to `_UL(1)`), hiding this
issue.

[1] https://github.com/torvalds/linux/commit/60e50f34b13e9e40763be12aa55f2144d8da514c#diff-9ec45948bad35c0e35d0c2d301a2a643336ff8fe2ee8ea3fff19d8f0bb948a46L34

Thanks.
Wende


>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Wende Tan <twd2.me@gmail.com>
> Gr{oetje,eeting}s,
>
>                         Geert
>
