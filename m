Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866CA4097C6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344768AbhIMPtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244694AbhIMPtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:49:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49DAC03D6E4;
        Mon, 13 Sep 2021 08:33:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b6so15337395wrh.10;
        Mon, 13 Sep 2021 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWXmDpZaWGj5j9E7Z1va6xEMGPrQKj28NZ3Lpex3gSk=;
        b=gGydgc5WG9qP+XafnPlnIhq4Jkw9gFS6cL+s0Fzpf6uH5jRxzSiQqq8dqkrP6P6X/x
         c1O/xlJAb6NhfoHusa2YEteHfrHqqASps2eCccwz8auVvk5OIQJq65Ola2TiK3vZFGZ5
         C7F9oUELGj6mfDRFYbDmwDRUvocDC0ggqoX10j7XjgICPH39qf1COPHiGy8ZTkGKti/B
         gw2WJ9/szdNEuw0Fnr79v8porIBjnnWl7J4SAX7GoVUOSudpdlfhWQZXy62d2cgDhdl4
         EmUtAL6kjerRSAl4Ka5MtdWDP/Gp8ZA8KX1ZkS5MvN3LgYRdLaDZF+0qh/a5LFXR2j/A
         Gw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWXmDpZaWGj5j9E7Z1va6xEMGPrQKj28NZ3Lpex3gSk=;
        b=MzaLCkkZ0wyLiT77h5sBF+lIZXSkkbq/bFpAUFAGhucF7R6hUF/6L15ZgpfhWOEAyz
         k6lX/KxDrg6DuwLOTRmhghr1wH9dFYaLYeRoJWHUmPPITnQLo0c34fp25gTtvFplBjba
         icUDFWqPBmE1YgWs+J2qVgDBXDEI/mvr0sYpCoQ+DhTm/7+OPUSQXw9BHJOxTCMD4u7s
         NxP1mwitJJzRWn+DYzgTWEm3UGB3Yz8trb0mYHHrU/pZLtkeDeG/jQ97712dOoHIG5Ny
         17ZdlWMr5H0HiIzeIrgJlRsYD0oOUwcGoLDHTTJcKsRiIj2slgMIp01V5SGErBmjqu8t
         oEMQ==
X-Gm-Message-State: AOAM5332tGgCEsM1UQRsuYE7QS3RdITBHQ83Cn0sWdGAPih0xcIOX0NM
        pX7PaIZEfeNprZJK0mVotB1847O9FftdYg==
X-Google-Smtp-Source: ABdhPJyj2q3U91trxKY3jdr7ZN8T4SItcT/Ai6azGMbEw3OJvXoU7wHS/d/cT3wdfi8N1XCC0mZ2tQ==
X-Received: by 2002:adf:ed92:: with SMTP id c18mr4947352wro.86.1631547204293;
        Mon, 13 Sep 2021 08:33:24 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id w9sm6975406wmc.19.2021.09.13.08.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:33:23 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 1/2] dt-bindings: sound: sun4i-i2s: add Allwinner R40 I2S compatible
Date:   Mon, 13 Sep 2021 17:33:22 +0200
Message-ID: <22661441.uYPlIyrNLm@kista>
In-Reply-To: <20210913111117.GB4283@sirena.org.uk>
References: <20210912072914.398419-1-jernej.skrabec@gmail.com> <20210912072914.398419-2-jernej.skrabec@gmail.com> <20210913111117.GB4283@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne ponedeljek, 13. september 2021 ob 13:11:17 CEST je Mark Brown napisal(a):
> On Sun, Sep 12, 2021 at 09:29:13AM +0200, Jernej Skrabec wrote:
> > Allwinner R40 has 3 I2S controllers, compatible to those, found in H3.
> > 
> > Add R40/H3 compatible pair to DT bindings.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

I did exactly that. But history is not uniform:

$ git log Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
ce09d1a6800d dt-bindings: sound: sun4i-i2s: add Allwinner V3 I2S compatible
0bc1bf241de5 ASoC: sun4i-i2s: Document H3 with missing RX channel possibility
e84f44ba4604 ASoC: sun4i-i2s: Add H6 compatible
5c7404bb30bc dt-bindings: Change maintainer address
eb5b12843b06 dt-bindings: sound: sun4i-i2s: Document that the RX channel can 
be missing
0a0ca8e94ca3 dt-bindings: sound: Convert Allwinner I2S binding to YAML

Most subjects contain "dt-bindings: sound: " at the beginning. I selected 
variant from latest commit (ce09d1a6800d).

Best regards,
Jernej


