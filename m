Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64233A94DF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhFPIXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:23:55 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40885 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231245AbhFPIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:23:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 35EA25C01F1;
        Wed, 16 Jun 2021 04:21:48 -0400 (EDT)
Received: from imap8 ([10.202.2.58])
  by compute3.internal (MEProxy); Wed, 16 Jun 2021 04:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=KCoXZt4Cft/f1cQILn4U+MwRm5df
        AcTHJ0SChYhfoS0=; b=UJlyvp4eU7amyLvC6pIlBfPxPpsqSZe0cpFZH/Ecm1w1
        lcoKCAoqFpiaXooSAFLXFW0z+9kvUM4/6JKrRGJ4CeUs7NKYFjqQrU7E8i7nF8yS
        ObWG8XZ5YsuJcacgvN7PmotoKkThdX8umuG/GG6kZSVwgno/5PXbJgatmpLxgPnx
        vtqnGCGPaKNqmmLstADIA4YnXNrwp4KrvsFq8/Lost6DevxjLy+jPaMrJorP8n+r
        qQpgSnXr/FC/gDMPpDG7TNR9zJNv2CGfYswlvuX9GpVeaKROzBQ5p33eSjDQtiyP
        LReeweo2JzDjBSWDwvNatw9y4Y7wiC6hxlh1xzNCxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KCoXZt
        4Cft/f1cQILn4U+MwRm5dfAcTHJ0SChYhfoS0=; b=wBtogdmuo788kl9I2X9fyg
        klr8fXjv90iAKyoVUqCzypVYfY+VHazKlrl4EfNZs6Rf46oA6poKK90CmkehstnO
        8vWHcIzRZa+CtxPEc2hSQ8Ta43KZx6Vq20Ly+0gDmLxJLfV4XBAzRzB44XvlIq19
        to4WsiozX/EPATm6CI0NoACTcOVGCFqeCLkYWk5qllBY3iEetvegzIETnrgS7xcG
        dTX1yv87y9QQnh/izG2XDr+/DULDQ8GhQ7hiIqqKYTqLNRdIVpCKte/rzxucOcap
        o0w1X7LcMWxSRlyJ/sIPtsiHNsjnuyXHuByvZ7xrV5DaGw5HC7Bmr7vHkmdtyBIw
        ==
X-ME-Sender: <xms:m7TJYLw8ULbMS0rCCgMD6s1kqBnFOAaOsOYVvZUYCD_YkokEullwZA>
    <xme:m7TJYDTgAATAkUEpnul3hVFGcWI046zZ6dbPMs9ZD55lePr0r0AuMREkyZMhmXN7Y
    H06Ri6zZuILj2s870U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomheptehlihhs
    thgrihhruceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrg
    htthgvrhhnpeffheffffeludeiiedtheduleetveeuveeguddutdejkedvvddvuefgledu
    kefhheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:m7TJYFWGHj26YSBHQmxQZksC1xGhspseE1X8a9lENDAS0E9TlE3qGw>
    <xmx:m7TJYFj87kNQsAaQiMxpsHh-umg6xHF28jJHcAzU2pKQwiiZdJbGiA>
    <xmx:m7TJYNBF3NBfC7dZcLOis2057y1o-sjsTLYf85LKaer3YYyoHjNjAQ>
    <xmx:nLTJYK46mGyArh7tWdeYSBRq_GDwu45ClhDSTf7jw6WFGTCwacjang>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C775B3A040C; Wed, 16 Jun 2021 04:21:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <f104cc23-b674-4496-a416-6d582820f429@www.fastmail.com>
In-Reply-To: <20210616034458.3499522-1-axel.lin@ingics.com>
References: <20210616034458.3499522-1-axel.lin@ingics.com>
Date:   Wed, 16 Jun 2021 18:21:27 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Axel Lin" <axel.lin@ingics.com>, "Mark Brown" <broonie@kernel.org>
Cc:     "Lars Ivar Miljeteig" <lars.ivar.miljeteig@remarkable.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_[PATCH_1/3]_regulator:_sy7636a:_Add_terminating_entry_for_?=
 =?UTF-8?Q?platform=5Fdevice=5Fid_table?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021, at 1:44 PM, Axel Lin wrote:
> The platform_device_id table is supposed to be zero-terminated.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

> ---
> drivers/regulator/sy7636a-regulator.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
> index c384c2b6ac46..54ab1be1001e 100644
> --- a/drivers/regulator/sy7636a-regulator.c
> +++ b/drivers/regulator/sy7636a-regulator.c
> @@ -110,6 +110,7 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
>  
> static const struct platform_device_id sy7636a_regulator_id_table[] = {
> { "sy7636a-regulator", },
> + { }
> };
> MODULE_DEVICE_TABLE(platform, sy7636a_regulator_id_table);
>  
> -- 
> 2.25.1
> 
> 
