Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BB043F4E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 04:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhJ2CRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 22:17:08 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:37622 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhJ2CRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 22:17:07 -0400
Received: by mail-oo1-f43.google.com with SMTP id j6-20020a4aab46000000b002bb88bfb594so206702oon.4;
        Thu, 28 Oct 2021 19:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FbMoOA+srpZECEM4zFCkGJJsPbPqalqoHRgY7gpc/TM=;
        b=rmLePVLLM02fwmiJ9TMxhmFILL1lLDRzTrILPQlq0gIzkyMU6+1FFpJd3IQsrLZ+Z3
         8sLu5o8zIyKyazk1Ujmjj72JLJKTm9VGAXiqFdkGBawz2aPIAjIWRdr44o0KuH2Ui11K
         E36/xYOpL1w+4ETnzgLdABiG7rHelYStp8GLXH/z6UfL89oaCaDC6A6QFVO+Uu9i/1yK
         ON60yWVetLA5t29Au32mtoqJHxJ32WeTyyBU9Act3W+zY5nDpF5JcDx9awda53WqVdpl
         YfObpCZZZMm5+9ETEljrTXGv5evGrh+WxTfINiTmX0wmhQNWukKZySxP2buV0yFdpkvd
         zuWw==
X-Gm-Message-State: AOAM532QPuSDOphYdg8syHk+mGfwF7DpLAuXHGWzmTs1wpkNXZyzMy16
        TwvJvDgC2GCA+lOeuEMN/A==
X-Google-Smtp-Source: ABdhPJwIaM15lT2fjoQ9/qmb7TUSUgveYFzB+ldBfIF6tbmQXlGPNxR1fi85bhNN2CmhWxtISK0NaQ==
X-Received: by 2002:a4a:819a:: with SMTP id c26mr1232978oog.51.1635473679339;
        Thu, 28 Oct 2021 19:14:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s9sm1492018oic.14.2021.10.28.19.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 19:14:38 -0700 (PDT)
Received: (nullmailer pid 1023892 invoked by uid 1000);
        Fri, 29 Oct 2021 02:14:37 -0000
Date:   Thu, 28 Oct 2021 21:14:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sascha Silbe <x-linux@se-silbe.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq: add defines for IOMUXC_SW_PAD_CTL
 register values
Message-ID: <YXtZDelpt8fJhU/V@robh.at.kernel.org>
References: <20211024152832.649738-1-x-linux@se-silbe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024152832.649738-1-x-linux@se-silbe.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2021 17:28:32 +0200, Sascha Silbe wrote:
> The IOMUXC_SW_PAD_CTL_* registers on i.MX8M Dual/QuadLite/Quad all
> have the same basic structure. Add defines for a common subset
> supported by most of the registers. They can be used in Device Tree
> source files instead of magic values, making the sources a lot more
> readable and easier to write as well.
> 
> Signed-off-by: Sascha Silbe <x-linux@se-silbe.de>
> ---
>  .../arm64/boot/dts/freescale/imx8mq-pinfunc.h | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> The board I'm using this for is an out-of-tree prototype. If there's
> interest I can convert the in-tree DTS files. I have don't have any of
> those boards but comparing the built DTBs before vs. after the change
> should be sufficient.
> 
> 

Acked-by: Rob Herring <robh@kernel.org>
