Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A45E3A94E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhFPIYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:24:17 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37367 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231344AbhFPIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:24:16 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 36F465C00D9;
        Wed, 16 Jun 2021 04:22:10 -0400 (EDT)
Received: from imap8 ([10.202.2.58])
  by compute3.internal (MEProxy); Wed, 16 Jun 2021 04:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=CBYVAp3+AVjvLUzw4bv5C+wMLBO0
        hjWPcQswY8gmBho=; b=XLiII+RDuzgCAdXUhIo+a9CphimSuz0vMEbqYiJfd8yc
        MCfNOu8VfEvNtwXQLjELRvF33n9w8iL+JxrD+PnvpBu2zJj//jal8CWlVn6EKL5E
        po4bmlWE7iil9Lej6Kyo0LNHHX5rFol2ZJhp41XSKtUjyUwFUyivjUFhjhPGk1dY
        AJmvWthTeAo22djnVg1iqKizIaF7kmkVhAIu22kY2Fz8xo1TEhJeXSp8CyhSFCVx
        0RslpcW+6EfOn7/1jZcQbVQFCKaMRphLhJr3qydffPL5nz5T/AvA59TI8RKreoH5
        BkUSwP48dhGaZz27U1PWwHfOxXVKMvWlfA7kMJW5qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=CBYVAp
        3+AVjvLUzw4bv5C+wMLBO0hjWPcQswY8gmBho=; b=Ftdkhc2ilaiU0D8IM8wKpQ
        wXl7SgmPEIkOaswpvkDILAF21TQE4CuhKC3bRCZXEi2hh6rvU2RjjS0SzCrl6G3r
        55fXvVUcnEFkUh9nAcCxyxIAnJT43T57CypT00JeO8t2oXp9OKu4w+JUg/0atpoF
        Dnn/5xThPgUB7lBsW2ff3/+rHHE9M3T2WtP54w/C9rp1TBe1vPP7XKevuptYWDFJ
        +kCDMZ4R3MJMruQxr9kp3qqSFjMSpvLfSpfgKqEzoV/w4KCa7MCp00KF+dElbHT3
        W7hZSR+frBrBwycLPEdLv9Rw4p3mMq7p+RcRu3aOV5sj4b4bjPfAqhcSqiSfSI1g
        ==
X-ME-Sender: <xms:srTJYIfmvHc8AzMdasf7GlcCaPr0Hc86Mo7GlWwe__-XBikyLSv0Ew>
    <xme:srTJYKON9ZASm-C11NWnoBkok-5k6gDJvtNJvoRgv_lGovOVua2XCkGldYJoo-MSa
    EqIgMEcZTUzpJAKSNI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomheptehlihhs
    thgrihhruceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrg
    htthgvrhhnpeeuffekveehjeeltdeuveeikeelkeejhfejheduhfdtgfdtgfejjeekvdev
    jeevueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:srTJYJgYcjkhoWPrwFqTyqY1QAXjMvXmkldSzhvdgLXvjs4jfjXcUg>
    <xmx:srTJYN90sLgUA2L0mfMDXM7KN5y1jzKBuzQ5n_UQwmFSVICEzkmeJw>
    <xmx:srTJYEvh-YcR2BqeSfOMIJ9SY3nc0D11YeqIEjCjmUu0zx6J908wDw>
    <xmx:srTJYBWd5-e6SbO3z3MkKFTA2T5pPawQ7dZt1RtFAesvpOWsUcH-oA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 147253A040C; Wed, 16 Jun 2021 04:22:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <995cb2a4-f99c-4601-91fe-966c088eaa58@www.fastmail.com>
In-Reply-To: <20210616034458.3499522-2-axel.lin@ingics.com>
References: <20210616034458.3499522-1-axel.lin@ingics.com>
 <20210616034458.3499522-2-axel.lin@ingics.com>
Date:   Wed, 16 Jun 2021 18:21:49 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Axel Lin" <axel.lin@ingics.com>, "Mark Brown" <broonie@kernel.org>
Cc:     "Lars Ivar Miljeteig" <lars.ivar.miljeteig@remarkable.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] regulator: sy7636a: Make regulator_desc static const
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021, at 1:44 PM, Axel Lin wrote:
> It's only used in this file and never changed, make it static const.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

> ---
> drivers/regulator/sy7636a-regulator.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
> index 54ab1be1001e..c71c0a007d95 100644
> --- a/drivers/regulator/sy7636a-regulator.c
> +++ b/drivers/regulator/sy7636a-regulator.c
> @@ -53,7 +53,7 @@ static const struct regulator_ops sy7636a_vcom_volt_ops = {
> .get_status = sy7636a_get_status,
> };
>  
> -struct regulator_desc desc = {
> +static const struct regulator_desc desc = {
> .name = "vcom",
> .id = 0,
> .ops = &sy7636a_vcom_volt_ops,
> @@ -61,7 +61,7 @@ struct regulator_desc desc = {
> .owner = THIS_MODULE,
> .enable_reg = SY7636A_REG_OPERATION_MODE_CRL,
> .enable_mask = SY7636A_OPERATION_MODE_CRL_ONOFF,
> - .poll_enabled_time = SY7636A_POLL_ENABLED_TIME,
> + .poll_enabled_time = SY7636A_POLL_ENABLED_TIME,
> .regulators_node = of_match_ptr("regulators"),
> .of_match = of_match_ptr("vcom"),
> };
> -- 
> 2.25.1
> 
> 
