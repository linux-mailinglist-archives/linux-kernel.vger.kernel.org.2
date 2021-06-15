Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B983A8BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhFOWlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:41:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47367 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229898AbhFOWlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:41:45 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A49B55C018B;
        Tue, 15 Jun 2021 18:39:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 15 Jun 2021 18:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=f2gn9UHXuaQi9VRk/NVthPD7rSg
        BJOO3nqkzPfXlP7E=; b=A++O9VvnEAsR4q74jfqdIW+6V7C44iNxSXt+XblUeR/
        mygiNFBgYrFqmsal3rQ7ZwGP58LTDblE0Dt931gyIHHka/57gvok/sbA/zm5LuEl
        ziCTLx/7Fi39ZgX2YeHOcoR10WNaxD2wsOXmau2IoWJ6aBTgMmywVXSGDF0HFYtj
        lXI2bDAaZdeePZhGoS3dbhPys1Z5xtewA0KJLtLF7n+NTMyBdbnDeP3yl37CrEzh
        RbhNvF/q1A+246IztXcx0y3L0AeROglBa1Lc0l58OTZT5K3Huk3+nbH16umTzn91
        z2iBQwXc1fcAbAFtuB9spRaL5/ifdaLPURkfv+7MI8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=f2gn9U
        HXuaQi9VRk/NVthPD7rSgBJOO3nqkzPfXlP7E=; b=Y4wZEyfAt9osHhIvUU46Hu
        p9CNxo6Yyc2mPwsk0OI5iKhOCqMNUdkIH3uLla9q9kEwlgN5M6/fD+JyHyLW0/JI
        NkfKGkg1hOB88FFMJ7be+rVDXRCxe8rZC8ntcQOTC0joJVKRVI9e6FyZeX5CrE8g
        I9SIYiyT+aqA/kfhS8KW4hvW44GoldR48qRsBfg3hLu4jAGccmY4nh2tDk/PVVif
        qapajDNE9X9YPaszc9hs5cXBQ8QxPE9yP6kTEf6vqS7bO7JNNfzQOAnz2z5e7bzo
        Tj3sBSAp5Q+pIETDBaR8cnQgD6tQwuWgaHfUnWVo6EQGONMbE+NXj04tlsgGtbqg
        ==
X-ME-Sender: <xms:KizJYO2GpgECFrneKpOMOEmtFvCKfarL7icFeblHGta63S6LCWkJkg>
    <xme:KizJYBF9koFEB3ks4WTaDZaiTu58H9f7Zkge40JVj6yOSyiKEGqjTt79QV4S6uk81
    wfpFtRbuglcIyqMzQw>
X-ME-Received: <xmr:KizJYG7eyMixE2kl4tLCEQmN_9oc1M7znwPvWI5T5sYdHoP-J7rsNz857dc2cPJQ72my898iw5AajhFHwKUOVVU9XhpoC6_W9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvkedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeelhfeugedvjefgjefgudekfedutedvtddutdeuieev
    tddtgeetjeekvdefgeefhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:KizJYP30qKsC3JnMScwSmy63hwhe6n6ILp3PO3Ku_kUpdeP53PpdOA>
    <xmx:KizJYBFii14uQjRXQvD_Ve0E7nsRHcQcOzsEGrd0cqHCxrlKAxaBhg>
    <xmx:KizJYI-jBiL0KtjTgh1TNU89X3SwyPV0j2hdR8JP5ZCcx-__gEKGuA>
    <xmx:KyzJYKPlUwuJKTQqRk0ToD6C2eZyOfWHwlXdfHNR5k70gBgpUtp7-g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jun 2021 18:39:36 -0400 (EDT)
Date:   Wed, 16 Jun 2021 07:39:33 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Colin King <colin.king@canonical.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: bebob: Fix bit flag quirk constants
Message-ID: <YMksJcvtwwkkqE4S@workstation>
Mail-Followup-To: Colin King <colin.king@canonical.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210615142048.59900-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615142048.59900-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 15, 2021 at 03:20:48PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The quirking bit-flags are currently set as contiguous integer enum values
> and so currently SND_BEBOB_QUIRK_INITIAL_DISCONTINUOUS_DBC is zero and so
> he quirking never getting set or tested correctly for this quirk. Fix this
> by setting the quirking constants as shifted bit values.
> 
> Addresses-Coverity: ("Bitwise-and with zero")
> Fixes: 93cd12d6e88a ("ALSA: bebob: code refactoring for model-dependent quirks")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/firewire/bebob/bebob.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
> index c06579d9380e..4d73ecb30d79 100644
> --- a/sound/firewire/bebob/bebob.h
> +++ b/sound/firewire/bebob/bebob.h
> @@ -76,8 +76,8 @@ struct snd_bebob_spec {
>  };
>  
>  enum snd_bebob_quirk {
> -	SND_BEBOB_QUIRK_INITIAL_DISCONTINUOUS_DBC,
> -	SND_BEBOB_QUIRK_WRONG_DBC,
> +	SND_BEBOB_QUIRK_INITIAL_DISCONTINUOUS_DBC = (1 << 0),
> +	SND_BEBOB_QUIRK_WRONG_DBC		  = (1 << 1),
>  };
>  
>  struct snd_bebob {
> -- 
> 2.31.1

Nice to catch it. Indeed, I overlook it...

Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto
