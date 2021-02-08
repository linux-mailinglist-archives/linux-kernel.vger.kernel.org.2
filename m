Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DC5314256
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhBHVxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:53:51 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38838 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbhBHVxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:53:05 -0500
Received: by mail-oi1-f174.google.com with SMTP id h6so17289648oie.5;
        Mon, 08 Feb 2021 13:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U8tnst308e6RauLdVa5a7TNIbxkAWuY5AsfA0wur2Dk=;
        b=oPz0PnknK607g+EhHarUWG6eLOaNAxRXpeVGo2SjcXvTxysmSK2LYT5bNuI2B0LMs2
         I3zkKTEnZ+TvjXhr++WjQkJx3XFsEWpmT5iAJCarCNqbmnkzqmcs4pADxL+uf3YE58hc
         jyK8fOnXZrRJfBqkKO2l9aBi61Q8vuu1vGGV9y0XhdTxXq3fJa05nAu9pSfP+9P67nRm
         Va6kL9wU+kRGZ05WlNZ6SvR0Ap/N0JqGad/XUezz6ERRGZqDLk0CFV4B5K9gdJ6uvCMd
         0NbF5XFWsQdLr6jBU4gcKRTTY4ZFGSIRywNnCMk6ziPGazxbTHej7NZdP0vWgGIB51gf
         I8KQ==
X-Gm-Message-State: AOAM530gkCOTW8xSbVETc+NUnKb8UK1XS038vURZdqWMk/LVpCU5sGmw
        8D8wRFEIedFtUWhvM1Mvug==
X-Google-Smtp-Source: ABdhPJyujBb8um9slbs8pmbjX48fp1di4TFtFS/wbVUEAmUdc/fIQmMdKAfXk+Pfz8wf0F7yNniuSw==
X-Received: by 2002:aca:5a57:: with SMTP id o84mr569707oib.0.1612821144124;
        Mon, 08 Feb 2021 13:52:24 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n93sm3878402ota.37.2021.02.08.13.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 13:52:23 -0800 (PST)
Received: (nullmailer pid 2085478 invoked by uid 1000);
        Mon, 08 Feb 2021 21:52:22 -0000
Date:   Mon, 8 Feb 2021 15:52:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Benjamin Fair <benjaminfair@google.com>,
        Tali Perry <tali.perry1@gmail.com>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Avi Fishman <avifishman70@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: Convert nuvoton,npcm750 binding
 to YAML
Message-ID: <20210208215222.GA2085425@robh.at.kernel.org>
References: <20210116010907.3475405-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210116010907.3475405-1-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jan 2021 02:09:05 +0100, Jonathan Neuschäfer wrote:
> The general trend is to have devicetree bindings in YAML format, to
> allow automatic validation of bindings and devicetrees.
> 
> Convert the NPCM SoC family's binding to YAML before it accumulates more
> entries.
> 
> The nuvoton,npcm750-evb compatible string is introduced to keep the
> structure of the binding a little simpler.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> If someone else wants to be listed as the maintainer, please let me
> know.
> 
> 
> v2:
> - Fix indentation to satisfy yamllint
> - Fix $schema line
> 
> v1:
> - https://lore.kernel.org/lkml/20210108224008.705687-1-j.neuschaefer@gmx.net/
> ---
>  .../devicetree/bindings/arm/npcm/npcm.txt     |  6 -----
>  .../devicetree/bindings/arm/npcm/npcm.yaml    | 23 +++++++++++++++++++
>  2 files changed, 23 insertions(+), 6 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
