Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B3C3B900B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbhGAJxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235300AbhGAJxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:53:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FB6D60238;
        Thu,  1 Jul 2021 09:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625133079;
        bh=fpuEFrUiU5EVTjFlLK6uC+5uhkFCrLLjAqBmuItpzFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6SOxaiey35zldGTmJos6Vw0zFdMWtV920qP9urq24IvOdyQOEcbWFq/eP+lBth0b
         R9XnFR9BbOsZ+ib9P9IPSO4Rdc3qe0tzRu213lswhExJ8WzWJk3PiJvTBRUPETmsLE
         bAvVdKdHZOLZJoEl8QyaQEqTpw82Yy1qit2kAP2E=
Date:   Thu, 1 Jul 2021 11:51:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        linux-phy@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: repair reference in USB IP DRIVER FOR
 HISILICON KIRIN 970
Message-ID: <YN2QFcH/DcGeg/0u@kroah.com>
References: <20210701093903.28733-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701093903.28733-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 11:39:03AM +0200, Lukas Bulwahn wrote:
> Commit 8de6b7edd493 ("phy: phy-hi3670-usb3: move driver from staging into
> phy") moves phy-hi3670-usb3.c from ./drivers/staging/hikey9xx/ to
> ./drivers/phy/hisilicon/, but the new file entry in MAINTAINERS refers to
> ./drivers/phy/hisilicon/phy-kirin970-usb3.c.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches  F:  drivers/phy/hisilicon/phy-kirin970-usb3.c
> 
> Repair the file entry by referring to the right location.
> 
> Fixes: 8de6b7edd493 ("phy: phy-hi3670-usb3: move driver from staging into phy")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210701
> 
> Mauro, please ack.
> Greg, please pick this non-urgent minor fix on top of commit 8de6b7edd493

Thanks, I'll take this after 5.14-rc1 is out.

greg k-h
