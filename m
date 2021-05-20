Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E66838B8D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhETVPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhETVPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:15:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A6BC061763
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:14:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g24so9804316pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JDuRhdD0c+I8x9p2xseG7EsWF35hPeDyR9fNC7DqgL0=;
        b=ChvS/XCpiCjagokqDdvJr+aJoJuu4cFnMUg2lcjpmf6uYamCI71lziN+fHQ7mbexEj
         itAg6b8BvXH4iwtz3uFLDaAGfP8hb4NFtgZCiC9azDp+lk5A5wrSjjbJaErvsVZdJzeQ
         fWUwfNUsxb0z3kUN5Zud/t8V1s546c+98Bu+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JDuRhdD0c+I8x9p2xseG7EsWF35hPeDyR9fNC7DqgL0=;
        b=aHyd2XI9Odau40eJeDenTn5vfWHHR7z/JzOJHBLkxb31QL4fG8Es873K5T7lnPXkRY
         kVlsPVna7+7ajnIfS5oeF1AMJstDSMqPFPCBlOFVIagGmamI5tLN55UeT8di2bB8r/KS
         yoGc2ZOO+TR66ZzDd0G37WiZtUIxfBiRnJ7y6zNp1C9LclFopq3GDq2UlGyIVeAhsJjC
         mBAUXY+2aEtYVizvswwkOdzxh7iHrGb3zPYRi5qoLiKy2F676YdO7Z49E72GbFOZLDIq
         9YbEJDlJBrhNj9ObYd6k4cFuIggcwSQMRO5NjOocav1ClROJXS1gynVvFOBJ4Sjy/TLU
         BX4Q==
X-Gm-Message-State: AOAM533RQFxpEfv3845Yu25sZr+juOxsw3Ak5aGFpMst1Dp2RYuR3BLN
        Djj7J8iV1u7b2RilNH+Q5yE2YQ==
X-Google-Smtp-Source: ABdhPJxRARguFLWFtqDDIo6kBbex1/oE8L/Z6VvTahbOh853k3DU7m91wAjdpyBTkBpmnu3t2dcjog==
X-Received: by 2002:a17:90b:1955:: with SMTP id nk21mr7314169pjb.208.1621545257677;
        Thu, 20 May 2021 14:14:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7ac6:cb3b:191b:54f3])
        by smtp.gmail.com with UTF8SMTPSA id c19sm2125745pfo.150.2021.05.20.14.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 14:14:17 -0700 (PDT)
Date:   Thu, 20 May 2021 14:14:15 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Al Cooper <alcooperx@gmail.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v10 2/5] USB: misc: Add onboard_usb_hub driver
Message-ID: <YKbRJylHrDiuSRGH@google.com>
References: <20210511225223.550762-1-mka@chromium.org>
 <20210511155152.v10.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <YKPz7a68duMyXU5x@google.com>
 <20210518194511.GA1137841@rowland.harvard.edu>
 <YKQ0XxhIWaN37HMr@google.com>
 <20210519144356.GB1165692@rowland.harvard.edu>
 <YKWaJdrpj1ixx9+v@google.com>
 <20210520020521.GB1186755@rowland.harvard.edu>
 <YKZnA2bifn346bPa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKZnA2bifn346bPa@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 06:41:23AM -0700, Matthias Kaehlcke wrote:
> On Wed, May 19, 2021 at 10:05:21PM -0400, Alan Stern wrote:
> > On Wed, May 19, 2021 at 04:07:17PM -0700, Matthias Kaehlcke wrote:
> > > On Wed, May 19, 2021 at 10:43:56AM -0400, Alan Stern wrote:
> > > > On Tue, May 18, 2021 at 02:40:47PM -0700, Matthias Kaehlcke wrote:
> > > > > 
> > > > > Could you also have a look at "[4/5] usb: host: xhci-plat:
> > > > > Create platform device for onboard hubs in probe()"
> > > > > (https://lore.kernel.org/patchwork/patch/1425453/)? It's a
> > > > > relatively short patch that creates the platform device for
> > > > > the driver from xhci-plat as you suggested in the v4
> > > > > discussion.
> > > > 
> > > > I'm not the maintainer for xhci-related drivers.
> > > > 
> > > > However, there is at least one thing about this patch which looks 
> > > > suspicious: Adding the onboard_hub_dev pointer to struct usb_hcd instead 
> > > > of to struct xhci_plat_priv, where it would make a lot more sense.
> > > 
> > > I can move it to struct usb_hcd if that's preferred
> > 
> > Thinko: The patch already has it in struct usb_hcd.  I suggested moving 
> > it to struct xhci_plat_priv.
> 
> Ah, didn't actively recall to which struct I added it to, it has been a
> while since I wrote that patch ;-)

> Agreed that struct xhci_plat_priv is a better place.

Or not, xhci_plat_priv is optional, which doesn't make it a good candidate
for holding a field that could be used by any xHCI controller.

Should I move the field to struct xhci_hcd instead?
