Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8BC3C26E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 17:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhGIPgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 11:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231976AbhGIPgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 11:36:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A59BD613AF;
        Fri,  9 Jul 2021 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625844816;
        bh=xFQbgmxuolYLTy1axxONjEKSxdDD/CwUMCqfIpUvCWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q7llvPRkO7nBSIf2cKcoi8rfCLXpjRrvykEZQr+ueqZH83TNYcBK0mVud29CSze7U
         OgfyiuKv8ZTWptBuiDXa0vr8ZjF/r8hes9RUfOewqoAqGBB7EjDd4P7mh8wlYfwFd3
         DKq1LbQnfupa9A8QAazZULQx+R9dtpzTYRy4NESsu3gitdFsME5k5a/Gh3Egpm1ZpK
         bA7fc+ziOi8PeI68F1KcTfSKcXTpeZV1zIkGenlB7ukjsCYkkciU/9o4V2l8V/4anG
         JTjpnGav/E9yh4lAtADe0g1HftOjdqFCBlgpXDotw21enu6blNsNPATt+gREaXOMrY
         dcs+NODyjfY2g==
Date:   Sat, 10 Jul 2021 00:33:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Shaobo Huang <huangshaobo6@huawei.com>,
        <gregkh@linuxfoundation.org>, <chenzefeng2@huawei.com>,
        <kepler.chenxin@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@arm.linux.org.uk>,
        <liucheng32@huawei.com>, <tixy@linaro.org>, <xiaoqian9@huawei.com>,
        <young.liuyang@huawei.com>, <zengweilin@huawei.com>
Subject: Re: [PATCH 4.4.y] arm: kprobes: Allow to handle reentered kprobe on
 single-stepping
Message-Id: <20210710003332.8c3cf2a0e79c63278b3b70b6@kernel.org>
In-Reply-To: <9ca81fb8-8d6e-1708-db01-a29e54c79343@huawei.com>
References: <YOcOcNBRou5KlbOR@kroah.com>
        <20210709024630.22268-1-huangshaobo6@huawei.com>
        <20210709180031.adc7260b54645b0292a6f02a@kernel.org>
        <9ca81fb8-8d6e-1708-db01-a29e54c79343@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2021 19:39:30 +0800
Xiaoming Ni <nixiaoming@huawei.com> wrote:

> On 2021/7/9 17:00, Masami Hiramatsu wrote:
> > Hi Shaobo,
> > 
> > Thanks for backporting!
> > Greg, it seems this patch can be applied to 4.9 too without any issue.
> > 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.9.y&id=355a04fa1fc23c4fb1d16440e62d46a42691e96b
> 
> The v4.9 branch has been fixed.

Oh, I might see wrong branch. Thank you for confirmation!

Regards,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
