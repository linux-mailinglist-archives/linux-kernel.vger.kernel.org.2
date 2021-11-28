Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CED460B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 00:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhK1X21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 18:28:27 -0500
Received: from mail-oo1-f52.google.com ([209.85.161.52]:33603 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346859AbhK1X00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 18:26:26 -0500
Received: by mail-oo1-f52.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so5167730ooe.0;
        Sun, 28 Nov 2021 15:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cllw/+pfJt+sUKSkEHfCh1qWAKZ4sczIkvNLPMwJPZc=;
        b=dCteKVDgwbR42WFS8wZA0DiF/EQNhczVMD4/S+scB1iZvXxr8wn+NTGO5ZKw7TvWFq
         aMT/9U8UtIUfhdfQtajz8aN66F51BCWOY5REoIBlSjyaSutCaBTAVm8Lh7vQmSxZk7TQ
         z2oQKqYu+GqPend4c4DFci3mHm9JdZzZqeSeqmgYyCBez5j2tBAjS27B2Gke4Zz2YbUq
         F4Z/DN5kKGSEbUEzg1KGKPwLxbfO3UQsh7Kz8lGuF1nX3g5FKdnXM82C3mt33/7ZdNEi
         V+W5rZrP+eVccNtHO4mSrbOCNyeHVMvB0ZAqc6m80SMW+XwxbvaKDBBClAUz52hXC041
         yyIQ==
X-Gm-Message-State: AOAM533MwVSdXK2KrPob9Y0JEZBFlMpB/+Zc6xg92PMNRyIJN3txjxtb
        Du2jiwPH3BOFYKAe8LpOmg==
X-Google-Smtp-Source: ABdhPJwOmzzEBxMC6X4uHTyJw7S20Mx8SSdvffD7p2Qng+JvC6eUz1r4vwpvo3N5MuZkYH0IJvhN4w==
X-Received: by 2002:a4a:d0af:: with SMTP id t15mr29334868oor.12.1638141789098;
        Sun, 28 Nov 2021 15:23:09 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fe7:4487:4f99:dbc0:75d1:3e27])
        by smtp.gmail.com with ESMTPSA id y12sm2687975oiv.49.2021.11.28.15.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 15:23:08 -0800 (PST)
Received: (nullmailer pid 2808253 invoked by uid 1000);
        Sun, 28 Nov 2021 23:23:05 -0000
Date:   Sun, 28 Nov 2021 17:23:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: apple: Add iMac (24-inch 2021)
 to Apple bindings
Message-ID: <YaQPWUZl0E4tYzVM@robh.at.kernel.org>
References: <20211123224926.7722-1-j@jannau.net>
 <20211123224926.7722-2-j@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123224926.7722-2-j@jannau.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 23:49:22 +0100, Janne Grunau wrote:
> This introduces compatible strings for both 2021 Apple iMac M1 devices:
> 
> * apple,j456 - iMac (24-inch, 4x USB-C, M1, 2021)
> * apple,j457 - iMac (24-inch, 2x USB-C, M1, 2021)
> 
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/arm/apple.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
