Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B0D33160A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhCHS2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:28:25 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:34861 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhCHS2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:28:15 -0500
Received: by mail-io1-f46.google.com with SMTP id g27so11030542iox.2;
        Mon, 08 Mar 2021 10:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pkbaxNzQLHArH8DUwfUMp/Z2ylGM8hVdhjO/fky3lKY=;
        b=smmP8jI7cFq6Y0FnWTXvIhGX7SifSHWN7N8JKXdRob0YDhOYVMJ3ezmhzhblXWUhtF
         QKfBczgSlvaSyTyiLCWHz8u2FFVt/0m7lOuImSScDeKbmB2CUMNOmX0iSsCOgyi2mQj3
         ArKeCc++KklrnJSzxJysCiQO6PsBkwozhhYtuXzU9AP+vaIhKeh4cAheZ9Gzz3N3WzPJ
         ChNX03aypyMOLaw0RGzV1vQPupYg6/cfo/uJCIiURAHtJSRLG6Sctruz7f4gzwcc9i27
         W/2yvs/hWt9m3UGOtLVFoH7J9SSSFmg6j+IFCej6dnEmXZGYaaHrpHQGmdDtetI6D3PW
         D1qA==
X-Gm-Message-State: AOAM5330g6HX02fmP++pcVcNbo/oJBsJmGUbH9wQX6ddhDe62oPDqLxv
        luTj7czlSwmA0F+peYKhawL6kACMvw==
X-Google-Smtp-Source: ABdhPJwHpA3KqP1fPZljP8jc9FSfl2zbrcPXoTUukx/3q5TeueaKiHX7Zmok4sIN9ZPnBHSUD+MSeA==
X-Received: by 2002:a5d:81d1:: with SMTP id t17mr19944894iol.208.1615228095353;
        Mon, 08 Mar 2021 10:28:15 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o19sm6449916ioh.47.2021.03.08.10.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:28:14 -0800 (PST)
Received: (nullmailer pid 2746923 invoked by uid 1000);
        Mon, 08 Mar 2021 18:28:12 -0000
Date:   Mon, 8 Mar 2021 11:28:12 -0700
From:   Rob Herring <robh@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com,
        alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, broonie@kernel.org,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 7/7] ASoC: convert Microchip I2SMCC binding to yaml
Message-ID: <20210308182812.GA2746864@robh.at.kernel.org>
References: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
 <20210301170905.835091-8-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301170905.835091-8-codrin.ciubotariu@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021 19:09:05 +0200, Codrin Ciubotariu wrote:
> This patch converts the Microchip I2SMCC bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v2:
> - moved from the beginning to the end of the patch series;
> - includes the changes (to yaml) from the rest of the patches that
>   update the DT binding;
> 
>  .../bindings/sound/mchp,i2s-mcc.yaml          | 108 ++++++++++++++++++
>  .../bindings/sound/mchp-i2s-mcc.txt           |  49 --------
>  2 files changed, 108 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
