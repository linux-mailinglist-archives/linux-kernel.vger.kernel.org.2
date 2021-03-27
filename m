Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9B434B835
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 17:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhC0Qgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 12:36:53 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:42893 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhC0Qgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 12:36:35 -0400
Received: by mail-oi1-f173.google.com with SMTP id n140so8940950oig.9;
        Sat, 27 Mar 2021 09:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qFbUkW6r9j3+DNwYmMXAzHmOSal7Nsz8qw3jTrj+nfQ=;
        b=E3zW9q6RVzaC9+YWbjGlCyc0kILa7ZBDOury8aoZ4aJYi1Su43xnClMLaXgNRxIDBd
         U8fsOQIhdZdcSthbXl4bNqGGkzwb9FhUUUJvPWCtk8sZqvky2B+Egdqyes019vV2tETV
         yMhLZObMxtGbYf0IOgjCnfU2YoiIrVPh9t71fUNZcK+8xhI7t/+LXAEBXQpYwRrsxKYf
         xUw5BxLvGldtpIJjnDYihrZG4s+z3YiaCqAGJNQiABIEeQDqA5++hZhUADfvxaWK5iLD
         Y5lOmh8PCjb6sOaLtgbSyoT1+Q3Ol0O1TKKgcUbWXVEvr8rmwfwjqZ6Zwvuu8xgyyFLi
         XLmg==
X-Gm-Message-State: AOAM531L5bjQ01XAjJJrWB52gr4U8iS7oIH8D6J0Bur9DvH+vDpnkhTE
        Fvyja1YjudAo0lnpr2iXOA==
X-Google-Smtp-Source: ABdhPJzIlSKn0efAGI+v5EEMnYuN1WqKZ85QmF8LK5oghKxGT+1ZrJfmZHWAtr8G6EtMOvPqUL10Qg==
X-Received: by 2002:aca:3bc4:: with SMTP id i187mr14140035oia.174.1616862994960;
        Sat, 27 Mar 2021 09:36:34 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.140])
        by smtp.gmail.com with ESMTPSA id o6sm3082470otj.81.2021.03.27.09.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 09:36:34 -0700 (PDT)
Received: (nullmailer pid 211432 invoked by uid 1000);
        Sat, 27 Mar 2021 16:36:31 -0000
Date:   Sat, 27 Mar 2021 10:36:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Patrick Venture <venture@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nancy Yuen <yuenn@google.com>, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] dt-bindings: arm: npcm: Add nuvoton, wpcm450
 compatible string
Message-ID: <20210327163631.GA211376@robh.at.kernel.org>
References: <20210320181610.680870-1-j.neuschaefer@gmx.net>
 <20210320181610.680870-3-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210320181610.680870-3-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2021 19:15:58 +0100, Jonathan Neuschäfer wrote:
> The WPCM450 is an older BMC SoC in the Nuvoton NPCM family, originally
> marketed as Winbond WPCM450.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> This patch requires "dt-bindings: arm: Convert nuvoton,npcm750 binding to YAML"
> (https://lore.kernel.org/lkml/20210320164023.614059-1-j.neuschaefer@gmx.net/)
> ---
>  Documentation/devicetree/bindings/arm/npcm/npcm.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
