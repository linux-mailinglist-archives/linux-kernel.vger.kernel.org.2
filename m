Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67C74151A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbhIVUxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:53:16 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36591 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhIVUxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:53:13 -0400
Received: by mail-ot1-f45.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so5448203otx.3;
        Wed, 22 Sep 2021 13:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K0e+QIxMALBQhCsB26FgEJQQDulL1SytM9MRZsK5UAg=;
        b=52DcddMiXw1etfB3U8HnE3umLBKSSYSAL0ZNwRRrwG3RD7lCn/GBQ0K4mc6FwqSsYQ
         PTF/YIS6svz1U8Aq6WHgGkBVyCvNHe0VnWUmklLo5GDZbRCDZ+FMxXrMvpCzpMttYk3G
         /Kjqsx6ihnZ4zarokKpsHLkABATInaU7NbNf8Bf+O84VeNbbG+y2zYUzSnU8/U8J3grr
         qDGP3J2aS8JIAIs1dGbGTUGqgKi/Ij1gYDMB2FD5xYs6szAiokTVqiC4beOBjWEFoKzJ
         zC/QAUKQOfeeKZAayexFVw9w9ByM/JC2AvgIkW/4RjdLY3Ci/noKXd4G/P2RjYQTTYgl
         S4gQ==
X-Gm-Message-State: AOAM531gtme4harCewt7ylijnkjsRDssAB6uBAsSC5J3LhxXR4WD9vCX
        kjpI2xLl2gdTZBEW+TyZPg==
X-Google-Smtp-Source: ABdhPJy6OpIj46BmIEk9sdynWbEHNejhn0TTMdLRFY3I5UsBmDoeryrQJAxSoYcMR2hPTg5RzxfBMg==
X-Received: by 2002:a9d:3e5e:: with SMTP id h30mr1018357otg.255.1632343902316;
        Wed, 22 Sep 2021 13:51:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p2sm796463ooe.34.2021.09.22.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:51:41 -0700 (PDT)
Received: (nullmailer pid 1271985 invoked by uid 1000);
        Wed, 22 Sep 2021 20:51:41 -0000
Date:   Wed, 22 Sep 2021 15:51:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     kernel@pengutronix.de, olof@lixom.net, krzk@kernel.org,
        linux-imx@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
        leoyang.li@nxp.com, linux-kernel@vger.kernel.org, soc@kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH 1/4] dt-bindings: arm: fsl: Add E70K02 based ebook readers
Message-ID: <YUuXXRPyIDQseQhk@robh.at.kernel.org>
References: <20210918141627.2142457-1-andreas@kemnade.info>
 <20210918141627.2142457-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918141627.2142457-2-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2021 16:16:24 +0200, Andreas Kemnade wrote:
> Add the Kobo Libra H2O and Tolino Vision 5.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
