Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30E0357225
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354326AbhDGQ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:29:47 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:36529 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbhDGQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:29:40 -0400
Received: by mail-ot1-f49.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso18653436otq.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ca6aNPrlJllDN40VkjZY0A4uBR3pGPFR8vmQTnzwuF8=;
        b=qri2AvWMbpjFL7Fx2yjGJJutWSQQ2F5tt/0fIWv9owT7udsv5cO1zH/qTbh2CQrpL/
         pyltBHzrVXESRhhZFlUIgpWuTwVYp20XuuZDQ01MHlvVC+aN9tKyutK0+rR19u8DM/Yc
         E462syeeVpMNHphFu+iD3O+/CmJl6GJlytPtkjah8SnAWhE8Sgz39CO01GqHv3UBgzTm
         TZ7TN3/dLjPwlhPB3G/fpBIJycdoETl6wWCq9xSQ9u1iMRNbx6IX9YaKcxrThF3Yjqkp
         g8LDN1Bc3Zeu0RVvtwZkuDALL5xPdzdiYP6yo+dofEpWUWpRhP+YCvRnYvxn6KhceCWQ
         QCQQ==
X-Gm-Message-State: AOAM530maLb+rNzVJ8Rprq3lwljkSh52HQajyb3gCC1opljSXdPmR12h
        65Tvaxt3/mvgzBM0Kzigi5xThw9PVA==
X-Google-Smtp-Source: ABdhPJyUJ0FutOkRHX4vlvMDlp8OLzozptHzeFdA22UUVXU3rpXWjB9yj4eW8vQFBqlU93dUi76XrA==
X-Received: by 2002:a9d:6d87:: with SMTP id x7mr3667610otp.250.1617812969004;
        Wed, 07 Apr 2021 09:29:29 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 24sm4337505oij.58.2021.04.07.09.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:29:28 -0700 (PDT)
Received: (nullmailer pid 3856511 invoked by uid 1000);
        Wed, 07 Apr 2021 16:29:27 -0000
Date:   Wed, 7 Apr 2021 11:29:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] RISC-V: Add kexec/kdump support
Message-ID: <20210407162927.GA3836121@robh.at.kernel.org>
References: <20210405085712.1953848-1-mick@ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405085712.1953848-1-mick@ics.forth.gr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 11:57:07AM +0300, Nick Kossifidis wrote:
> This patch series adds kexec/kdump and crash kernel
> support on RISC-V. For testing the patches a patched
> version of kexec-tools is needed (still a work in
> progress) which can be found at:
> 
> https://riscv.ics.forth.gr/kexec-tools-patched.tar.xz
> 
> v3:
>  * Rebase on newer kernel tree
>  * Minor cleanups
>  * Split UAPI changes to a separate patch
>  * Improve / cleanup init_resources
>  * Resolve Palmer's comments
> 
> v2:
>  * Rebase on newer kernel tree
>  * Minor cleanups
>  * Properly populate the ioresources tre, so that it
>    can be used later on for implementing strict /dev/mem
>  * Use linux,usable-memory on /memory instead of a new binding

Where? In any case, that's not going to work well with EFI support 
assuming like arm64, 'memory' is passed in UEFI structures instead of 
DT. That's why there's now a /chosen linux,usable-memory-ranges 
property. 

Isn't the preferred kexec interface the file based interface? I'd 
expect a new arch to only support that. And there's common kexec DT 
handling for that pending for 5.13.

Rob
