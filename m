Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B22D375C68
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 22:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhEFUt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:49:28 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43955 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhEFUtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:49:25 -0400
Received: by mail-ot1-f45.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso5302852ots.10;
        Thu, 06 May 2021 13:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bM7mNDdiOUZmeeObZqbnT+glfKVgqMgaIDdHVATsGTA=;
        b=cjsY7vwfaI05s8w+/Y7zampz7V4EDShdRdKPuLq8ZsORsMWbba9QlufCo6JORdmcrj
         /xIVhG4e2ntus+qNdoKozITGt+R+mIgQr+bg7Yy9o33ThjZhtIWbaJS8pffXMQsZB6r2
         KMarKfgVPzkQL8tsBlPHniaE0pib7H/tEfYsz6SEuGG/hyDOI9vzKzjsm0EggO5d2nZ8
         mGdyNr/j8by03pHB2iYoBAyU44YOLC/owdypiLT5TO032jfH5zfH1gcNAgQ4pt8w7g52
         6Jo4yuk19bRFL6GdsV/XPB6DSlP83gC8K890wNwr3saBUk/sqAl8rbx6A5kNlDWQCEUe
         kaBw==
X-Gm-Message-State: AOAM533MXs7j9JFYrnG9r8CxPD81p3Kp8Nbika4WHThrGPUuLdlsdoWK
        TObBBOBiIqS/F35iTyyDXw==
X-Google-Smtp-Source: ABdhPJx12QWqOGOWr2UyyDEwlPKiJHLXHbUgBE8IbfUNRLj53eVq51YTwDrdTr+th8GX9IrsgV/ugQ==
X-Received: by 2002:a05:6830:24af:: with SMTP id v15mr744597ots.165.1620334105882;
        Thu, 06 May 2021 13:48:25 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u207sm618265oie.56.2021.05.06.13.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 13:48:25 -0700 (PDT)
Received: (nullmailer pid 776804 invoked by uid 1000);
        Thu, 06 May 2021 20:48:24 -0000
Date:   Thu, 6 May 2021 15:48:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: add vendor prefix for Insignal Ltd
Message-ID: <20210506204824.GA776775@robh.at.kernel.org>
References: <20210504120742.12922-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504120742.12922-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 May 2021 08:07:42 -0400, Krzysztof Kozlowski wrote:
> Add vendor prefix for Insignal Ltd (http://www.insignal.co.kr).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
