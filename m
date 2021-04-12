Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CE935C302
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbhDLJyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbhDLJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:44:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7733DC061344;
        Mon, 12 Apr 2021 02:43:31 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id o123so8853623pfb.4;
        Mon, 12 Apr 2021 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RRj0QLkLZYPQcVKJp72pa3AAj6jfYEfpWU0idxFOvQ=;
        b=k1rd81UDrsz1X978HiQAvUklb5BEXKMwcgaN2T+Tv9T5+FkEAlKBb6P48lOrnK7Xdn
         1aaJSRjO/xrAH2gn+wy4e01ihs+uBLGyrcc3eHjV01AUCnlLPiku7RHmfBe2Nrz8fKMD
         QuZ16uzEcV/f5zmok8MhOhQTjpAXZvSCyShbMjPj7MSIXtNU0qL7KHBEiWM6sFq/xruy
         BNszCZJ3xZbn2Xm+mgIvbb8EQSWuudA4Hc3XijrWKJP45wHeSYPlrXjoKlql0SU/IVNo
         U70zXW6AXeB7jvomWp1+nkpqIph3+BZWTjVJ3x8lsijYWwL6WWawQZAUWyJNNcdyey/K
         BvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RRj0QLkLZYPQcVKJp72pa3AAj6jfYEfpWU0idxFOvQ=;
        b=Zyb93IcutWJJuK0px7mjxCwdxcAsuh55uxIlRoYb5oiBK6uEHA5mHlSET5KLvULhQR
         oej6FXApm9NfPOLujWCKfHlZsrq6552k1MFHU5SQ1btMpWyu4vthiE0E3MBYzNYVA8PO
         rn/P3Q6Mt44O4Q4SQZp+EYmldtLGKDctThgteOwkTHFQzhA4clyik4yIanxBJrMoybA6
         AW1XL2kBIQKcyQirvawue9pxny+fo7WjU5i7FwnKLB5ekRbGEfCm/HxW3DUWGgV3a8xb
         vuYEdbLoZXXxQYIdZa0MeNT9O+fKGIK4JC5TjPwRGoKX6YPMSg4C/ApWeJpK7aOI+x6z
         uJuQ==
X-Gm-Message-State: AOAM533cFrBbksRk1PW71DrvdJjkR8lWWe1aREPkuAyHDf3/zrdfCWO/
        iEqL0xY8/wXx+aIBHBxcoPaMjtiQOIqZe3cTybo=
X-Google-Smtp-Source: ABdhPJzoYqxH2BqOBpKkof0NrkwFstfx+MTVNv7MC0+nLseZqw3OKp3aOiTHrupAl+ZrffN6L2fcDHs+A+HjZ0ba7YI=
X-Received: by 2002:a63:cb44:: with SMTP id m4mr26080943pgi.4.1618220610970;
 Mon, 12 Apr 2021 02:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210412090430.167463-1-linux-kernel-dev@beckhoff.com>
In-Reply-To: <20210412090430.167463-1-linux-kernel-dev@beckhoff.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Apr 2021 12:43:14 +0300
Message-ID: <CAHp75VfLQBDv-Bcj5=Ksv6kp2XH2v8msDvNjsdj6=WZiCk=Q9w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: pmc_atom: Match all Beckhoff Automation
 baytrail boards with critclk_systems DMI table
To:     Steffen Dirkwinkel <linux-kernel-dev@beckhoff.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 12:29 PM Steffen Dirkwinkel
<linux-kernel-dev@beckhoff.com> wrote:
>
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>
> pmc_plt_clk* clocks are used for ethernet controllers so need to stay
> turned on. This adds the affected board family to critclk_systems DMI
> table so the clocks are marked as CLK_CRITICAL and not turned off.
>
> This replaces the previosly listed boards with a match for the whole

"...previously..."

> device family. There are new affected boards that would otherwise need
> to be listed. There are only few unaffected boards in the family and

"...only a few..."

> having the clocks turned on is not an issue on those.

"...not an issue."

> Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

I'm afraid it's a bit too much. Is there any guarantee all the boards
based on x86 will be Baytrail only?

-- 
With Best Regards,
Andy Shevchenko
