Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A80A348058
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhCXSVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:21:01 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:45781 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCXSUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:20:43 -0400
Received: by mail-io1-f50.google.com with SMTP id k8so22509118iop.12;
        Wed, 24 Mar 2021 11:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ig+KkfJQcwSblEK2S1I9sobCgnNed5Bj9RDLShyJXOY=;
        b=hWbYg8P6D7Qw+fVfMQJ1Wcf8mtnGryctym9BfvBC4DW7bQTUAp0gE6jGYY6MWAoB40
         hI6QCp3FdG4ApovkwNNOcvdeDwwu94e6CwGjnHIuFz2KuafnoraPukmfgTbBlwltI7Dl
         zVHHD8s0Rmuy7+9QeOTwEyfOe5ABpRREWemAufWrLu1kPgPdvXz46489CeKxEfPJ2Q74
         LvClWLxvHMSbHWCb5rbEIsv0da2rmDnbZNOcO1gmCBeqq3A0wTk8bB3dKTexu7K9ZEWK
         GICkIknWXpACRN2vr9EP6GwZHp+Aah/CGMgmCqYZFTObKcyEK0DAg4Rits2pGw0jSR7X
         JqSw==
X-Gm-Message-State: AOAM531mmXoUze1fdn4j8vU9pQVD1HwMg9Liv82OSTo3e2vox3GIJnnf
        dWvOeJfPQauprc0AqkfW8BAvKn9FKPjO
X-Google-Smtp-Source: ABdhPJwqYw2al+Pn/HET/T00REhPwMvU4pDU6ezy3eQcK+M4dbS+fIyQb9sfu6GyHAkDZ6H2WIAD4g==
X-Received: by 2002:a5d:8149:: with SMTP id f9mr3503048ioo.191.1616610042946;
        Wed, 24 Mar 2021 11:20:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e13sm1492634ilr.0.2021.03.24.11.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:20:42 -0700 (PDT)
Received: (nullmailer pid 3371542 invoked by uid 1000);
        Wed, 24 Mar 2021 18:20:41 -0000
Date:   Wed, 24 Mar 2021 12:20:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: add vendor prefix for YIC System Co.,
 Ltd
Message-ID: <20210324182041.GA3371439@robh.at.kernel.org>
References: <20210315124423.115039-1-krzysztof.kozlowski@canonical.com>
 <20210315124423.115039-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315124423.115039-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 13:44:22 +0100, Krzysztof Kozlowski wrote:
> Add vendor prefix for YIC System Co., Ltd (http://www.yicsystem.com).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
