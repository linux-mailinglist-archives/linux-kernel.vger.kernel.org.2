Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F836457F6C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 17:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbhKTQRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 11:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhKTQRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 11:17:42 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F85C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:14:39 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y12so56127211eda.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37Eo2TgA1H3M++3lTmrTgd72aKPxnWff95OCkzud/z4=;
        b=GpWY+Fz+5+fq3xCM01UVUeBJ1iaxSAYI74UINjzU+p/RBTVDMSMnyjkM65tpRtH7o/
         oh8Ll4AMPDBUORyy7JFghVzuQrjurC2/ysu7IbvTRFFoRyRNAulUzZcmDe3dWBT9aK9b
         Gn9Vk6mtsJva8P92Qi+Lw3RySJN4ok38fmAFB5sKoAqXudBBt+ljwpNSAGDNOsPg7Vgq
         xeUuq15suECiUs85/El4WtsVhU8ncTlJ2pNpNcs0nOBLmr0917fuGDK50WUa25Kdj0O4
         1TAwkzzHs3s85vqZ/FUPFFnojf2TAND/Lc/S65Q+W/l4jveGUoHeNB64Pyhz2moZIKbg
         hwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37Eo2TgA1H3M++3lTmrTgd72aKPxnWff95OCkzud/z4=;
        b=ZaKYUnVH6WGOdF65BYxmOnbs9mTMVWl57qQXL6hUuVo/i0zYt1Z3G8GkFU14NJ26RC
         VsbtAxSD7BJSJsy1OxMaheE2tmMokEA2crjH34nLfdDyJc19HvnIsbd6FYk15LPKqyeV
         kQxzQCQcVNm0jsnDyeNUDtTEKlWmIhVGO/jVFeWgI7OWm3I68qSwQR9g631H9J7tTl1v
         4enCfR2I1cDxZNZ+cCVR16d0G6x++v7/2IUCa9tntgfAN/xXt4btU6qJ33B09AmdR5VA
         k6YffCJqawQ+rXdlCG3wq8Quq1z9c0Y2ygg0UPF1UfMJsCi6DJFJ+S9/6Nz6CAYx59xX
         JEUQ==
X-Gm-Message-State: AOAM532gQQ00QBccZjpY6C5L5FdRgY6s2KtNlk6x74awZIpHjlCCwjo/
        XhQQl/x4wbn2fjcRFJFIZQ/K49FDK7VZ4Xpx8OkqEONcTUaQ4A==
X-Google-Smtp-Source: ABdhPJwzMxHu59dB/IMkhCA0090hxPU3Gslu6sII5X4hw/AGOtZUaRqk0MPVvTlYZu/IOmVNBkX12+kjxBrnpXZ3wOY=
X-Received: by 2002:a05:6402:51c7:: with SMTP id r7mr12720599edd.359.1637424877788;
 Sat, 20 Nov 2021 08:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com> <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-2-alx.manpages@gmail.com>
In-Reply-To: <20211120130104.185699-2-alx.manpages@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Nov 2021 18:14:01 +0200
Message-ID: <CAHp75Vd8SKA+mu-5AXWJufsitpeNGnBms4nOzDjOD2g04cjpeg@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] linux/stddef.h, linux/offsetof.h: Split
 offsetof() into a separate header
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

On Sat, Nov 20, 2021 at 3:02 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> Include <linux/offsetof.h> from <linux/stddef.h> for compatibility.
>
> From <linux/offsetof.h>:
>         Include the same exact deps that <linux/stddef.h> had.
>         Changing that in any way broke my compilation.

The commit message does not explain why you are doing this, what's the
problem it fixes.

-- 
With Best Regards,
Andy Shevchenko
