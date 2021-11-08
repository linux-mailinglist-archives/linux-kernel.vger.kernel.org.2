Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363E1449B97
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbhKHSZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:25:21 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:42974 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbhKHSZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:25:19 -0500
Received: by mail-oi1-f171.google.com with SMTP id n66so5381311oia.9;
        Mon, 08 Nov 2021 10:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sO2dt8DuhlMcsC8zejGWVfhyLHr9Al/EyUYlESvy22E=;
        b=atrxvylIc7B0oA9J9nl+SrHCQV+eKE+t+BPqY2ZppOodnKO0VL1wp/qgfT0pgM4d33
         kNit4OdXtYjhxmNHGjGTU4A+mLsMWLkz8+dpuyH4oeXaRumWL049mMrxup6mfW4OgrzG
         IwdxdRMsDZjnwxEmyt/L58sWJJd7JY8SukJTfoGVsRIMLr5w55ZPfYCA3bgvucW9v3Zr
         2EriArB/ZJPiuCCR6tCffXPSNGFCDLzXd3kPQsN0acqn0Bae/j0KurnISh01K+p6HgIU
         RVKL5X6DzUV5oWd/4uUbo9fO9g0miU6lsyY4VjLfEyuq6WHI+nF9cstmFNdTjk1Z9vJ+
         5BNg==
X-Gm-Message-State: AOAM53272FgTAkrPHqgk37gHXtSV3S1T6jXyJCyRO9a+VOj74zVhag2J
        xyQlt62jUHsrKiK+ervEEg==
X-Google-Smtp-Source: ABdhPJxjGJxzII6GW6D0MF2LEukd9ujymJo8yNJF+Bk/9w959yWxMDxBudokbIThUeDliSUknY3Wjw==
X-Received: by 2002:a05:6808:2182:: with SMTP id be2mr280835oib.80.1636395754777;
        Mon, 08 Nov 2021 10:22:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m2sm538039oop.12.2021.11.08.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:22:34 -0800 (PST)
Received: (nullmailer pid 3971322 invoked by uid 1000);
        Mon, 08 Nov 2021 18:22:33 -0000
Date:   Mon, 8 Nov 2021 12:22:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        - <patches@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, ~okias/devicetree@lists.sr.ht,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: sound: wlf,wm8903: Convert txt bindings
 to yaml
Message-ID: <YYlq6QqkTjxoBJKE@robh.at.kernel.org>
References: <20211028124639.38420-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028124639.38420-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 14:46:38 +0200, David Heidelberg wrote:
> Convert the Wolfson WM8903 Ultra-Low Power Stereo CODEC Device Tree
> binding documentation to json-schema.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/sound/wlf,wm8903.yaml | 116 ++++++++++++++++++
>  .../devicetree/bindings/sound/wm8903.txt      |  82 -------------
>  2 files changed, 116 insertions(+), 82 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8903.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8903.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
