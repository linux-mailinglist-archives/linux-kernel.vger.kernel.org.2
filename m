Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656203EF5BE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 00:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbhHQW2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 18:28:14 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:40458 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbhHQW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 18:28:13 -0400
Received: by mail-oi1-f169.google.com with SMTP id r5so1486544oiw.7;
        Tue, 17 Aug 2021 15:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+BfyWYAoDwRkQ9ttoNeQVU12lDc/IMP5LXy6G6YFggg=;
        b=DkXknGSv8IUaUH7XMH31NDdFalzjy5ZQYkUuLUMLSIdwwvlGdb7kFHI/ijPmUOz9rQ
         Zz03iB+igq/zWQF8hVBn2NQBDQVjce4B0uxxylekxhz6fBQLQgettijFGf3lFu4GkQ6G
         c/fUmae6Sc2RhmJbqc5SN7ippKQC9DloUyLQCNmhZn4pYT3+37WmIRHrDokHzrOj7nk8
         RLR/ELNoGLW2lW1FpxRK2pPdqUiZ+gvhHtRZwN83nMdd4NkM1kfSvrKp835OLHta11//
         fyOKLjjfJHm0wdiGbV4263I9rRPC6KjJ/kY+UPr5JPK/XA7aReCY+1cbuFnCQXVEjmsW
         bedw==
X-Gm-Message-State: AOAM533bVY1nhpwh7+MZJ3keHXlG3HpCNSdrSM/dgydAlT7cnCXEk5uk
        SqK01CAH0Qv18717fIXJbg==
X-Google-Smtp-Source: ABdhPJxty7SNfAPEV9cCyobRKduumTHgvCTsgLmTbjfmVB7lp43RU+dh1FnRjisXCBnLAZc5V7Rybg==
X-Received: by 2002:a54:4791:: with SMTP id o17mr4498500oic.133.1629239259608;
        Tue, 17 Aug 2021 15:27:39 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 21sm688844ooy.5.2021.08.17.15.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 15:27:38 -0700 (PDT)
Received: (nullmailer pid 951091 invoked by uid 1000);
        Tue, 17 Aug 2021 22:27:37 -0000
Date:   Tue, 17 Aug 2021 17:27:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] amba: Properly handle device probe without IRQ domain
Message-ID: <YRw32YE4cnNnWSvl@robh.at.kernel.org>
References: <20210816074619.177383-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816074619.177383-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 03:46:16PM +0800, Kefeng Wang wrote:
> Patch 1 and 2 make some cleanup, and patch 3 use of_irq_get() instead of 
> irq_of_parse_and_map() to get irq number, return -EPROBE_DEFER if the irq
> domain is not yet created, amba_device_add() will properly to handle the
> no IRQ domain issue via deferred probe.
> 
> Kefeng Wang (3):
>   amba: Drop unused functions about APB/AHB devices add
>   Revert "ARM: amba: make use of -1 IRQs warn"
>   amba: Properly handle device probe without IRQ domain
> 
>  drivers/amba/bus.c       | 100 ++++++++++-----------------------------
>  drivers/of/platform.c    |   6 +--
>  include/linux/amba/bus.h |  18 -------
>  3 files changed, 27 insertions(+), 97 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
