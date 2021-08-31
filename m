Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FFB3FCB69
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbhHaQVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbhHaQVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:21:16 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0368C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:20:20 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso23450119otv.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Nxjd5f4FQP+iuJdlCMMXyBCT1vbYwVqlZ+8XK9fwdQ=;
        b=J72jUYPDy5vSnEPtLJff6zOJWiJ8rBr7sxb0kJeX18yOKAaIgyhAtBo/RdbLgqvVbT
         +NJL+5U10HnPXrjROQSfIq3yQ6aZ5hP7SRh9gkLZO6vO2kx9nWceTIE8S2OJrVUDTDvy
         XSY+zI9ptht4vdGw7GKMLV5oX50v6/cjMOekM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Nxjd5f4FQP+iuJdlCMMXyBCT1vbYwVqlZ+8XK9fwdQ=;
        b=He/YXowIhelSi/1KdgUAbQKB355h/K1CWRsmPP5SIvw90DIZGRQt+KisqNj8HT3XfZ
         NZ5WPjm/PJSIWfPcjlUvqNyHKNR7roDqUAip5lkPoNF7IUWYImQibaLYjj+2Mk6dxrFJ
         sv9lJGXf0Oiz8ag/6lIeSY72Whesxhd4jEWyRBpwuY36FqaktJaF26FBLduN4c7TDUAJ
         Tg6JFwKzVh0pi+OCL7/YrA1/dz4TVBjKl34GClp4Qz9hF8AJucMlDnKjTHpYijX7o/3Z
         x+J6wySluwuTitRGwHARY1dHbIjPwwTkiU9DynX2LXBwBPycbN6fXM4Cw7ufNKiytYW2
         w4zw==
X-Gm-Message-State: AOAM530SJJ8E1IMXORJ87KI6TzChkyWoMz/1GWpEPa5im8k9HqYGaiO5
        8ODRDi+ar7JaR7yKEZuq929q5yz0E5HMiU7CXStmCA==
X-Google-Smtp-Source: ABdhPJwStM5dJA6wjR+VVbKMzJ3V+gw9bRn26N055U5GnWbinAi7zEmvwJCmKgB5Hcu7VTrZr/ZjSHHRE3i3ciIrmVE=
X-Received: by 2002:a9d:65da:: with SMTP id z26mr24499621oth.303.1630426820214;
 Tue, 31 Aug 2021 09:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000815b9605c70e74f8@google.com> <131b24e5-ee31-6f7b-42b4-c34583711913@infradead.org>
 <2fccb5d3-191c-924e-159f-1c9d423e282f@i-love.sakura.ne.jp>
 <339bfb21-8e80-c7d9-46dd-c416f87c50c0@infradead.org> <535e404d-03bf-8e7a-b296-132a2a98c599@i-love.sakura.ne.jp>
 <CAMuHMdWX7s63X_zR9329canbQkPGBVxZNG4O+_=jUut60aGR9g@mail.gmail.com> <5c6d2b95-31d7-0d59-5e62-2593d9a0e1fe@i-love.sakura.ne.jp>
In-Reply-To: <5c6d2b95-31d7-0d59-5e62-2593d9a0e1fe@i-love.sakura.ne.jp>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 31 Aug 2021 18:20:09 +0200
Message-ID: <CAKMK7uEbvUjskYmobK1g-iA++LeQvfUUik=ZJtrHh0+TdjE7+A@mail.gmail.com>
Subject: Re: [PATCH] fbmem: don't allow too huge resolutions
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 5:24 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2021/08/31 15:48, Geert Uytterhoeven wrote:
> > Furthermore, this restricts the virtual frame buffer size on 64-bit,
> > too, while graphics cards can have much more than 4 GiB of RAM.
>
> Excuse me, but do you mean that some hardware allows allocating more than
> UINT_MAX bytes of memory for kernel frame buffer drivers?
>
> > IMHO that should be fixed in vga16fb, too.
>
> According to https://elixir.bootlin.com/linux/v5.14/A/ident/fb_check_var ,
> there are 89 files. Randomly picking up drivers/video/fbdev/udlfb.c as
> an example. dlfb_is_valid_mode() from dlfb_ops_check_var() is doing
>
>   if (mode->xres * mode->yres > dlfb->sku_pixel_limit)
>     return 0;
>   return 1;
>
> where max dlfb->sku_pixel_limit seems to be 2048 * 1152 but I think we need
> same overflow check. I want to avoid patching individual modules if possible.
> That depends on whether some hardware needs to allocate more than UINT_MAX
> bytes of memory.

Yeah basic input validation makes no sense to push into each driver.
That's just asking that most of the fbdev drivers will never be fixed.

Same for not-so-basic input validation, if there's no driver that
actually needs the flexibility (like the virtual vs physical size
thing that's floating around maybe).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
