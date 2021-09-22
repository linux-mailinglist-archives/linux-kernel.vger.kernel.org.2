Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83BB414C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhIVOrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhIVOrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:47:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E61CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:45:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t18so7732312wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vBtJFE+lofow65KkthlKBCy0zY8p2r2WeZxJ4tazkWI=;
        b=XlWRxcZKczZ6MNWmAJ6uzfftNpBFTtj2u6tlchvACgOocDNUd5vnx3674guNB1p3iB
         1rtvroB0yiiHcAULxT4Clmacv6TJT56G91i0b9DF70mZKUnst5czv6K8qr5plEEO8GaB
         FNToCMwSpS0ds+dH0/pWnZNJc6BDYVYLH+yuJ+DmMIOevRKRm1wiz/xenEvA1YzK50F4
         N7Y0WiQrGWq9Zsd7AqbzvEos0jU8+2hCkhQyDt1K6qxJnOOYEzCpd3IN7yCR5AQLOZRa
         9gqoFktAiAVy+y/7Rd0neQkZR8xiWbSxg9fw/wOni8K+mTec8UHVvyFSkzIgmNp+Q+yX
         Ckhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vBtJFE+lofow65KkthlKBCy0zY8p2r2WeZxJ4tazkWI=;
        b=RATuJqfpkYWHQYU/LMJHkiXPiLNsJ+9aVNJ9Cd6Ib2SThjWiNoMBKSx0lzhD9p6PYh
         xqvP5yNOhZtQUgCUfnt1AXnhbiBNwJEWPhgtOwOWYztEdxBgCjcU5CU5jlEzDynNYBh1
         XyzAjRgodyVPdB+NfV3dk3BlccBERUwnok58vWsOBjyJWsjGc0KOD7VxZIj/UfA0CK4J
         cSsNxWGlmocF8tlICbvE52RwuKMtYcSopGiCNmM8f5ZfbXXkR0qGRzmpsmntU8Xd0QCp
         ndR/p0UOr5VBXOo9+FMezmJMUKcQGYAS81wiLpNaJycZBtQdT41wezMmcIUwywOal1dB
         67cQ==
X-Gm-Message-State: AOAM532MwFYpCKoSV689MpUg86j4IDiYCsJHAzHhY3RUa41pqJ8X1+tn
        DJO6CXVm7Ae1ApsqMtj46SNjjw==
X-Google-Smtp-Source: ABdhPJw8riDRCc+8hErOFvP4SgnMWnSaRjwppkdDu9v3Rwgwoehg8PNJNDJ3cM4zJ6telHppmPbZrA==
X-Received: by 2002:a7b:c4c2:: with SMTP id g2mr11052165wmk.134.1632321939185;
        Wed, 22 Sep 2021 07:45:39 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id d2sm2441774wrc.32.2021.09.22.07.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 07:45:38 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:45:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v9 2/4] dt-bindings: mfd: logicvc: Add patternProperties
 for the display
Message-ID: <YUtBkOFeQWnteG5L@google.com>
References: <20210914200539.732093-1-paul.kocialkowski@bootlin.com>
 <20210914200539.732093-3-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210914200539.732093-3-paul.kocialkowski@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021, Paul Kocialkowski wrote:

> The LogiCVC multi-function device has a display part which is now
> described in its binding. Add a patternProperties match for it.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
