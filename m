Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC738970A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhESTvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:51:48 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:39637 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhESTvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:51:48 -0400
Received: by mail-ot1-f47.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so12822010otc.6;
        Wed, 19 May 2021 12:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I1uvTDG2OZUbucg6l58mULhf0aAS9KnjR9rg8Nbg/Jo=;
        b=KoVkcfXqQwUygUQjd2G5VujP4dycjWH6hc1I6AtUbi2D92ZJiTrhJh1xr5jIb7vpX5
         /qLmeoSaz2fQW50Q+qKpsZiK6jTdo/LRCUKclUXvCBSGRrZnVCTcmBuDrhqizZN+wPHi
         RayXq8GN2HwYOn8EruN/PAdk8182KWzttMeVgrxbq7qHjhyGqyyqeNGLAZujl/8qk1/a
         8P50+jxHJ7xm5NHq9i3QfmlwTts6wyfSPvhmfUFPRb9iheC5+Fh8WrvSB1plgXfZXHS0
         DdP49jFpC960TX2Tv5Fbryr69nJhr6Hn6n67k6zy6pGwmeTO2X6890cUCQtoe1a3oZWE
         cGdw==
X-Gm-Message-State: AOAM532L9s6q2rc9ZMKMQ8spsUgvtfCo8u2/pxHO/gCDwUXnXABS7Tct
        RTSHZ5YM7Z9dFj8IHZsFYw==
X-Google-Smtp-Source: ABdhPJwrHVc2P5vLxQ+BR4go+vILSaFqfZHLcQ3INgskiyPhp8eJ8bI+GvqEIxWP2XOunEwh6KIdSA==
X-Received: by 2002:a9d:644f:: with SMTP id m15mr954049otl.99.1621453826858;
        Wed, 19 May 2021 12:50:26 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n193sm124169oig.49.2021.05.19.12.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:50:25 -0700 (PDT)
Received: (nullmailer pid 3534510 invoked by uid 1000);
        Wed, 19 May 2021 19:50:24 -0000
Date:   Wed, 19 May 2021 14:50:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        soc@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, ulli.kroll@googlemail.com,
        linux-arm-kernel@lists.infradead.org, olof@lixom.net
Subject: Re: [PATCH 2/5] dt-bindings: add vendor prefix for edimax
Message-ID: <20210519195024.GA3534096@robh.at.kernel.org>
References: <20210517193205.691147-1-clabbe@baylibre.com>
 <20210517193205.691147-3-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517193205.691147-3-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 19:32:02 +0000, Corentin Labbe wrote:
> Add vendor prefix for EDIMAX Technology Co., Ltd (https://www.edimax.com/)
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
