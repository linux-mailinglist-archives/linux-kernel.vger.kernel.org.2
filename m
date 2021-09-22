Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710494140DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 06:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhIVEyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 00:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhIVEyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 00:54:02 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87622C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 21:52:33 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id 10so950484uae.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 21:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpuuIXY3YT8zX08OIyc5AYDl7AvmqE1AVfLy03ll3n8=;
        b=JHCOYIumug81g1pht6WTo5kjc6d4/NTLpa7+BViaYWlqiSY9z89OyTPjWq/lTUGomr
         +2Bzh1jJS30VO+LQaXXoNg9flrm7lbWJcltpv0RGSIM4D8XU+8/4sJciw3sUS0sJJN1v
         J8ecn+qL2Z1vMpefKcHeSlPMpMRd2wXsGM/i3/1xvyNmL90AVCtRyAJNdr85YvbVA0RF
         N+kzAyQBcdATviRRGxzl6htqYfjNdq6qESANXL1g+mN1Ic6Mv6sXeN5/Mi6O5CPbCuuQ
         K/krKPwu2hNp6rEE64QnCaSDm7TD2Sz2msKEKJ0wayZIOisQQBNZ54ornmBmgG2L3hlM
         A17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpuuIXY3YT8zX08OIyc5AYDl7AvmqE1AVfLy03ll3n8=;
        b=Nv6YjFnChpTBvn2Lv7lvLi+k/NXr162hfoVHU2VO0UrYObRyuIR4c9E245oaWFZb6M
         zHLGGgNlqQFpPawAcxb6ws2u5jRfOK84ksUGTZbJ+hSToDw127up/XLtLnoxUOymfJOt
         TL6WvCzhfzM0NYJpWJ0kNx/Doae1wtL6tVkvxwsHZhuIE7gFrU0ZKVojwkV4PU+HvIDq
         tGn+zavDMpRH9d0AvpdxuKbHDmW/k/mQUOwSvt3C3wHA36whAYn9YmLE/Ri80sirdhuZ
         W+ZoleWRKgJeWwLXhwynGnbQ4NsBiyhwxPORtUIRn1Sq0VPY9kaXAW+gjr9WAK3+pqvB
         248g==
X-Gm-Message-State: AOAM5320Zp7jfQA9I/+xp59RZC/jBEIU87J2ElFi/v0KyUCfyW6cAm/0
        SQiZYqKkqzEEakpZTvhPbLqOpvArosML6vpsBOI4X7Wy
X-Google-Smtp-Source: ABdhPJxMsdcu4/kqS9K8SS4JsNXoInkAazaejR1y6/SeuyBwVgylNLF9U+PdTlQuIXhMuSqQ9ZVMJU52K5c95U4kOcI=
X-Received: by 2002:ab0:5448:: with SMTP id o8mr4536523uaa.59.1632286352648;
 Tue, 21 Sep 2021 21:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <1632130171-472-1-git-send-email-anshuman.khandual@arm.com>
 <YUirurhvmBPCOsS+@arm.com> <127b2334-5c40-1b71-e510-ac837c3ac614@arm.com>
In-Reply-To: <127b2334-5c40-1b71-e510-ac837c3ac614@arm.com>
From:   Itaru Kitayama <itaru.kitayama@gmail.com>
Date:   Wed, 22 Sep 2021 13:52:21 +0900
Message-ID: <CANW9uyveSs-+DgGr87jYtruYcS7_FMxS=VD7mM4-G8NNcqBqNQ@mail.gmail.com>
Subject: Re: [PATCH V2] arm64/mm: Add pud_sect_supported()
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How did you test the 16K page size configurations? In QEMU? I wasn't
aware of hardware that's capable 16KB page size.

On Wed, Sep 22, 2021 at 1:47 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 9/20/21 9:11 PM, Catalin Marinas wrote:
> > On Mon, Sep 20, 2021 at 02:59:31PM +0530, Anshuman Khandual wrote:
> >> Section mapping at PUD level is supported only on 4K pages and currently it
> >> gets verified with explicit #ifdef or IS_ENABLED() constructs. This adds a
> >> new helper pud_sect_supported() for this purpose, which particularly cleans
> >> up the HugeTLB code path. It updates relevant switch statements with checks
> >> for __PAGETABLE_PMD_FOLDED in order to avoid build failures caused with two
> >> identical switch case values in those code blocks.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >
> > Assuming that you tested the corresponding configurations,
>
> Right, I did test this on all page size and VA bits configurations
> , including the specific ones which were problematic.
>
> >
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
