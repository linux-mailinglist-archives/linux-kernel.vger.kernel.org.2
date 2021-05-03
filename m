Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3689037200B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhECS64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:58:56 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42883 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhECS6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:58:54 -0400
Received: by mail-oi1-f178.google.com with SMTP id v24so6368020oiv.9;
        Mon, 03 May 2021 11:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LKIBq+EuRXvOGhymbU5xpmDcLOErCQK9vT+5hztdLcs=;
        b=ByBy2vnks+nrT8RvBzuIbo44etuxFxNzlipgS5ZZRLqrl/8/aQb33OZ1afgjsAT6Jm
         jJQtyfsqaoH4rB0+J+vvlysDRcmgfKqTWYfpKNc3OLP8ND/H+E83zy5LXAnRUr22dK03
         Z87dwuNdEZLaap32rFLz+pmXKb/aLZaRYnJJGQxpqOlj3cmKQLHSyQ3e+tuiPUbtF5cT
         1TlDEZ4TXcCtQgI6Y9JNCYe1zvVNnNhXXuVpPr/HPCbuaNnaF6h2NFsRAfIiprvgukAm
         AJejlgFEjkZG5a0yqlbfHDxabPAob+76DcBVEKYlJ8o9Vyd8TxmC1EVOUjz2sWUPizVM
         JhKA==
X-Gm-Message-State: AOAM5323orsIZfvnJ+FzvA7s5WUBWDS4NnYI20oX9zpEk69lMZZaOC1k
        3XV6tV17Cfso7JjNBAgxtxX26AsuaA==
X-Google-Smtp-Source: ABdhPJw/k0barMDJb4NTC9PDoj5BmRX+6Xc3euPhePDc+cCOlt5n2ycwZQHQCjPtsmeJQ4XA1NeZeA==
X-Received: by 2002:aca:f156:: with SMTP id p83mr14855164oih.91.1620068280037;
        Mon, 03 May 2021 11:58:00 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d25sm149125otp.72.2021.05.03.11.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 11:57:59 -0700 (PDT)
Received: (nullmailer pid 2192163 invoked by uid 1000);
        Mon, 03 May 2021 18:57:58 -0000
Date:   Mon, 3 May 2021 13:57:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     frowand.list@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] of: overlay: Remove redundant assignment to ret
Message-ID: <20210503185758.GA2192105@robh.at.kernel.org>
References: <1619347258-55002-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619347258-55002-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Apr 2021 18:40:58 +0800, Jiapeng Chong wrote:
> Variable ret is set to zero but this value is never read as it is
> overwritten with a new value later on, hence it is a redundant
> assignment and can be removed.
> 
> Cleans up the following clang-analyzer warning:
> 
> drivers/of/overlay.c:1197:2: warning: Value stored to 'ret' is never
> read [clang-analyzer-deadcode.DeadStores].
> 
> drivers/of/overlay.c:1026:2: warning: Value stored to 'ret' is never
> read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/of/overlay.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Applied, thanks!
