Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478A933E108
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 23:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhCPWAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 18:00:25 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:39255 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCPWAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 18:00:14 -0400
Received: by mail-io1-f49.google.com with SMTP id o9so38906003iow.6;
        Tue, 16 Mar 2021 15:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hWQnLy+wlCYyKsfibvRnMmDe6TnPBpLcmFf0o5i5sXo=;
        b=FoFtp4TVECI7zYuqZr/uv6pcGi+4NhsgyCDtlXjqPA8rP0+HoASBncaT45DB2dpNri
         oVZKHu3xEkuyMZpzwaOy8PrmbQk7sp9/QNQIsj6JOEXxbRDPJCf7C9RXRmu6/mVY1u7i
         6NWwNVoBE79Fd0oWkegEtGW7I4diKnHQsRTerHce+WRT4SrH7w5Sn+3G2igv//nSRjPx
         2L00YUc9Wj63fFzVPf/LCqVoO2gITjVWDVqSBHzShcdZAa6rLJZWlUqWCTkZR5Kuq3ua
         JBzJXeXTN8h2TKpbbQbVL5hZha7YqFz6DSLrCdJEKa8rjGtoeiZkwEGsjz8c/WfZEjHL
         kBPw==
X-Gm-Message-State: AOAM530liCvYkMfQLOk0vS604htL2s4J4ZR4AxVI5GtiuOPM81GCkyy8
        8WOAq9sZ0KxStDWurYHCCg==
X-Google-Smtp-Source: ABdhPJwCXPLXH5ryR9zjM8plYiRvPqgWPNS67eAHKVo6mFw4S0V6YZBXB8qtNjD3qRbtCquQg9ctNg==
X-Received: by 2002:a05:6602:179c:: with SMTP id y28mr4758814iox.151.1615932013916;
        Tue, 16 Mar 2021 15:00:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id n16sm8806315ilq.71.2021.03.16.15.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 15:00:12 -0700 (PDT)
Received: (nullmailer pid 3753212 invoked by uid 1000);
        Tue, 16 Mar 2021 22:00:09 -0000
Date:   Tue, 16 Mar 2021 16:00:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        soc@kernel.org
Subject: Re: [RESEND 2nd PATCH 01/10] dt-bindings: arm: intel,keembay: limit
 the dtschema to root node
Message-ID: <20210316220009.GA3753176@robh.at.kernel.org>
References: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
 <20210308170945.161468-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308170945.161468-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2021 18:09:36 +0100, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> The check for the board compatible should be limited only to the root
> node.  Any other nodes with such compatible are not part of this schema
> and should not match.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> ---
>  Documentation/devicetree/bindings/arm/intel,keembay.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
