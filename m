Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1E43F4B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 03:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhJ2CAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 22:00:33 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43988 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhJ2CAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 22:00:32 -0400
Received: by mail-ot1-f47.google.com with SMTP id n13-20020a9d710d000000b005558709b70fso4946973otj.10;
        Thu, 28 Oct 2021 18:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xd3JPDiqLoDCjW/js8fpuA/vxqFjpZuL5j1lPV9KiWk=;
        b=eXwroKF3N99O49xau+9FBt+lOsFD+3272Ir7QYJZweeLH4OBHScYKg8havxiakgZ0c
         DQdsqsub75XLhmgrKlc9sy5G0LBId5YrqnJZSLxVdvql2/j1ZsJc1+uI2q3F+n24uYVi
         nShAm+63PeEAiURsv69rNDHTIv2cS8V1wsnGzc59oBj9iL0Xc1SYROmVg4ugPUo98e5Q
         L881PAV0WwvhTGw3xwEUD0Aw/hPra/L/hLjyRzomqNNpOH92zvp6cPQHM6/e/pg1zSA8
         3EPrT6S7ZTy4aPAQUxl+TqFDK4BEwdbYyW2cnJ2vBj4017aAuWB+b446k1mMJw0aOTH5
         PyIw==
X-Gm-Message-State: AOAM532R2/Bkna/TkY1bBSETFWUASCtSe6EDk3YIH+7qjvTxXAk6it4o
        Q2Xjl0dKjo3OX8QUHp/4lC4h0CuGGg==
X-Google-Smtp-Source: ABdhPJxM7VyA/UHyNnKdHlw0rJCMZloAC7K6nT7jFez62OjNzZ/7WVsWAM68AtcliNpfutvXcfxa6A==
X-Received: by 2002:a05:6830:2b11:: with SMTP id l17mr6533848otv.298.1635472684272;
        Thu, 28 Oct 2021 18:58:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e7sm1450780otq.4.2021.10.28.18.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 18:58:03 -0700 (PDT)
Received: (nullmailer pid 999745 invoked by uid 1000);
        Fri, 29 Oct 2021 01:58:02 -0000
Date:   Thu, 28 Oct 2021 20:58:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, jassisinghbrar@gmail.com,
        aisheng.dong@nxp.com, s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, o.rempel@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: imx-mu: add i.MX8ULP S400 MU
 support
Message-ID: <YXtVKmOe+FG6uIPD@robh.at.kernel.org>
References: <20211022101856.8612-1-peng.fan@oss.nxp.com>
 <20211022101856.8612-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022101856.8612-2-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2021 18:18:55 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Similar to i.MX8QM/QXP SCU, i.MX8ULP SCU MU is dedicated for
> communication between S400 and Cortex-A cores from hardware design,
> it could not be reused for other purpose. To use S400 MU more
> effectivly, add "fsl,imx8ulp-mu-s4" compatile to support fast IPC.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
