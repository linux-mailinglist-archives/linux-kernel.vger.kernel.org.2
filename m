Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4103348056
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhCXSVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:21:01 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:35506 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbhCXSUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:20:34 -0400
Received: by mail-il1-f173.google.com with SMTP id 19so22233434ilj.2;
        Wed, 24 Mar 2021 11:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RxUaOPg0Ia7mLYebX0Ddfx9H/tShBA6X9OAJt1fHGMY=;
        b=LYTvEaN8YBsZpcBC5LK9498bD7CIsCVMNaXtNH9XoasjtxP3w1rb+OieUVKXTZ4fyh
         n/6sjxLx6LYgcgjiN/7EctKlpkD7e/U5aBOZIgQapDoeSBg9ipRKLy/2jLNYDVWzwkgM
         0dHmrfydUrFlveJKEmmi2ugWiQ69tO7EUJmDaUvIJjpJJls7CAjz4a3N3bXsQwHLanFO
         rXbp0U8y3hoRtoYhdhmfR6yoP0kMYW/+K9TwAzrJqfLjcIdMjJY8PUbT94bMQmGcg6MC
         aPQNJ8VZwUgsayH9MHiyYd9eBH969ipuXecnajk+3c9+TEkr7Al0zLKY/RqH/TRdL3Jw
         4ubg==
X-Gm-Message-State: AOAM5331uIOfA/Wa098qyPuCUkUavJKdxA1M6BWbxgnxwNAs5u8d0clg
        fOyjMjkhbvSbfGo1KM8fNJTyBNFIKtae
X-Google-Smtp-Source: ABdhPJyVVfF2ssrvyt0OdX7fQzCEIX8G1Y5Y437vb8L9kMsFTO3h7397qJJ4Bf76ihYy4MH8p2cW2A==
X-Received: by 2002:a05:6e02:15c1:: with SMTP id q1mr3714298ilu.151.1616610034008;
        Wed, 24 Mar 2021 11:20:34 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i6sm1367940ils.77.2021.03.24.11.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:20:33 -0700 (PDT)
Received: (nullmailer pid 3371127 invoked by uid 1000);
        Wed, 24 Mar 2021 18:20:32 -0000
Date:   Wed, 24 Mar 2021 12:20:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: add vendor prefix for Siliconfile
 Technologies lnc.
Message-ID: <20210324182032.GA3371069@robh.at.kernel.org>
References: <20210315124423.115039-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315124423.115039-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 13:44:21 +0100, Krzysztof Kozlowski wrote:
> Add vendor prefix for Siliconfile Technologies lnc.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
