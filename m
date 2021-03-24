Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E85F34805A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhCXSVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:21:04 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:38688 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbhCXSUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:20:52 -0400
Received: by mail-io1-f50.google.com with SMTP id e8so22533179iok.5;
        Wed, 24 Mar 2021 11:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LXQ/cn60etRO06VYX0/TVyUxNGev2BuhBfzjSkMzu9Y=;
        b=XEJOseeH+4dR9XLHU2jBNc+YrhlyMWsWZ7vU+BQBf4jsMf40aORMkRoYEQIwwcE9BL
         FRU5KC+yJQfR+jdpV7YDoJ6UbbOOqkfi4OuaHofXNXXfZ7pWbYRdkwZ9ncDKEwS9Rast
         HY8TDQzshGaNGsgQENgoN7r29kULDLbUx6miN9GZ+UZJhv0W88SNKakNJZAEuAtsjI7/
         6nZ811aaje+0ViHHMNNadV7zPySQG9CmBc0id0UGk3HPsC2ry0ZS5BWzcX4Rjhi+SK7m
         I6FuF3GUQh9FVT/hebLL3UXhle5R10wgpqBq1GzQnBdtjReRTNx8OUCyKc0G3yAsUN+e
         8maA==
X-Gm-Message-State: AOAM530yVFGq37Fcgc3BeoviTxkhzlq70miqZBFCXVtdZBi/1PaDazFs
        cqKEKQBfseP1myPnbKQRKQ==
X-Google-Smtp-Source: ABdhPJycZllu0LH/CKR/lVFOXHC5F+cCiMHSjqyn/uH0Fx2MOKs+qZk0CCJs/TbMxwUlnDuEINPSug==
X-Received: by 2002:a5e:cb4c:: with SMTP id h12mr3329527iok.183.1616610051683;
        Wed, 24 Mar 2021 11:20:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r3sm1450128ilq.42.2021.03.24.11.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:20:51 -0700 (PDT)
Received: (nullmailer pid 3371921 invoked by uid 1000);
        Wed, 24 Mar 2021 18:20:49 -0000
Date:   Wed, 24 Mar 2021 12:20:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: add vendor prefix for AESOP
Message-ID: <20210324182049.GA3371869@robh.at.kernel.org>
References: <20210315124423.115039-1-krzysztof.kozlowski@canonical.com>
 <20210315124423.115039-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315124423.115039-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 13:44:23 +0100, Krzysztof Kozlowski wrote:
> Add vendor prefix for AESOP Embedded Forum (http://www.aesop.or.kr).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
