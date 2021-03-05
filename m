Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE0232F5E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 23:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCEW3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 17:29:17 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:39008 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhCEW3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 17:29:14 -0500
Received: by mail-oi1-f171.google.com with SMTP id z126so4223556oiz.6;
        Fri, 05 Mar 2021 14:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L8tLi7VYLiIzROIrBSzUwyPtWKAzZzpCEIfH10Dw2mg=;
        b=Dc3+fJJ6dUXfXkE99Jde+MMgoUQBm9CGwcQU2K07Ejgn598DlKK+EAoy8OffBEDoFl
         9l/QDF+XwEmpfeLCwsjmgfAH1YXAh1xJtCxzOk8FIiDLkkqOlzFcS+xb7vEos7D3KrG9
         3Qxxp8SwTDD8BsABvcvoC8kGm1+0fcJhUPGXgonUI+S200RqiIB4jx6c5zqDISDjQu5e
         R/xv4KWNogAWsKRrEnvGk7HmwjaYmeVdCIpQ+G8rpTQL0Xak0Ga0akgnc+CHKFSraFc6
         TdGIFbq0W2fFB77zYyQlLieqHqzPsX6/vjLrgJgaB4fHyWMoSjr6eV3jWHw7ibOIgHN7
         x+lQ==
X-Gm-Message-State: AOAM530lpGHnX2fhSjUMcOeyubrh+9ssgD0qndH4QQoYEAeC/I6EzXqY
        7kLvC+2gNoMlwTgXPtxEsQ==
X-Google-Smtp-Source: ABdhPJxUS5H3RDgRiDRd9ZHr+vpecCH1SPBWWbrfekHR6gdcttpt+v38J9DDZtl2wyp2nXY41ZHn4g==
X-Received: by 2002:aca:f388:: with SMTP id r130mr8968623oih.55.1614983354126;
        Fri, 05 Mar 2021 14:29:14 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r81sm833977oie.2.2021.03.05.14.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 14:28:03 -0800 (PST)
Received: (nullmailer pid 757659 invoked by uid 1000);
        Fri, 05 Mar 2021 22:28:00 -0000
Date:   Fri, 5 Mar 2021 16:28:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>, phil@raspberrypi.com,
        linux-rpi-kernel@lists.infradead.org, mripard@kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, wahrenst@gmx.net,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, eric@anholt.net
Subject: Re: [PATCH v3 01/15] dt-bindings: soc: bcm: bcm2835-pm: Convert
 bindings to DT schema
Message-ID: <20210305222800.GA757608@robh.at.kernel.org>
References: <20210217114811.22069-1-nsaenzjulienne@suse.de>
 <20210217114811.22069-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217114811.22069-2-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Feb 2021 12:47:56 +0100, Nicolas Saenz Julienne wrote:
> This converts the brcm,bcm2835-pm bindings from text to proper schema.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Changes since v2:
>  - Slightly change things to make it less dependent on next commits
> 
>  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 46 -----------
>  .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 79 +++++++++++++++++++
>  2 files changed, 79 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
