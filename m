Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9058730565E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhA0JBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:01:31 -0500
Received: from mail.strohwolke.at ([116.203.115.155]:57658 "EHLO
        mail.strohwolke.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbhA0I55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=strohwolke.at;
        s=mail; t=1611737828; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wdEsu7hTQGuu0Mrz/8QIkT1CtZl6ybGHwKUHQbqT7XU=;
        b=AvdFS6JXpcqRDcuxS/7y81Z+00YV/Fzeug1qg43MRy3DtxnTbdVzQoR92Pkr0hgNJxvcLE
        Lb39poyW7xyd9YX8F5UJfU4gRKMPxqey5u2OgZi2d6o5iLoimFTaQsIAZJmI+8c+TaoHjQ
        jeu4w3pFFE4Zsg9tdGdnzO+h/6brj14=
Subject: Re: [PATCH] dts: ARM: add kobo glo hd ebook reader
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210126173130.45427-1-apreiml@strohwolke.at>
 <20210126193419.1e067639@aktux>
From:   Armin Preiml <apreiml@strohwolke.at>
Message-ID: <97c3fa7f-f2eb-a59c-9bc0-670deeb90804@strohwolke.at>
Date:   Wed, 27 Jan 2021 09:57:06 +0100
MIME-Version: 1.0
In-Reply-To: <20210126193419.1e067639@aktux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback. I will do the changes.

On 1/26/21 7:34 PM, Andreas Kemnade wrote:
> hmm, pictures (we are talking about FCC ID NOIKBN437, right?) show two
> uarts, next to each other. Which one is this?
It's the right one (above the Board Identifier String).
> That is for emmc? And it is not populated, so probably better not
> enable that here.
ok.
>> +&usdhc1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc1>;
>> +	status = "okay";
>> +};
>> +
> and also not add this.

ok.
> If you are really brave, you could add a complete devicetree on top
> of my branch
> kobo/drm-merged-5.10 of github.com/akemnade/linux. Besides of backlight,
> it should give full hardware support (including a drm driver for the
> display), so we can see what is different and whether we can use
> a .dtsi file to define common things.
This sounds great. I'll definitely check out your branch. Yes I've also
seen in the uboot and kernel sources, that they've stored the board
details as a group with flags and versions to the sd. There may be some
similarity between multiple boards.

Kind Regards
Armin
