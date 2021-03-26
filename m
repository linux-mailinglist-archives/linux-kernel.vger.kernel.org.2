Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C5349D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCZARz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:17:55 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:44864 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCZAR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:17:28 -0400
Received: by mail-il1-f177.google.com with SMTP id t6so3644141ilp.11;
        Thu, 25 Mar 2021 17:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LzkNs7zb3oaH5slSNnfze5rKPCk8h7J3wPJIRw9ZRT8=;
        b=jjck+j4rmJgGb8XhuJbbgdiUT68d+s5b1DMiSom1m/ZZyHGDW+Uk4QZ+Us7ClRvl29
         7hTVJT3p9qV7QSG/10Y+2W26X+u9l3tQhoitLy3Aed7aQFLLimx0HhxuOSKK2xvoLYrp
         fW4mOfhhdHnGfnbOQ3T3SOisMOSTnQMpmjlBVMVPfNRgOYZe1678iJeCL+ViWYP/cvI4
         8cGePInXuxJ+UWgxwF5yteRgbmC0bJ0GwEusX4ei/rNa9Dd9BxAX+G21BsQ3UpZui2Rd
         OhPiaM1UjWGDhZEWIBAAusWPyWwEkLrgQPo5CVqVdTmLuOKu1KcV7GKLhRf4xgEVm7E2
         kHpQ==
X-Gm-Message-State: AOAM532bxP3Nnh04jgKmgydmS2zzd7+c71axWmAzn7hqrkHB8RO4nZKV
        fBvP5lOTmVvoctQshd7YGIOLWDUwgQ==
X-Google-Smtp-Source: ABdhPJwO1QI6jRCgAw4lTeldvQek3yCJdHIolsVNpeqKAZ/i353EZFrLiVm6qKo1Tn2NIMTjZ/s/CA==
X-Received: by 2002:a92:ddd0:: with SMTP id d16mr8780446ilr.52.1616717848219;
        Thu, 25 Mar 2021 17:17:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a7sm3388564ilj.64.2021.03.25.17.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 17:17:27 -0700 (PDT)
Received: (nullmailer pid 2014659 invoked by uid 1000);
        Fri, 26 Mar 2021 00:17:25 -0000
Date:   Thu, 25 Mar 2021 18:17:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net
Subject: Re: [PATCH v3 1/3] dt-bindings: Add vendor prefix and trivial device
 for BluTek BPA-RS600
Message-ID: <20210326001725.GA2014607@robh.at.kernel.org>
References: <20210317040231.21490-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317040231.21490-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 17:02:29 +1300, Chris Packham wrote:
> Add vendor prefix "blutek" for BluTek Power.
> Add trivial device entry for BPA-RS600.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v3:
>     - None
>     Changes in v2:
>     - None
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  2 files changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
