Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3866443F4AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 03:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhJ2B4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 21:56:55 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36741 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhJ2B4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 21:56:54 -0400
Received: by mail-ot1-f42.google.com with SMTP id s23-20020a056830125700b00553e2ca2dccso6541581otp.3;
        Thu, 28 Oct 2021 18:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KdtQTI+i0L72ij8xkXdRpvscoefW376+vSIEVHmU0w8=;
        b=frqfT5jcmk7OToDtl9LBn3erstbnkEb3yS9lPkjooQlCH2sNOgCBY6ntRYtNFDqKgs
         KsrgVsaFrrE4QdkV7wTJcIhyZQY7ows/2SYibiTXSg4UZrjeAjRNj0YJQdYi7sKTgyiL
         7xvZVQomhsak6YbXpwegfs1kb9am0IVSuz4VoG9ylnUC5AXpRHYkpbir+c71D0QdKS2w
         AAtXJPkEpOYDPdXFBb+MfrySuLcpRP0VbY9fRmTt2m34U8CAFg6aDibHY2V5eb5BISV2
         NBReIEgqxfeao8Z2XsE/gC0bcBqLFgyWLSctcO/9CHUgZE4zqVqYCAjeUuij58ppakpy
         2zQA==
X-Gm-Message-State: AOAM532e0+delwE4po4cOr7Fe9oAF+zeDVoLPuvpg7sw4dHrj72WD3UR
        0HohajQRi+pg0vv5INr0UQ==
X-Google-Smtp-Source: ABdhPJws++qYzzDd0TvOO+bzozA4CaZIn9mRQT9UiMBOn3SU+LPjDqHW0XJRSMmSM+cEKb+e5Qyu8w==
X-Received: by 2002:a9d:847:: with SMTP id 65mr1825246oty.326.1635472465941;
        Thu, 28 Oct 2021 18:54:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 21sm8522otu.76.2021.10.28.18.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 18:54:24 -0700 (PDT)
Received: (nullmailer pid 994142 invoked by uid 1000);
        Fri, 29 Oct 2021 01:54:23 -0000
Date:   Thu, 28 Oct 2021 20:54:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     qinjian <qinjian@cqplus1.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: clock: Add bindings for SP7021 clock
 driver
Message-ID: <YXtUT/BCyX1yDSYW@robh.at.kernel.org>
References: <20211022061105.281807-1-qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022061105.281807-1-qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2021 14:11:05 +0800, qinjian wrote:
> Add documentation to describe Sunplus SP7021 clock driver bindings.
> 
> Signed-off-by: qinjian <qinjian@cqplus1.com>
> ---
>  .../bindings/clock/sunplus,sp7021-clkc.yaml   |  38 ++++++
>  MAINTAINERS                                   |   2 +
>  include/dt-bindings/clock/sp-sp7021.h         | 112 ++++++++++++++++++
>  3 files changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/sp-sp7021.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
