Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDDB386EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345398AbhERBLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:11:04 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:39510 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbhERBLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:11:00 -0400
Received: by mail-oi1-f169.google.com with SMTP id u144so8223042oie.6;
        Mon, 17 May 2021 18:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JNWjXggEu8J9sL5ZhoPZyw5YSW1iHpwfijjTjQ6C7Ek=;
        b=SYO85kslVb2v6y03iB1eOERgZGo8f6hrevnGjr/QM99W00FIHDwD1wSa9Wmj1GqkHf
         06T9nIdURATpxjZys5VaKhf0W4yZQBwL0zAUNfoc07N3BUN9PnxSeiMU4cmvQFttCOwg
         NRCF2lBf371JyCivCwlinqmltHH70vIWu/ZjBgjqGSc/Oa8bzoFmKGYySaxbg1nGkybw
         /EsnIuGQ+VlyB16yjax8MpuOkWDyCTwp7RZTnpGZ8vjRGbm++XCJkoUYICx8HkIlP36z
         THd55yX3E5uUnzNlh8LpKuTklKPwd1Jxmb6fWrHDBvXHNSRFTLjEi5tR1n9mVOJxQ/2P
         e/JQ==
X-Gm-Message-State: AOAM531LfOZiSD2zlNdoUn2c4ex+54dCKcTy/DXOQ+NNTZVIYO5IRPy/
        kinyXvZ3ANBYpTruPXZhGg==
X-Google-Smtp-Source: ABdhPJxp+pf66Lk1gp+j3TROFkuPYMIg0SSfCQ2Sp4EI5vcyetqOohnvREe2pb0K9qdihUjuiASPAA==
X-Received: by 2002:aca:afd3:: with SMTP id y202mr1538701oie.90.1621300182965;
        Mon, 17 May 2021 18:09:42 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s17sm3423215oog.31.2021.05.17.18.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:09:42 -0700 (PDT)
Received: (nullmailer pid 3571158 invoked by uid 1000);
        Tue, 18 May 2021 01:09:41 -0000
Date:   Mon, 17 May 2021 20:09:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Mark Brown <broonie@kernel.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [RFC PATCH 1/2] ASoC: dt-bindings: codecs: Add bindings for nxp,
 tfa989x
Message-ID: <20210518010941.GA3571094@robh.at.kernel.org>
References: <20210513104129.36583-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513104129.36583-1-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 12:41:28 +0200, Stephan Gerhold wrote:
> NXP/Goodix TFA989X (TFA1) amplifiers are controlled via an I2C bus.
> Add simple device tree bindings that describe how to set them up
> in the device tree.
> 
> Right now only nxp,tfa9895 is supported but this will be extended
> to at least nxp,tfa9897 in the near future.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/sound/nxp,tfa989x.yaml           | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
