Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B1D449C08
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhKHS55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:57:57 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35496 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhKHS54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:57:56 -0500
Received: by mail-ot1-f44.google.com with SMTP id p11-20020a9d4e0b000000b0055a5741bff7so27066114otf.2;
        Mon, 08 Nov 2021 10:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rVRh1sxzpaMQeA+0p6EZeOg5M9eCwHLOcOw6O1U43pE=;
        b=nUDngUCHlxvpMYYCuRtMAXBdXkdCUeQsDSmbDx3zJjO9/xIcwDePFpSH8kZdOuL+/w
         Vxi4BNjua7+fHgnaCmGcvoKv1sLiiGSdhm1Umo+6L9r1gW2K7M16xlEwmklrTU61xNMC
         v/3j1uQLDtrhMwxcnTPNBcpQ4j4tn1qPaB7wILCiHveVxydLPLE+abTi4qRsa/SXNTFQ
         cXZP/wrdTLg6lw9w+reLFyqR2hYrug5Oqq2Zl5mIUbF0kBgMKN7R5Y4+7zEmaRbnnaOH
         QlLwZBjRbvOTVv9bOTH8quh6SiAeJT0zsToScDc5pJFaKFli7bzOgPyF0UyeGmNWt7Vl
         k40w==
X-Gm-Message-State: AOAM5309H+sSP+Tb4eCFlveYPXjGDU2WQu/63B/g+BFCLBxtuyXg0dra
        2ieSXCoGcSIMG8/H3sa7td7R9MAXPw==
X-Google-Smtp-Source: ABdhPJyohxO+K12heylMLci20BfZuAXUmtzxjEv0ifKRtxwCkxt4R3ufjC0VuUmqblEHbDIynR9zVw==
X-Received: by 2002:a9d:4d0f:: with SMTP id n15mr991993otf.127.1636397711483;
        Mon, 08 Nov 2021 10:55:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p62sm6243908oif.43.2021.11.08.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:55:10 -0800 (PST)
Received: (nullmailer pid 4020110 invoked by uid 1000);
        Mon, 08 Nov 2021 18:55:09 -0000
Date:   Mon, 8 Nov 2021 12:55:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: cs42l42: Convert binding to yaml
Message-ID: <YYlyjT9bB+EKYoGL@robh.at.kernel.org>
References: <20211028140902.11786-1-rf@opensource.cirrus.com>
 <20211028140902.11786-4-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028140902.11786-4-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 15:09:02 +0100, Richard Fitzgerald wrote:
> Replace the old .txt binding with a new schema binding.
> At the same time, some of the descriptions are updated to make them
> clearer, fix errors, or just make them fit better into the style
> of schema binding.
> 
> The cirrus,hs-bias-ramp-rate property was missing from the old .txt
> binding and has been added to the yaml.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../devicetree/bindings/sound/cirrus,cs42l42.yaml  | 225 +++++++++++++++++++++
>  .../devicetree/bindings/sound/cs42l42.txt          | 115 -----------
>  MAINTAINERS                                        |   1 +
>  3 files changed, 226 insertions(+), 115 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42l42.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/cs42l42.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
