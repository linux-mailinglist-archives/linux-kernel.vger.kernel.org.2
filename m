Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE085389A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhESX7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:59:09 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:42646 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhESX7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:59:07 -0400
Received: by mail-oo1-f45.google.com with SMTP id v13-20020a4ac00d0000b029020b43b918eeso3394917oop.9;
        Wed, 19 May 2021 16:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gPibAC4fBuEtXIMkEUnm/g9igUPKzlNRAN0X0H8j1J0=;
        b=JWliZnq8ZXlJlc8pEBoqiJH8cPOm6KHHXw8qXsaG7gxizScdnsZgvTbv4Z2Lx8oaVF
         ZjcBFxKSxBwyvOlPDoF3XIIpe7epqAvt0b8LBc4Slhusf97mXNMx90YG3YSXsURTQ8YP
         PAyq9ZvIIGPekWvvWseXKKCZV95bZwD70HKytjg+zTI3GQ6/AQ9bUCMg8oxm1igyLWe6
         GzQ+lWRMKRBDCj93vJPTNwXOHTxw/II9qIwv9PmcQUAKiHJj/C5n8Ak1fSyseWSu9Tym
         rmIsYN54TU8YWW9G9qtdvZzVXTI2H2udrwOqKrXoNrdbgEnT15E5wW2ML1exd7jioSGe
         8D0A==
X-Gm-Message-State: AOAM5309SbK7avYanTI5sbsXUZE8pPv13UoykycIYhH4Tb+/1I7vmRJL
        G/lpf8tUHrWqiLBsEx7iqP3NIDrHFg==
X-Google-Smtp-Source: ABdhPJyLHDWhDOyOGSioukLmoOiY9HOKWtKcYj5hkDbf+7rwVkVsa9EjnYbtJkJvxuX3YScyDEkxow==
X-Received: by 2002:a4a:e61a:: with SMTP id f26mr1572038oot.76.1621468666964;
        Wed, 19 May 2021 16:57:46 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x141sm251630oif.13.2021.05.19.16.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 16:57:46 -0700 (PDT)
Received: (nullmailer pid 3914307 invoked by uid 1000);
        Wed, 19 May 2021 23:57:45 -0000
Date:   Wed, 19 May 2021 18:57:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] mfd: db8500-prcmu: Add devicetree bindings
Message-ID: <20210519235745.GA3914249@robh.at.kernel.org>
References: <20210518145132.428340-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518145132.428340-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 16:51:32 +0200, Linus Walleij wrote:
> This driver was merged in the early days of device tree
> on Arm in 2012 and somehow we failed to provide bindings
> for it. Fix it up with some YAML bindings.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Enforce unit name on the DT node, 'prcmu@'
> - Remove overspecified unit names for prcmu-timer and thermal and
>   use patternProperties to match this to a regexp instead.
> - Drop dependency interrupt-controller: [ interrupts ] instead make
>   interrupts required. Make interrupts required instead since
>   interrupt-controller is already required.
> ChangeLog v1->v2:
> - Make the main PRCMU node name more generic instead of
>   hammering it down to a specific address.
> ---
>  .../bindings/mfd/stericsson,db8500-prcmu.yaml | 278 ++++++++++++++++++
>  1 file changed, 278 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
