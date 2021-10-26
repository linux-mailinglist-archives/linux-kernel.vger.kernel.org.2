Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBE343BB09
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbhJZTi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:38:28 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:43784 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbhJZThr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:37:47 -0400
Received: by mail-oo1-f52.google.com with SMTP id w9-20020a4adec9000000b002b696945457so91621oou.10;
        Tue, 26 Oct 2021 12:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cuWCHHaxpGzZ+RLHdReFqP8G1KbQl7FUnQlYA5RdMHo=;
        b=CD6L0wzofWKx5tAGIlyQP7mZfbsSgMyRRb3iT9ckx7dGU/ex/h2hKC5fxOC5vCVi6+
         dpHXaHDbnLzi3GtaTTqReCgrH0W93Tvu18lS0abcS2xdE0jFZge9D3mY/DukDvgzpi17
         TV37ixsCMeV9RU7A8OuO4eYUL9NmztEjht8Enjli9WKlJ6AZRFKdvtLpkdQlIHP2Mjfg
         JELWk6d4ExZv7qzwodnGX+MT1ZYbH39oqflsRNBOlolMBIhB70D9567glbyaHKPZY3s6
         ncxI1uCXWs7zVPt9ls489gNe/LTsddCzevbmWQNJ/uI9esiXSB/KeL5GFX/R/Ndu7q9Z
         B2lQ==
X-Gm-Message-State: AOAM531226CUSmiYrWbdhjF2NzVurRVsPCSBc1+os9rRW1I3j+YgSo7W
        aDEVm6A0Bo4OMrGeeIKZiQ==
X-Google-Smtp-Source: ABdhPJzQ2i57R1fwkX0bvqTZxhQM361+dMED+ZfgS6kHAZqfRaU3DV5TopReaYlNX8wntMv3LmXlNA==
X-Received: by 2002:a4a:d5c8:: with SMTP id a8mr18735869oot.18.1635276923035;
        Tue, 26 Oct 2021 12:35:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l1sm4993196oic.30.2021.10.26.12.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 12:35:22 -0700 (PDT)
Received: (nullmailer pid 3097732 invoked by uid 1000);
        Tue, 26 Oct 2021 19:35:21 -0000
Date:   Tue, 26 Oct 2021 14:35:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Suman Anna <s-anna@ti.com>, Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] dt-bindings: sram: Allow numbers in sram region node name
Message-ID: <YXhYeVIkL60ePHrp@robh.at.kernel.org>
References: <20211012154833.14111-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012154833.14111-1-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 10:48:33 -0500, Nishanth Menon wrote:
> Sram regions node name describes the region of reserved memory and can
> be names such as l3cache@1000. Permit numbers to be used as part of the
> reserved memory node name.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  Documentation/devicetree/bindings/sram/sram.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
