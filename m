Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F3E375C97
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 23:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhEFVHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 17:07:51 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:39725 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhEFVHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 17:07:50 -0400
Received: by mail-ot1-f47.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso6138519otv.6;
        Thu, 06 May 2021 14:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8NvB2tyPckkIgewV0lmTw4rJstRnCjKDzoP9iBSvnfQ=;
        b=qW88VfD4jNcqg951sapoOn3pyHqHzZXcvBqnGm1KTDQr2Ffc7t/7QKj05v2SACKY7U
         MVWamKbrSIp+sCt0zuZ5KmrmREkpvJHU/jdYtIjed/h0QGqwMrjyTyynbB52P2Sm8gdZ
         3CHyrN5nbdCGox5712whyBvmrqtcn7Q/lBL5hJipT/+4QxvgjIP7/9i6MdS57Z/KVcHI
         2whKyIv2lD6mlq1fuFk2bbiCtLxIx9x1qewYdUyxoTdOdXRZ8+qm9hMSIyri5d1q9CCm
         bzJOwFXV+aIfQkatpRjjjSB8gNo/ek1Jlvx1OvKc/MRm7X50GaTVmJSWUabXXFUakLG1
         tgdg==
X-Gm-Message-State: AOAM533JPb0YOHCDeed4G+d1E5v5s6YmFGwomzGPTFTgd3TyWNK3p+1e
        BmjRumGQ3LmcGFgbQsRo6A==
X-Google-Smtp-Source: ABdhPJwFIx0e8c86RcR2tVo7iJB2J6CR53YsYNw6wGVQ7XCn1k0eh+UfytGsFuiJoJspx6n2BQ/8Pw==
X-Received: by 2002:a05:6830:1690:: with SMTP id k16mr5270532otr.54.1620335211551;
        Thu, 06 May 2021 14:06:51 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k7sm729416ood.36.2021.05.06.14.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 14:06:51 -0700 (PDT)
Received: (nullmailer pid 801808 invoked by uid 1000);
        Thu, 06 May 2021 21:06:49 -0000
Date:   Thu, 6 May 2021 16:06:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, kaloz@openwrt.org,
        robh+dt@kernel.org, arnd@arndb.de, khalasa@piap.pl,
        linusw@kernel.org, linux@armlinux.org.uk, olof@lixom.net,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: arm: intel-ixp4xx: add welltech,epbx100
Message-ID: <20210506210649.GA801760@robh.at.kernel.org>
References: <20210504193457.4008384-1-clabbe@baylibre.com>
 <20210504193457.4008384-5-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504193457.4008384-5-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 May 2021 19:34:56 +0000, Corentin Labbe wrote:
> Adds welltech,epbx100 as a valid intel-ixp4xx board.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
