Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6975E3FA6E4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 19:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhH1RFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 13:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbhH1RFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 13:05:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F8BC061756;
        Sat, 28 Aug 2021 10:04:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bt14so21024739ejb.3;
        Sat, 28 Aug 2021 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w86O53R0J9hPAmoMxLqD9PUEU69iy1C6zXa6K7LrGPI=;
        b=tBbxa08M5/VPnFYR/fRRU2HTgiMaRnWmPpYIu9p9xu4RjenmHk+md/NRFDHqIHESH9
         NwVuWCVd421jvPydzefGSgsnVE9aGQU0HWgC5cycZ7Fx4RkSM9xOpL+hOtQfDv9bcYEJ
         0tmUK+Hqr+AE1NRgpTjpwG/hrp+3RYWe0dI/SPqWedGE5qf7tSHfACBpry6XZx4dEA88
         gK7gmco7c7zxu9aYKVHIgphuenONlHDdM+V/S0Uo6wzlw6D09wfNrfOtKJ3Sphz6sOew
         DHKrYbBVQL2a47WAHN0R2CuaAAP2MJ6ByeFgFaRKHg7wF4dvSSr7WZ5IsvhkP5lfSxDv
         qiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w86O53R0J9hPAmoMxLqD9PUEU69iy1C6zXa6K7LrGPI=;
        b=KqT1hgP/fP3qCDaheN4qZ93447OwV4XI/kA4C/bEaoYll+THyDsseoNKlAmnPmNb7z
         FdFWeofG4MfL/mpZoNv4WOL5SXMsTearV6Ehd1JSV7CruzGzAmQSLWQ+kfvmdfKDKKSz
         qQCe3xaR8+k/+PG+wzScrkx4QUKBH2ZR3a8JMoME8xy9vus+9VLSVw/9/NFlQ/XGqc+d
         YwBurSzTzo4F9c2JKZZc/4QiqlFjFZfRAoHBBuo7eqlHOJGBYnA7nwFNHOwroTpr1gHm
         EqTC03M8aj3ufKTPyE02p2eBy1JmrdUEaN1gaoSoxL6ElNvZMoSnvT1F+VFuVSaXNvsE
         MF2g==
X-Gm-Message-State: AOAM532Phs8V8n09yCsgw0+h7+2Dbq2KeuVOj3oJklKEMAssfBph2oA9
        86MmPLnakasUiZXqQ7sCkjjvKzEwyUji2L/L59s=
X-Google-Smtp-Source: ABdhPJyzSQfA/Xqemm3AqsLNOWUIM10kvcUovjp0GttH/+y7Wm9S5+vX2S9WWNyyCG2N6dytdtR5wQ==
X-Received: by 2002:a17:907:75d9:: with SMTP id jl25mr16224777ejc.4.1630170293607;
        Sat, 28 Aug 2021 10:04:53 -0700 (PDT)
Received: from fedora (cable-178-148-241-131.dynamic.sbb.rs. [178.148.241.131])
        by smtp.gmail.com with ESMTPSA id v10sm5102658edt.25.2021.08.28.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 10:04:53 -0700 (PDT)
Date:   Sat, 28 Aug 2021 19:04:50 +0200
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: add driver for Aquacomputer D5 Next
Message-ID: <YSpssm0+rN6nr2Yi@fedora>
References: <20210828155441.GA820794@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828155441.GA820794@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 08:54:41AM -0700, Guenter Roeck wrote:
> On Sat, Aug 28, 2021 at 07:26:28AM +0200, Aleksa Savic wrote:
> > This driver exposes hardware sensors of the Aquacomputer D5 Next
> > watercooling pump, which communicates through a proprietary USB HID
> > protocol.
> > 
> > Available sensors are pump and fan speed, power, voltage and current, as
> > well as coolant temperature. Also available through debugfs are the serial
> > number, firmware version and power-on count.
> > 
> > Attaching a fan is optional and allows it to be controlled using
> > temperature curves directly from the pump. If it's not connected,
> > the fan-related sensors will report zeroes.
> > 
> > The pump can be configured either through software or via its physical
> > interface. Configuring the pump through this driver is not implemented,
> > as it seems to require sending it a complete configuration. That
> > includes addressable RGB LEDs, for which there is no standard sysfs
> > interface. Thus, that task is better suited for userspace tools.
> > 
> > This driver has been tested on x86_64, both in-kernel and as a module.
> > 
> > Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> 
> Applied.
> 
> Thanks,
> Guenter

Thanks.

Aleksa
