Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FDA393101
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhE0Oib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233092AbhE0Oia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:38:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A333611F0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622126217;
        bh=yJVHGTIOLgdvibxuryyK1OgywwUMuWCxRTTQvWjkjQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Un0O1C3GdI2ZsEdTuojy7sZ4i75KUTZopfN9/sFFbhYd0X38MZQ9ROApVMqKccGni
         xGV8wnX1OuJ9a0QqYxtRU+gQlHGWdpHR0qf8/5HjgWXH+503j4GHtYrVNlVP/mEG+j
         QqmiF2+nXsZzxyKZOp0gvdMOo4eBMkHXo9u/lBbbIDoGTGFulXFYRsMO2jYBjoQhua
         oGoJHlZnRCP+aNlrIokrfnvme0rl23iHOq7ULkLscOE7A1rBqbcgx1Smm1FDqsF10p
         pVBjwggse9lzwjzgTGuGAJu6mzlXTS/kxduTq7n7keTduGAakDot9rcDikTQ1N0l5a
         gRD/36/XZKhhA==
Received: by mail-ej1-f51.google.com with SMTP id b9so383776ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:36:57 -0700 (PDT)
X-Gm-Message-State: AOAM530kqagHvigd19vRfPOMQSXWiUrNd7+AEaGAaALDAEm2grqyojAn
        n9WY0JLhqujfPwmx+07xEVaRQVjRv4E8EWInkdU=
X-Google-Smtp-Source: ABdhPJybDdeVzEUEBPTofoAKabkuVAG470/vN6dPcdxU1RGp5yJPvgpGHLp7ChBDr8xfjbDvLu4XkqkvHM/rtv+wkkQ=
X-Received: by 2002:a17:906:9155:: with SMTP id y21mr4146387ejw.148.1622126215710;
 Thu, 27 May 2021 07:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <202105271713.TLhpzN7N-lkp@intel.com>
In-Reply-To: <202105271713.TLhpzN7N-lkp@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 27 May 2021 10:36:42 -0400
X-Gmail-Original-Message-ID: <CAJKOXPdkDe1iNpZa9X0eRyWO85WBWuhRk-t=ENqkRk3p0=-LuA@mail.gmail.com>
Message-ID: <CAJKOXPdkDe1iNpZa9X0eRyWO85WBWuhRk-t=ENqkRk3p0=-LuA@mail.gmail.com>
Subject: Re: drivers/memory/fsl_ifc.c:298 fsl_ifc_ctrl_probe() warn:
 'fsl_ifc_ctrl_dev->gregs' not released on lines: 298.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 at 05:31, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hi Krzysztof,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d7c5303fbc8ac874ae3e597a5a0d3707dc0230b4
> commit: ea0c0ad6b6eb36726088991d97a55b99cae456d0 memory: Enable compile testing for most of the drivers
> config: s390-randconfig-m031-20210527 (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/memory/fsl_ifc.c:298 fsl_ifc_ctrl_probe() warn: 'fsl_ifc_ctrl_dev->gregs' not released on lines: 298.

Thanks, I will fix it. I also see some more leaks there...


Best regards,
Krzysztof
