Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC62309C91
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhAaOJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:09:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232008AbhAaMod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 07:44:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7712A64E09;
        Sun, 31 Jan 2021 12:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612097032;
        bh=yOfrM4/gd3A2HsbAbSmBciknAKqFeNdVCFkijAGQElw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+aky6PJ+d9dfH5SXhRSiycuy2xqH/vfZaxZd0ATEM4H+T6xuglsi/kCLQWJqXtHq
         /rNWH1oVArQhB5ZZ4uWgO2aff9NIR7hvD05J2WQjkF/LT5/KzpVH3TmUNirnHahZ4v
         yrX/BlcRg1JRoMW0stYU8xFswwb/cfeg0POOZoy4=
Date:   Sun, 31 Jan 2021 13:43:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mayulong <mayulong1@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Yu Chen <chenyu56@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org,
        David Gow <davidgow@google.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v8 00/14] Move Hisilicon 6421v600 SPMI and USB drivers
 out of staging
Message-ID: <YBamBfrr+cSqwjE1@kroah.com>
References: <cover.1611949675.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1611949675.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 08:51:46PM +0100, Mauro Carvalho Chehab wrote:
> Hi Greg/Mark/Lee/Vinod,
> 
> Another rebase , also the top of staging-testing.
> 
> This series contain the remaining patches for USB to start working,
> except for a final DTS patch.
> 
> Patches 1 and 2 convert the SPMI and regulator
> drivers to use regmap and simplifies the logic by using
> regmap helpers.
> 
> Patches 3 to 9 address some issues pointed by Lee at the MFD driver.
> 
> I guess the best would be if Greg could apply patches 1 to 9
> via the staging tree.

I've taken these first 9 patches in my staging tree.  If any other
subsystem maintainer wants to ack the move of the files out of staging
to their respective subsystems, I'll gladly apply those patches here as
well.

thanks,

greg k-h
