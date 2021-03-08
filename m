Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A92433166F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCHSoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:44:02 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:42957 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhCHSnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:43:53 -0500
Received: by mail-il1-f171.google.com with SMTP id p10so9767459ils.9;
        Mon, 08 Mar 2021 10:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=04A7qljy+K+sfiSB0qKOdBkqP1yaL7Hp5xr+2U1W7O8=;
        b=nPuNWsSyYEMYYQl1+zTslA0FaNTRNGYe9eN9P/x69GNAjJNA1nhLRzcWKUXOQQR+lX
         EgNMi/MQkmcL2kUb/KwJ6uZDR0X0cd9s4XZ0zdQuvsIG+MwmSe/GLrX/mh8I6vp6/iLX
         T3MnW0P5PPesBsM2HLaXoe37qMAEDDLWxkZwAnPBHpi5LVwlyYLdGBQGUqLiv+Tq/3rt
         NxiTh4yZhuZwWcnSNrPpXDA6wrLRf4VA0u8AoTFLT0zDqZlCn4AVyi2GcD4KsFfCE2ey
         lZyNMsMSB5tUcSNxI9swcvSOEZRiOtleYBnb5YI1ov+tRDjDYsdlfikZ/miGfjbYZTQ6
         rt0Q==
X-Gm-Message-State: AOAM533cpeEDUKZo8J9ohvJQzS4MIobF2Rz9Xai282ozhSx8iVcf+Gnj
        FLp06ZU4kJopq0sk8u9UbQ==
X-Google-Smtp-Source: ABdhPJyNC7RQ8wNadbDPLnxmemmcFWKiN9fJxUEgnu31U4bbeZ678QJ03h8DOsb5XydgZp4sMBPpwA==
X-Received: by 2002:a92:194a:: with SMTP id e10mr22028649ilm.213.1615229033152;
        Mon, 08 Mar 2021 10:43:53 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 74sm6379073iob.43.2021.03.08.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:43:52 -0800 (PST)
Received: (nullmailer pid 2767878 invoked by uid 1000);
        Mon, 08 Mar 2021 18:43:50 -0000
Date:   Mon, 8 Mar 2021 11:43:50 -0700
From:   Rob Herring <robh@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, frowand.list@gmail.com
Subject: Re: [PATCH] of: property: Remove unneeded return variable
Message-ID: <20210308184350.GA2767821@robh.at.kernel.org>
References: <1614676598-105267-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614676598-105267-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2021 17:16:38 +0800, Yang Li wrote:
> This patch removes unneeded return variables, using only
> '0' instead.
> It fixes the following warning detected by coccinelle:
> ./drivers/of/property.c:1371:5-8: Unneeded variable: "ret". Return "0"
> on line 1388
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/of/property.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks!
