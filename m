Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E9E3579EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 03:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhDHByY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 21:54:24 -0400
Received: from m12-11.163.com ([220.181.12.11]:44085 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhDHByW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 21:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=oESgj
        rDTSJZx6iCAz42pUJTMrnferOVNTf/QOUZOefA=; b=bTZF/17ckVw94iNXIduEU
        9Ui0f5e7cmSk01vZ48+42sOtXnWloYQyYBCYYUoil6Ze+YfZhacuNtoGVW90KrTo
        bOjKfV17m4IbjiR3ZVoPPLPHqmRT+osB/dpT5EkM5BMRRk9/K9CqLOoo/ExTyA9I
        w4MXV290eoXMcOr0guvojE=
Received: from localhost (unknown [218.94.48.178])
        by smtp7 (Coremail) with SMTP id C8CowAA3SaEIYm5gARmZWA--.45991S2;
        Thu, 08 Apr 2021 09:53:13 +0800 (CST)
Date:   Thu, 8 Apr 2021 09:53:12 +0800
From:   Jian Dong <dj0227@163.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     abel.vesa@nxp.com, mturquette@baylibre.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, Jian Dong <dongjian@yulong.com>
Subject: Re: [PATCH]  clk: imx: reference preceded by free
Message-ID: <20210408095312.00004267@163.com>
In-Reply-To: <161715700800.2260335.7834636340431628632@swboyd.mtv.corp.google.com>
References: <1616469034-9691-1-git-send-email-dj0227@163.com>
        <161715700800.2260335.7834636340431628632@swboyd.mtv.corp.google.com>
Organization: yulong
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C8CowAA3SaEIYm5gARmZWA--.45991S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4rCryrGFW5Jr43Kr1Dtrb_yoWxtFg_C3
        4xCr97WrykGF4UA3Z3ZFn5JrsIkw18uFyvkF17Zr4UGas5Xr1Y9wnY9rZ2yr4UX340kw1D
        Wa4jk3yv9r13WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbbTmDUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/1tbiMwlu3VXl8mrQuwAAsK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 19:16:48 -0700
Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Jian Dong (2021-03-22 20:10:34)
> > From: Jian Dong <dongjian@yulong.com>
> > 
> >  when register failed, clk will be freed, it will generate dangling
> > pointer problem in later reference. it should return directly.
> > 
> > Signed-off-by: Jian Dong <dongjian@yulong.com>
> > ---  
> 
> Any Fixes tag?

Sorry for late, I'm unfamiliar with tag rule.

For this patch include two files commit 2f77296d3 and fe37b482
maybe likes:

Fixes: 2f77296d3	(clk: imx: add lpcg clock support)
Fixes: fe37b482		(clk: imx: add scu clock common part)

and I noticed this patch has been merged, do I need RESEND again with
tags like above?

Thank you

