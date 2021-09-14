Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C2040AC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhINLT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:19:56 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:35099 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231851AbhINLTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:19:55 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 00C6C3200949;
        Tue, 14 Sep 2021 07:18:37 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Tue, 14 Sep 2021 07:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=zdCYHQsLazuTxNfijd9HbyHAzPrm
        rs4T+iZufyp+7cc=; b=T82sHDxdKWfQ8RTC8uHahQoUUg+/uSH2Zl3kEuyeFAqE
        AgpOdfUM27XhU+FkVEsiqpwwxqXvx3ZB0vfVQGR9fYr4TgxfJOxfcHCcFzTtyV/x
        PD9OkKk+3f/ziMqSw7iQRo2gU0Y8Hs0AqNK7JwomD6f8VO7Q4ydez7e+8N86eVCb
        Nn14oFGsnHaUyMkFPdk1GbxAB8Xt5JFDoHReV8e/ZrU5xqj8nI+znmiQWGir3Wmj
        AycFc+N5Bus+XM+BMhu+WZtGJM5ZWtM6twnT15TjCkxg7ZBLAYXvwJZm0ylIEtiy
        Ztq0qpGO5HFfWPYydvc0/MXzga/NECIZ4D/b0tU1Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=zdCYHQ
        sLazuTxNfijd9HbyHAzPrmrs4T+iZufyp+7cc=; b=C/seIXNLQRwmGTdo9ShNAz
        zZWiHq2bWKuvTvQ36uwFJbis4aa3C/Fn8orpbTfUVkokstBuHtrO6rY+ifHkjsgf
        lwtMhMqTvf/71jgZ4ytAsdYMcPDu4Z4ujII5V/yPatjiN+70cnsftLlqu0poisC6
        AdOY6PueW9zQx0FVPJYg+v0sf0mmcK+AsabbCejIxJRkzPI/X5/qODCa5px13FPE
        IjaIVTWeTvRCefGN/JV484Tj+p4BVvai+IzRko12EQlfmZ5abFxhSZA72NLmcus0
        5aXZyTjVItEwXxbqZefuRI8BG38RS28q1UtaB5gjuQhQxKi5HeZjGX7zuFy0MtqA
        ==
X-ME-Sender: <xms:DYVAYcjq9Qoz6wmhJKuDwG0XueJx_TtlA3cSwrzb1yMVFMlkD33hdQ>
    <xme:DYVAYVDD-sO3Y4JegB0hdqjEQnbPMz3257uakWeuEfoKNkz6arbkKjdxws2oFKpMZ
    ckvxuNhPjhkP3zmaxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:DYVAYUFhXyKbUv89bn5Qhe9p7yDBjjiwtag0gHU9ShTaueq5BssyBA>
    <xmx:DYVAYdQ6zJ644LsP2oxBuaIoFgFhhQWH_YJ9_sow3B5uYx_ov5I6kg>
    <xmx:DYVAYZxIg2lFgHL3LzeOx_hFLmyMDP9GCPJ0KSYbY3QH6KaByqkZLg>
    <xmx:DYVAYapM2JjweyIKqYEkYLX8UsTAPLcKl_VdLeQnpce3tTrOx-5RZg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0B09251C0060; Tue, 14 Sep 2021 07:18:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1291-gc66fc0a3a2-fm-20210913.001-gc66fc0a3
Mime-Version: 1.0
Message-Id: <05fe66fe-e1a3-46ba-bbd6-8b0a41109b81@www.fastmail.com>
In-Reply-To: <YUCAsmRLu1hBlfRI@kroah.com>
References: <20210914104253.61365-1-sven@svenpeter.dev>
 <20210914104253.61365-2-sven@svenpeter.dev> <YUCAsmRLu1hBlfRI@kroah.com>
Date:   Tue, 14 Sep 2021 13:18:16 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: tipd: Add an additional overflow check
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Sep 14, 2021, at 13:00, Greg Kroah-Hartman wrote:
> On Tue, Sep 14, 2021 at 12:42:53PM +0200, Sven Peter wrote:
> > tps6598x_block_read already checks for the maximum length of the read
> > but tps6598x_block_write does not. Add the symmetric check there as
> > well.
> > 
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > ---
> >  drivers/usb/typec/tipd/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> > index c18ec3785592..70e2d0d410c9 100644
> > --- a/drivers/usb/typec/tipd/core.c
> > +++ b/drivers/usb/typec/tipd/core.c
> > @@ -139,6 +139,9 @@ static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
> >  {
> >  	u8 data[TPS_MAX_LEN + 1];
> >  
> > +	if (WARN_ON(len + 1 > sizeof(data)))
> > +		return -EINVAL;
> 
> No need to crash anything.  If this is a valid thing for us to check,
> let's check it and handle the error, but we should not reboot systems
> that are running with panic-on-warn enabled, right?

Sure, that makes sense. I guess the same point applies to the WARN_ON in
the same check in tps6598x_block_read. I can add a patch to remove that one
to v2 as well.


thanks,


Sven
