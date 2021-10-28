Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1553543E633
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhJ1QiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:38:05 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37877 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230070AbhJ1QiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:38:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0061758059B;
        Thu, 28 Oct 2021 12:35:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 28 Oct 2021 12:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        bryanbrattlof.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm1; bh=Dmo
        DyFhle48A/BncL9peDPujVA8ksYC4fnqTHSY2dtg=; b=ZpnVps44vv/Hx3/cXjx
        xHFBUHzeauLYDByrZ8dlPTFgjuSd+KqqoY9ShsC0H7CDUEvj22ZJHkH53eYhSHLo
        mNLtLedaXIRbBnDv3IgE/ogHEHdB6LXX93IWfLijd/X4Z4gIx7soL89mi/FF7zWr
        TO669TxQOeeXjaDwsNZTgCGNHGk01Fy5U1CTx4epc0mtXE87NuLDDceO+LPXBJxa
        haEPzNSfP9tRQR+STZlw0cbGiRzjGrufnslgOH3J1jPMr5HigM0WDsGlSH649XQH
        hzJHUZ6vHkqDU68SAm8bI4rixvvBdn0asw2LVyz7AXn6ojf0WJYJPnuAiBNger80
        3kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DmoDyF
        hle48A/BncL9peDPujVA8ksYC4fnqTHSY2dtg=; b=Z0yUDBojdOFgdO45GRCBxM
        DMSEjWxsu7PPOFXybpFnfbuSqxy48zztB76ktFApTrw773oA1mf80bE5fxias97G
        Kb6gOZwmjO+fYjDsh1e+OIGtVb2m2pSXZVoQPi2acXwVkBKr3rbTs2InYkD2VI8w
        PyhxyQiet49VksdZSylW+e6VJXVih4Y6xxcJyRFl7bMfN+pPoC13YI7L1YkKFkI7
        hLqs+g3AsCAvNAAIqZh3ZuMLwolexW+nuI7R0X5WMn9S8GF8B15DSrmttlV1jMLv
        03motH23L+GOC3otEGzqeinVUjee/nXYo2jX+jYcEVvpw5ZCSUCLXIn6c3jJEJZw
        ==
X-ME-Sender: <xms:V9F6YZ7WE40cMPFjBPqLhOsO18BsnN9Hsxr58Pr79lebo7j4uojReQ>
    <xme:V9F6YW5x4gnLljUmC9CFuC2-8C-u6BDFSckfq-zO2L4n1c13jcd84kU8GQwZdLaYq
    tsJktlckOcpxYCohFY>
X-ME-Received: <xmr:V9F6YQd4G5RMq_UFIOitAlOEqO4yRxVovRaeXgZisKN6HIdel3AauYZ8GKShjdYLfNeTnNjWg9u2PvZV4gHtIf-1Lzk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdegvddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeeurhihrghn
    uceurhgrthhtlhhofhcuoehhvghllhhosegsrhihrghnsghrrghtthhlohhfrdgtohhmqe
    enucggtffrrghtthgvrhhnpeevtdelgfefjeduvddvgfefhfeggfdvheejhfdvhfegudev
    gfeitddtjeffkeejheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehhvghllhhosegsrhihrghnsghrrghtthhlohhfrdgtohhm
X-ME-Proxy: <xmx:V9F6YSLR37om6QI6NHhTHdtKxT_SYqhyFwEMWcFSd_rygJnFdcCI3Q>
    <xmx:V9F6YdJbzCoLyo3DSP74rICc9VXSXNNjLYH70s1GNJbOVExlAgQDcA>
    <xmx:V9F6YbxgABYs_5-KJgisMqNIcmGcET7qfw3uoflh9Ry2NQ5ySMPPVw>
    <xmx:V9F6Yd2h9bZBl0f18xEyuukbWpEPKLwUOhRGh7Rvo67Ef4HoyCG02A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Oct 2021 12:35:35 -0400 (EDT)
Date:   Thu, 28 Oct 2021 12:35:34 -0400
From:   Bryan Brattlof <hello@bryanbrattlof.com>
To:     Senthu Sivarajah <ssivaraj@stud.fra-uas.de>
Cc:     vaibhav.sr@gmail.com, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: greybus: audio_codec: changed a void function
 to return 0
Message-ID: <20211028163534.mpoimdxtdirlsbmn@h510>
References: <20211028153808.9509-1-ssivaraj@stud.fra-uas.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211028153808.9509-1-ssivaraj@stud.fra-uas.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Senthu,

On this day, October 28, 2021, thus sayeth Senthu Sivarajah:
> From: Senthuran Sivarajah <ssivaraj@stud.fra-uas.de>
> 
> Fixed a coding style issue.
> 
> Signed-off-by: Senthuran Sivarajah <ssivaraj@stud.fra-uas.de>
> 
> ---
>  drivers/staging/greybus/audio_codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index b589cf6b1d03..9f99862791dc 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -1028,7 +1028,7 @@ static int gbcodec_probe(struct snd_soc_component *comp)
>  static void gbcodec_remove(struct snd_soc_component *comp)
	  ^^^^

If I'm not mistaken here, our options are to remove the return or just 
leave this as is. IMO I think this is fine as is.

~Bryan
