Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B315444EA0E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhKLPcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:32:16 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:42885 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhKLPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:32:13 -0500
Received: by mail-oi1-f171.google.com with SMTP id n66so18447454oia.9;
        Fri, 12 Nov 2021 07:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DW8VgudtocUZU1HDUii+/dHVF3J3mG1GILU0W17O9qk=;
        b=iOq+vabz7fEoY21bN+YRIre+rxVhJg4XG/vT3LI4tNGEt+zVqAOEJBGwk1gBFhNcOT
         7WB+Kegt7agukvf5/SJIGL+FpD9d7dXJErj6Q6r/QT832kzWnRr9ZnOPfjhXTH3I/FIa
         gAQf5UrUBRkSGrUlz81fy9Oqgr5PNOq3QAIvQysBy+tmf/66LdsA+xNjPEu/PN2hEWg8
         cj2wJR4JKfpvpjyYOp1LC1r6FziZjPAywpQ8StAskuY5I/gGCzW58lOIuWu9zPpqGh1V
         ugn7TiLWxv05ygKzgqUAhZfuZ9nWXhi6rb2YQnSE8YUpS4JJT/EKLo54C5CDJOduGlrh
         GdlQ==
X-Gm-Message-State: AOAM533oAQgM1M4wdcP+uPbhvvTURspR/m3D8gYO25X2MseYfhaJIyhA
        uB4pdALrDXrJRv0L4YJeXQ==
X-Google-Smtp-Source: ABdhPJwbTtvg9M+B+8LafzsMv7N7DUzYI4eFvElyss/WrN8Ef8+ofOCHjyrSNmOpNl/xc9lWPCOELA==
X-Received: by 2002:aca:30c5:: with SMTP id w188mr13002779oiw.35.1636730962320;
        Fri, 12 Nov 2021 07:29:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bn41sm795096oib.18.2021.11.12.07.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:29:21 -0800 (PST)
Received: (nullmailer pid 2884254 invoked by uid 1000);
        Fri, 12 Nov 2021 15:29:20 -0000
Date:   Fri, 12 Nov 2021 09:29:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        stephan@gerhold.net, ~postmarketos/upstreaming@lists.sr.ht,
        devicetree@vger.kernel.org, perex@perex.cz, broonie@kernel.org,
        alsa-devel@alsa-project.org, tiwai@suse.com, robh+dt@kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: nxp, tfa989x: Add rcv-gpios
 property for tfa9897
Message-ID: <YY6IUOspigx/yDvj@robh.at.kernel.org>
References: <20211031210956.812101-1-vincent.knecht@mailoo.org>
 <20211031210956.812101-2-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211031210956.812101-2-vincent.knecht@mailoo.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2021 22:09:55 +0100, Vincent Knecht wrote:
> Add optional rcv-gpios property specific to tfa9897 receiver mode.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../bindings/sound/nxp,tfa989x.yaml           | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
