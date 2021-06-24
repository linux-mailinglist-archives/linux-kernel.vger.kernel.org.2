Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF6C3B3148
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhFXO3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:32794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhFXO3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:29:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F77F6024A;
        Thu, 24 Jun 2021 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624544803;
        bh=fidWoLxi9CvIgEMxC5pKHC+zyH4imGcIkbPZC1UJc9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=05ZviCxBd591Rd/Emz/ISAlQh7XK3YkClf2I3eIkdxoOeih86Vw3V16Spk0a+oxp2
         n+UzGu4szI+lkwfzjkvV+j6mtimH0vMkyzw4EpI+tTGOSHHpfdhcR9KZ9y7GesvOTp
         NogPKjypGBjW9yAwKo09aZxi2rp4DCKK8eObptkc=
Date:   Thu, 24 Jun 2021 16:26:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v7 3/8] staging: hi6421-spmi-pmic: do some additional
 cleanups
Message-ID: <YNSWIUzO1FYDAxyS@kroah.com>
References: <cover.1624542940.git.mchehab+huawei@kernel.org>
 <08b3d0eb4256c4fad25652f2aeb701b81d11ece2.1624542940.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08b3d0eb4256c4fad25652f2aeb701b81d11ece2.1624542940.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 04:01:32PM +0200, Mauro Carvalho Chehab wrote:
> Before moving this driver out of staging, do a couple of
> cleanups, in order to make the driver clearer.
> 
> No functional changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 122 ++++++++++--------
>  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  |   7 +-
>  2 files changed, 71 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> index 626140cb96f2..252b731e272d 100644
> --- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> +++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> @@ -2,9 +2,9 @@
>  /*
>   * Device driver for regulators in HISI PMIC IC
>   *
> - * Copyright (c) 2013 Linaro Ltd.
> - * Copyright (c) 2011 Hisilicon.
> - * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
> + * Copyright (c) 2013- Linaro Ltd.
> + * Copyright (c) 2011- Hisilicon.

What does the "-" mean here?  That does not mean from 2013-present.

thanks,

greg k-h
