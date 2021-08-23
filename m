Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79E23F503B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhHWSQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:16:33 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:37621 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhHWSQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:16:31 -0400
Received: by mail-ot1-f48.google.com with SMTP id i3-20020a056830210300b0051af5666070so28959830otc.4;
        Mon, 23 Aug 2021 11:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UV4CCLlx2/3av4QM3ejjnkE261kMA2Hzsf+cSXd+Vsc=;
        b=KRgofHgNDgYPBpOJfqhgKnLyI0Bek+XazoCtuhzGChYrX3B6kRq23kLoGf7IC9jRWn
         y3xKgkQSs3oGvubJ+CKUTdKuGSxbUcJgJpLdH1sn5MZN1b/ZIH6ttEF03dnJwHOCL+CV
         xL88jEDlkd7CH/FM4qOBhcxQD13eK04bRW0iDZRXn2m4iKvIJdeOqJsRBizxRiJRwun7
         ZdaY7ZqwUFzBBuP6L1gssA79b5i2EW8nEgPsrAtdB+ydaTw119zxv8Yp+PM66Kj/7FI7
         BSg0rPoJnFmtXt9OG++VLxsyIbNRYJ9x1k2R/XEr4doMrRbD8KZtRwjDbX79jF9AYDrr
         6lxw==
X-Gm-Message-State: AOAM531ytS6J3Tcbjo9M3Y0md7fD0ai01afYJhx5R97pDBpWNBgcvXhk
        FLctk5q8B6zZ5hWN7tDmZA==
X-Google-Smtp-Source: ABdhPJwQenwSGhA5Zmx7gY6VmlzIQL3TjBa2ECWAw4h4e7faZ2gNyv0SNJ1ZhIpEif0ycyfreKN/Xw==
X-Received: by 2002:a05:6830:1443:: with SMTP id w3mr28872612otp.49.1629742548090;
        Mon, 23 Aug 2021 11:15:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 45sm4068354otm.43.2021.08.23.11.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 11:15:47 -0700 (PDT)
Received: (nullmailer pid 2455714 invoked by uid 1000);
        Mon, 23 Aug 2021 18:15:46 -0000
Date:   Mon, 23 Aug 2021 13:15:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v2] dt-bindings: memory: convert H8/300 bus controller to
 dtschema
Message-ID: <YSPl0priG9zyN3L7@robh.at.kernel.org>
References: <20210818202953.16862-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818202953.16862-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 22:29:53 +0200, Krzysztof Kozlowski wrote:
> Convert H8/300 bus controller bindings to DT schema format using
> json-schema.
> 
> The conversion also extends the bindings to match what is really used in
> existing devicetree sources (the original file mentions only
> "renesas,h8300-bsc" but "renesas,h8300h-bsc" and "renesas,h8s-bsc" are
> used with it).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Changes since v1:
> 1. Add renesas,h8s-bsc pointed by Rob.
> 2. Extend commit log.
> ---
>  .../memory-controllers/renesas,h8300-bsc.txt  | 12 -------
>  .../memory-controllers/renesas,h8300-bsc.yaml | 35 +++++++++++++++++++
>  2 files changed, 35 insertions(+), 12 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml
> 

Applied, thanks!
