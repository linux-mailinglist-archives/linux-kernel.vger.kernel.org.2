Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1A4347D64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhCXQNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:13:02 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:33319 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhCXQMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:12:38 -0400
Received: by mail-io1-f52.google.com with SMTP id n198so22090563iod.0;
        Wed, 24 Mar 2021 09:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LQe8mB4Zgg4XFKf9gTgpkrZrwD2w0XrO12e5gW6IipQ=;
        b=UXqRCwic7O/veasV43oNR+95O30rsEKgNHRWFBIaUZBFEhf/1aXwFoHvHcCyEyGEGt
         zqCK0GEYHefxg0FEmgOq44NMXk3malDhg3NfVG7cPa/sKDFhagtA0mQaJtk9e8wqz1/D
         BIrAhVb6fbKx8c07Ss3erRMOG3t4mUGnahfVrQJ5iMEZqw7IlfxP5VwOWGzQ6AaqoVYk
         tskp4/SaCf6E88lAEnXZ0KGPC9kyoVWTylGLh3mnMlSn03P/3Y/+SEI8tLyMisJBGfp3
         VF8QbVMR9gx9X7wbzE/3VA+v10iNKxGsrMD+aSkAA+nV/WNGi9cy8Cgp47XrqURMNZ7O
         wD4Q==
X-Gm-Message-State: AOAM530IQrED/cLaC0Tm/Gd2MnjyBBDrgfwfavKgbPYmGmSAQj16Rhg8
        vYlS8+AB55c4DKaEeoenxw==
X-Google-Smtp-Source: ABdhPJwX4gV2lhVI6+HX3+Erc3mPYuI2WdlwXzBahI+PyLQt9TmCbprlf42MQp8SkKsbMlZQFVt6Sg==
X-Received: by 2002:a05:6602:80d:: with SMTP id z13mr2999536iow.17.1616602358385;
        Wed, 24 Mar 2021 09:12:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i12sm1250140ila.1.2021.03.24.09.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 09:12:37 -0700 (PDT)
Received: (nullmailer pid 3170148 invoked by uid 1000);
        Wed, 24 Mar 2021 16:12:35 -0000
Date:   Wed, 24 Mar 2021 10:12:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     lee.jones@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, matthias.bgg@gmail.com, broonie@kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 1/7] dt-bindings: mfd: mediatek: Fix regulator description
Message-ID: <20210324161235.GA3170092@robh.at.kernel.org>
References: <20210312145545.26050-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312145545.26050-1-matthias.bgg@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 15:55:39 +0100, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Having a separate compatible for the regulator node is redundant and not
> needed. Delete the corresponding requierement.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
> 
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 3 ---
>  1 file changed, 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
