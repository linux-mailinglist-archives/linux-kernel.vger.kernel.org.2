Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329AE3C34B3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 15:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhGJNNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbhGJNNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 09:13:00 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9FAC0613B4;
        Sat, 10 Jul 2021 06:10:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m17so18454985edc.9;
        Sat, 10 Jul 2021 06:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m+2uDLVnJqvxnopDKdmW/+zUCo6k/oZnFyd1ECUsC0Q=;
        b=P68we8SNJ2sqUT2CvfLm2T71TYpBDWvsKg7gFB24igqRL7zT7U5KJ4j7qMX8OIU8G8
         dmGkQTSUg0f/xE52cnGQSgoqqz0wsZcJ3llsDjDB4r4Ax/Tdvub9hdu/wbYOryb5W0e+
         /4Rh1O0Uxtm7X7IXR4UJPnJd4lw1sBFlpX8WUyOobvs76B+6J8ypOZQEuM1SVdJ4NIp5
         XdrBK+wvaymKhxtV6Y9U46g50WbmQwuItykLbxabWbyS5BaUVOrZgD7UjkVjEET1TEC6
         46Dc0+ZgkkKey+v5EKI7TpE5jeGJZsLWoAro4vDawKiuIhVYy/+qy5+BMoBQxZRKGdzJ
         wJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=m+2uDLVnJqvxnopDKdmW/+zUCo6k/oZnFyd1ECUsC0Q=;
        b=lYhE9GC0/E+XZzx3F/zadr+eHdIBljVIpv0VCmNlt8fXV/7YeImfwN8pjSrjt6e5Gc
         QDE8PI5N3nrEbQoNknJQEHMVgjR/DNfXFQ4jGox4pnWbM5I/rI+M5a2l+cveQnNmDApv
         d2OXpbG164ziAH/8DGiOcpHzV9ENioNBooDk5FmZVdLBm/0UezRqyTyxhEnMa3LA+YvF
         d/Xlwx6VIuNf/9eGDYiHRheGQhjh3wxfkAHGQJxpG+oiSpetSqPzzCQSLmIXIPhY6gtx
         XIwxpYbNQeWflMSJJHLpSil9sSSbiHuXQwXUf2gOd9MmiQkVCnbVVKXB0f/TCdgMpa8J
         3geg==
X-Gm-Message-State: AOAM532sdlyR1EzpzsPV60e3PATvlYpXr86YGUvq4PBoHrMJkeUeJkhc
        wDt33pCGc/SEowI108C3cGM=
X-Google-Smtp-Source: ABdhPJxLMZjNkBTHposEZBtwu92P2ac+tWFu+M8LeM7SSsF/AYfd57LXQAjUn40pivT1nrTwBo9L2w==
X-Received: by 2002:a05:6402:20e:: with SMTP id t14mr52600538edv.193.1625922600001;
        Sat, 10 Jul 2021 06:10:00 -0700 (PDT)
Received: from eldamar (host-80-104-22-174.retail.telecomitalia.it. [80.104.22.174])
        by smtp.gmail.com with ESMTPSA id l16sm3748873ejb.26.2021.07.10.06.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:09:58 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sat, 10 Jul 2021 15:09:55 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Vagrant Cascadian <vagrant@reproducible-builds.org>,
        "B.R. Oake" <broake@mailfence.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix ethernet phy-mode
Message-ID: <YOmcI191mbxXCrp1@eldamar.lan>
References: <20210524122111.416885-1-carnil@debian.org>
 <20210524123506.cuwwtqgtejquuq5e@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524123506.cuwwtqgtejquuq5e@gilmour>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, May 24, 2021 at 02:35:06PM +0200, Maxime Ripard wrote:
> On Mon, May 24, 2021 at 02:21:11PM +0200, Salvatore Bonaccorso wrote:
> > Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
> > config") sets the RX/TX delay according to the phy-mode property in the
> > device tree. For the Orange Pi Plus board this is "rgmii", which is the
> > wrong setting.
> > 
> > Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananapro:
> > Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which gets
> > the Ethernet working again on this board.
> > 
> > Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> > Reported-by: "B.R. Oake" <broake@mailfence.com>
> > Reported-by: Vagrant Cascadian <vagrant@reproducible-builds.org>
> > Link: https://bugs.debian.org/988574
> > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> 
> Applied, thanks!

Did this fall trough the cracks? 

I see it in
https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?id=b19d3479f25e8a0ff24df0b46c82e50ef0f900dd
but got not merged yet in mainline.

Thank you for your work!

Regards,
Salvatore
