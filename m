Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3214D38BBC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbhEUBl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:41:56 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:36677 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbhEUBly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:41:54 -0400
Received: by mail-ot1-f50.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso16649393otn.3;
        Thu, 20 May 2021 18:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0BIMIr+vPahmBauXRfzt2P0Ds58ZfqNsm2Ee2f6z5uE=;
        b=L12BMOwLqKhAvBPNRjosE9SifHaNwafJ8p14eH9EqQ+vjXa5V22N61TCyDcEP6a0Wb
         INGB+gZcGwGXQhzG2Go+W9SOly7AQ/fhKrUiiKyBOaKt/JmtmDZqWPjSg2/F9GuXqOc0
         QZTvK/Sbuwbl3LGxw3UCdcCfcnHrE57pP44Iup+it6RtcqJJ0mw5avtZ9phclgt+7HPK
         o0VEE5B1DIX6kc2dbru2fimwbduGpeAP4Zo9WjMAgqK0SClaPGRtw0ZsStcnTj7dyq3s
         Pqw1+mHvmZ35Wz2788uvVeY84d7iQzjSXhnLWJbLRy4cI+ZUJiN+rFKHb5l5e/bQacmb
         CJgA==
X-Gm-Message-State: AOAM531E/xN49OEQd3gybQsXx/FuQy1yDYL8aXT8if85XL9bp0PZDdds
        tOQiHopKAE3Cor+OBk+Ujg==
X-Google-Smtp-Source: ABdhPJxNlR4PrBb+IozGsfyNMDszEoRAZvLptKfs818Bvw2pDWjPOw0VdaTzTKxTP2dLdHeFJSTf6w==
X-Received: by 2002:a05:6830:10c9:: with SMTP id z9mr6253358oto.275.1621561230643;
        Thu, 20 May 2021 18:40:30 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v19sm1015441otk.22.2021.05.20.18.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:40:30 -0700 (PDT)
Received: (nullmailer pid 2462099 invoked by uid 1000);
        Fri, 21 May 2021 01:40:28 -0000
Date:   Thu, 20 May 2021 20:40:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        linux-sunxi@googlegroups.com, linux-usb@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>, linux-sunxi@lists.linux.dev,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v6 09/17] dt-bindings: usb: sunxi-musb: Add H616
 compatible string
Message-ID: <20210521014028.GA2462070@robh.at.kernel.org>
References: <20210519104152.21119-1-andre.przywara@arm.com>
 <20210519104152.21119-10-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519104152.21119-10-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 11:41:44 +0100, Andre Przywara wrote:
> The H616 MUSB peripheral is compatible to the H3 one (8 endpoints).
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> ---
>  .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml      | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
