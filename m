Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21C440A564
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhINE3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:29:03 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:32815 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231393AbhINE26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:28:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id F36733200AFD;
        Tue, 14 Sep 2021 00:27:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 14 Sep 2021 00:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=D21R8AWr21ZjOOvFqpKdwkdBiCd
        nFG/TDv8yfPnl1AU=; b=ORtpZSGvcCsa9juWSjZkzxF/CmNJnhJozQKVuFeGvSV
        53Fp0dHzdP052qUIbxPYK63yFFf8gPK2ETD3kkbQUF2CB70NhxlUbxIiUvfvKkMa
        ZUDACMSLccJDFLCMjgkqNJa4JsZDMJgNFoIf2X7y8f2pbD1Rb/pdhydX29qBOvNb
        KtUwG7dMoRzw9U0A4OVlaEfU+fPEPz5cAuyeqpKKaBYe6DIKwcPsn/fm2Yb2EaI5
        E/ULg26NfS3nrOUAofPCG6+eswGoV6X6DqxbiHoUVUPYKpL01wJmacNQHmy0MYkx
        yajvt7UTpYExQVsRDbXoBQOQ9FWvi935RpuBRto8nAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=D21R8A
        Wr21ZjOOvFqpKdwkdBiCdnFG/TDv8yfPnl1AU=; b=nBfM4KMj/xyIYmXGRxFafh
        U5ZLI866LPTsVoa7cQeOlSp0FE70SeqNMeSo7J0nSBTJYsBeqZ/Mc5Q0g2xRcVRN
        MRrefm8wPksCIlnY90oaYYGOGwvEdknkR+/AxC42fpA6gQ/SZmCrUvEOxQ3T1NmZ
        9WByrRSRjk3e4dHidkCCF6hP7GGUfOMYpSIIksaqNFVXrhIsbXF1hLjU0ALOsPsf
        4f0Pm5+15pJKkLgBn5ZhQ3PecOsy0HKKJoQpPAePOehl50JA9x2vYaqrEectOjF2
        dXm34IqehCtb+zEsspDj71Fcnd9lNBiZWTavRmpLvx5sb+7HgE26/RJTsHPW+Qow
        ==
X-ME-Sender: <xms:syRAYds72Ma4zOUT9zknOw7f8DTotBm4DZb9U-a1Lim3kGbHHyz8cg>
    <xme:syRAYWdask85YPeZLFDuHIKsfGyzCxpAVC0P4mK4zUECfFSdpG0HhsZ_W4JxyJUBv
    1yX1axkU5JSJw>
X-ME-Received: <xmr:syRAYQxgfcxnhDtdvl0NRRpFQd4vIJSZod6z-Y_3NAbnuGAYJ41_xsGwOYEsvzkDPZULPElMT7iAZUFIczY4VEFD2sDAPL9F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegkedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmrhhorghh
    qdfjrghrthhmrghnuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrh
    hnpeelfffhffehvedtueetleehkeduueeuteffudfgleetueefueejheetvddvfeetuden
    ucffohhmrghinhepuggrthgrrdgurghtrgdptghhrghnnhgvlhhlihhsthdruggrthgrpd
    hmrgigtghhrghnnhgvlhhtihhmvgdruggrthgrnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:syRAYUMZoO3xfEnmFX7eFTmYLdB9YqOsCwwxI_fP11Ui8dPJ7wIG3w>
    <xmx:syRAYd-35KNZ0AaPv2DFXvmYc4OlWBKIUhcVFKZC7m8wLbGq_H070w>
    <xmx:syRAYUVAD6qLTdvFuw42ifE2jyAtX5zwKJ56ExUUlE5TQYPGqTKfMA>
    <xmx:syRAYfJBtf88twrlpDILjA03k1QWCgqztwXf8gphuqBK14tWo9pCZg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 00:27:31 -0400 (EDT)
Date:   Tue, 14 Sep 2021 06:27:10 +0200
From:   Kroah-Hartman <greg@kroah.com>
To:     Tawah Peggy <tawahpeggy98@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Staging: wlan-ng: cfg80211: A better fix for: Lines
 should not end with a '('.
Message-ID: <YUAknrSU55x+1WJ6@kroah.com>
References: <20210913220836.GA3790@peggy-InsydeH2O-EFI-BIOS>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913220836.GA3790@peggy-InsydeH2O-EFI-BIOS>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:08:36PM +0100, Tawah Peggy wrote:
> This patch fixes the checkpatch error : lines should not end with a '('
> by reducing length of function name to enable the arguments be passed on a single line.
> 
> Signed-off-by: Tawah Peggy <tawahpeggy98@gmail.com>
> ---
>  drivers/staging/wlan-ng/cfg80211.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index 7951bd63816f..711c88c59e78 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -328,8 +328,7 @@ static int prism2_scan(struct wiphy *wiphy,
>  		(i < request->n_channels) && i < ARRAY_SIZE(prism2_channels);
>  		i++)
>  		msg1.channellist.data.data[i] =
> -			ieee80211_frequency_to_channel(
> -				request->channels[i]->center_freq);
> +			ieee80211_freq_to_channel(request->channels[i]->center_freq);
>  	msg1.channellist.data.len = request->n_channels;
>  
>  	msg1.maxchanneltime.data = 250;
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
