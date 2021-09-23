Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3719E4167F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbhIWW0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:26:15 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:34404 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243436AbhIWW0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:26:13 -0400
Received: by mail-ot1-f50.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so4933665otb.1;
        Thu, 23 Sep 2021 15:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mb587nGf0voR/Ax95mATSV+fC/nr8Rr1/llTyc2fCdg=;
        b=OUDRObaWr2dP1CaUHxO2IK+s9QJyoTd3QJWJZgTsW2k7Y+VhU6d7r8HwOYYNzgKGeB
         TVLC7eUhmihiXVpVSr8hB+wPDE9LIEZri8EOyiBLBj9OMtH6rqG8Luue61JI2nXNcPYc
         iWOjb7Nbk+Ty8NFQrYO08Us97Zay0iFFSUe6b2E7NXYIlE22uRV1czCNnmYl7B6B0+85
         If+WaPXc9hdSKprM9BwIbBbNs+m6hBBIOf1UQwmkQT0LKUFJ66YwSnpcEE7DCvYmnQvs
         43nUwEraDD/yhGgwkBdRxnf1H918DJoJTzQgq3P4AAyypzf+1Q+6jobD9FEKiPmSL5rs
         4bTg==
X-Gm-Message-State: AOAM533YlwZW29hA1A8GHk0Ncco817vxgfNG0o2UhhGYeu0VJKNk3I2U
        9rM+yX18o7WYFHpKEZF8mQ==
X-Google-Smtp-Source: ABdhPJyK5AkfcoxcdUx/qdVtfEdGVdXMSEbvuYeuL1VZkTBuHnfC586+HY3jM+CBAcMYp22wu+ryxw==
X-Received: by 2002:a05:6830:1512:: with SMTP id k18mr968033otp.31.1632435880696;
        Thu, 23 Sep 2021 15:24:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p64sm1647430oih.29.2021.09.23.15.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 15:24:40 -0700 (PDT)
Received: (nullmailer pid 3633988 invoked by uid 1000);
        Thu, 23 Sep 2021 22:24:39 -0000
Date:   Thu, 23 Sep 2021 17:24:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: hwmon: ibm,cffps: move to trivial
 devices
Message-ID: <YUz+psAILnF5L5GH@robh.at.kernel.org>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
 <20210921102832.143352-3-krzysztof.kozlowski@canonical.com>
 <20210921123025.GC1043608@roeck-us.net>
 <68fa27ae-4704-181f-e2f6-92635865798b@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68fa27ae-4704-181f-e2f6-92635865798b@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 02:45:42PM +0200, Krzysztof Kozlowski wrote:
> On 21/09/2021 14:30, Guenter Roeck wrote:
> > On Tue, Sep 21, 2021 at 12:28:29PM +0200, Krzysztof Kozlowski wrote:
> >> The IBM Common Form Factor Power Supply Versions 1 and 2 bindings are
> >> trivial, so they can be integrated into trivial devices bindings.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > 
> > I won't accept any of those "move to trivial devices" patches. In many cases
> > the bindings are simply incomplete. I can not and will not make that call,
> > and I always did and will leave it up to driver authors to decide if they
> > want to add a device to trivial devices or provide explicit bindings.
> > 
> > Please stop sending those patches.
> > 
> 
> Back in the older times, there were no trivial-devices and checkpatch
> plus maintainers required documenting compatibles, so some of such
> simple bindings were created.

We've had trivial-devices since at least 2011, but it was under i2c 
until 2017. Many existed before we had clock, regulator, etc. bindings, 
so they may have been complete at the time.

> 
> I understand however your point, fair enough. I'll stop sending such
> patches.

Just about every device has a power supply which would not fall in the 
current definition of trivial-devices, though maybe that could be 
extended. I do sometimes wonder if we should just get rid of 
trivial-devices.yaml.

On the flip side, I'd much rather have a schema for these than wait on 
someone to decide to convert them. That could mean a device.txt -> 
trivial-devices.yaml -> device.yaml trip, but that doesn't seem that 
terrible to me. Then we at least are running schema checks on the 
devices and know if actual users have more undocumented properties. 
We still have ~2000 free form binding docs to convert. I'm looking for 
whatever ways we can speed that up and this looks like one of them to 
me (both Krzysztof's great job doing all these conversions and utilizing 
trivial-devices.yaml).

Rob
