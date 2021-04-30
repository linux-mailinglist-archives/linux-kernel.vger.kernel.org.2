Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28762370329
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 23:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhD3VrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 17:47:01 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:44615 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhD3VrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 17:47:00 -0400
Received: by mail-oo1-f50.google.com with SMTP id i3-20020a4ad3830000b02901ef20f8cae8so8539823oos.11;
        Fri, 30 Apr 2021 14:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lQ8vdEh4rJx00Ki7Tq3K8HSCeSzDZ++EPb2cKQeU+yo=;
        b=RFuX87YmDi070EdMrvdG7HzQlELFq8L+J6EDMP/g4Lze0rExQj8RIbnOzgUi3VQ45T
         A0Zg4J2sbx9ZTk5VAIPdT9OxuTT5QjhmWcl8BB1b74hY2qRrYpWk1SmqvrzlDLf1Q3v+
         lItEPSjIus3qbJvlFOJgJz+VzIioWjV/DE92+RdqEh6hKOE0T9GuNpbfGV/8w3BIhwg0
         ZGZ+d5gW4csatamqbm9/ZhSlkNx+TxjCScZNqtJk39BNpqQH3gXMk40ZYQ1PQfHxzb6E
         pzlPaJOLxvj3E4X871KjfGk9Fb/CV9c4RusHja7QvCP26RD7Ek+lQ+FE/4pnUK0oHSoi
         oICQ==
X-Gm-Message-State: AOAM530+8r5EY3DgZfzy4airgpBN1nGZEhk/GqRVi/Y69UVn1bhiO3Is
        7bavdmfkjvvssa/fiVGgTw==
X-Google-Smtp-Source: ABdhPJz6PdKIigOtZcVYOpEsFx+nvBVRc8Vx+MdzxKvkVayWWFkpXLA1s7S9yhZm38LZWhL24gYbaQ==
X-Received: by 2002:a4a:1104:: with SMTP id 4mr6265762ooc.57.1619819171630;
        Fri, 30 Apr 2021 14:46:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u1sm1055005otj.43.2021.04.30.14.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:46:10 -0700 (PDT)
Received: (nullmailer pid 3956163 invoked by uid 1000);
        Fri, 30 Apr 2021 21:46:09 -0000
Date:   Fri, 30 Apr 2021 16:46:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v3 1/7] ASoC: dt-bindings: sun8i-codec: Increase
 #sound-dai-cells
Message-ID: <20210430214609.GA3955996@robh.at.kernel.org>
References: <20210430035859.3487-1-samuel@sholland.org>
 <20210430035859.3487-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430035859.3487-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 22:58:53 -0500, Samuel Holland wrote:
> Increase sound-dai-cells to 1 to allow using the DAIs in the codec
> corresponding to AIF2 and AIF3.
> 
> The generic ASoC OF code supports a #sound-dai-cells value of 0 or 1
> with no impact to the driver, so this is a backward-compatible change.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../bindings/sound/allwinner,sun8i-a33-codec.yaml         | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
