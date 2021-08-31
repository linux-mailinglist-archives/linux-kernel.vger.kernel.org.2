Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780FD3FBFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 02:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhHaAUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:20:35 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37733 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhHaAU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:20:27 -0400
Received: by mail-ot1-f50.google.com with SMTP id i3-20020a056830210300b0051af5666070so20688074otc.4;
        Mon, 30 Aug 2021 17:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5kubVYDgr+H+MwB6W5C9Rpp1FgVflkLGibEHAVmx7xQ=;
        b=GlqbAFFRu6t5niWcuLSSVLD0NN6pMmbaZSoeVN7pUQgt0BAKyoryi8IHgkrdNuf2nt
         P4Muy0lkoa4gHP9uVlmKiBQ2g5FTxSE82aYbO35lWyXI+aWTqYH7Qxh7oxlvDnUVOHr2
         cLSQzRQ+NVhHVw/xaWCNtNASfZV4DfLIecOBHAHcfLsYXQYUK95A4eAulnPMJIM0vdE3
         99Q4dxXoAqfCmUAXpXHvObvOuwr41eQkVmVw7uQZtzM5lfbbaAp4cRfj+iQonsPyDj0L
         +jmt5xGEuVvC6RVRyRM3i7qUr49E1krPvAKd0Z4ajQujLcr9iS028Ymd5JIUZI9nKdSM
         7nfQ==
X-Gm-Message-State: AOAM531R1D9jBo55EDUcDX++/z79bqRQNc22y9fGOg6iGg3S8UK+gcoP
        EVS4nNIHa+1z+6v9HAuK7Q==
X-Google-Smtp-Source: ABdhPJyJBIXWC0f381ulM87fyByFnK9rcOmO1oavV0+d1JfKQBceUsirPqGw435MPnfhJZz3JqCbzg==
X-Received: by 2002:a9d:7c8c:: with SMTP id q12mr22645940otn.352.1630369172968;
        Mon, 30 Aug 2021 17:19:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h3sm2560997otu.7.2021.08.30.17.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 17:19:31 -0700 (PDT)
Received: (nullmailer pid 2966810 invoked by uid 1000);
        Tue, 31 Aug 2021 00:19:31 -0000
Date:   Mon, 30 Aug 2021 19:19:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        devicetree@vger.kernel.org, galak@kernel.crashing.org,
        linux-imx@nxp.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: imx6: convert the imx pcie
 controller to dtschema
Message-ID: <YS11k+IhBra3+C5g@robh.at.kernel.org>
References: <1630046580-19282-1-git-send-email-hongxing.zhu@nxp.com>
 <1630046580-19282-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630046580-19282-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2021 14:42:58 +0800, Richard Zhu wrote:
> Convert the fsl,imx6q-pcie.txt into a schema.
> - ranges property should be grouped by region, with no functional
>   changes.
> - only one propert is allowed in the compatible string, remove
>   "snps,dw-pcie".
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie.txt           | 100 ---------
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 202 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 203 insertions(+), 101 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> 

Applied, thanks!
