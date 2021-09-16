Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D7A40EB75
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhIPUOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:14:49 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:35503 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIPUOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:14:48 -0400
Received: by mail-ot1-f48.google.com with SMTP id q11-20020a9d4b0b000000b0051acbdb2869so9897541otf.2;
        Thu, 16 Sep 2021 13:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hm8BQTs2tF+HTrQvP0NgTlvM7vNhDceZt+v3TFnyqmU=;
        b=7R/mpfJvKfrI6Q8KZ223gxw75AooHUtGb+ZNphUKecGLLitRvdIP5+xNVfWVzyf61U
         ZCAbsrxoFIClzAU8ZuC2uUwSw3HBEM2eNjqJOZ+uevicyCxvN9hFTSmb11sj/UxvBEqy
         ejypxrRVebNGxMWwqUr4I45PbOVyMp4/GEFAnpJWDx9eWfmgJ4IVdioGJtQIIm5IU1ib
         DrvJPKeFWdeAGIe//t0t4zzDjAWxDMrD36a3N579JCPc3tosrDTmmd+h1mDr8NGvOKuf
         iGo82LfRN4/QWuw0aNjuh+00buNCFbr798OrOMaCpjvzIowmdcoeMw6NcOgjG6OOxQST
         XWxQ==
X-Gm-Message-State: AOAM531pU++XdIKUJk94YrDrgktQHHH8JNk8oYGqA+MshEmrzKTiYiML
        Xpolga5Vf0h0BwEf8UBnknUC2Vf+kQ==
X-Google-Smtp-Source: ABdhPJyUU+3Q3CD7/okc+dVsFdUZtP6s/3iDKDqzX/LX9OQLePogmz7lA8Ahf7Hl2oLRfnYlcZj2sg==
X-Received: by 2002:a9d:57c4:: with SMTP id q4mr6491075oti.229.1631823207670;
        Thu, 16 Sep 2021 13:13:27 -0700 (PDT)
Received: from robh.at.kernel.org (107-211-252-53.lightspeed.cicril.sbcglobal.net. [107.211.252.53])
        by smtp.gmail.com with ESMTPSA id p20sm540216otl.56.2021.09.16.13.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:13:26 -0700 (PDT)
Received: (nullmailer pid 1419443 invoked by uid 1000);
        Thu, 16 Sep 2021 20:13:23 -0000
Date:   Thu, 16 Sep 2021 15:13:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     robh+dt@kernel.org, sgoutham@marvell.com,
        linux-kernel@vger.kernel.org, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: perf: Add YAML schemas for Marvell
 CN10K LLC-TAD pmu bindings
Message-ID: <YUOlY68fgN9TcNr1@robh.at.kernel.org>
References: <20210908120425.10084-1-bbudiredla@marvell.com>
 <20210908120425.10084-3-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908120425.10084-3-bbudiredla@marvell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2021 17:34:25 +0530, Bhaskara Budiredla wrote:
> Add device tree bindings for Last-level-cache Tag-and-data
> (LLC-TAD) unit PMU for Marvell CN10K SoCs.
> 
> Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
> ---
>  .../bindings/perf/marvell-cn10k-tad.yaml      | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
