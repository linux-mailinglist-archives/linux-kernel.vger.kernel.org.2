Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B3C3F0B46
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhHRSu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:50:26 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:34716 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhHRSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:50:23 -0400
Received: by mail-oi1-f182.google.com with SMTP id p2so1913491oif.1;
        Wed, 18 Aug 2021 11:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D+L+5MsL8JrbaXQWsR9UY0bCzFXBCcwVh5cQS8qHxoA=;
        b=kuflJkLITN3rjLxpW9zH5eTNn/4VR4W/SkePm8aeDb55SfTfPonzck/K4N1Dk9nCq9
         wHur7l/HZwHkoDA24n1FntZFk5auDEkU+1iY9p4kajLZNiywEXsISfMaY6V5Nf/IIsXc
         k4VYBZ8vbREzqQ2rdv5MowLTQzJVA7pWX9LzT3LovCw/D5o6k/VuXFsQk9nneOStt7Ov
         IXxjgGawkU7zMsX01FEUXdU1JBRGxp5qkuJnr95uz4Tu+as/QEZXMlLv6myrrwCOlErp
         OlviOlbQQft28P1M23AI/d9LNAbq1B/vGsMVLlWXgIB8h+QEey1luU0Z9gXWJeDpEx9t
         6dgw==
X-Gm-Message-State: AOAM5323EXYqbDra9wXMJvb3TcIQKoc3CgyXiDpGqLsEiTDKgIK7oKPT
        mNb/fpTSLHj0UG1X+P8q+w==
X-Google-Smtp-Source: ABdhPJx/17kEnYBrc3WJTXebScH75BCjo/Uh+9vxxhgbkE84oXN0+Qx6NJTATO4I2IG7C3F67HvXkg==
X-Received: by 2002:a54:459a:: with SMTP id z26mr1241173oib.165.1629312588278;
        Wed, 18 Aug 2021 11:49:48 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 7sm164556oth.69.2021.08.18.11.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 11:49:47 -0700 (PDT)
Received: (nullmailer pid 2902891 invoked by uid 1000);
        Wed, 18 Aug 2021 18:49:46 -0000
Date:   Wed, 18 Aug 2021 13:49:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Manish Narani <manish.narani@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: memory: convert Synopsys IntelliDDR memory
 controller to dtschema
Message-ID: <YR1WSoyXqSnQTqat@robh.at.kernel.org>
References: <20210818113139.84869-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818113139.84869-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 13:31:39 +0200, Krzysztof Kozlowski wrote:
> Convert Synopsys IntelliDDR Multi Protocol memory controller (present in
> Xilinx Zynq and ZynqMP) bindings to DT schema format using json-schema.
> 
> New binding contains copied parts of description from previous binding
> document, therefore the license is set as GPL-2.0-only.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../memory-controllers/synopsys,ddrc-ecc.yaml | 73 +++++++++++++++++++
>  .../bindings/memory-controllers/synopsys.txt  | 32 --------
>  2 files changed, 73 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys.txt
> 

Applied, thanks!
