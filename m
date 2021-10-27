Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC62A43BFCA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbhJ0Ca6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:30:58 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:33636 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhJ0Ca4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:30:56 -0400
Received: by mail-oi1-f171.google.com with SMTP id q129so1508600oib.0;
        Tue, 26 Oct 2021 19:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mUnsX6KcymyxjG9AHUyhpLpsTsT6H98sO9aH0GblzD8=;
        b=ThKMUm2la5PtEJJTQzgOn6k/EYdq3x45TRkIrYa9afGEskYmMa/Zj7oiyq/Fa2G7Km
         szzvAT+/XuhpmfErETsP9jkeGVf5a6k70jJBoesaM9oLp1azRw23E8BPfgGrFxc6u6Np
         f+exs3sSvkZyzBUmINuSKM1bEg7XoN6Bu3fdGjFtxRHBuV10Zh8XGZaM/eGCwZ7UzhTP
         DmXXw9FFSghztX0bvVWrtfXiChh7cnfEFHToXsfHkHQcny2KS1Yw+QIjf1XCiiRVG8p6
         PZtsgvBG4pbkE4W0iRSs7+BNgYjaOTVk8w8EUkfcixdDS2qIxxbukI1CTkQd1/pfRF3Z
         eTUw==
X-Gm-Message-State: AOAM5322UwE5Msy55TIkHdRDW63b4sxjkYgDFq/CgqSB/or98siZqoRu
        sp0fQ/klb8huD2Uo21wdzdOxoWZFqg==
X-Google-Smtp-Source: ABdhPJx3/gRv4BZZ76xa/QVb4iUAhZb4NF7Hho6OHW0SXmqwzETLKB5jlBYs0TEdT2laZAEjnSdR5A==
X-Received: by 2002:a05:6808:11c9:: with SMTP id p9mr1737188oiv.169.1635301711598;
        Tue, 26 Oct 2021 19:28:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j15sm4524747otp.27.2021.10.26.19.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 19:28:31 -0700 (PDT)
Received: (nullmailer pid 3831661 invoked by uid 1000);
        Wed, 27 Oct 2021 02:28:30 -0000
Date:   Tue, 26 Oct 2021 21:28:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     john@phrozen.org, linux-kernel@vger.kernel.org, neil@brown.name,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mips: convert Ralink SoCs and boards to
 schema
Message-ID: <YXi5Tm5QYirZeFw8@robh.at.kernel.org>
References: <20211019041659.15761-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019041659.15761-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 06:16:59 +0200, Sergio Paracuellos wrote:
> Convert Ralink SoCs and boards bindings to YAML schema.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../devicetree/bindings/mips/ralink.txt       | 32 -------
>  .../devicetree/bindings/mips/ralink.yaml      | 87 +++++++++++++++++++
>  2 files changed, 87 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mips/ralink.txt
>  create mode 100644 Documentation/devicetree/bindings/mips/ralink.yaml
> 

Applied, thanks!
