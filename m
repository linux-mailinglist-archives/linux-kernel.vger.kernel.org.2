Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F99435E91
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhJUKFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhJUKFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:05:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FD8C061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:03:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r7so119270wrc.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Pq6ffVOHqPjfKN12beban1i7Qjv2tPHN8CWSESl3fUQ=;
        b=f1t5T1HrVbqwRSlm2cPc1EGMx1JrONofDyFCm53gZY8MiyAbzia/BrKYdWW2YgXyKB
         n3gPfiivXhQBAwEs9iSh7btskWaLYgdkzLqmZhqOfzrstMuCKXkuPjJaMKn8uh5AUQyZ
         ytaVKFj/4QaoiZv9kN6ApDzmyCZ3n4+FgTw/3L+HqkYvY6khz0HGrLbZHR2HQV81pVmZ
         sD+pmAuIsHGuCDh9enq+QhF15cQnspOfFQkh9IUHViLltK23ZXoynf4SCy8qiBkk/FtM
         a2/RNMxdGbc6hZzuFq0eXrQ1IlZJjvsSh1o+KLurOiGiKMPuqJhTbZh86DAsGYeQVlN3
         Rl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pq6ffVOHqPjfKN12beban1i7Qjv2tPHN8CWSESl3fUQ=;
        b=SjmwlOkuYwNsXKQZUoAotMEM6NMvnqsgutUmLHvL36z9EE5ym5CjiJwxHe0gmv61Xr
         aDpA5b3nTbkw9ARMXM8jP0Y9Th/kUx1dVpxZOC3VUW5IkUeAsjTNHcscoqTeHNPCGChv
         qPnNfl8E15HOyAYcS+D3B4eVOCUt0JBX09D6cpNKb6eoh3S0I6vCbYioQ1vQRX6JBP+L
         hN0vZdLLB0X5SoTsnGTJy1fJfJ18nkoSxdnQZ/OWRYpAmK47SMoQEU5fbTIUJl9BCsgI
         pmRWG6sbE2iOKxTbbw4CFuVHoD7YfOYNbkCaodshIm95qEKV0AtLxEbMCu6TIBCly/Dn
         r8Ow==
X-Gm-Message-State: AOAM530968hexMprVAXZvC+DSaV/UuMuZ/yszpXqMs1AL4BXbHH5+xCJ
        3b1CePEAkE+IAJ041BeMcTxczA==
X-Google-Smtp-Source: ABdhPJx7WTp8oG6l5QNbcQVWisfShvLDN8DMb9PpRMsPd1LvqzjLVj02VOuCi7j7aSCfBu2SYff0Cg==
X-Received: by 2002:a5d:47a7:: with SMTP id 7mr5958605wrb.75.1634810600022;
        Thu, 21 Oct 2021 03:03:20 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id r17sm5012006wmq.47.2021.10.21.03.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 03:03:19 -0700 (PDT)
Date:   Thu, 21 Oct 2021 11:03:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mfd/regulator: dt-bindings: max77686: convert to
 dtschema
Message-ID: <YXE65SBhGFHP54L6@google.com>
References: <20211008123552.191384-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008123552.191384-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Oct 2021, Krzysztof Kozlowski wrote:

> Hi,
> 
> Convert Maxim MAX77686 bindings to dtschema.  The MFD patch (2/2)
> depends on regulator, so this should go via one tree, for example MFD or DT.
> 
> Changes since v1:
> =================
> See individual patches.
> 
> Clock bindings
> ==============
> Existing Documentation/devicetree/bindings/clock/maxim,max77686.txt are
> left untouched. The file is still used/referenced by other Maxim
> devices: MAX77620 and MAX77802.
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (2):
>   regulator: dt-bindings: maxim,max77686: convert to dtschema
>   dt-bindings: mfd: maxim,max77686: convert to dtschema
> 
>  .../devicetree/bindings/mfd/max77686.txt      |  26 ----
>  .../bindings/mfd/maxim,max77686.yaml          | 132 ++++++++++++++++++
>  .../bindings/regulator/max77686.txt           |  71 ----------
>  .../bindings/regulator/maxim,max77686.yaml    |  83 +++++++++++
>  MAINTAINERS                                   |   2 +-
>  5 files changed, 216 insertions(+), 98 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max77686.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77686.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77686.yaml

Does this need a PR too?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
