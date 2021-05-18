Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4051386F28
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345725AbhERBas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:30:48 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:41528 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbhERBap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:30:45 -0400
Received: by mail-oi1-f180.google.com with SMTP id c3so8256926oic.8;
        Mon, 17 May 2021 18:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AtUJefJLoHgziahUui2+8nbwoSw2tOAjyBNrIem7eVQ=;
        b=rVZhxYDCUQhbqXN0WlMYhudNKBXphW/YS0/9v0TMbnoV2CAuQQfnCiv+f4HitG71NU
         BkHoCDpDxj1w25eUp7HGVesugk1uABgyH4simWLOaIRE1cUHKIfL/ziRaM3sJmeYwin3
         AvqhyWXjcUinmOblc8MpGpUXlWHcMBK+z99OAnWEMwfjZwHk7GNwqVK+EFMi0H9z6Iy1
         DieYkouV2XzCUuXviGQhn324FW2KhdcFDAgFANJzhPwqpk0MJ4iFWmYVPTGxBYA8ef1p
         x1/vY0sdeJMhH2W9ESPCBkCQCNfrxHjrYljB74QNCJfXDfQmKy2MnpqIRAz5B0cIdcTz
         ptBw==
X-Gm-Message-State: AOAM530fz2cecr+ZB3yo/PaWr9sa2p96zoq70XCk3h3cxyxX3gX1d9xe
        MjNRv38I1SncG9wtYjwwCw==
X-Google-Smtp-Source: ABdhPJx6wOdBI4b10WjHGBkCm+4XJjD+7Eoy6luPwoehX+SKk7fVDkEOGjYJKKVlExHXMyl4rVR+yQ==
X-Received: by 2002:a05:6808:8cd:: with SMTP id k13mr2036279oij.156.1621301368098;
        Mon, 17 May 2021 18:29:28 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c17sm3605051otn.45.2021.05.17.18.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:29:27 -0700 (PDT)
Received: (nullmailer pid 3603310 invoked by uid 1000);
        Tue, 18 May 2021 01:29:26 -0000
Date:   Mon, 17 May 2021 20:29:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 6/7] dt-bindings: sound: sun4i-i2s: add Allwinner V3
 I2S compatible
Message-ID: <20210518012926.GA3603252@robh.at.kernel.org>
References: <20210514134405.2097464-1-t.schramm@manjaro.org>
 <20210514134405.2097464-7-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514134405.2097464-7-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 15:44:04 +0200, Tobias Schramm wrote:
> The I2S peripheral of the Allwinner V3 SoC is compatible with the one
> found in the Allwinner H3 SoC.
> This patch adds a compatible string for it.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml     | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
