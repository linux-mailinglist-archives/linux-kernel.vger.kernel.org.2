Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD76539A3E1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhFCPDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:03:48 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54725 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231228AbhFCPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:03:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 35AAF5C0099;
        Thu,  3 Jun 2021 11:02:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 03 Jun 2021 11:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=0HIisfxA5dTWqdfe+GombLbxAER
        gPt2GjHpbX0Q+X/w=; b=2kXWyUHzy1Y4vfP8nNmuwdemo26kvXp+cfAes7hkS3q
        /a9OoSfNolk177p56a/9aM0y39F+3SXeeoaCf5+hg8/SP0dfoQbn9VYnqCBhxBQ4
        fXSpqy1roKXAQzQ5ljBZUWSDgz5w/vfGtRPrlhI2MHtbbAJe7XranTkW8FxHYl8n
        1xTvoLOoZAu7yxRBLwg4w+081KhlCfq4yX3MkhlNWV1MAag2K0zRWQ4K+yMntM/r
        3Rai26yCSzdTGd8+Cq1PsGXhPPhJ0zT7e+bTGA9TXewi2d+9MsrZNRZtwPJCa2oM
        vK+XnMxubxK5vm2nNg+HleVCLIDnCUz2qKGgZMa04EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0HIisf
        xA5dTWqdfe+GombLbxAERgPt2GjHpbX0Q+X/w=; b=fE8UHn3YowsxE0qYhMurup
        bYNnah78+g5Hv/QYS5YLTyOzIPgecJf33LdyKvGStuAtNviw8+px9Y/O16Wv7n9L
        ney9BwfkKSu1FaqE1ctGrqKRMOCiiDeinn9ZDu1E0OqeKk+rtgAmm5cYzlOxv+/4
        ZXuoaACwWJOOC12qfp0i8kRm9Mu7wm5jnVxo7FKGvv21Xgq+L8YvWTC5rdwTFYX7
        8lCnIleENgFK/YtC26jj/2dNaDLxBrq10/WdoYB4ckvw9bYYgXjddNrZ+8RsVw+r
        OzvjKVDG5obs6CzB2zXZOuQJNi+gISvmWUlLAP4tKPLOwLvdHG9D20nxosLhHEug
        ==
X-ME-Sender: <xms:6e64YKcxeJf6VXeaTwcYOj8ZcDiQj-F0LDlK22hPRiJy-kRrVke4Gg>
    <xme:6e64YENKs1q7uyXufnAAIK7QJU_iIFGl6nDmilmOnbbj37u_CwFEEXfdNQftVhHdo
    Pik7RWPiW7vaWrhzwk>
X-ME-Received: <xmr:6e64YLgoMzoEeCDENZOcLNfl6EQjrsqzHRLshRdiWo8MulKF30Y7xJL8y7sSPMZirHpIJaXLPBhtmzD7IK67WeyXEDsPsMa9Yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdelledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeelhfeugedvjefgjefgudekfedutedvtddutdeuieev
    tddtgeetjeekvdefgeefhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:6e64YH8S4RxT17EPJEIr6uGI-WFxy1J2KM1STZJQIVneNSrEOXxHGQ>
    <xmx:6e64YGu-yu2_9qnhY9uG5i-a1dirxOHlX7L-theya1zCeCnMS2gZ7A>
    <xmx:6e64YOHR8TuddI6rNELZmKiNHiZgbr6GyKJ4czD_dq0ogEy6HW_Zew>
    <xmx:6u64YP4NqUrv3aHW_nM1ODlzTY1N4f7-ZnfRZITWhTxlG5BF2D-Kgw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jun 2021 11:02:00 -0400 (EDT)
Date:   Fri, 4 Jun 2021 00:01:57 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com
Subject: Re: [PATCH -next] ALSA: firewire-motu: fix error return code in
 snd_motu_stream_reserve_duplex()
Message-ID: <20210603150157.GA3437@workstation>
Mail-Followup-To: Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com
References: <20210603143203.582017-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603143203.582017-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 03, 2021 at 10:32:03PM +0800, Yang Yingliang wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: e50dfac81f73 ("ALSA: firewire-motu: cache event ticks in source packet header per data block")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  sound/firewire/motu/motu-stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
> index 43ff5be32b15..9e6ca39ebd7f 100644
> --- a/sound/firewire/motu/motu-stream.c
> +++ b/sound/firewire/motu/motu-stream.c
> @@ -191,7 +191,7 @@ int snd_motu_stream_reserve_duplex(struct snd_motu *motu, unsigned int rate,
>  		if (!motu->cache.event_offsets) {
>  			fw_iso_resources_free(&motu->tx_resources);
>  			fw_iso_resources_free(&motu->rx_resources);
> -			return err;
> +			return -ENOMEM;
>  		}
>  	}
>  
> -- 
> 2.25.1

Indeed. Nice to catch it.

Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto
