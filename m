Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6465B3F50C1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhHWSvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:51:37 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34735 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhHWSve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:51:34 -0400
Received: by mail-ot1-f41.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso33926404otp.1;
        Mon, 23 Aug 2021 11:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ibqYqwzrxFDs1rIICXd2rSUQKkjt4bbArJMFMUQA24=;
        b=FRzulpq/qRI45FbOrTygVJA2L5SvF/F9hsifWEuCi45jrf5SpnnxiwvsHTw43NzFyN
         GbpxXOOrdPK/VyLO7iO/w7WDgDO7WkCKwWehR2YZ7XffUpXR3e6OaR34B7qZyP66HehQ
         BufIImaO57Jf/ysq77UJfsDRQRxd29JdgH+pQCL+OslQCWl48LN3PZF2VrQ58kXnU5t3
         ZTawb3gsccPC/Q6rBFjHpwd2ZDQsfpWp/T5PBn0fAvLSaYyYdjXekIUQXIVNwLf3QMiw
         cYrsSj8tWE6gwilWND6DDDHcGqpY+/ZmtqqOZVWgiYoVO5RWtxm3nmfQtn93hr53HeZN
         /f1w==
X-Gm-Message-State: AOAM5318RG9eA772y3vqf4DAgcNlMKjZ7lMJ+vmYiEDFkmGA7hgVdmoi
        eHLAnSM4TE2gNDVl7twNuA==
X-Google-Smtp-Source: ABdhPJzFJJbSXFtX7YAuba3AVKMuf7OYPT2gNdc24xFPtDyky2Tiy3wtUcc6tGnx/rNwasTwbiIjSg==
X-Received: by 2002:a05:6808:cf:: with SMTP id t15mr7280oic.108.1629744651364;
        Mon, 23 Aug 2021 11:50:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b28sm2854249oob.4.2021.08.23.11.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 11:50:50 -0700 (PDT)
Received: (nullmailer pid 2510580 invoked by uid 1000);
        Mon, 23 Aug 2021 18:50:49 -0000
Date:   Mon, 23 Aug 2021 13:50:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        robh+dt@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: remove obsolete zte zx header
Message-ID: <YSPuCapn1wsUbTPn@robh.at.kernel.org>
References: <20210821030924.192-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210821030924.192-1-yuzenghui@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2021 11:09:23 +0800, Zenghui Yu wrote:
> The zx296718-clkc driver had been removed in commit bcbe6005eb18 ("clk:
> remove zte zx driver"), so this header is no longer needed.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  include/dt-bindings/clock/zx296718-clock.h | 164 ---------------------
>  1 file changed, 164 deletions(-)
>  delete mode 100644 include/dt-bindings/clock/zx296718-clock.h
> 

Applied, thanks!
