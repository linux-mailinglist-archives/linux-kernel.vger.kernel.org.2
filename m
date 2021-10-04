Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D8942159A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhJDRzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:55:15 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45712 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbhJDRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:53:14 -0400
Received: by mail-oi1-f177.google.com with SMTP id v10so22640853oic.12;
        Mon, 04 Oct 2021 10:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3vWwFoLU/AV3mlTHht+MMyQ5jmWKT/p5IFY/3H+BlVc=;
        b=QpjhOAxMiLrjpk1cpJf8PYsp2euwmGcdg6lAorI26lygV/mUy5j5k4911NvQK8XqaP
         HW6FlBuiCrvz3kEvcX+p5P9kcFkdYm67B8hTxClShR6FocJ8G+4J9Q56QpHVaqv8OEq5
         CVQn1gCwavK7tiYbCAmDfwMxpWXG++mVrxCKbCju4I5ur4573OXFaE7+0zgPleouwnXj
         XzwhxRASrehywgLv7TMOlwROtDYE3hizhxDw3iH+e4L9HJ4QyhXXweqyH3TNy2mkAV33
         sgO6sbdZG8yCwAX2xLhE/KmOGzlXzusnZoRQzn+HzStHdM6hYmJdKAnfMMtbSJwJ9+NQ
         vBLA==
X-Gm-Message-State: AOAM532rv7CNOYKuWGmHPkPknWFHldxWnuJusqcChJKzGweNDz4/PwlN
        F/LD9JF+k2pxjQG4xDk28Q==
X-Google-Smtp-Source: ABdhPJya8ioCqBxAIdwFPEEysr8oQqLtz2mjK5uD+nxi59pFeB2kP5iwanEEqI6Hgjd2nBGMq4h/5g==
X-Received: by 2002:aca:ebd5:: with SMTP id j204mr14247424oih.14.1633369884850;
        Mon, 04 Oct 2021 10:51:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bd24sm3029117oib.52.2021.10.04.10.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:51:24 -0700 (PDT)
Received: (nullmailer pid 1553251 invoked by uid 1000);
        Mon, 04 Oct 2021 17:51:23 -0000
Date:   Mon, 4 Oct 2021 12:51:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Raffaele Tranquillini <raffaele.tranquillini@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, sam@ravnborg.org,
        y.oudjana@protonmail.com, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, thierry.reding@gmail.com
Subject: Re: [PATCH 2/2] dt-bindings: panel-simple-dsi: add JDI R63452 panel
 bindings
Message-ID: <YVs/G9T6Jw7Y1AWn@robh.at.kernel.org>
References: <20210925103135.518443-1-raffaele.tranquillini@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925103135.518443-1-raffaele.tranquillini@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021 12:31:33 +0200, Raffaele Tranquillini wrote:
> This add the bindings for the JDI FHD_R63452 1080x1920 5.2" LCD DSI
>  panel used on the Xiaomi Mi 5 smartphone.
> 
> Signed-off-by: Raffaele Tranquillini <raffaele.tranquillini@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
