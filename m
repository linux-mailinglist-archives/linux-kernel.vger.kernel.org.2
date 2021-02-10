Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B6B315DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 04:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhBJDkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 22:40:22 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:11135 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhBJDkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 22:40:19 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Db59L6s1Tz2d;
        Wed, 10 Feb 2021 04:39:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1612928375; bh=aDSrPcZLnyFTwRvQIZw7dYa9jPbEgxmzVe6t1XLUv7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aa2jt3ua6sQmDbJ1EZghcRfzc92eq9QsRTfCsaBp2MWenwgKZwc+p58uihYydjHaS
         wknULXa1x+1TU1NolsnYemL97WT0mpS7zcnecWdJT+asPROhiU37GP4P/C5jHVvGMm
         ijTwm3pVP3t7d6e31FJOn2K2xKlCZVtkKb0TIT/SuYCJ/7aomCg+aRO2S++8cTpP2F
         PbH9rSDqJ7XnIQrlgNgidwg2g2tmnGzBmfFfdft29iFEfnTWoUtiPJfIgkpYCcSsfa
         SEuX3FNGPfWzhXSPSYjp+QU97PDi72oixGPDB9ASLv1skrJxyc0qH934dn5x6fuJiN
         zD1j810uE2r8A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Wed, 10 Feb 2021 04:39:02 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: cb710: Use new tasklet API
Message-ID: <20210210033902.GA12086@qmqm.qmqm.pl>
References: <20210208134551.39696-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210208134551.39696-1-kernel@esmil.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 02:45:51PM +0100, Emil Renner Berthing wrote:
> This converts the driver to use the new tasklet API introduced in
> commit 12cc923f1ccc ("tasklet: Introduce new initialization API")
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>

Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

> ---
>  drivers/mmc/host/cb710-mmc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
> index e84ed84ea4cc..6d623b2681c3 100644
> --- a/drivers/mmc/host/cb710-mmc.c
> +++ b/drivers/mmc/host/cb710-mmc.c
> @@ -646,14 +646,14 @@ static int cb710_mmc_irq_handler(struct cb710_slot *slot)
>  	return 1;
>  }
>  
> -static void cb710_mmc_finish_request_tasklet(unsigned long data)
> +static void cb710_mmc_finish_request_tasklet(struct tasklet_struct *t)
>  {
> -	struct mmc_host *mmc = (void *)data;
> -	struct cb710_mmc_reader *reader = mmc_priv(mmc);
> +	struct cb710_mmc_reader *reader = from_tasklet(reader, t,
> +						       finish_req_tasklet);
>  	struct mmc_request *mrq = reader->mrq;
>  
>  	reader->mrq = NULL;
> -	mmc_request_done(mmc, mrq);
> +	mmc_request_done(mmc_from_priv(reader), mrq);
>  }
>  
>  static const struct mmc_host_ops cb710_mmc_host = {
> @@ -718,8 +718,8 @@ static int cb710_mmc_init(struct platform_device *pdev)
>  
>  	reader = mmc_priv(mmc);
>  
> -	tasklet_init(&reader->finish_req_tasklet,
> -		cb710_mmc_finish_request_tasklet, (unsigned long)mmc);
> +	tasklet_setup(&reader->finish_req_tasklet,
> +		      cb710_mmc_finish_request_tasklet);
>  	spin_lock_init(&reader->irq_lock);
>  	cb710_dump_regs(chip, CB710_DUMP_REGS_MMC);
>  
