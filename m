Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D7F365D42
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhDTQZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:25:48 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45040 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhDTQZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:25:45 -0400
Received: by mail-ot1-f53.google.com with SMTP id 5-20020a9d09050000b029029432d8d8c5so10361590otp.11;
        Tue, 20 Apr 2021 09:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xNokQdd4tw5VCGbyrKSX00JvoLe/Bjaadc0Hud+iZsc=;
        b=m2yuPpt7E9eW6bfevvbTbnJRSAC65PVRdhCpJuT6rxXLdV4JDtG0F/IzFJ3O5FP+8l
         9GUA2AHMCxPLl8Xvis9flmwV9wt5H82iPUhlUfzHQxN4PewGC7fSV11lUklkBXhBVTK9
         kasrkuIkfxm8f7cPN1LGn2tH49yhLxZTpp/4OLIkWIu8//4sahCw83DiqMX9EriXvrub
         Ib8ls64/+I1uOvAan7EGvkB25PHEp3qUqLgCnkEzT/4QxlPHXDjytkLOFQAZ5UdrrRgh
         nyCf8y9jm/YO6uEFiDCcuTiy1mY/4H5UpPPX9zpiNiKg408OqJkgWdNtm/M3Nw57LF9A
         RYkA==
X-Gm-Message-State: AOAM531l1W7Mytao62Fkh3tK+tQcP3LGCZCMhMYA7/kNw/PGZdrnKO5R
        FujgsHq0mgbp6IgYRHO/xA==
X-Google-Smtp-Source: ABdhPJzASVJX35pEZmVLXrSCMM1IFUj/grYGNXM2VM9K/dZzVcb9p8rJj4sXmjiCuipGmkeJADIxgg==
X-Received: by 2002:a05:6830:15cb:: with SMTP id j11mr19339733otr.209.1618935913281;
        Tue, 20 Apr 2021 09:25:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a65sm2362646oob.27.2021.04.20.09.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:25:11 -0700 (PDT)
Received: (nullmailer pid 3431648 invoked by uid 1000);
        Tue, 20 Apr 2021 16:25:10 -0000
Date:   Tue, 20 Apr 2021 11:25:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com
Subject: Re: [PATCH v3 2/5] dt-bindings: mediatek: add mt8167 to hdmi,
 hdmi-ddc and cec bindings
Message-ID: <20210420162510.GA3431608@robh.at.kernel.org>
References: <20210419073244.2678688-1-narmstrong@baylibre.com>
 <20210419073244.2678688-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419073244.2678688-3-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 09:32:41 +0200, Neil Armstrong wrote:
> Add mt8167 SoC compatible to Mediatek hdmi, hdmi-ddc and cec schema bindings.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,cec.yaml       | 1 +
>  .../devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml  | 1 +
>  .../devicetree/bindings/display/mediatek/mediatek,hdmi.yaml      | 1 +
>  3 files changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
