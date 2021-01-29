Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D5D308DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhA2TqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:46:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233036AbhA2To5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:44:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BECA164E0E;
        Fri, 29 Jan 2021 19:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611949457;
        bh=4uA8DEtVUTJtQbH/lV1yVkqAXtxwx/Ez6Fi4zN699bw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bwDwxWN9dlLW8RCeaJbDiGTvykIEQAFmxGTJ4EzCQHh3jmZ6l8HB7eq8wN84WL7kh
         iplrCcAa3eo4IAC7NLphJ67WT9JaK2v8VSKjZGLJ8nSpa16kaBWKqTgwWKYclU7/XT
         zE34argo92tLExxnFxmOuJteLxJ7FWBYNo1eDR8T6rddI7RVSS4lT/+NIZ/qe02Xh4
         2brrzf/hOq/g7W2xjnQ1QcsSjxpHrjh3Tuy7a5YrUGh+gL6ZLG5lew+QuJohP31w4U
         2FU5+irjD5a8OARqaJF7hHUu64PGcB3tPXmvlVnxvg16L6V/2/f5ICP8iLT5bdG/Kz
         AESy9kGJavL/w==
Date:   Fri, 29 Jan 2021 20:44:12 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Mayulong <mayulong1@huawei.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 01/14] staging: hikey9xx: spmi driver: convert to
 regmap
Message-ID: <20210129204412.25e912a6@coco.lan>
In-Reply-To: <YBQth03ENuTIp1Rb@kroah.com>
References: <cover.1611932194.git.mchehab+huawei@kernel.org>
        <8148fe6afb24f91efba22f66472b227aab2ace70.1611932194.git.mchehab+huawei@kernel.org>
        <YBQth03ENuTIp1Rb@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 29 Jan 2021 16:45:11 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Fri, Jan 29, 2021 at 04:03:36PM +0100, Mauro Carvalho Chehab wrote:
> > Instead of doing its own SPMI I/O implementation, use the
> > already-existing regmap one.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 115 ++++++------------
> >  .../staging/hikey9xx/hi6421v600-regulator.c   |  26 ++--
> >  include/linux/mfd/hi6421-spmi-pmic.h          |   7 +-
> >  3 files changed, 52 insertions(+), 96 deletions(-)  
> 
> After applying this, I get a build failure:
> 
> ERROR: modpost: "__devm_regmap_init_spmi_ext" [drivers/staging/hikey9xx/hi6421-spmi-pmic.ko] undefined!
> 
> So you need some sort of build dependancy here :(

It seems that it is missing REGMAP_SPMI.

> Also, when I apply the first 9 patches and stop, I get a build error
> that you should see as well, so I can't take any of these right now,
> sorry.

Gah, there was a rename patch which a hunk that went into the
following patch. Sorry. 

Added the missing select REGMAP_SPMI / REGMAP, fixed it and
tested, patch-per-patch.

I'll run a new test at the hardware to double-check if everything is
OK at the hardware and should be re-submitting the series soon enough.

Thanks,
Mauro
