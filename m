Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D35427120
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 21:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbhJHTDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 15:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhJHTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 15:03:41 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A56C061570;
        Fri,  8 Oct 2021 12:01:45 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id z24so5749679qtv.9;
        Fri, 08 Oct 2021 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xew2Cqp055SEboMYSD4xaomAE75lVTjIUs6xXR179/0=;
        b=C+zkVLwQ561jKCx3zhQEnbk8TmUmArvKZwuTu4o6hFVYBf50l6nH4eFXzxeT6ckUFG
         iCT7GRokfADm3mNb1neAQNsX8B+bhJQe3zQAv/kVlJe6lq/GOCY/0zCqZMG/JLnZx84+
         QTJGxJARW6YfYHxWtL1p6VQgRNDqyww+1GGeqigEy+zt+NntIzIhypf3jsCXtUyhCXQY
         JXRo/4T++xB6+pLKViUSF1mz7D37WsgOLsf2/WFzq51e8PYFd32ltlPrTQ3Fq4ORQ8zk
         DiSu2vcdV9MIj6pwSf2XDvgtd7/eGnvA34XGuLQxsdeFv8D7XsXVRwNAysOAKAMTr0+8
         WhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xew2Cqp055SEboMYSD4xaomAE75lVTjIUs6xXR179/0=;
        b=JF/AP17xS6mi2q4RvIr/iCPLfY/k64V7lWMqKvBDNviorBkORp3TUdQuH+fYBnZCQk
         YipFbDBahEKgvJSwAPj8Dy5kurngoFCN+DYnfZJuK7xVHA1ddyVaLzTbjy49qS1Oo+bm
         PqwvjFqTAJYDapMzqDR7eXJzibQgD6Hdw6sNg8fp0LdZlIxeMEldDltSP48RUXLhaerY
         eCXyOMUP9pzNPZyYjOPD0TozaJejyWMW8DaGgx8XBe17a3X5pHLaSK7M+oj99gpkzaEA
         v8lCXLZfJ+PyjN+cjS8JEnmENHk7X++E9YyQ4c1SRyMFnFdcNr5HG9mUixc9KRHm5uzj
         HqSA==
X-Gm-Message-State: AOAM530X8h0nZXh1x1LIE3Ah9GfqAKMhhmnl5UxwJL9udz8ppVYOKBCD
        5rl2x11UM4FgY1SLSiaIkQ4=
X-Google-Smtp-Source: ABdhPJwzquROKMLegjco20qGn59bJ5syteqkBCE5kUqtvcwMyaDc2geIlDVH3Sdsrj2dMslo6mBkrQ==
X-Received: by 2002:ac8:5e51:: with SMTP id i17mr19299qtx.339.1633719704376;
        Fri, 08 Oct 2021 12:01:44 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id f15sm101193qtf.66.2021.10.08.12.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 12:01:44 -0700 (PDT)
Subject: Re: [PATCH 7/9] of: make OF_DYNAMIC selectable independently of
 OF_UNITTEST
To:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <20211007000954.30621-8-zev@bewilderbeest.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <288e4900-c23c-56ee-5c23-9a51cd3f315e@gmail.com>
Date:   Fri, 8 Oct 2021 14:01:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211007000954.30621-8-zev@bewilderbeest.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 7:09 PM, Zev Weiss wrote:
> The writable status sysfs file enabled by the 'dynamic' DT property
> requires CONFIG_OF_DYNAMIC to be useful, but that shouldn't require
> dragging in CONFIG_OF_UNITTEST as well.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/of/Kconfig | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 3dfeae8912df..8e0ba87db030 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -55,12 +55,14 @@ config OF_KOBJ
>  # Hardly any platforms need this.  It is safe to select, but only do so if you
>  # need it.
>  config OF_DYNAMIC
> -	bool "Support for dynamic device trees" if OF_UNITTEST
> +	bool "Support for dynamic device trees"
>  	select OF_KOBJ
>  	help
>  	  On some platforms, the device tree can be manipulated at runtime.
> -	  While this option is selected automatically on such platforms, you
> -	  can enable it manually to improve device tree unit test coverage.
> +	  With this option enabled, device tree nodes that are marked with
> +	  the "dynamic" property can have their status toggled between
> +	  "okay" and "reserved" via sysfs.  This can also be enabled to
> +	  increase test coverage with CONFIG_OF_UNITTEST if desired.
>  
>  config OF_ADDRESS
>  	def_bool y
> 

The help message should be extended to explain the impact of enabling
OF_DYNAMIC manually (as opposed to auto selected) - it will be to
allow writes to a node's "status" property in sysfs if the node contains
a true value for the "dynamic" property.
