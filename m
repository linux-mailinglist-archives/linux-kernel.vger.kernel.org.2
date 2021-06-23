Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACBE3B1732
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhFWJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 05:50:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19176 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229833AbhFWJuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:50:18 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15N9ZWor021240;
        Wed, 23 Jun 2021 09:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=FA+wKCvEqhPL++IUAHUQdMEuak2t5x5+jh4eWW+pcyg=;
 b=ogBxUl36I7sVZ27nLgITcq3jsMiGbHXYZunKDllpR1LKEQ53uLOd0XtXjg9EAE4KOXBE
 NNoteLvlfB27v4/29NARzeGBrmfHA91xh8UnueK/pPlYpm6MrAMUXKRSGk4sYV6vl9OL
 t9B9PddMhiA0ooVRancKGN4Wy/RpBJY1gs9NrYrRjDoZ26ABWX77ayKYCoHeWKXlOt+i
 mnO4IaUjcVO29E2t5Z0ztGTf7JYt8uwRB8omO2K4XjkN0yVXPNlv201S4oTQjQhqazIq
 JR2Z/f4nwtyIUSgTuGGyV3SxV7K3bFEubHoLvAm0+ehlWR2Dh+ntmzpaaQ2mkkbMHjpM 4A== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39aqqvwe8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 09:47:11 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15N9kv8W182759;
        Wed, 23 Jun 2021 09:47:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3995pxyyju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 09:47:10 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15N9l9fU183647;
        Wed, 23 Jun 2021 09:47:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3995pxyyhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 09:47:09 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15N9l4r9018569;
        Wed, 23 Jun 2021 09:47:05 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jun 2021 02:47:04 -0700
Date:   Wed, 23 Jun 2021 12:46:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        Adam.Thomson.Opensource@diasemi.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ASoC: da7219: Fix an out-of-bound read in an error
 handling path
Message-ID: <20210623094655.GB2116@kadam>
References: <4fdde55198294a07f04933f7cef937fcb654c901.1624425670.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fdde55198294a07f04933f7cef937fcb654c901.1624425670.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: KXRfO7fq66-Z4md6qkgM-t4DEuQv-mgZ
X-Proofpoint-GUID: KXRfO7fq66-Z4md6qkgM-t4DEuQv-mgZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 07:22:45AM +0200, Christophe JAILLET wrote:
> If 'of_clk_add_hw_provider()' fails, the previous 'for' loop will have
> run completely and 'i' is know to be 'DA7219_DAI_NUM_CLKS'.
> 
> In such a case, there will be an out-of-bounds access when using
> 'da7219->dai_clks_lookup[i]' and '&da7219->dai_clks_hw[i]'.
> 
> To avoid that, add a new label, 'err_free_all', which set the expected
> value of 'i' in such a case.
> 
> Fixes: 78013a1cf297 ("ASoC: da7219: Fix clock handling around codec level probe")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  sound/soc/codecs/da7219.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index 13009d08b09a..1e8b491d1fd3 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -2204,12 +2204,14 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
>  					     da7219->clk_hw_data);
>  		if (ret) {
>  			dev_err(dev, "Failed to register clock provider\n");
> -			goto err;
> +			goto err_free_all;
>  		}
>  	}
>  
>  	return 0;
>  
> +err_free_all:
> +	i = DA7219_DAI_NUM_CLKS - 1;
>  err:
>  	do {
>  		if (da7219->dai_clks_lookup[i])

This do while statement is wrong and it leads to potentially calling
clk_hw_unregister() on clks that haven't been registered.

I think that calling clk_hw_unregister() on unregistered clocks is
supposed to okay but I found a case where it leads to a WARN_ON()
(Nothing else harmful).  It's in __clk_register() if the alloc_clk()
fails:

	hw->clk = alloc_clk(core, NULL, NULL);
        if (IS_ERR(hw->clk)) {
                ret = PTR_ERR(hw->clk);
                goto fail_create_clk;  // <- forgot to set hw->clk = NULL
        }

The better way to handle errors from loops is to clean up partial
iterations before doing the goto.  So add a clk_hw_unregister() if the
dai_clk_lookup = clkdev_hw_create() assignment fails.  Then use a
while (--i >= 0) loop in the unwind section:

err_free_all:
	i = DA7219_DAI_NUM_CLKS;
err:
	while (--i >= 0) {

regards,
dan carpenter

