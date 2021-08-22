Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CAD3F3ECB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 11:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhHVJB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 05:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhHVJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 05:01:27 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94DC061575;
        Sun, 22 Aug 2021 02:00:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a21so12665077pfh.5;
        Sun, 22 Aug 2021 02:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6KjlbNbnKQOdXW8I3XO8GYFdv56dKxIcNuRwEDg+I0=;
        b=EKUO+vkYuLfJJ/yUooPmMrnWDMJqqZi5baoE8sAZMz7bLJovtaB+cna4Pb6GxqSKhU
         iXTf9wdtlTY2OI3/5L1brhvVD81ePCDOJjGxORwx6oz5yqimNnxKkSa+8mWb4OKUyEQt
         eaMJiRlTciYzXK8se4ZDK2NNhBqohNVgGN48towG/rSG+zA71KTM7rbJ8tPm5KZmh9tv
         tQ4p6nWgXorJfWv+0vGQaaE2lKPJDTaUQGfFy4hZ9RDsLWZPQi0DIaL28Jqme89XBrnF
         efhft1hWMLuQIE+qDp6FMGLb4Kq6j8KVXBKaKTzJeW1poLtKwAhZTZqzZY/aR+Cw5UTL
         ocyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6KjlbNbnKQOdXW8I3XO8GYFdv56dKxIcNuRwEDg+I0=;
        b=f3xBNcJbEhxg3qhAlo8Hwmm8G7GusqEH+9FnlcBBvEzUJWpLUNMsd1UZ2mqS4PWm1v
         kxVPdvIrWAtjC6jUtxDjCD0v87xjS2mOVNNvILpatRJZSqfc5Sn50urerFbD5P7671o6
         +mN7yejs8MjVmVZ1soxNPTbEC3aMRstESKwWdnt68ZB0ggI7e9dSBpqUTCtK5YRu3Onb
         eIQ9GORBgiZRaUTtxygou8mjnAGNBUURDJkmIVXKy3XiBDkffu2sBg94FS+QP4Ui4noq
         dtDcvu2JqrGloKsqr35IatCEdIuVwGmRX8Ui5V8b2Hz2wf2oCFL4uePD8EQRGmtKSW7g
         zUrA==
X-Gm-Message-State: AOAM531jqcAko6LFVAqi6WBxD+7dX/p0687mfRef6bDN3VGVT5RzWe/K
        TeY1nz/o+xyRJ19MJ4I4JHJw7rZL22lwOZOrvdg=
X-Google-Smtp-Source: ABdhPJzyT9FtSbnZnOhvbwH1u4xX27on850c8vC0/PGAM9iCuJtB4NkJx4taGHAZ7Zb0hlahzhtz1ROXY+DNeKBqWHo=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr27890153pfi.7.1629622846378; Sun, 22
 Aug 2021 02:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <6abd83d11f1daa3094f82e92843e8279f302e349.camel@perches.com>
 <CAHp75Vdh2CP9n0FrU+6nkmzVWKoKD6RN-RGv7Z+UD_KUoFXPfw@mail.gmail.com>
 <12a41a13f8d03a16c3d5c20710a901c090b7d244.camel@perches.com>
 <CAHp75Vdyms1O+GLFDNn+P0CswbCnk8=XR4t2OBex8i-KuuD9Pg@mail.gmail.com> <8afa5f3847a18ab15005614903646da822c1267a.camel@perches.com>
In-Reply-To: <8afa5f3847a18ab15005614903646da822c1267a.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Aug 2021 12:00:10 +0300
Message-ID: <CAHp75VdKjo7F50FxBiGnPZXT=vjRCXMW7ZpfVwPJHgz11P35Nw@mail.gmail.com>
Subject: Re: [PATCH] vsprintf and docs: Add X to %ph for upper case output
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 11:57 AM Joe Perches <joe@perches.com> wrote:
> On Sun, 2021-08-22 at 11:53 +0300, Andy Shevchenko wrote:
> > On Sun, Aug 22, 2021 at 11:45 AM Joe Perches <joe@perches.com> wrote:
> > > On Sun, 2021-08-22 at 11:31 +0300, Andy Shevchenko wrote:

...

> > > +       return snprintf(buf, 16 * 2 + 2, "%16phNX\n", sn);
> >
> > > +       return scnprintf(buffer, PAGE_SIZE, "%16phNX\n", unique_id);
> >
> > I think you need to convert to sysfs_emit() in both cases.
>
> First things first...

Yep. and to avoid ping-pong style, first here is converting to
sysfs_emit*() since it's already in the kernel.

-- 
With Best Regards,
Andy Shevchenko
