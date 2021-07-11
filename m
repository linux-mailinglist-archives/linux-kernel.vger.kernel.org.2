Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67F23C3A6E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 06:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhGKErL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 00:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhGKErJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 00:47:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC091C0613DD;
        Sat, 10 Jul 2021 21:44:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p36so3172718pfw.11;
        Sat, 10 Jul 2021 21:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PlZg0ejVeVVgYgplvRVntE0/vGatxDYt2QQJIV+FaSM=;
        b=Zqzepfmv5LEPxMBPAskvo35XnALuNvYS4/QPgPI8e7A5XdMSM5Wp1QQMWwM9r9Xhrf
         fg592TJzTe1sELcw+3lPFJN27i2IrXEFEW01XHB95EDyfsuRjO+lM5u/INIME10RXA6/
         34O85A63Z969vmLjR+++N0AeTlpszbGZymacZiAj89ZNxdNDxOTiJuXd9uRmfxNh1h3u
         DOGNgJa81omyHa9tswf95oH8HaXcXKcReyEVrvC2pbXSE+dg28mzw4xIq8mPMN/oKI8A
         5wcIc3tNTc7UeyH4R8eLtqj1Z3px+/l9KDwT/7119pR63WmslDx0y45J8yQE/hpdB0wo
         XLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlZg0ejVeVVgYgplvRVntE0/vGatxDYt2QQJIV+FaSM=;
        b=mU1cwSk999b1Oxfz4O5Vf+a/FakpkjA3/HsmLEZTChHcfE5JNbRg6+skhQUfOQA4YG
         t27ZeLVuFRoHNjheBqdtPK6qv78+XWxbznHvSl6VJ6WKXmttdTizQuPRKfe/XfOcGg/b
         rU67dzX/GwdWSJSUlpgQleq86//s7W8ig52p87e5x0Q/uCxtc+QN9/k476uPLfaBGQbr
         mr/wBQaDBdVYq42e/ESmEvjxJbhVzriIH30hMpiCU53MJCfHBVkTL9ZQTg8TVQR8+A/z
         tLPyz+exo53dYzKHPoIBCEDIiMgFleSz6eTeG0InaqK2ljeL9AsJDiQgmZxlJmHECf8N
         903Q==
X-Gm-Message-State: AOAM530mk0A5qxAXWqrigxWjLXS7EnZzoeJmJe35nHwMUgB0s6y6dOSJ
        z68zwhR0cukVw+Cp3htQ2DmRsREh9bhRf7qTlBM=
X-Google-Smtp-Source: ABdhPJz+/4bHDlZLIb7lBn1FY1kAGBJb1DbxkB8c+Xkc78W5sXOd4GSAMARhAlEZX9pK81TzNiiIgQ==
X-Received: by 2002:a63:383:: with SMTP id 125mr41759687pgd.208.1625978663054;
        Sat, 10 Jul 2021 21:44:23 -0700 (PDT)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id n32sm1800421pfv.59.2021.07.10.21.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 21:44:22 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id 007AA900050;
        Sun, 11 Jul 2021 04:44:19 +0000 (GMT)
Date:   Sun, 11 Jul 2021 04:44:19 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH v3 2/3] hwmon: da9063: HWMON driver
Message-ID: <20210711044419.7b1c00f8@gmail.com>
In-Reply-To: <20210711025502.347af8ff@gmail.com>
References: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
        <2c24ef5953401e80d92c907704bffeff1d024de0.1625662290.git.plr.vincent@gmail.com>
        <20210710160813.GA3560663@roeck-us.net>
        <20210711025502.347af8ff@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2021 02:55:02 +0000, Vincent Pelletier <plr.vincent@gmail.com> wrote:
> On Sat, 10 Jul 2021 09:08:13 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
> > Unnecessary include.  
> [...]
> > I don't immediately see where this include is needed. Is this a
> > leftover ?  
> [...]
> > Same here.  
> 
> Are there ways to systematically tell which includes are useless
> besides commenting them out all and uncommenting until it compiles ?
> (if that is even a good idea)

I tried this, just to get a baseline: the module compiles with just
  linux/hwmon.h
  linux/mfd/da9063/core.h
  linux/module.h
  linux/platform_device.h
  linux/regmap.h

Beyond what you suggested this also gets rid of:
- seems reasonable:
  - linux/delay.h
  - linux/init.h
  - linux/slab.h
- looks suspicious to me:
  - linux/err.h, which means the error constants are indirectly
    imported. Removing it feels brittle.
  - linux/kernel.h, although to my surprise a lot of c files do not
    include it.

By default I'll drop the former and keep the latter in the
next version, please let me know if another combination is preferred.
-- 
Vincent Pelletier
GPG fingerprint 983A E8B7 3B91 1598 7A92 3845 CAC9 3691 4257 B0C1
