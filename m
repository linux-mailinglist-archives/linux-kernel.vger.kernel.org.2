Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C0D3F08ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhHRQVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:21:44 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:46930 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHRQVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:21:43 -0400
Received: by mail-ot1-f54.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso4699674ott.13;
        Wed, 18 Aug 2021 09:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RbUPdIpj6yeN9aS9cdAwX+bResK01EzdrmFUkYq3ioI=;
        b=iqH0kyNUVxmSQ34GtcQHRKKFunGkBl94ZDG0tJNJXg0ETjdhhOksptgYqOap29OPHF
         V222v4mGNPQzwIHxo9WZFcedEF1F5QObFhAK/eKeCgk2AALZ8J+fJUtd6uzDC/aYOPL7
         ApeH1W9z/RnePsj1RmLCK2SEzRdyEhEMBh8PdfAq0JDgL5jjzXbpEckV9H7uV9qPkSUb
         ps/sTp2Bb4KNfMRuW03WIRGSYgjkiz7T3p+ycNPCZ3MzMcr/PWz2Qydo8I1RveD6Joyf
         RBAi9GSdm1qldAvy0PmwfczhlSNUEMZELp/Dmo3v9Mx2Mv89CYBtnICypu9+TxXJdIXr
         d7Ng==
X-Gm-Message-State: AOAM532jfemjiv7htBGGBN/3olyn0+ks79bTx0gRMN/j6NL/IcUghtvu
        znfoInOAKwokNpdfyS+bOg==
X-Google-Smtp-Source: ABdhPJyS5ZENuUOC3P+zY7kzgExcSiSclHa3BGSBieC0WlrMf1Lsxgs/rqgrg2D8zyryX34eBAevFw==
X-Received: by 2002:a05:6830:1bc1:: with SMTP id v1mr7478873ota.246.1629303668299;
        Wed, 18 Aug 2021 09:21:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w23sm88059otk.56.2021.08.18.09.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:21:07 -0700 (PDT)
Received: (nullmailer pid 2708083 invoked by uid 1000);
        Wed, 18 Aug 2021 16:21:06 -0000
Date:   Wed, 18 Aug 2021 11:21:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <mmayer@broadcom.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory: convert Broadcom DPFE to dtschema
Message-ID: <YR0zchjUr073SoTO@robh.at.kernel.org>
References: <20210817080617.14503-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817080617.14503-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2021 10:06:17 +0200, Krzysztof Kozlowski wrote:
> Convert Broadcom DDR PHY Front End (DPFE) bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../memory-controllers/brcm,dpfe-cpu.txt      | 27 -----------
>  .../memory-controllers/brcm,dpfe-cpu.yaml     | 48 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 49 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
> 

Applied, thanks!
