Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068223A951F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhFPIgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:36:07 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59575 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231334AbhFPIgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:36:06 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AD5AF5C0200;
        Wed, 16 Jun 2021 04:34:00 -0400 (EDT)
Received: from imap8 ([10.202.2.58])
  by compute3.internal (MEProxy); Wed, 16 Jun 2021 04:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=TwoBR5Sy608Hmsly6D5Zi0Mw8N82
        sl4iSihnt+suvF4=; b=XUClGEbJTkOrWEipaWDltU0vtlwtLsimkN2rmKd9yGbr
        p2eZGTxnrO7sVgRREqOhVnwbzaqHUGnGN178re4P1fKAxQSzWo98EzRsYQ75Sn50
        Qu8+YmH+Il4B8kmehCr9W7YP3YUeQodE7NiKYliQOL1VznaKu1VrMaFOdP1kgny1
        3DVojfLptGMqlpolP255EZxgT8iQJseYVoge0FFnBquE49HT1vaaypcTowUm5KzK
        HyW01VhC/K6PGp/bsFVlcQ6qQwNvDKtV6CJYlPDQ3orbna0QvKhDo9kqL30rq0+C
        K6LhheJbb1rKVBeb4ZkjS7b5uzQ4RBZnhQiLwbTg0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TwoBR5
        Sy608Hmsly6D5Zi0Mw8N82sl4iSihnt+suvF4=; b=CRePq5TB+lF1rcYy/XEwgD
        AnQnIwt3674X8zSza6Ck8Ok0eZwablxQlIWxIW5lXRiGrYnZzE/fOqEaIofve+f9
        maQjfYZC3oqo1rBjW+Lz6tavJldFvWp8ubad0vpLvx2jZchdNr8lXaFjO1rbJQS/
        OrQrXqYP7FJZAuZsCtovXFRqKYQpU9VDEo1xQn6Mipj5GR24dP+hxGTz2obXoD+2
        rsuLFMhuBqKhr745aSqoE+PWs2TBYy59AsNCrZga8zeAC+eD0UwC9qFYBQYfbeK4
        ECfUYral3qazcY3MSTvQLLZ/NhbuSwQKej+iIhBX0JZ8DsY4nFgkx9seMoq9z8RA
        ==
X-ME-Sender: <xms:eLfJYF7gdDk7NXmFShuTgpotVPQZqXsx7sZY6Jo4jNlKzQL7CmAVhQ>
    <xme:eLfJYC4Y9hrYjfsrpQSeAh2yVs6_83Ch5WM4h46Dh7vT-M6XPmn5uf5QJ0mE1yeu-
    PM2VWtnNkAtzKsdrTk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomheptehlihhs
    thgrihhruceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrg
    htthgvrhhnpeffheffffeludeiiedtheduleetveeuveeguddutdejkedvvddvuefgledu
    kefhheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:eLfJYMf3SbouFJ9o9WPX5m4u0OCqrRsn8cfRrWk8eaJeF-PsQebQgQ>
    <xmx:eLfJYOK1cgi0ZgNnEbgfZ_RVhmmQGseGPu2P_EgvYRLBV1laOsTYoQ>
    <xmx:eLfJYJJB3IwOeSGb6wjugSvq3Ws0ruscif9HNTtUiadEN5dcRwlB9Q>
    <xmx:eLfJYHjbwRio-ceKScxEiiKtSFM4nzVes3uhvE9WdvsDg6kLP63-OA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6A7FB3A040C; Wed, 16 Jun 2021 04:34:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <ec3af3d1-204b-4dbb-8c36-a33764c798e8@www.fastmail.com>
In-Reply-To: <20210616034458.3499522-3-axel.lin@ingics.com>
References: <20210616034458.3499522-1-axel.lin@ingics.com>
 <20210616034458.3499522-3-axel.lin@ingics.com>
Date:   Wed, 16 Jun 2021 18:33:39 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Axel Lin" <axel.lin@ingics.com>, "Mark Brown" <broonie@kernel.org>
Cc:     "Lars Ivar Miljeteig" <lars.ivar.miljeteig@remarkable.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_[PATCH_3/3]_regulator:_sy7636a:_Use_rdev=5Fget=5Fdrvdata_a?=
 =?UTF-8?Q?t_proper_place?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021, at 1:44 PM, Axel Lin wrote:
> At the context with *rdev, use rdev_get_drvdata() is more intuitive.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

> ---
> drivers/regulator/sy7636a-regulator.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
> index c71c0a007d95..e021ae08cbaa 100644
> --- a/drivers/regulator/sy7636a-regulator.c
> +++ b/drivers/regulator/sy7636a-regulator.c
> @@ -35,7 +35,7 @@ static int sy7636a_get_vcom_voltage_op(struct regulator_dev *rdev)
>  
> static int sy7636a_get_status(struct regulator_dev *rdev)
> {
> - struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
> + struct sy7636a *sy7636a = rdev_get_drvdata(rdev);
> int ret = 0;
>  
> ret = gpiod_get_value_cansleep(sy7636a->pgood_gpio);
> -- 
> 2.25.1
> 
> 
