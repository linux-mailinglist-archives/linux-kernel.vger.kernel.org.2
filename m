Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A555F4566B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 00:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhKSABB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 19:01:01 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43789 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbhKSAA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 19:00:58 -0500
Received: by mail-ot1-f43.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so13904512otm.10;
        Thu, 18 Nov 2021 15:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qQyw+OaTCyqoQUmDfKtk9AzuInHEGGF+maVbryFDHIA=;
        b=FUWQ2HrKYAUya1JJ60bxWoT4aCepSIT5J9TDGqNw10+bY5aL6L+66qq+h1m/MBSFW0
         4qUXKxhZSKJNx4GQBzZyLAVem+Eq+SZk5xxg/YTCqjxwQJuP2g6u02pJ3jekNuiRS9Pi
         OpUqULm5qAItthOlqtr9j6CthMXHcJkn2BVED9OHbR6VuXD0xYCr+ewiWyvFWxyMjZMc
         m7fRtzHjyPNVMMSCGiQJX/rbTkmjBsaBYuz1LAc2yZ+hkmYEimN9D4kSiL79Eq1l+Yhx
         0AH0Wj29E+vPxlwWywXpov6ukBNk3pZbKLecu8kGGodpU5IGRHhwHuWUzObDm1TYm7BD
         17Ng==
X-Gm-Message-State: AOAM531L6ydSZbu/gvmSEhCkyRSMP6MuWzXwRFz50jJaRZl+z+wjZyvN
        jcsAEl6TBOBaeOs+qwQJ+g==
X-Google-Smtp-Source: ABdhPJwh+xGuBd+uVwlGIC3te+m2L839boD/FFHCle5bUHDD9E0Ar8ETMfzGYzg5H/s9IF895MwqhA==
X-Received: by 2002:a9d:7758:: with SMTP id t24mr1025364otl.264.1637279877876;
        Thu, 18 Nov 2021 15:57:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k94sm253141otk.40.2021.11.18.15.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:57:57 -0800 (PST)
Received: (nullmailer pid 2028838 invoked by uid 1000);
        Thu, 18 Nov 2021 23:57:56 -0000
Date:   Thu, 18 Nov 2021 17:57:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        bgolaszewski@baylibre.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: mediatek: add mt8195 pericfg
 compatible
Message-ID: <YZbohHqctULU4Qu4@robh.at.kernel.org>
References: <20211112050811.21202-1-tinghan.shen@mediatek.com>
 <20211112050811.21202-2-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112050811.21202-2-tinghan.shen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 13:08:10 +0800, Tinghan Shen wrote:
> add mt8195 pericfg compatible to binding document.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
