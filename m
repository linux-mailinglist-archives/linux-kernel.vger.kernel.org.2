Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0683C9219
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhGNUdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:33:23 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:42997 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhGNUdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:33:22 -0400
Received: by mail-il1-f182.google.com with SMTP id h3so2862756ilc.9;
        Wed, 14 Jul 2021 13:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yeqH3519s9TR7u8H68VDtMcnBoL+fYSZSk2mtTvRFuU=;
        b=YqrKTZKIJWPGdf4UJqQo9+mUkQ0exFSpFT5lzlPTh0YvDaAMrmDvl14l0eiFGsFehB
         +Pf7JRLekoPIWFIlHmAwdc95ekMGiLYXTt96bKZsitLkcphDhmMkpIQu+7HHnZgW4uVE
         sz3UtIZ3XotsblcyFm1bpGNU/y5SO8fokQuO648EHfvNH6Hd7eVNyRWeWKWHk+6cVJ6o
         ZsO5L3fprlz55ZMZTK1PuwsrTVt7dtOLOLdVEHayS9+jeitH2J4KTRxglEXF6LZPcoFp
         xQO4sCl05ppNq3ONIFJyfhFFf4fzQfoAj2TpAY/epsCnf/3sgi4G6BhRIqfzyE1bBXEB
         fKkw==
X-Gm-Message-State: AOAM530Xv2YQsfNIzr2InWkvANL4opQI28pTTWG+PrgyXuSfAOHgYEqv
        WtoviWf/dekR0vXfaop9lA==
X-Google-Smtp-Source: ABdhPJytuNpDn/33kY2kMBoOHeFD1ZZbC1vgPUMTXoRZDQ11PyuZ3uK32kK5pVfUKHhpW1D05/SOZQ==
X-Received: by 2002:a05:6e02:1a28:: with SMTP id g8mr1031391ile.128.1626294629908;
        Wed, 14 Jul 2021 13:30:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m1sm1883001iok.33.2021.07.14.13.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:30:29 -0700 (PDT)
Received: (nullmailer pid 3466710 invoked by uid 1000);
        Wed, 14 Jul 2021 20:30:27 -0000
Date:   Wed, 14 Jul 2021 14:30:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        list@opendingux.net, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display/panel: Add Innolux EJ030NA
Message-ID: <20210714203027.GA3466681@robh.at.kernel.org>
References: <20210625121045.81711-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625121045.81711-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 13:10:44 +0100, Paul Cercueil wrote:
> Add binding for the Innolux EJ030NA panel, which is a 320x480 3.0" 4:3
> 24-bit TFT LCD panel with non-square pixels and a delta-RGB 8-bit
> interface.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../display/panel/innolux,ej030na.yaml        | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
