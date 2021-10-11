Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EED34286B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhJKGTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 02:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234073AbhJKGT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 02:19:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4FB7608FB;
        Mon, 11 Oct 2021 06:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633933049;
        bh=w2CW+S/hgiQRfRSNcRoqzQvvxHGT0QjqoAYHJpU41CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ot1gEZO/1/Ajwq8F9VaK4PqYHid8O3QbOrbYkotxX2iKWSu9du5q4JIcYrde6WBak
         orqsQ9L8at+8ItJzRqdQ4NF1gJSAkyPCUzWJO15dzSLK8L9LwE0vgUot/eGfww5HUr
         gv5nYrRI9SvzmxYgzwibwy5YObs3E1XrstmQZQ5KKVMjg2c8NVBNYRWt0hkNzX4jWD
         nEhYUAKJofvxbFfJwiZBDjNwR0vklBaLVy1GsrABORh525EDAkFpIPMD2UZSfJZkSh
         dO+SUnSQ3OhNL7q4BH5jpmpGCWRAb3hqgf/X7GpYrtlMaFoz2QABrWkprGSEm7l2kY
         HYv5qdwXMf0jw==
Date:   Mon, 11 Oct 2021 11:47:18 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] clk: fix the need of booking clk_ignore_unused=true
 on embedded devs
Message-ID: <20211011061718.GB1834@thinkpad>
References: <cover.1633607765.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1633607765.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Thu, Oct 07, 2021 at 02:06:53PM +0200, Mauro Carvalho Chehab wrote:
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

So you are mentioning a "race" condition here but it is not mentioned in the
actual patch. If the issue you are seeing is because the clocks used by the
modules are disabled before they are probed, why can't they just enable the
clocks during the probe time?

Am I missing something?

Thanks,
Mani

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
> -- 
> 2.31.1
> 
> 
