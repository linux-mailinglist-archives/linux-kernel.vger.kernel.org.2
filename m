Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9253EBD7E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 22:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhHMUkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 16:40:18 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:39754 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhHMUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:40:17 -0400
Received: by mail-oi1-f182.google.com with SMTP id bj40so17737642oib.6;
        Fri, 13 Aug 2021 13:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nwf3HxBs/DWJ6gxuqn8PSDwNL+5hxahjlAUN3iHW5uc=;
        b=iSx/IgS+xOQF7ZzCNuMM3oDLgg12c1Bq3eU8InR/HevmqlEOWawpy4JIb6YaqF5tex
         6ezPQfIe0uZN/EPFGdZf/aFn+FQ+AZFqjXwDfCe1XVAkb3x/47qAC1WCSl7Eg+cU0Gue
         /lRx+PCBSJtEt5nq0rdj5SWlEUHLblV3+qS6gfEpPr6JKPcnJQC/rtelIdTKn6UTrCkW
         ihamRDSgiQ32l3ykHjmk86p7CQBmBWO7TEhO9CMjyTOuQdV23MNX84+dQRB4m8p21vYl
         9o1DnAKoaZwtVTzRFl1XdaDVPowtdjVu7NloK3lrN4CP3/FWGjv0MT0vZ2M8gP3eg792
         w7kA==
X-Gm-Message-State: AOAM531/69SCOVxG/KMIvHSK6a8sE6a9Eu2wUey0dDugzqdLmgrqBeVo
        WWEBLcwcIkanpxxxzgOlJw==
X-Google-Smtp-Source: ABdhPJxPhDHaoGXr6o1TMLVqDILEGqBKa35MFIwEH1UvdA2N+YpquykztdNxSCAP2MZJI3Q6zKmZLQ==
X-Received: by 2002:aca:2b05:: with SMTP id i5mr3555977oik.55.1628887189594;
        Fri, 13 Aug 2021 13:39:49 -0700 (PDT)
Received: from robh.at.kernel.org (2603-8080-2a06-ed00-7254-0b80-dd3c-00c6.res6.spectrum.com. [2603:8080:2a06:ed00:7254:b80:dd3c:c6])
        by smtp.gmail.com with ESMTPSA id z23sm573158oib.36.2021.08.13.13.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 13:39:48 -0700 (PDT)
Received: (nullmailer pid 3990366 invoked by uid 1000);
        Fri, 13 Aug 2021 20:39:47 -0000
Date:   Fri, 13 Aug 2021 15:39:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com, linux-imx@nxp.com,
        alistair23@gmail.com, kernel@pengutronix.de
Subject: Re: [PATCH v10 01/11] dt-bindings: mfd: Initial commit of
 silergy,sy7636a.yaml
Message-ID: <YRbYk8K9ob4OqRe9@robh.at.kernel.org>
References: <20210807103940.152-1-alistair@alistair23.me>
 <20210807103940.152-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807103940.152-2-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Aug 2021 20:39:30 +1000, Alistair Francis wrote:
> Initial support for the Silergy SY7636A Power Management chip
> and regulator.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  .../bindings/mfd/silergy,sy7636a.yaml         | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
