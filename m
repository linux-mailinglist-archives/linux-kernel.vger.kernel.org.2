Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6CB314690
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhBICic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:38:32 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43515 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhBIChm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:37:42 -0500
Received: by mail-oi1-f177.google.com with SMTP id d20so17896338oiw.10;
        Mon, 08 Feb 2021 18:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQRP/+c33BpQI1+/tGbsJuFwMmZpjkX8hC1DLcxfDkY=;
        b=I0/0+u4MJ8iwyCduO0dRJkCqvAwxKME7dlEJRuSAcZLZ4huPhxb87+MErSyKkU7fbm
         ZRD3+UPmBJo3uoTs5J0ROt2Jhr4KJar+25YzoHeam/JHlnUJijwFP1i07dqw0V7m8LdK
         zV0JOa3hmZLcv/f6LFpRAY/kgR1EH2DaDxVrEznjqmiGE/UBUiTg4ofxw9woEGuHaxIy
         tucJ6V7WTJmAdC4EoFNL6N/2gsEnWhxc29O/Pic8q4bAmzf80ZxNS5TmeRCKwBqrATFQ
         InOXC0gG+JGcDw1193Ao2yZ24mNK5GYhgp4/kitzm3b9uRRao7dWau+UgVpUfgevXYgY
         W1WQ==
X-Gm-Message-State: AOAM530fi07j2RKZcV5VxKMOlYfeGw3+kh6P5X63hU/hilYrr6Ks+MFe
        5zbs2qWMRWbNo9Ibd4MxvPWAf8FZ9Q==
X-Google-Smtp-Source: ABdhPJxkPuqOi9xyaFRQXxdHtZhbsO1UswFQc/qFPL5GP+QGiKA/i3qF0K1U7CmEp7pB+Nmy2xEC7g==
X-Received: by 2002:aca:5941:: with SMTP id n62mr1130055oib.135.1612838220567;
        Mon, 08 Feb 2021 18:37:00 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p20sm2024040oos.46.2021.02.08.18.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:36:59 -0800 (PST)
Received: (nullmailer pid 2568970 invoked by uid 1000);
        Tue, 09 Feb 2021 02:36:58 -0000
Date:   Mon, 8 Feb 2021 20:36:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, David Jander <david@protonic.nl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Robin van der Gracht <robin@protonic.nl>,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 1/7] dt-bindings: display: simple: add Innolux
 G070Y2-T02 panel
Message-ID: <20210209023658.GA2568914@robh.at.kernel.org>
References: <20210121061141.23062-1-o.rempel@pengutronix.de>
 <20210121061141.23062-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121061141.23062-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 07:11:35 +0100, Oleksij Rempel wrote:
> Add binding for the Innolux G070Y2-T02 panel. It is 7" WVGA (800x480)
> TFT LCD panel with TTL interface and a backlight unit.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
