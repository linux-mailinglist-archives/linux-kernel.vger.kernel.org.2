Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B8938970C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhESTwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:52:04 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:36730 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhESTwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:52:03 -0400
Received: by mail-oi1-f171.google.com with SMTP id f184so14223248oig.3;
        Wed, 19 May 2021 12:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kx03fvdnhSjjspr5z254cIlvTfBxI5CrgzMJyPL5sC8=;
        b=miQoxRe7t3MfG5ELYiGXF6pcmVo/tyyY31fRXNybOhQRSC0lI13LTaoLA5OvOEJmHU
         KiNSIV0cbWCFFfWYDmWv0e4jY8PdS+qwC6MtpQFCpPEhZBnUpEc0H4VsDESJkISRNp56
         tC5UPoVVjiQ4GnlkPKDKl+6dBVH1mDLueUfGqEDv24Y6jyzEoR4TO+zJmBdKGXk31eGa
         btR1wBVzdCSXYRHPl7je9ZvcujoxPsBzAamy70mTbcww0rBqLZH9+p1IeI0hXOn7dKQK
         2FTYGffxZrlaFazg7nmZ2O9gFx48dFaC+UddcCNHI/i78J0vzl/TeQgQJVuOc3vFvprN
         pVSA==
X-Gm-Message-State: AOAM5317qoegKWdPZ2wKulBqBCbEkH8Gd1urEbkNDW4ec7aLjNhzc54P
        Ld2gcILFNVLmsla38GrKqw==
X-Google-Smtp-Source: ABdhPJy6M4FHoTzsYmeTAl5vxwq7ZJTk3MzyMOfhxI/Egom/A/S5/+VLjz+C/vNSpN9gJ3u2ntpNLw==
X-Received: by 2002:aca:4b91:: with SMTP id y139mr787385oia.78.1621453843557;
        Wed, 19 May 2021 12:50:43 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o20sm148796otl.2.2021.05.19.12.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:50:42 -0700 (PDT)
Received: (nullmailer pid 3535122 invoked by uid 1000);
        Wed, 19 May 2021 19:50:41 -0000
Date:   Wed, 19 May 2021 14:50:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linus.walleij@linaro.org, olof@lixom.net,
        linux-kernel@vger.kernel.org, soc@kernel.org,
        ulli.kroll@googlemail.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: add vendor prefix for ssi
Message-ID: <20210519195041.GA3535062@robh.at.kernel.org>
References: <20210517193205.691147-1-clabbe@baylibre.com>
 <20210517193205.691147-4-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517193205.691147-4-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 19:32:03 +0000, Corentin Labbe wrote:
> Add vendor prefix for SSI Computer Corp (https://www.ssi.com.tw/)
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
