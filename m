Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684ED3C8B74
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbhGNTRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:17:42 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:33664 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhGNTRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:17:39 -0400
Received: by mail-il1-f171.google.com with SMTP id z1so2718514ils.0;
        Wed, 14 Jul 2021 12:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JtlBztPf2rxywuzr11fiFFQATpnhawQel5nVIAIIJnE=;
        b=YMEaGIrIuf0V8KfXfWQQZ4fYirCt12faiYbzJRbao40/AJXs97j5NQCUs15hC40NE9
         YhoNIJZKY4To2SZCRPvu283S31Ca0nfxBKF/NPiCNBuy0+32z0k6t08XHi9a6+RV+Jtb
         3Yb8v48fnIeCLwOgrjngKiXA6Hi/ETsFM13htuSoNufH83Tz021kvNAxxe1/DVBtvYsL
         4aIh2cd7Zt5pt2fDmz9CfvQP2hvdK1Jy6Fwf0ll2gLreOwE7alxsRZO78r6vnvXr2suJ
         v+ddde5H9mzAY44xxcfrfjKbQGhGbqIMON8LWe1Ta8a1qOKbuQCsupfzJf8m11WTgKDg
         oSSg==
X-Gm-Message-State: AOAM532kGrW0t74RyeuLTFRojVL1pLiSbqM1AD4UWdjMEl1h6Ogt2shO
        iW/EvPAejPXMXU5eB5bZaQ==
X-Google-Smtp-Source: ABdhPJzNi5K0pdivTQLXSg/Yz/rSXiJShKfV9l86N0uFtd9QYkCJ1eP3QAyahE9d5gIxKF/BbncHNw==
X-Received: by 2002:a92:d8c5:: with SMTP id l5mr7698707ilo.79.1626290086755;
        Wed, 14 Jul 2021 12:14:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k10sm1691516ion.38.2021.07.14.12.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:14:46 -0700 (PDT)
Received: (nullmailer pid 2985496 invoked by uid 1000);
        Wed, 14 Jul 2021 19:14:43 -0000
Date:   Wed, 14 Jul 2021 13:14:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: regulator: Convert UniPhier regulator to
 json-schema
Message-ID: <20210714191443.GA2985359@robh.at.kernel.org>
References: <1624413137-17453-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624413137-17453-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 10:52:17 +0900, Kunihiko Hayashi wrote:
> Convert the UniPhier regulator binding to DT schema format.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../regulator/socionext,uniphier-regulator.yaml    | 85 ++++++++++++++++++++++
>  .../bindings/regulator/uniphier-regulator.txt      | 58 ---------------
>  2 files changed, 85 insertions(+), 58 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
