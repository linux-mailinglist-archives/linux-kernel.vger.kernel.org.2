Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E184B3D4132
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 21:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhGWTQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 15:16:19 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:45840 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWTQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 15:16:18 -0400
Received: by mail-il1-f169.google.com with SMTP id z3so2569945ile.12;
        Fri, 23 Jul 2021 12:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LneocB/f7rm7pYXiKsd0bKUKJNA6iTNE6EU9o8+2b/4=;
        b=kb716TA5joEA6JUnqypoc3L10yRFsuIcGtvt9XLc48IXRpMTXU/b9rjmxuOZSbdcGm
         EhdFQbj67iPAOxEQWWnMqmlMfPQHDZpKBNXEOBZ5aqAbmYkDuHIrWYKLIZAy40y6RgHQ
         H9KuVmE6oQeUCaJBhXoVlr8j0pwNLXSK+Ppb61C/OqzRKybbFqVJ8SXTLOOZdvRO8mpB
         LmNWe/kZIT8zpkfULYrAva2P4cId58C+3xEuzpBqgB/i2XmGBKSvGW54fgIxBZjXD4M2
         fQY/cpBEmNnQ/wEVcbkBZs2g3VImfm0bgJDrJPy4ppY+Z+PdJxS83pdcXvSZc3L0SQIP
         g4Gg==
X-Gm-Message-State: AOAM533XN4iHow/OGUab4oFgDzaPlX2sNTJ5bA5Cr00tIONVf8czpOa8
        sSCZF+9wpYOMgBVYa3/V2A==
X-Google-Smtp-Source: ABdhPJzZtdZfCALqIQrhlEsp6Jwk+w/L141JedKuOpCDZhTgTYvjCVXCyQtNjPKVvtQ2zJAo5/M6wQ==
X-Received: by 2002:a92:d3cb:: with SMTP id c11mr4635802ilh.178.1627070211690;
        Fri, 23 Jul 2021 12:56:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d186sm17400914iof.3.2021.07.23.12.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:56:50 -0700 (PDT)
Received: (nullmailer pid 2472320 invoked by uid 1000);
        Fri, 23 Jul 2021 19:56:49 -0000
Date:   Fri, 23 Jul 2021 13:56:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     galak@kernel.crashing.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org, l.stach@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] convert fsl,imx6q-pcie.txt to yaml
Message-ID: <20210723195649.GA2470892@robh.at.kernel.org>
References: <1626942155-9209-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626942155-9209-1-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 04:22:33PM +0800, Richard Zhu wrote:
> [RFC 1/2] dt-bindings: PCI: imx6: add fsl,imx6q-pcie.yaml
> [RFC 2/2] dt-bindings: PCI: imx6: remove fsl,imx6q-pcie.txt

One patch for this please.

Also, there's now a schema for DW PCI in my tree, so this should be 
based on that.

> 
> .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     | 102 ----------
> .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    | 212 +++++++++++++++++++++
> MAINTAINERS                                        |   2 +-
> 3 files changed, 213 insertions(+), 103 deletions(-)
> delete mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> 
> 
