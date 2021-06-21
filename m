Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B9F3AF77E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 23:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhFUVgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 17:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhFUVgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:36:38 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5592C061574;
        Mon, 21 Jun 2021 14:34:22 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id u2so1812387qvp.13;
        Mon, 21 Jun 2021 14:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d3c9VDld9cVll7jiOE4VaogdRPw6AneLM9bO2IMc2sk=;
        b=p3Z4oBwaAf/CzqFKoFIM1M8KmY7Wg7f2bqib/s4ROzYjlXDlqA2rz0QR5ZEx6T24dY
         vVydPJdvK1u1wwF+3pG/LB+K26EdnKi4YKQ+2vZN5lG40wdLdgNmlvlrlW8hhEyvrROo
         okXNlwoArj2NCzH6BAYUge9UF0rv3tk+YTX7bgutc12+FW4JiELD81lKx7lgQsyCZtu8
         F+5VYTsVjvuuwXQ+1hOOJTaVOpyJzHlvXH6CieHCPUcMM/CkE72pjOcQtBP/7EGn0am9
         sOtj05167/GWBgvUDxGuGnTp7oumSo5/CKSny7oiTk0wl/NyOAGxyx0SvnHPVuhY+HPb
         nh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d3c9VDld9cVll7jiOE4VaogdRPw6AneLM9bO2IMc2sk=;
        b=qZC6P7h47vCtJilffL8dGMpdx3xSg/TLfq0l2sW7DEzPosDfNZgpD01P10ri1cAzOc
         bYeiBYbyF5Q0uYBhV+8YxJMrykvCLgx5c6oBH16i87cUxz9p48ryJNfZNuhDxvMAd03/
         LIA+1JNXArnCrQHxcjytayn4HWwiYs9/xZaqdFjAlxA/KGAMShjkjz0Kd3NuF+IRxhgF
         Zs7IPShEjpOLr/BQTHL7N9DpOvdhz1PJbl+xiKccAhTzxaKHAhzs+boFcpvHh9frBtnu
         NxBM58bRtobVdhz1Ow6XQ2Mee9nIBUE+tgn+bdpqodlFGqAUzc8ZLXS4Ng7jNKdHt8bV
         QVig==
X-Gm-Message-State: AOAM532qB00+ipwjsSeEbOUxgEloKgxmzOogRuOZXrJBLDhWum9a+rRa
        MoS0RHZz1IlZVvTQbJKEQoA=
X-Google-Smtp-Source: ABdhPJyCWCfKmaUbhmrlNJ383qFx661DD98xr7rhC6QmgPxeKOjV5GXLx1pVQN95O1tQew7FlRzhJQ==
X-Received: by 2002:a0c:e912:: with SMTP id a18mr18884264qvo.39.1624311261786;
        Mon, 21 Jun 2021 14:34:21 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id h17sm237580qtk.23.2021.06.21.14.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 14:34:21 -0700 (PDT)
Date:   Mon, 21 Jun 2021 14:34:19 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marc Zyngier <maz@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexey Klimov <aklimov@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 3/3] Replace for_each_*_bit_from() with for_each_*_bit()
 where appropriate
Message-ID: <YNEF2w/bTLWIG8M2@yury-ThinkPad>
References: <20210618195735.55933-1-yury.norov@gmail.com>
 <20210618195735.55933-4-yury.norov@gmail.com>
 <20210621201711.GA631547@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621201711.GA631547@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 01:17:11PM -0700, Guenter Roeck wrote:
> On Fri, Jun 18, 2021 at 12:57:35PM -0700, Yury Norov wrote:
> > A couple of kernel functions call for_each_*_bit_from() with start
> > bit equal to 0. Replace them with for_each_*_bit().
> > 
> > No functional changes, but might improve on readability.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  arch/x86/kernel/apic/vector.c         | 4 ++--
> >  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 4 ++--
> >  drivers/hwmon/ltc2992.c               | 3 +--
> 
> This should be three different patches, one per subsystem.

It was discussed recently.
https://lore.kernel.org/linux-arch/20210614180706.1e8564854bfed648dd4c039b@linux-foundation.org/
