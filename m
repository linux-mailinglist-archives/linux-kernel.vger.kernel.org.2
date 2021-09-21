Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B004133ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhIUNTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhIUNTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:19:35 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829FBC061574;
        Tue, 21 Sep 2021 06:18:07 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso21295008ota.8;
        Tue, 21 Sep 2021 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zh1CgLOwhwyadJWHmM0DrwXsbBT3UEj5Mhn4XZFBPW8=;
        b=N+ukJLXvy+PTzH1+7VHEG+VAL7LkMICe8u0hYa/yU8vjgmYUYunh/lLNmeRsj7Y2F/
         tgd/wQI3f+M7xI96xv5DD36RCLUFQ4i6ynW5k3J6w5r0C0F2GZpfqaUAp4GSIvqyzslu
         GXIBYKlpRgAEKJjlfGas96ktdFzgu7bIvxLqCeTRivOkK0r+HQLZsPd4+c3f6WWd4eHQ
         kVEtYxs7fgXdyQb/W/oAxjfTxVNnVm1VEQYHIU4gpBMU/T5d3ClupHBbM3gtN7Z3ug7u
         KkUfbNbCjpsAGmulknoAsukIsWIaqQ6X6z588eTKqnVaz1dbrbhvcf+LAe421RQGqxpk
         fd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zh1CgLOwhwyadJWHmM0DrwXsbBT3UEj5Mhn4XZFBPW8=;
        b=k0L3J1TFL0MsEbXy8zqXSEb+Iv41cmFxkolIS5YQL1pOyhJxePFPVqHVoZb7KFm7NN
         QLDycziqt4sFUWroslAYJcisRCEzakDMln1ZjSFyDI4t+7nGKKZ0izAI4Fwlt1c5uyhV
         EHkgUwWk2b8O4TvKyYYge3kofnzFNROKy3gURTuDLxN/7trL0AHMVcrReAcNnwG8rqk+
         B5R/8Qp33ASzT8XC3FcrAE/UmBazy7CTAKgWNRYu98Ki4Jem7ptwL3/bXmiD1FcDXiVZ
         07WTtc5OktZAPO8DlBIvEWecFWXb7HfGBOZWBHnaQb0wooFy/Ga0f2OABGxlSZ533Kpc
         5RXg==
X-Gm-Message-State: AOAM5308Z8mXF1x3yaIJDjoNIqVodDNIs9O0ZEMNJmlCtlHEbNRvfWCM
        HQvfHMiBRedEX8TchRUfv7A=
X-Google-Smtp-Source: ABdhPJxWsjTpLlmBEjcj2pGwkR89u6zRHNNky9SlLLtC4PaBq0ZGPKE0PLosGiRn6lmxHE/wsPy+gw==
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr6022224oth.80.1632230286881;
        Tue, 21 Sep 2021 06:18:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n23sm3577623otj.70.2021.09.21.06.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:18:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Sep 2021 06:18:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: hwmon: ibm,cffps: move to trivial
 devices
Message-ID: <20210921131804.GC1864238@roeck-us.net>
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
> 

At the same time, as I said, the bindings for many chips are incomplete.
For this driver, we can not make that call because the datasheet is not
public. The same is true for dps650ab. For others, the datasheet is
available, and a reasonable decision can be made if the chip may ever
need more complete bindings.

So, let's qualify my statement: I'll accept such patches if you can show,
from the datasheet, that it is unlikely that explicit bindings will ever
be needed. That would be the case for LM70, for example. That would need
more than a statement that "bindings are trivial", though. It also require
a statement along the line that you have confirmed, from to the datasheet,
that there is nothing to configure for this chip that would ever require
explicit bindings.

Thanks,
Guenter

> I understand however your point, fair enough. I'll stop sending such
> patches.
> 
> Best regards,
> Krzysztof
