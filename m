Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC8B330872
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCHGvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhCHGuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:50:55 -0500
X-Greylist: delayed 125479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 07 Mar 2021 22:50:55 PST
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746F6C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 22:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=i0gmFpOVEqM0E4dUnLDzKTfLkWMoQgTTzY2+cl6n74s=; b=TwFIgrncW+ysQNb28Noc7ELeyQ
        jIU/0GL4pRe+3oVJqDTRlbgfJkva/8n96qvNL0GcOSl8nk1/vLkrrkJ8QiuXJ1a34avriDS2wo6Ep
        nvbZCmRfaiqfroxwUjCHOkyZtt6TwxlbBLtVRRSP0xC40frr2H3dh/5PQ4ywjWLdZE3bARz6BX+pr
        tkMU5FllgHO5VPse75hjIo0Ab1Ys/lDkO6TMTKO7FOlehTBzzjmZFW78/Yz+VtEP4FzR2HMEAfZTU
        24HAwKW73+kdLBoHs6ZgSNtsRaf1+a4HZhcyU9fR8e/E2lQVqqf55gTy19CwhqW5VjbhhB1Qq7D9T
        QXOGECZQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJ9j7-000UYr-5y; Mon, 08 Mar 2021 06:50:50 +0000
Subject: Re: [PATCH] sound: soc: codecs: Fix a spello in the file wm8955.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, gustavoars@kernel.org,
        ckeepax@opensource.cirrus.com, peter.ujfalusi@ti.com,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20210306115151.31759-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5a19f291-d5be-b30a-ae79-f1c5ce290164@infradead.org>
Date:   Sun, 7 Mar 2021 22:50:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210306115151.31759-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/21 3:51 AM, Bhaskar Chowdhury wrote:
> 
> s/sortd/sorted/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  sound/soc/codecs/wm8955.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
> index 513df47bd87d..538bb8b0db39 100644
> --- a/sound/soc/codecs/wm8955.c
> +++ b/sound/soc/codecs/wm8955.c
> @@ -151,7 +151,7 @@ static int wm8955_pll_factors(struct device *dev,
>  	/* The oscilator should run at should be 90-100MHz, and
>  	 * there's a divide by 4 plus an optional divide by 2 in the
>  	 * output path to generate the system clock.  The clock table
> -	 * is sortd so we should always generate a suitable target. */
> +	 * is sorted so we should always generate a suitable target. */
>  	target = Fout * 4;
>  	if (target < 90000000) {
>  		pll->outdiv = 1;
> --
> 2.26.2
> 


-- 
~Randy

