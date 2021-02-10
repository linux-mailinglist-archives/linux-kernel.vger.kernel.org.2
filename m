Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35658316CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhBJRjP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Feb 2021 12:39:15 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:51043 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhBJRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:37:18 -0500
Received: by mail-wm1-f41.google.com with SMTP id 190so2472799wmz.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qNAZpmv6l1WGEVmYTHaGcUVa/ZNs5DZCzP4JKX0yL/k=;
        b=q9Tf3yZWkF/1P+1VMEy7uV9dEeTSK1424wQDcBRK88UdXfoBmBpyatz7amWbfDtGGO
         ZNXiqjOurKfG88vrxutXMADqOOBWeUpwVMd1AjcQGBbYoR9HC8BMdXNTDcZ2I0/ChGYl
         v7H1UPW3xSHa9H9MnYrNZ8kzyOmRAMyIzzjX9yY3mu1W8tHoCTPqMd+5+8fH/DXoOvOX
         GLHmWQ+AT2hJlQXCPgAyCl+4c9guSe41pbkvgthwqNFmJd0E6Fz5ETmpROPZ3auDJUlq
         xuWvPWTwI1mSokgD4dglkWSHmKNXmPTinNub1e6240VDrbJS8UtKgzlvJF0mo4yFK6yj
         R9Fg==
X-Gm-Message-State: AOAM531axLXC9E7oSw2DmfpD9ap72l+F5K9pk0Y5QOv1+2TTtyUwOL/r
        i/p1qmWpqCK063C6POtcH9o=
X-Google-Smtp-Source: ABdhPJxMEOkgG/60QyZhKSNFzFFUSYYL6Jmiu/IRdp/NRKT4rkw+tGXXbXQHQ1pZcw8Bx24QaV/wYQ==
X-Received: by 2002:a1c:7f4a:: with SMTP id a71mr15190wmd.92.1612978594996;
        Wed, 10 Feb 2021 09:36:34 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 143sm3246635wmb.47.2021.02.10.09.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:36:33 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:36:32 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sre@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [RESEND PATCH v3] MAINTAINERS: add Dan Murphy as TI LP8xxx
 drivers maintainer
Message-ID: <20210210173632.fcbmzk4zdcwb5kps@kozik-lap>
References: <20210210172908.336537-1-krzk@kernel.org>
 <1b31c98b-2344-c502-6071-89b9d4a886a5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1b31c98b-2344-c502-6071-89b9d4a886a5@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 11:33:49AM -0600, Dan Murphy wrote:
> Krzysztof
> 
> On 2/10/21 11:29 AM, Krzysztof Kozlowski wrote:
> > Milo Kim's email in TI bounces with permanent error (550: Invalid
> > recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> > credits and add Dan Murphy from TI to look after:
> >   - TI LP855x backlight driver,
> >   - TI LP8727 charger driver,
> >   - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Dan Murphy <dmurphy@ti.com>
> 
> Unfortunately I need to remove my ACK.  My TI email will be disabled this
> Friday.
> 
> No replacement has been identified

Ah, then I propose to mark entries as orphaned - without any maintainer.
Other option is to remove them entirely so they will be covered by
regular power supply entry.

Any preferences here?

Best regards,
Krzysztof

