Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814883B3E23
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFYIDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhFYIDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:03:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9186E613C0;
        Fri, 25 Jun 2021 08:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624608072;
        bh=wA4i+6GMymdNLboi240ADpbTr3hVSPhdCcHusOPcKBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2XPBxQChSxECHWaZSD6hQaxV5A4fvwmpqgN6v2nYD/FlWGWTDeAL7sstzjmBZ8xRj
         DxaGeZr9F4cVbIDD1yHqV4PU1l/Dmk3cFrwKoKdb3JDwCnF9B99qtMZM0glYnu1HfA
         NGfqGHFzck6+WpOx3fpa3W1PwYND/i1kIID2BbWE=
Date:   Fri, 25 Jun 2021 10:01:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v8 04/12] staging: hi6421-spmi-pmic: update copyright's
 year
Message-ID: <YNWNRaipBawAs2YD@kroah.com>
References: <cover.1624606660.git.mchehab+huawei@kernel.org>
 <af023af1f7a0371a838cb336a29ef05780e4dff8.1624606660.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af023af1f7a0371a838cb336a29ef05780e4dff8.1624606660.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:45:56AM +0200, Mauro Carvalho Chehab wrote:
> Update the copyright to reflect the current year.
> 
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> index 626140cb96f2..29ac53684ad2 100644
> --- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> +++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> @@ -2,8 +2,8 @@
>  /*
>   * Device driver for regulators in HISI PMIC IC
>   *
> - * Copyright (c) 2013 Linaro Ltd.
> - * Copyright (c) 2011 Hisilicon.
> + * Copyright (c) 2013-2021 Linaro Ltd.

I see no record of Linaro touching this every year from 2013-2021.
Where was that record?  I would feel more comfortable taking such a
change from a Linaro developer, not anyone else.

> + * Copyright (c) 2011-2021 HiSilicon Technologies Co., Ltd.

Same here, it was modified for 10 years continuously?  Where?

thanks,

greg k-h
