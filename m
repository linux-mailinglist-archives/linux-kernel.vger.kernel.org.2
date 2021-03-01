Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A607327BBB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhCAKQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbhCAKQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:16:06 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17350C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 02:15:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y22-20020a1c4b160000b029010b2094f5deso2700182wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 02:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=crPUAdlFyPpfuaXxOqJsVVBomCDQLb56jxagBkQRnFM=;
        b=jWjM5EehUeNVMVoB+4VKLb05JQrfbgTBrVeKrBaLYJyeeJHO3CQ7KaBarf7rJek9tl
         R8F579g+wwY3RnA0CyQQ8WzvfIyF/BwLIIS5uMgNMSpduZwkuYmNbkJeMlnrMSkeCBsD
         d/wDslMH+WOLU5Kk/k9ohI6zGkoD35nIIctGpAoHsUHeHcLyabOZ2hQZGW5MevjzTebx
         UpdgENOY+mm5i3g5GBRB7wlt/26pVjn0KmCrvXIpKaZNwS/5yX7UzJOGRVNDVo3URsg7
         aNNt5DMJhX47XzS6vL9NNCCjQb34TgToPHNY+EN+hW1hpFZPy+CuKj43OYgljNzZ7eKR
         kQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=crPUAdlFyPpfuaXxOqJsVVBomCDQLb56jxagBkQRnFM=;
        b=fVkUbDNwtyfKAJB9woZxlPmS7DDoS8pLkDEWe+3U7Vd/w7RRb8DTktfv+Z+KDA4m8D
         LxXdnSOmcVY5pjEoQmHXNNsE8aU9fAfoDTae/nU18sqsgEpln0Ba9utu9Nyo2roxPwOH
         NFFkBEacvTotypaVPxUlhWUSOQsO9IO3PdFZeUYw6d5HgRMAmSAqXe7cmp4C8Y+UVuro
         ko05X9GS8VbY7QkanN6Lv0LCLjvztv02dBDExy9lwdmSlU39jqarHStI0yxowkRIQk59
         KZABTVAXmsZ4imvG5GYXgWz6qM2Rs3E7mEMnVQ8MPXqg4sv2f06zo1jHpKZJs2vcqDBH
         oWlw==
X-Gm-Message-State: AOAM533lYbfubFA9aSW7AL2OkByBccpKTp1+EUgmbDtM/rDLTEV6vzFd
        by3o/3VOfJh5Yf0Nq3/B+x7axA==
X-Google-Smtp-Source: ABdhPJyemhH27fZmSE/DGIYaD/4JRppne9AD71z7T3Bzenw+2zecWpfTVjabFcnmwTRwcD/4cITr/w==
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr15177227wmk.101.1614593724842;
        Mon, 01 Mar 2021 02:15:24 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id s11sm22750263wme.22.2021.03.01.02.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 02:15:24 -0800 (PST)
Date:   Mon, 1 Mar 2021 10:15:22 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.galvani@gmail.com, stefan@agner.ch,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RESEND v2] dt-bindings: mfd: Convert rn5t618 to
 json-schema
Message-ID: <20210301101522.GH641347@dell>
References: <20210131215730.4647-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210131215730.4647-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jan 2021, Andreas Kemnade wrote:

> Convert the RN5T618 binding to DT schema format. Also
> clearly state which regulators are available.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> https://lore.kernel.org/lkml/CAL_JsqJWt91+aZwAWEUVjOBQgsYw6GBHqmoHwU_T5qZabxX+Aw@mail.gmail.com/
> 
> Changes in v2:
> - drop irq description
> 
> Due to its .txt-format history BSD license was not added.
>  .../bindings/mfd/ricoh,rn5t618.yaml           | 111 ++++++++++++++++++
>  .../devicetree/bindings/mfd/rn5t618.txt       |  52 --------
>  2 files changed, 111 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/rn5t618.txt

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
