Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6A375C92
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 23:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhEFVHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 17:07:23 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:45718 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhEFVHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 17:07:20 -0400
Received: by mail-oi1-f171.google.com with SMTP id n184so6740463oia.12;
        Thu, 06 May 2021 14:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k/gPMK+Xfg6ep+H6MWsHFEMQ9T2XmEt9xMifTotgLCs=;
        b=YBJ2XY+5NHKkQNeEI0BbZcki/RKyuy/66EGRF/YZCZ6XHC34wQ2/q9Pp6lbR2JqAt/
         o/MW/C5SVEm10klVKrBycyWx4r86EiQb/3T8RZ4LyxT98HQc0E6cLfAIwyGBC1UOmuAh
         8EwjMZNcZMVIjG3ceRNDL6Fq3tnjWG+0TEHjlZIC7254h+1n5qK4IOyGolk/bsvjsc+i
         ooDgroKBYO09IamMM27ZxXaFXQxaGK1RZyrB+yvJT3NiMy2X9N0kcRY4DAuOyCORXZkt
         OBVUMNAUmA9D5NFDTGu+HDNsOYPgaVmBHsPQnpHkQI4L2z55hZtHTcE4LMh/qF47bGtb
         blYg==
X-Gm-Message-State: AOAM533bhmyzqatKKkX41Rhkyw8GdsfrJypVulVZN+ZDYaQow6kIaD5l
        V9/KF0H+nU9MMFDGkbemBA==
X-Google-Smtp-Source: ABdhPJzMN9gjgQY9BEYZiNpCP4xZ48xwWs/pBZ5ttg5f2hhyvx0IaZqFCZa39vj+ke+XsaLqICcQnQ==
X-Received: by 2002:aca:a852:: with SMTP id r79mr12235980oie.21.1620335181875;
        Thu, 06 May 2021 14:06:21 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n13sm728879oop.8.2021.05.06.14.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 14:06:21 -0700 (PDT)
Received: (nullmailer pid 801022 invoked by uid 1000);
        Thu, 06 May 2021 21:06:20 -0000
Date:   Thu, 6 May 2021 16:06:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux@armlinux.org.uk, khalasa@piap.pl, soc@kernel.org,
        arnd@arndb.de, robh+dt@kernel.org, kaloz@openwrt.org,
        linux-arm-kernel@lists.infradead.org, linusw@kernel.org,
        olof@lixom.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: add vendor prefix for welltech
Message-ID: <20210506210620.GA800993@robh.at.kernel.org>
References: <20210504193457.4008384-1-clabbe@baylibre.com>
 <20210504193457.4008384-4-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504193457.4008384-4-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 May 2021 19:34:55 +0000, Corentin Labbe wrote:
> Add vendor prefix for Welltech computer Co Ld.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
