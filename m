Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752B8426644
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhJHI51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhJHI5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:57:23 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C10C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 01:55:28 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id r15so544944qkp.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XxU7p1t2vpoUkds+Z7mgCZaRnwUz2A7ihwGXZAdD+IU=;
        b=fc2FLpKZzIJDjstSp6GLjBw4e2ZHSCTlZFd6xstLnhAeSppM99wXCw+PRxq3YGwR5n
         p9SICUYAyHFaqr7QefI3Dazg0WgTUPtFe0KFb1Yc62WXiaJVXyrEoiIJSCirlEakXFuG
         HmNxEkE4a8O+inntrNIAYvLc+uUHXfOLEi4OPqatsNIIr0Psf50d85RlP1Rws1f9mq8W
         mXyUgNFlelO1rwxcnIjqSjO+jlDlH4sFSh9owjhDlb2XHQo7SQL0glJVTjyInkJz0bzN
         TX1LySmuRFGkSCS1VkGY40lmCqcBQQsU63xs0EfwdZ4wT8olf+6nsxJNZtfHHYJ7flv+
         CCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxU7p1t2vpoUkds+Z7mgCZaRnwUz2A7ihwGXZAdD+IU=;
        b=pD+JRrW5RgpBd+486s4pLcmbv566yYwpHKV1EWyrhNKgWI9HMQ/7LtOPqZXrHMGkv5
         QXuMTwZyIUIANf96rYLdZ2qR+ibswoGF3EWH4KHHs0EoUVEKvtXEJEtQ59mv2XsRQbeh
         KbTr+Kf29UEubPKe72lqe00+/eZhlAmpOeEipdErJ/2eMwO4VD+kQkkpSWumKdYZPrwy
         VagqSHOFBp43asW5Cm8zST7h+27grcp5XGf6FvO4IBCDYhbbsNOXKL84wjBWT2qk6EK2
         tBVbZMqaZ6PpFnfonTmF+pENRc7VQVBZSHSt3LqWakhOxpuiKXsecexwg2VPWGWF78yY
         zjOA==
X-Gm-Message-State: AOAM530WU1dW1Y4pzrwNFlGsgnbml9IqDA4A/Oc3U3JdmCjWSwZyAFFz
        DmaQPev8MfUjP6HijkFw0LVYO3Y9QiDZY9ZDhLY=
X-Google-Smtp-Source: ABdhPJykIT4TxDpHeer8ri66LEX6RxKFj1evY2wqwVhceMmeHl4IjOSJQgGyaLWNZ/11nnjKceZMz8ZvZxkse00r9Lc=
X-Received: by 2002:ae9:d607:: with SMTP id r7mr1849084qkk.142.1633683327420;
 Fri, 08 Oct 2021 01:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <1633673269-15048-1-git-send-email-huangzhaoyang@gmail.com>
 <20211008080113.GA441@willie-the-truck> <CAGWkznEh6RuEgxTH-vHB1kMjb0CERigqpL4+f0Lg1X1_VBQuMQ@mail.gmail.com>
 <YWAFHgUseH2t/FUf@arm.com>
In-Reply-To: <YWAFHgUseH2t/FUf@arm.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 8 Oct 2021 16:55:05 +0800
Message-ID: <CAGWkznHeCfxx_S4nFqWEZzSRxdGRkdMQmv4p7fbPi+3o+WYE2w@mail.gmail.com>
Subject: Re: [RFC PATCH] arch: ARM64: add isb before enable pan
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <qperret@google.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>, ping.zhou1@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 4:45 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Oct 08, 2021 at 04:34:12PM +0800, Zhaoyang Huang wrote:
> > On Fri, Oct 8, 2021 at 4:01 PM Will Deacon <will@kernel.org> wrote:
> > > On Fri, Oct 08, 2021 at 02:07:49PM +0800, Huangzhaoyang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > set_pstate_pan failure is observed in an ARM64 system occasionaly on a reboot
> > > > test, which can be work around by a msleep on the sw context. We assume
> > > > suspicious on disorder of previous instr of disabling SW_PAN and add an isb here.
> > > >
> > > > PS:
> > > > The bootup test failed with a invalid TTBR1_EL1 that equals 0x34000000, which is
> > > > alike racing between on chip PAN and SW_PAN.
> > >
> > > Sorry, but I'm struggling to understand the problem here. Please could you
> > > explain it in more detail?
> > >
> > >   - Why does a TTBR1_EL1 value of `0x34000000` indicate a race?
> > >   - Can you explain the race that you think might be occurring?
> > >   - Why does an ISB prevent the race?
> > Please find panic logs[1], related codes[2], sample of debug patch[3]
> > below. TTBR1_EL1 equals 0x34000000 when panic and can NOT be captured
> > by the debug patch during retest (all entrances that msr ttbr1_el1 are
> > under watch) which should work. Adding ISB here to prevent race on
> > TTBR1 from previous access of sysregs which can affect the msr
> > result(the test is still ongoing). Could the race be
> > ARM64_HAS_PAN(automated by core) and SW_PAN.
>
> Can you please change the ARM64_HAS_PAN type to
> ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE? I wonder whether
> system_uses_ttbr0_pan() changes its output when all CPUs had been
> brought up and system_uses_hw_pan() returns true.
ok, thanks. We will try. Is it a workaround for known defect?
>
> --
> Catalin
