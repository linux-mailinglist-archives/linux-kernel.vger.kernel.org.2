Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2887C38B03E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbhETNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239228AbhETNnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:43:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA2DC061342
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 06:41:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so5298353pjv.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lCDY3zqYN0TPm8XTDIr+feSz7CGQpYBusVmFxZWqbvU=;
        b=aYWpmcG5UzZYC+GcETZKyG/HHk9fPzAE6LU8/INOkQM5UZ1Yhm8j3OhGzZW0NjogHI
         q6fDF14+qqS3G+/gwiAo1S32FwPnRb/jZ5dOYjR720kR4CywTZk3la+dZv9d+wZcsSTN
         OBVzV8pjjA1u/jk4Ut+OypKVCJjV7ozSUeMhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lCDY3zqYN0TPm8XTDIr+feSz7CGQpYBusVmFxZWqbvU=;
        b=P5c7EQVCnJF+igXCo/Z+Rr/SyLpmcEIzPBItqVql223et52UdJF2QGtvcpQ236ejEY
         A13oe27fvYWs7Ivc4K0cGZOne5qvEJmm+4ri6MJhH7/6wHOPj6jDSXabxaaFTM3zKv+9
         fKL1dKjNdicvN7SlxTxmmJPsuCOpUYEdERtzV9WM89qqT4fR+gkg43PGJeF6pgx0AIYX
         Omqlo4q4VeISiz7od1+P/mINsEAC1MNMtNWGQvbQJIafRNmxP4DZh3Q31R/m4EelZ/2j
         a7Vs1svrcyChtXEqeH3hTMIyMvAnU31S2ux8RCdfv3Zvw8eJJ1c5ooDHxB69SU55ibDA
         V8TA==
X-Gm-Message-State: AOAM5325dUHt6XhkNe6tWy3mpEVP+zuS6naZRuDQCb27hiirZS3CU+1w
        vE8G1ptT2z6az11Ixiog4bL85g==
X-Google-Smtp-Source: ABdhPJxIYFp3eVKeAwRaBfZhep5/uA8j/WMPoEzhG5E+LYHkc9EzY3M3ZpacSfZlKO4VgWPceDGyhg==
X-Received: by 2002:a17:903:189:b029:f1:d67a:5168 with SMTP id z9-20020a1709030189b02900f1d67a5168mr5966517plg.82.1621518085625;
        Thu, 20 May 2021 06:41:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3d5d:d560:9fb4:d9d1])
        by smtp.gmail.com with UTF8SMTPSA id k21sm2111284pgb.56.2021.05.20.06.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 06:41:25 -0700 (PDT)
Date:   Thu, 20 May 2021 06:41:23 -0700
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
Message-ID: <YKZnA2bifn346bPa@google.com>
References: <20210511225223.550762-1-mka@chromium.org>
 <20210511155152.v10.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <YKPz7a68duMyXU5x@google.com>
 <20210518194511.GA1137841@rowland.harvard.edu>
 <YKQ0XxhIWaN37HMr@google.com>
 <20210519144356.GB1165692@rowland.harvard.edu>
 <YKWaJdrpj1ixx9+v@google.com>
 <20210520020521.GB1186755@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210520020521.GB1186755@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:05:21PM -0400, Alan Stern wrote:
> On Wed, May 19, 2021 at 04:07:17PM -0700, Matthias Kaehlcke wrote:
> > On Wed, May 19, 2021 at 10:43:56AM -0400, Alan Stern wrote:
> > > On Tue, May 18, 2021 at 02:40:47PM -0700, Matthias Kaehlcke wrote:
> > > > 
> > > > Could you also have a look at "[4/5] usb: host: xhci-plat:
> > > > Create platform device for onboard hubs in probe()"
> > > > (https://lore.kernel.org/patchwork/patch/1425453/)? It's a
> > > > relatively short patch that creates the platform device for
> > > > the driver from xhci-plat as you suggested in the v4
> > > > discussion.
> > > 
> > > I'm not the maintainer for xhci-related drivers.
> > > 
> > > However, there is at least one thing about this patch which looks 
> > > suspicious: Adding the onboard_hub_dev pointer to struct usb_hcd instead 
> > > of to struct xhci_plat_priv, where it would make a lot more sense.
> > 
> > I can move it to struct usb_hcd if that's preferred
> 
> Thinko: The patch already has it in struct usb_hcd.  I suggested moving 
> it to struct xhci_plat_priv.

Ah, didn't actively recall to which struct I added it to, it has been a
while since I wrote that patch ;-) Agreed that struct xhci_plat_priv is
a better place.
