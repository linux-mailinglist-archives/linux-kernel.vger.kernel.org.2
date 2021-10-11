Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FC0428554
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 04:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhJKCvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 22:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhJKCvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 22:51:21 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95202C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 19:49:22 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bi9so1405195qkb.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 19:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5tv84GQY+BXrm7Uh+yrBQDIxyhTf+S8jMuhW5BS2r+Y=;
        b=psYp9WB8j+BJKu/Mq8xIZp8jo2vSsNcINJMY6LA4KBKcreYo1R5B0zOPTJp4m3CB1v
         rxVByjRunV5irEZXgc0J4qsrCC6D+We7gUpRubFDb+eOAYs1hNEaW/VxlT8mnQWPhZKT
         xgmLm6hdcyVg2eJpZN66MmgfKEnvaSvTUzUBNEelYxHL8onYbg1mBefHGKk2tmP1CCfs
         GjK114XOAQGnrH0BzjL/46PFX5CK1USoFQiXuVwiavz3KXiu6fTx32Q2e9Ru8plh2Gu0
         gvw5ZFroIO8z3aLgvYObpCpPI5qKOnTpTXw2nyLAnQL4i2i55CuqfNIyfgGQsHB9v1vH
         Cktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5tv84GQY+BXrm7Uh+yrBQDIxyhTf+S8jMuhW5BS2r+Y=;
        b=MYYXa7QYGKAtaDZ1gxGA8xWO9aci2BRTayi2VH1Cj1n1IlfJqyZlIQd2irZfQuocB0
         xxO0iGfrb8qQocJM/Xs1gg1hd1AwmLApYcdHMCX3yETt9flFVF1j7z89II2KWicFfezS
         4h4krXjVLBMRK5DwQcu0JM5WInT3w/DcbVXqkmhw9VhUthYzATLLBUOENLo24eXdck1G
         wF8e7J291ebS0IggHG5r8RJuc3dDl1ybECmN/BjD8v/nCInA/J0tzslFh3YNx8n/1/S3
         cIOOxaXPg66sfE2b/JuZ7DqjbiJ58PSvvfLYRmT1K4dc1mUwLEgBfH+7OUtnHTsBqLHo
         nCJQ==
X-Gm-Message-State: AOAM53014AcczPgbJgi0JmcqdoXtCE+0GyCWmhmZoAvgoknkVVGfyuGo
        qhvI4w8zqUI1ErbZjb67OpiM0nNsoEcJ7AFoHYk=
X-Google-Smtp-Source: ABdhPJwcp0kwhyBSNesZ1fC3zZ4LiZp1c8tWRgYK2yPFdQVLA/2Szm2upmesGEgR4Ap/kAs3vt+saWQ+D+1dZDhCvMo=
X-Received: by 2002:a37:8e44:: with SMTP id q65mr12640141qkd.372.1633920561774;
 Sun, 10 Oct 2021 19:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <1633673269-15048-1-git-send-email-huangzhaoyang@gmail.com>
 <20211008080113.GA441@willie-the-truck> <CAGWkznEh6RuEgxTH-vHB1kMjb0CERigqpL4+f0Lg1X1_VBQuMQ@mail.gmail.com>
 <YWAFHgUseH2t/FUf@arm.com> <CAGWkznHeCfxx_S4nFqWEZzSRxdGRkdMQmv4p7fbPi+3o+WYE2w@mail.gmail.com>
 <YWAKSoBW2KLHSFp1@arm.com>
In-Reply-To: <YWAKSoBW2KLHSFp1@arm.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 11 Oct 2021 10:49:00 +0800
Message-ID: <CAGWkznHxQBKgz3Axq=hmTOz0BY6ebb7cPtb+xGxCBFv729ULvg@mail.gmail.com>
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

On Fri, Oct 8, 2021 at 5:07 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Oct 08, 2021 at 04:55:05PM +0800, Zhaoyang Huang wrote:
> > On Fri, Oct 8, 2021 at 4:45 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Fri, Oct 08, 2021 at 04:34:12PM +0800, Zhaoyang Huang wrote:
> > > > On Fri, Oct 8, 2021 at 4:01 PM Will Deacon <will@kernel.org> wrote:
> > > > > On Fri, Oct 08, 2021 at 02:07:49PM +0800, Huangzhaoyang wrote:
> > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > >
> > > > > > set_pstate_pan failure is observed in an ARM64 system occasionaly on a reboot
> > > > > > test, which can be work around by a msleep on the sw context. We assume
> > > > > > suspicious on disorder of previous instr of disabling SW_PAN and add an isb here.
> > > > > >
> > > > > > PS:
> > > > > > The bootup test failed with a invalid TTBR1_EL1 that equals 0x34000000, which is
> > > > > > alike racing between on chip PAN and SW_PAN.
> > > > >
> > > > > Sorry, but I'm struggling to understand the problem here. Please could you
> > > > > explain it in more detail?
> > > > >
> > > > >   - Why does a TTBR1_EL1 value of `0x34000000` indicate a race?
> > > > >   - Can you explain the race that you think might be occurring?
> > > > >   - Why does an ISB prevent the race?
> > > > Please find panic logs[1], related codes[2], sample of debug patch[3]
> > > > below. TTBR1_EL1 equals 0x34000000 when panic and can NOT be captured
> > > > by the debug patch during retest (all entrances that msr ttbr1_el1 are
> > > > under watch) which should work. Adding ISB here to prevent race on
> > > > TTBR1 from previous access of sysregs which can affect the msr
> > > > result(the test is still ongoing). Could the race be
> > > > ARM64_HAS_PAN(automated by core) and SW_PAN.
> > >
> > > Can you please change the ARM64_HAS_PAN type to
> > > ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE? I wonder whether
> > > system_uses_ttbr0_pan() changes its output when all CPUs had been
> > > brought up and system_uses_hw_pan() returns true.
> >
> > ok, thanks. We will try. Is it a workaround for known defect?
>
> No, other than the potential kernel bug you reported.
Changing the type to ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE doesn't work
for this issue.
>
> --
> Catalin
