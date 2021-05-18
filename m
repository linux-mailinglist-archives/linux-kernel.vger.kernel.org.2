Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD87B386F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345744AbhERBbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:31:00 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:35543 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbhERBa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:30:59 -0400
Received: by mail-ot1-f53.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so7273306otg.2;
        Mon, 17 May 2021 18:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mtEq8j55mxGIhLsxC+0Tt9kquORYhapeNt/w6anQQt4=;
        b=oAhHxobPX3knvRxqVu/rQSoxSzp9UXz1LFvN8cU2LkqRpZa5JT1Ook5Bf1dveEl6qw
         bE+E7UJCnSK/fDRpMFM9hmWwdzJuiXY82PYXhC5JFvxT3JzZfbn88bNSdkwOZG5cun0Q
         pDT8wucmKtOoK20wsZgoKnL2EBgtj/2qAPP4hVOj+rPFqx8qgxyreuC13jjgpU4Hh8Xv
         mrnbE54H325oepESVR3tHBJmcSJcmTjl2zX8N5z5eDIWeGoTgOC6p2BJcS/AUKLVSulC
         akSJxkq5hHYEmsj66NsO87kFh3vNVfTxAbDFVmP2ZdM7b1VT9vRJ0sSeRWjbg8/XpsyY
         svww==
X-Gm-Message-State: AOAM530ioFp5sxd0Hd3WMwRsWqkp1VgUGLQHoecLmi/bgN2kA5Exggtl
        cB3Zmio6L3nYkOZJ1JihUg==
X-Google-Smtp-Source: ABdhPJyaIl7Zp0SviQyZPzJ4iROXA8Xzg41TCNtFf1ajSkMLSoWadKPjaKwFMNBk0DrG19v5b3+zXw==
X-Received: by 2002:a05:6830:1196:: with SMTP id u22mr2046404otq.247.1621301381876;
        Mon, 17 May 2021 18:29:41 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i2sm3447330oto.66.2021.05.17.18.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:29:41 -0700 (PDT)
Received: (nullmailer pid 3603772 invoked by uid 1000);
        Tue, 18 May 2021 01:29:40 -0000
Date:   Mon, 17 May 2021 20:29:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        martin.blumenstingl@googlemail.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: amlogic: add Banana PI M5
 bindings
Message-ID: <20210518012940.GA3603721@robh.at.kernel.org>
References: <20210514143255.3352774-1-narmstrong@baylibre.com>
 <20210514143255.3352774-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514143255.3352774-3-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 16:32:54 +0200, Neil Armstrong wrote:
> Add bindings for the Banana PI M5 board.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
