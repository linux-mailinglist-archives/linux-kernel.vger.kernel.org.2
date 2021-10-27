Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA5143C3C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbhJ0HX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240455AbhJ0HX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:23:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 992126109E;
        Wed, 27 Oct 2021 07:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635319291;
        bh=AuW3QkBS5Hsr9hfHspFW41KpdMXremTDQB0r9HDoJaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mSBQVwGMA7izM44EQzRy8mm+KTKEdV0ECmckETRGFgcE4kFc6c8F/Si04HwfSvLhE
         +uDP6GLqYe3//wsn0JZ5LXg6McgZ+ouoSJRmOi24D4oTCZ+cACVHCvsgajxD8AlMWs
         rsc5WHO35KFA0xDGtwIV0uj/+eGEXAJ9IoKDVQx9VxqMlZyBrKzQxrsz8jta7tTk/A
         8xezZ0ljK2HWvi1G/4vUVVSaKsrfmnzYcNevx4WWHq/jU25Md7OnMhTN5xCRUsS4Ay
         VAbRzjDkauWYK2vq2HXGY4QwHTKijYRWve1VY2QSWE1Xb1qjc1ze95ptEGTB/rw0x0
         C+mrxTa+s5CWg==
Date:   Wed, 27 Oct 2021 08:21:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] clk: fix the need of booking clk_ignore_unused=true
 on embedded devs
Message-ID: <20211027082126.57dab8fc@sal.lan>
In-Reply-To: <cover.1633607765.git.mchehab+huawei@kernel.org>
References: <cover.1633607765.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen/Michael,

Gentile ping.

Regards,
Mauro

Em Thu,  7 Oct 2021 14:06:53 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Currently, the only way to boot a Kernel with drivers built as modules on embedded 
> devices like HiKey 970 is to pass clk_ignore_unused=true as a modprobe parameter.
> 
> There are two separate issues:
> 
> 1. the clk's core calls clk_disable_unused() too early. By the time this
>    function is called, only the builtin drivers were already probed/initialized.
>    Drivers built as modules will only be probed afterwards.
> 
>    This cause a race condition and boot instability, as the clk core will try
>    to disable clocks while the drivers built as modules are still being
>    probed and initialized.
> 
>    I suspect that the same problem used to happen at the regulator's core,
>    as there's a code that waits for 30 seconds before disabling unused
>    regulators;
> 
> 2. there are some gate clocks defined at HiKey 970 that should always be on,
>    as otherwise the system will hang, or the filesystem I/O will stop.
> 
> Ps.: 
>   I submitted already 3 or 4 versions of patches for HiKey 970 clock, but
>   they're all unreliable, due to the race conditions at the clk core due to (1).
>    
> Patch 1 solves the issue with the clk core.
> Patch 2 solves the HiKey 970 specific issues.
> 
> Mauro Carvalho Chehab (2):
>   clk: wait for extra time before disabling unused clocks
>   clk: clk-hi3670: mark some clocks as CLK_IS_CRITICAL
> 
>  drivers/clk/clk.c                  | 51 +++++++++++++++++++-----------
>  drivers/clk/hisilicon/clk-hi3670.c | 24 +++++++-------
>  2 files changed, 44 insertions(+), 31 deletions(-)
> 
