Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811B0434167
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 00:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhJSWdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 18:33:07 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37828 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhJSWdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 18:33:06 -0400
Received: by mail-oi1-f178.google.com with SMTP id o83so7207430oif.4;
        Tue, 19 Oct 2021 15:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c2P3hU+6DosmYSIf3DMYRO0O3fSxz+RiqQskPSBrXIA=;
        b=XilqN/gs62snEQdXR6fpJK57gzWfBJSjcjUfGe11g49x6WIgcb7qy8ctnV2NnykZbV
         UD67HIUZbiyxZJESFwJsCoJ27o0xQHCuSpygjkmBbafW4Q2P/51wMUbAegSOCogqONp6
         YitYcwVMoLgxz3rPorV8W+BcUAIfIqm+SDFLk+8vPVlhB4WxYK+627flTtyj8iRWJE2D
         gMthWWSIlnQ4xeAbbRxAgjWDp0Ughn9H1ohICDa+iXS9RVsPwM1qQfNYYOCb8i56xTGY
         wBRiGbeUn0f/Hnh8GW2za4aiJAlGFTaLsct1GOn3G/0PMOi2+ydnOLAM3AEQS8vk+pT2
         5w2Q==
X-Gm-Message-State: AOAM532XsE5WMDlJhw1P5jxylU3rfTiMnMSHqSDKEWoLniJxHaxFVw6K
        UGaVG51aFvkNvNREPymSpA==
X-Google-Smtp-Source: ABdhPJxYFWvjuVFeLU6eHynZMyA7JBL7ENZUsNvTARz3qLi/UoQfLZzsgsLfSn22lpQTkqg8UCK52w==
X-Received: by 2002:a05:6808:5d5:: with SMTP id d21mr6164512oij.104.1634682652688;
        Tue, 19 Oct 2021 15:30:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v13sm79885oto.65.2021.10.19.15.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 15:30:52 -0700 (PDT)
Received: (nullmailer pid 944950 invoked by uid 1000);
        Tue, 19 Oct 2021 22:30:51 -0000
Date:   Tue, 19 Oct 2021 17:30:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastien Van Cauwenberghe <svancau@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt: Add SpinalHDL vendor
Message-ID: <YW9HGwAC+pr7xSKM@robh.at.kernel.org>
References: <20211011100531.443157-1-svancau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011100531.443157-1-svancau@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 12:05:31 +0200, Sebastien Van Cauwenberghe wrote:
> Adds SpinalHDL as vendor. This project
> provides FPGA IPs including VexRiscV CPU
> 
> Signed-off-by: Sebastien Van Cauwenberghe <svancau@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
