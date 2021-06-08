Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BED39F14C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhFHIr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:47:57 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:37843 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhFHIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:47:52 -0400
Received: by mail-pl1-f170.google.com with SMTP id u7so10263934plq.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 01:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTo5oaCWf2VbF9R1SbnzgIb9eIskqqS+oMK1lnzv8H4=;
        b=aMZ7Qxr3e+7Pst5WyAYcdheAqmjXTbDmPt2itZGLY7Qd/x6CWhHIEOEQ8HjRETfG2D
         F6HqexTOjhfhcwgjjbg/jUkzu48HVpa0OIQ3e/HhpOX9GqoMcusojUhw2fH87tEELNVL
         qeyVhxb43B+2k6ahbkNjeKI5VbghXfE0OEwJoLNuC1szHU/dXeQwcBEGAttTqHOh7c6g
         xqj370quGauGB+gWdvwjecjZyYQhQaYID1eCbPWRKbrLZ2Atrplz5T6YQSuNFV8IsWLb
         U0AWxWV3CxwPmkUrEPa/c4sZ0zToaagqCL+r86AKY3/DJWBZgumNIL2DZhvO9cgOcBTU
         9ZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTo5oaCWf2VbF9R1SbnzgIb9eIskqqS+oMK1lnzv8H4=;
        b=ZYGVlVIz+GBXg1dLME/DDHZ+g+sJLORRrHDIXUgzluXTKJZNePyNr8LF+zEN9StEvZ
         FZIAffN3193XD+kJhM0MLQvMC/wggsFjIhh6Unourl1tAn7cuUQG7aE3IBPCfyLmJTZX
         CG0AadBvBqEd4EfUD2lYv3/Xbxz7MPQ1HlLHbSx3UhIqFu/OXfa34xq1fUl4x1uHCUsI
         +wHZ25GyxVh95QG9HoJFKGgibrMXg7R0nJ7jQ+QrOh9vYJfWQ/C2h/ySbsgvRJgylRQJ
         lqg77p3jW34RynsZBtrjsM4QogvYi/0Qr02LwFIsJhvqggtykcyWudBAGDUGEut0p1EB
         RJQg==
X-Gm-Message-State: AOAM531HT4Yej/hlBgNYWC/ag65xIgXY+VjZXt/+kaJ0dKPlpH/FHLGT
        cXhfwNrRybd1Ix9UMo5b3IJyyUmhwOSVhdhJhwI=
X-Google-Smtp-Source: ABdhPJwqTRTfusBwwfUj2YQghBK8Y8HNvO/p/824mCiSr5s2+tJp90IztaIV39hyMZ8P3yL2xMjFWwmt4UcNiad/Ot4=
X-Received: by 2002:a17:902:d305:b029:10d:c8a3:657f with SMTP id
 b5-20020a170902d305b029010dc8a3657fmr22137740plc.0.1623141883695; Tue, 08 Jun
 2021 01:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210608071430.12687-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210608071430.12687-1-thunder.leizhen@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Jun 2021 11:44:27 +0300
Message-ID: <CAHp75VfuMJ5kfRDB4tE2zr2Em79HiwrDJVROnw+kD3H+QNM4sg@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: remove leading spaces before tabs
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 10:14 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> 1) Run the following command to find and remove the leading spaces before
>    tabs:
>    find lib/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'

Hint for the future, try to use what Git provides, for example `git
ls-files -- lib/`.

-- 
With Best Regards,
Andy Shevchenko
