Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D630C45C8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbhKXPeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbhKXPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:34:40 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E3DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:31:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so5768506wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lDZ0qqCGY31bN5SGToe8ocb8Dqd0fJcPwdzqLP/2Ca0=;
        b=Lby9aa/FaSopDaF2GQWVvAsHRqx8stczVFSiKORgnTS1NhE3zOJoliiH47hYg34Tnn
         V0oKC0eotLcnGkmj/dML2m0ZCSfvt+DIRfK4myxW6bLvZJSZxHbNZyvBzsohetKqxbv5
         dJdLLfvpSEWvMcemh1znmZmezdgklSuWO9O/ANl+QAk6gy50Rwv/OCdlXbfjDF9Yffk0
         qJeEa4n8y8Mzoz5GK4mrFgcMCpQtWr/NDyO71JFzYouR61vddAWQFiGtnDr7Pj/9ZVEe
         yV69/aAmpNVADG4D8c7H6SO0wxJAqCdF9ek3lNw/j1H7/r5PNLNG/xg/Cg6ozsvi6JeF
         DLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lDZ0qqCGY31bN5SGToe8ocb8Dqd0fJcPwdzqLP/2Ca0=;
        b=2zKxJT54l4vkhQvFJDa3xjsNv5cj2WSD3uRikcCbHD5FqfiB/hDY6Ela+bMLMKLydH
         Cr9vJ8VAlMFM7oBZeneHcvkklAVyq5Lvp9mM4eTnEDOGrQ61aweeFFZQHEs9y4Hw8hlj
         FOsfqQQzOkMMGMjdueyFpESWCdpoJsQg6bgbGkVOnPTTv/8aKsdQFgCehLKjRSLKd8NX
         SqAk1pq/ncVXS6uQhD8cH9cp+r5dhnK9ODFljvUZrQAw+JzeHMdusUWvGCc0OdgjJHX5
         /65jw83auviu8YDwjC2yZEIeJQC4a9YOI20GJiQJpghzUa8dWWoL7k8L8T2Sqm7nejQI
         Fg9w==
X-Gm-Message-State: AOAM533ixrJTCLZw9j38Ykrtxu2qz+SSNwqAXIFOzSYTuxLImlMf5bTr
        166EVCcTUo5PQ+GIcumeG/Fkeg==
X-Google-Smtp-Source: ABdhPJyc6Sc10kUwldoJyZQlSStCddZNM5msJUbD4wNaW9xODUSkA9XhAG/oV0n8knS5/+jSoS2Hwg==
X-Received: by 2002:a1c:a503:: with SMTP id o3mr16628627wme.98.1637767889091;
        Wed, 24 Nov 2021 07:31:29 -0800 (PST)
Received: from google.com ([2.31.167.61])
        by smtp.gmail.com with ESMTPSA id l21sm183708wrb.38.2021.11.24.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:31:28 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:31:21 +0000
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
Message-ID: <YZ5ayQBtPYiSconZ@google.com>
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

Tired to hoover these up, but they do not apply cleanly.  Would you be
kind enough to rebase this onto at least v5.16-rc1 and resubmit please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
