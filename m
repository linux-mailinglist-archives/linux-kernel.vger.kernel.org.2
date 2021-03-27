Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CF634B84C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhC0QpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 12:45:24 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:41889 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhC0QpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 12:45:00 -0400
Received: by mail-oi1-f170.google.com with SMTP id z15so8964882oic.8;
        Sat, 27 Mar 2021 09:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2F8RzeTleB8udHCv5mRu3tw4FmnypGvkRtmFHpRztvE=;
        b=XztMy4OYBou5J8IAEkSTkf/1C+MLJNCtpkxkQ6FAoX7ek8SWAR0UNNKQ7Q5KM2gayZ
         enY4pwVcdZt7lEAEiJ8lWWkMNGW0YoqcDUEWSkTAs/0BJEiNpcXpRDwXQ1IaKtLup3X9
         J834hbDnsM9TPiJUCwzhpVyp/mr4Gdh8LLAq1+hLuMsLpvM9SGmwSma/DtBh1Gav8xS1
         x4SchNEW/SNvWmGA/i2HttAKG+mDG3TV2ih/rHGQJjrOaBfwU/F3Ci8wQybSKhzp9orD
         jMG41GIZLoNOwxr8QLOypGVXT8QDCY3Qv1eRCSXxk4syqqJim0ljkp/D61O0bbbnwW73
         fmDA==
X-Gm-Message-State: AOAM531yAOY8WsKt+Hqqfv96zeim3LMb28WIPIkUjj3HYRjALegTv4WU
        bqjQF1bWir7F2R/qDJsiKA==
X-Google-Smtp-Source: ABdhPJxxFybdvkzTsqZO6qv3YqeMmmcg3+FTflQKCCnCH6rWeKtKOq6qu4yFD9S8pulpvjtPrO0gFw==
X-Received: by 2002:aca:1b01:: with SMTP id b1mr13387336oib.177.1616863500303;
        Sat, 27 Mar 2021 09:45:00 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.140])
        by smtp.gmail.com with ESMTPSA id z3sm125375oop.41.2021.03.27.09.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 09:44:59 -0700 (PDT)
Received: (nullmailer pid 223207 invoked by uid 1000);
        Sat, 27 Mar 2021 16:44:56 -0000
Date:   Sat, 27 Mar 2021 10:44:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: timer: Simplify conditional
 expressions
Message-ID: <20210327164456.GA223158@robh.at.kernel.org>
References: <20210322044707.19479-1-samuel@sholland.org>
 <20210322044707.19479-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322044707.19479-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2021 23:47:03 -0500, Samuel Holland wrote:
> The sun4i timer IP block has a variable number of interrupts based on
> the compatible. Use enums to combine the two sections for the existing
> 3-interrupt variants, and to simplify adding new compatible strings.
> 
> Acked-by: Maxime Ripard <maxime@cerno.tech>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../timer/allwinner,sun4i-a10-timer.yaml      | 25 ++++++-------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
