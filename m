Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD0449B08
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbhKHRtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:49:23 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:35413 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbhKHRtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:49:13 -0500
Received: by mail-oi1-f182.google.com with SMTP id m6so2891128oim.2;
        Mon, 08 Nov 2021 09:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=toDZEBHuaa1x3Jwug3DZHPkTTaz7ktotK2ulHBej8nk=;
        b=YXAV7tGF0edft6nsVUDKgKi1D2eJ+lXXysWGR2BVd+qrj+PktPTyXEQZ5axvvl0Ii5
         D0iuZolCHalupuv+8R25lj+g4bOFrxu/+dmJcMgKcZ+Xnjc4euSsqLeGbyr1fu24TO09
         XreADFfUEhvVtsTSkSCPXORyaLCeRp8G2adn5IbYdsqewYystPytHtGTtMIvFxyJJtFX
         FfLOKzdR5KLPUU2A3JP3TngLtC3ScxYx5dm3xxS+XZaY85fLxguqzBt+xVskaZGbaG2x
         jrZ8hP55UcVqnKmaQ7gy6MM7N0MDtqXWj2lRstU4PQk0ZM++DLncCZQxlgl627AKcKFj
         H74w==
X-Gm-Message-State: AOAM531305gsiLZgIrZt4gmWXV/1iqlsLgAYxz6E9dO82R+q+zDRue5x
        ubFO666ryjLTEJRrfaWYJQ==
X-Google-Smtp-Source: ABdhPJwJf1N4LQz7lHDGovI7YOIjHtafLOOX0BulYtrubOxSn+TFI+LBd2/q855qVhgiDlkyhm+wJA==
X-Received: by 2002:aca:ab84:: with SMTP id u126mr43245oie.41.1636393585984;
        Mon, 08 Nov 2021 09:46:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k17sm1920099oom.6.2021.11.08.09.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 09:46:25 -0800 (PST)
Received: (nullmailer pid 3817073 invoked by uid 1000);
        Mon, 08 Nov 2021 17:46:24 -0000
Date:   Mon, 8 Nov 2021 11:46:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     sboyd@kernel.org, wells.lu@sunplus.com, robh+dt@kernel.org,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        maz@kernel.org, mturquette@baylibre.com, linux-clk@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v4 07/10] dt-bindings: interrupt-controller: Add bindings
 for SP7021 interrupt controller
Message-ID: <YYlicPy04xGNIum4@robh.at.kernel.org>
References: <cover.1635993377.git.qinjian@cqplus1.com>
 <d143123af9b90618d92264ec704d1be499662bb0.1635993377.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d143123af9b90618d92264ec704d1be499662bb0.1635993377.git.qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2021 10:57:04 +0800, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 interrupt controller bindings.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  .../sunplus,sp7021-intc.yaml                  | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

