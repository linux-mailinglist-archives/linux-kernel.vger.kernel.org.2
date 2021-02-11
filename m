Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E731F3186B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBKJPQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 Feb 2021 04:15:16 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48]:35252 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhBKJGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:06:25 -0500
Received: by mail-ej1-f48.google.com with SMTP id a9so8899006ejr.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gNUXHZgHcejVF4iv95Z/ItrXjYCLnuO/hAbPuWh63jc=;
        b=L8zfOCuMtDgzIUlBiEHBZjy0qUp4rwdtczYq/6b7wTknvQTMbwxtpfpNleyh2pgqXh
         U2wohWT3aYx/c6J9l4ryT2cVjmj/VuwJ8HCq9gxBD1z6bPRNebEJUHEEdz/IFDDc7th/
         dvGiR5kh6eMDU2qUw76XLp1kyzceOBoo7LMh1bpTMrQlUDrEMJnZobp1YRheVhBbrh/R
         y1ZQI6t7gmmZq8Q3LOmezZcyzbO7tFuQYEvFiXGJSgTz5qrH/5dMc4ZHlEziXAXO4J7T
         WV7FJ1EF8thW2Hz3qwo7irgZag6UviqkYpYbbd6cU9JJy6a5bjwsD99CEcWDKCUYSoOl
         U7AA==
X-Gm-Message-State: AOAM532o1zZVSjRX8UG+PlH7ScovBYFwCtY/dGtzOETyIb7HfGurQKMN
        JhJhhIV5CqbNckonwQv20/I=
X-Google-Smtp-Source: ABdhPJwT7chm+5A4A3+hGIqse7GCUso45r6Oqim+VOn/SYx+u73GMqoEu/MlDUXZfFTN2NMMfw5K0w==
X-Received: by 2002:a17:906:8690:: with SMTP id g16mr7329486ejx.113.1613034319022;
        Thu, 11 Feb 2021 01:05:19 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id r9sm3593947eju.74.2021.02.11.01.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 01:05:17 -0800 (PST)
Date:   Thu, 11 Feb 2021 10:05:16 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sre@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [RESEND PATCH v3] MAINTAINERS: add Dan Murphy as TI LP8xxx
 drivers maintainer
Message-ID: <20210211090516.gpcydiit6lmc6m5h@kozik-lap>
References: <20210210172908.336537-1-krzk@kernel.org>
 <1b31c98b-2344-c502-6071-89b9d4a886a5@ti.com>
 <20210210173632.fcbmzk4zdcwb5kps@kozik-lap>
 <20210211090327.GB4572@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210211090327.GB4572@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 09:03:27AM +0000, Lee Jones wrote:
> On Wed, 10 Feb 2021, Krzysztof Kozlowski wrote:
> 
> > On Wed, Feb 10, 2021 at 11:33:49AM -0600, Dan Murphy wrote:
> > > Krzysztof
> > > 
> > > On 2/10/21 11:29 AM, Krzysztof Kozlowski wrote:
> > > > Milo Kim's email in TI bounces with permanent error (550: Invalid
> > > > recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> > > > credits and add Dan Murphy from TI to look after:
> > > >   - TI LP855x backlight driver,
> > > >   - TI LP8727 charger driver,
> > > >   - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > Cc: Dan Murphy <dmurphy@ti.com>
> > > 
> > > Unfortunately I need to remove my ACK.  My TI email will be disabled this
> > > Friday.
> > > 
> > > No replacement has been identified
> > 
> > Ah, then I propose to mark entries as orphaned - without any maintainer.
> > Other option is to remove them entirely so they will be covered by
> > regular power supply entry.
> > 
> > Any preferences here?
> 
> Counter-proposal: Since they are driver-level entries, just remove
> them altogether.  They are not orphaned as they will still come under
> the subsystem umbrella.

I also vote for this (that was actually my v1 of this patch).

Best regards,
Krzysztof

