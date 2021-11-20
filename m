Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2387D457F66
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 17:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhKTQPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 11:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhKTQPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 11:15:44 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4E5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:12:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g14so56138044edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3RKlpyzM6ngIFUO1sdmP1R49NA3ldK/jgZ39lCHBKrY=;
        b=kjr/dyGy/tFVGE4RVE2bF8x0vDISPpezeNnCjJ15qKMEXNT/1BLJkPR1FtnQYVmX20
         rMQ1N9860CFZisSYrz5ghY9XALZMt41XBSmYTSPwRzJTrjX9lkutfJFKdg82n1C4n9Si
         /coc8hmmu6BfwVzMOV7J5OTdtG4p6224Jjtj3UJ+oPAYY9EWRwBciq3x0K1upBfrcyfZ
         YvllVC1nHA9Im7ra+XnLhFTKN+576snoYd37ILM1rXGBmgDBwh9enQDE2+hO2YiUD5lE
         mXhh3pLjhcmLrJbqi2w192/DewnFmxaWg84MUuHadi5E066m6bMJmoWBuckjQl2PXFhC
         A8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3RKlpyzM6ngIFUO1sdmP1R49NA3ldK/jgZ39lCHBKrY=;
        b=tTYIh3QOAyg3nxxlks/Vg894ZdSnXMJuBtuncLGr8t226OvqzT/oI4C5T3bUqN+MYY
         wRtBZUgG4UZ4wdEVtIFREPApI3NamnsdCD1M2bvPordQw5cZt+DXPVxy+zGpHFf7zX5D
         0g278d/Vy7jh3HQ3t2Oqrlt3c/qsTR/YnlhHTfZe+WjBUwC2kUTfFwA0MGqH+fxGMyWg
         lRswJfMMk3qpwDc4AQy5t8JddknAEZyjQ5US3fQevgCuu1bA2q+7zwnTOnLzYCkgc9y7
         Loq0gaVPOEf66Ksc1Kdk22UemuIg+ElFdSiQtuzcfdmRykRftOjPeM+lkoBBwTcEVs+Z
         Mmxg==
X-Gm-Message-State: AOAM532f4RjrkXONhXPvbhEf8Uzo4F3Hm6Z3BYhXL2ycnKyTbJ7V9XgX
        BRuDSgCPeZtNCfDUzFb6KSsAPNu7InUr30IhVAU=
X-Google-Smtp-Source: ABdhPJzT/c/KUE6tpZxBV4v91gECMTD3rDfi+6S9QnVJOgVvqublqIFRtoQF8Co310l3/gfF/VQEnalaqTFP4NUeu7A=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr19720322ejb.69.1637424758909;
 Sat, 20 Nov 2021 08:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com> <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-12-alx.manpages@gmail.com>
In-Reply-To: <20211120130104.185699-12-alx.manpages@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Nov 2021 18:12:02 +0200
Message-ID: <CAHp75VfYvO2pHTtExLpcY1AmiGAEvvdf_Q_46ZhxR6JD68MNow@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] linux/container_of.h: Cosmetic
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 3:03 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> Place braces in a ({}) expression
> similarly to how a function would have them.

I don't think we need this change. ({ on one line is pretty much
idiomatic for macros.

-- 
With Best Regards,
Andy Shevchenko
