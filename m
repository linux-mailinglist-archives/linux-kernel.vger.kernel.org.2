Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450E143F5E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 06:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhJ2EMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 00:12:39 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41055 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229542AbhJ2EMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 00:12:38 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id C96D55C01C6;
        Fri, 29 Oct 2021 00:10:09 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Fri, 29 Oct 2021 00:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=UYI7x8drKFo+z2c59k1zz18ttLncojn
        V015Ms+RXfkk=; b=NJew601mql0ZaKz1pQpGByp1l2uktlg6YuBOi8oQf1uRff7
        BMIbucowOBmJ9pkdYEFx4yQYVjEXmxp2r00L79q2FvYl6SVgmreNJtlT6vtLXHPC
        KG0sV2igMbJJPnaY2cpx0Uxm7P3Gv77WWkSEfC6x4tko4Jkd5MjyLpcD6k7QbOnV
        7cTb3iqXU335Hu24/8yR9gScjsrgXk4Av1KaUarJWHiV8Z0hRrKVINWNDby/5snB
        +eUZvmCCrs4oZsPROaDYaGT1W0EJH60Ppc9ihJIU1aoKSLMHCD/BjW6L+jaj1rhd
        OrS849+oTQbCrMoQzxLCkwWTfR98trb3akRcOcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UYI7x8
        drKFo+z2c59k1zz18ttLncojnV015Ms+RXfkk=; b=lkwOL57IK5TaLqKr5WRrPj
        5RjN8jQIZKMiUI5utD6v6etlmr3dYirPSyQWmbhNZf5beKhTghFXvQ64uB18j/UA
        7cFeRMnV60xHbjqE9UyJMe1na6z3yHuFxurY3PGe7qPB7oULUeDfrg8bgvFSZufa
        7o6uVoZPGlsG+zW65s+qDWXNrXVwQ5PHMumNtATDDbg9OzI7cLjlojGdBxuP1lyj
        0Ky/zdBtEPXAPiOQrCdLFQthQmp1JcGqEIGqQe37T/cGw2nv4bawcPwYnulDmBXL
        FOGAXZmRl9rYYWg9ni+brfaF11hxYSpE8gYtG2a5QoKkHANHMG+kKf0jiHxB7RvQ
        ==
X-ME-Sender: <xms:IXR7YX4kI4ozS3epy37kf2wSR2FHzbbS060jPjG71Itop0ZpEMsnKQ>
    <xme:IXR7Yc7Z3ZO4yScikn1Plj5ERHQ3tcvj4CtTwqnBAzhhxRKxoP99RNBvqsueAa2Cu
    uqEwTRIS84iMKDA6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdeggedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:IXR7Yecobax7M1TTqf9axnYPHeFt6LpKILX__ml_Mi0R_5QsqUCRpA>
    <xmx:IXR7YYJgEckDFRZ02tvTtZDZZQJN-RmwROMYlh3sL_7nEsSEoeIYtg>
    <xmx:IXR7YbKnNinUg2ztu8V1pkcKOsMzScbHCBjcKo8C_IaLVOAi9tm0NQ>
    <xmx:IXR7YT2c4jmBgHj5Zc95-WxbDNekaga6YrrrH9B_KEfABmWksw85HA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 61A93AC0DD1; Fri, 29 Oct 2021 00:10:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <e9d50c0b-3d34-4b01-865f-4170f8ddc288@www.fastmail.com>
In-Reply-To: <ecbfa15e94e64f4b878ecab1541ea46c74807670.1631048724.git.christophe.jaillet@wanadoo.fr>
References: <ecbfa15e94e64f4b878ecab1541ea46c74807670.1631048724.git.christophe.jaillet@wanadoo.fr>
Date:   Fri, 29 Oct 2021 14:39:49 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Corey Minyard" <minyard@acm.org>, "Zev Weiss" <zweiss@equinix.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ipmi: kcs_bmc: Fix a memory leak in the error handling path of
 'kcs_bmc_serio_add_device()'
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Sep 2021, at 06:36, Christophe JAILLET wrote:
> In the unlikely event where 'devm_kzalloc()' fails and 'kzalloc()'
> succeeds, 'port' would be leaking.
>
> Test each allocation separately to avoid the leak.
>
> Fixes: 3a3d2f6a4c64 ("ipmi: kcs_bmc: Add serio adaptor")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Sorry for the delay

> ---
>  drivers/char/ipmi/kcs_bmc_serio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/ipmi/kcs_bmc_serio.c 
> b/drivers/char/ipmi/kcs_bmc_serio.c
> index 7948cabde50b..7e2067628a6c 100644
> --- a/drivers/char/ipmi/kcs_bmc_serio.c
> +++ b/drivers/char/ipmi/kcs_bmc_serio.c
> @@ -73,10 +73,12 @@ static int kcs_bmc_serio_add_device(struct 
> kcs_bmc_device *kcs_bmc)
>  	struct serio *port;
> 
>  	priv = devm_kzalloc(kcs_bmc->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> 
>  	/* Use kzalloc() as the allocation is cleaned up with kfree() via 
> serio_unregister_port() */
>  	port = kzalloc(sizeof(*port), GFP_KERNEL);
> -	if (!(priv && port))
> +	if (!port)
>  		return -ENOMEM;
> 
>  	port->id.type = SERIO_8042;
> -- 
> 2.30.2
