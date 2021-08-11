Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55653E97C8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhHKSkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:40:53 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:33540 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhHKSkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:40:52 -0400
Received: by mail-pj1-f48.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so5710087pje.0;
        Wed, 11 Aug 2021 11:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6XWZ7uipzmbT4b9s5UP3Dp3Et7I/DEvFdMWNyQg4EWo=;
        b=mtNR8gOyDBX1Pt1uklU2vFgcy0l0akrG7R1C/Gzpo700w0R5cVLtUz1eZacUe8ISj3
         eoJUp8wo/bx8GleeK8F0HHOoozgf0REilBoedJ0YoNIfDXarY7mO2XCmeisq4JHzZIo6
         NVbcG+BEhDCq7dj6lQVzZL2/XN5SQ4eRBzLKBRv/9CaM783wY9Dwr/gB96aBbFv2Bgge
         nu8SqCWBmlQR828fps1KNT658BbVAfjJGLd+hiV0uRP37r2UbGRyLSNvy80WRMAE4vDD
         MwLJNOv583JW3MXCpI5SX7BFPYEjX63M3PTCly+Z6n2lyPPEpyPj3XH+ZtkGNDIrBRdi
         I4kg==
X-Gm-Message-State: AOAM531887HYN5hFRdkQZQKUN00E0TXVU5QSNuBwFgbpzD3rIiM/VnFs
        nAxAOBgqPYuoS5irrGZA+A==
X-Google-Smtp-Source: ABdhPJydzGSNHHLbCABFjtI2hErQQ3Hvcs3ObcdrBQP2nvWLFn8lM3bPlQ55R/pujUDc+0x05iMkZw==
X-Received: by 2002:a05:6a00:150d:b029:3c8:e86e:79ec with SMTP id q13-20020a056a00150db02903c8e86e79ecmr182380pfu.62.1628707228843;
        Wed, 11 Aug 2021 11:40:28 -0700 (PDT)
Received: from robh.at.kernel.org ([208.184.162.215])
        by smtp.gmail.com with ESMTPSA id u21sm218257pfh.163.2021.08.11.11.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:40:27 -0700 (PDT)
Received: (nullmailer pid 66990 invoked by uid 1000);
        Wed, 11 Aug 2021 18:40:23 -0000
Date:   Wed, 11 Aug 2021 12:40:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add an entry for
 SKOV A/S
Message-ID: <YRQZl94LsG9smzI0@robh.at.kernel.org>
References: <20210804043439.11757-1-o.rempel@pengutronix.de>
 <20210804043439.11757-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804043439.11757-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2021 06:34:37 +0200, Oleksij Rempel wrote:
> Add "skov" entry for the SKOV A/S: https://www.skov.com/en/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
