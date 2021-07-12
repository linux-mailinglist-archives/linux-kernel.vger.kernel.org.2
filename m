Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E09A3C64C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 22:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbhGLUOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 16:14:41 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:36778 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbhGLUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 16:14:40 -0400
Received: by mail-io1-f52.google.com with SMTP id u7so24214353ion.3;
        Mon, 12 Jul 2021 13:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OxPIiCu8t6BRcFmXlg/qwdKH0Oy9r4vjSImMHgxaBOg=;
        b=nxO+VCmHElA/XROvbQK7dIPiC15A00rBWJPtRP8YjI+hC6Khk9tu+CznXelH1idVDb
         C+jO1H0jZ590dLqyviES2VWkael5Hr+MbahlREi3WFfng8jNmgNMQHRIJ65OMh8G7Lt0
         etkY0JHCaex5joJrucRxdH+EHyJ4f9mn64RYp9hCSiR0JzJCVtyDfkugvXUDTF7OV7sg
         5Gr6V10zUoDpgkIF9MhFv8ggcV3LogNj6a31YhRq3Wlq1Wf4DPItwrnq3PG/1Brq98AK
         A1u9t+/S0Pfp4lpX1C1J0gKL9IoLKzQ9GfoVRJO/IKSIqbgT1HHx9njevdldaHd4ZzSk
         rL/w==
X-Gm-Message-State: AOAM533PFN7zTdkxr43W8ZMjAH7qlmgmT3ExOjk9e6wIgJXQe/EsZBGc
        KxDMu8fOAm0bQ0UXu/H09w==
X-Google-Smtp-Source: ABdhPJzW6AFfFMICizJP5QMZjYZ9nJPabK3GBmxZyX2c4V5/uCYFdnz9UEb+6IfxFpZC/aQOCQm8sQ==
X-Received: by 2002:a02:ca41:: with SMTP id i1mr657291jal.70.1626120711261;
        Mon, 12 Jul 2021 13:11:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b25sm8792990ios.36.2021.07.12.13.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 13:11:50 -0700 (PDT)
Received: (nullmailer pid 2408523 invoked by uid 1000);
        Mon, 12 Jul 2021 20:11:49 -0000
Date:   Mon, 12 Jul 2021 14:11:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, soc@kernel.org,
        olof@lixom.net, devicetree@vger.kernel.org,
        ulli.kroll@googlemail.com, linus.walleij@linaro.org
Subject: Re: [PATCH v2 3/5] dt-bindings: add vendor prefix for ssi
Message-ID: <20210712201149.GA2408465@robh.at.kernel.org>
References: <20210618205533.1527384-1-clabbe@baylibre.com>
 <20210618205533.1527384-4-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618205533.1527384-4-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 20:55:31 +0000, Corentin Labbe wrote:
> Add vendor prefix for SSI Computer Corp (https://www.ssi.com.tw/)
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
