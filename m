Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADF6311331
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhBEVNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:13:41 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34198 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhBEVNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:13:14 -0500
Received: by mail-ot1-f41.google.com with SMTP id y11so8272904otq.1;
        Fri, 05 Feb 2021 13:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jfXJCkiBzbq780Z0WFVTQqlIBpbcIEnBg7oB/G419nM=;
        b=Cg+aWVdzfHVYj97L5Lc1oQvv4VhFw6Gm4G6/xv3SOUnTl4pKECtFf7OQP6r1ii8WnO
         DC3OGCAkni0HBUDYoWqjrJm0Vqo5TjZU2JFtUKlG7GkFdGhvMJh4VkY9U6TMrgDUhsW1
         oNsDt293TpdVDf850GSE/leTJ/Ch//ChBbkmkTfSUUrrwD524Cx/ScvxLVXrSmsI+Syp
         ueJULAXA9kkzfvGBPJRfJbAbJWVmh7dL+2g5QbbIvF71cX0omLvsPZYgXzsMRnepPY2U
         5x3zX2ae0mlJba4NzQH4AsX+e35QxzW+t0B6SLcRPsSlRXfm8AZm4ILVWidicYswf0J6
         Az/A==
X-Gm-Message-State: AOAM533yxa/rzuh04aeEPB8H+nYLpNEa0yhBRbmb0IWylYaWmTLt6nN3
        EaJcZze5Q5QmNQFZt72k8w==
X-Google-Smtp-Source: ABdhPJwylAqylwqaR3GqMNYPn7cDS6VJiFFAOeAJX4/1JNczAVxaR0FslH3GAyypehTQNn18GlE58w==
X-Received: by 2002:a05:6830:1e8b:: with SMTP id n11mr4868561otr.360.1612559553804;
        Fri, 05 Feb 2021 13:12:33 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e20sm2058017otr.14.2021.02.05.13.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:12:32 -0800 (PST)
Received: (nullmailer pid 3749759 invoked by uid 1000);
        Fri, 05 Feb 2021 21:12:31 -0000
Date:   Fri, 5 Feb 2021 15:12:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v7 3/4] dt-bindings: arm: hisilicon: Add binding for
 Kunpeng L3 cache controller
Message-ID: <20210205211231.GA3749721@robh.at.kernel.org>
References: <20210202071648.1776-1-thunder.leizhen@huawei.com>
 <20210202071648.1776-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202071648.1776-4-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Feb 2021 15:16:47 +0800, Zhen Lei wrote:
> Add devicetree binding for Hisilicon Kunpeng L3 cache controller.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../arm/hisilicon/kunpeng-l3cache.yaml        | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/kunpeng-l3cache.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
