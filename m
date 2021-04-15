Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3523A3613EC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhDOVLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:11:45 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:36786 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbhDOVLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:11:43 -0400
Received: by mail-ot1-f48.google.com with SMTP id i16-20020a9d68d00000b0290286edfdfe9eso13263240oto.3;
        Thu, 15 Apr 2021 14:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hzANp36iuVSG+0nY48Uw2kEyuGobYOFTvaDygpInvZk=;
        b=gJKM5aHWkmEzojXT7y/Swtolu+7AKAXJRiWYWCg3maFo31CwY8jOpGAwXmZVcDZBhz
         gv0RD+T/TSKYLSQuJeegtIWGwxWoy9vWYVQKIEB/0lsvH3U/wRrKUTcq/cbTphLbHMaf
         EpFCAfygDzfGIk3hcwopsBrfEm+pzk0uXkqKweohw5m6Mp2a+g3QPIfgxoE6TrkiFHK3
         VV4ARgxJaGRVo0UT7T35ee8duwGmvvKzOSKXmt30sbG1JnkvzBkqdiS8mo6uTlQ4aPZx
         YksfOAsaYnfPmyhZo4OW3rNlJj3PxazYh+3dsQnG6/9Pt+vqsdrbpNFoDd9XPgjUbZqe
         /Zwg==
X-Gm-Message-State: AOAM5333d+RPJp1RTmFr2ll+cguyQxh/oTGFv80oKxk/+vQAWksOFNra
        BYs0czUMqKZb48tF29Ky5Q==
X-Google-Smtp-Source: ABdhPJx7M8OzPKhmXFXFq1RjJQv7cP2sRuHIZ80t44v8vBHwbXLUTAvz5SMUj6P2J2lxw9VvegLoJw==
X-Received: by 2002:a9d:de5:: with SMTP id 92mr922710ots.25.1618521078811;
        Thu, 15 Apr 2021 14:11:18 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k44sm775632ool.33.2021.04.15.14.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:11:18 -0700 (PDT)
Received: (nullmailer pid 1889333 invoked by uid 1000);
        Thu, 15 Apr 2021 21:11:17 -0000
Date:   Thu, 15 Apr 2021 16:11:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add vbus-supply optional
 property to phy-stm32-usbphyc
Message-ID: <20210415211117.GA1889278@robh.at.kernel.org>
References: <20210413143141.12919-1-amelie.delaunay@foss.st.com>
 <20210413143141.12919-2-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413143141.12919-2-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 16:31:40 +0200, Amelie Delaunay wrote:
> This patch adds vbus-supply optional property to phy sub-nodes using
> connector node.
> A regulator for USB VBUS may be needed for host mode.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
> Changes in v2:
> - add connector vbus-supply property as suggested by Rob
> ---
>  .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
