Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C4430EDBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbhBDHtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:49:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234639AbhBDHtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:49:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4956764F59;
        Thu,  4 Feb 2021 07:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612424947;
        bh=ow5324N+X0yX6Y++DQH8Ee4d23dUDvfZqkh3Y+REDTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T60CgV3iWmtMePG9PaOF16n7zzvEozhEBDUnfGcX0uKML/AvPfAqMrI7H29ktWW7w
         7SR0mqi/fDx0TrKllkRQjZY4RjibrCUBtfkxNimS5pdeonw59KVQ7GYTUT6AoRllxT
         RecRizCWWLrYsKor5myS/0UEeMEZR+noehqrgQe67kDjLDAwfHtVqlvo7nmtinKPo7
         6HHGvihZA0cYspklJ0/cqZ+7JXN5XuXSk1bLeNI6NmA2Tad6IbXL7oVVFcRG3pST2I
         7lpW1gVofXkWWbZKOz6EnUsjS+RrkfHGZwmBYppjstNdsH3Uli/5i0UslefLN1Ob7V
         OwpGSqt6Xgt+g==
Date:   Thu, 4 Feb 2021 13:19:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, Yu Chen <chenyu56@huawei.com>,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alex Dewar <alex.dewar90@gmail.com>
Subject: Re: [PATCH v4 0/5] Promote Hikey 970 USB phy out of staging
Message-ID: <20210204074903.GF3079@vkoul-mobl.Dlink>
References: <cover.1611052729.git.mchehab+huawei@kernel.org>
 <YBBWQeglmuDn1g11@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBBWQeglmuDn1g11@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-21, 18:49, Greg Kroah-Hartman wrote:
> On Tue, Jan 19, 2021 at 11:44:38AM +0100, Mauro Carvalho Chehab wrote:
> > Hi Vinod/Rob,
> > 
> > This series moves  the Hikey 970 USB PHY driver out of staging.
> > 
> > Patches 1 to 4 contain the fixes from staging. Patch 5 moves the
> > driver from staging:
> > 
> > 	$ git show 82ce73ac9a38 --summary
> > 	...
> > 	 rename drivers/staging/hikey9xx/phy-hi3670-usb3.yaml => Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml (100%)
> > 	 rename drivers/{staging/hikey9xx => phy/hisilicon}/phy-hi3670-usb3.c (100%)
> > 
> > I opted to use --no-renames on this series in order to make easier to
> > review via e-mail, as the entire driver and DT bindings will be seen
> > at the last patch on this series.
> 
> First 4 patches applied to my tree, thanks.

I have acked the last one, pls apply that one too

-- 
~Vinod
