Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148983EAA13
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 20:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbhHLSSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 14:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhHLSR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:17:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02400C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 11:17:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d4so14991108lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGHPatc+TnqYShXQudoDUtRaLggOUzB+ZREYC5Ga194=;
        b=Pbryzjo1isXl/nuZlAUtnmnoPNhKu0gwCDInZuzsF4QRGNoD7Tgz85fI9NDmXmAf86
         Pz+UloLHqsTmig/Dz0PYevrvSbkTcgcCuUgDxSJRRb8OSzZcruLX61NlYHCI+oU60BvK
         J2mjSCcNTjzYuNj/DobML4FsAjPvqI1fjz9G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGHPatc+TnqYShXQudoDUtRaLggOUzB+ZREYC5Ga194=;
        b=IfZWeJsjUfF171vEqxpEg/+TyXG6rxUtyv1suuyc5rJZQPIwBg5WbnE/GGxcJr+91S
         zsIp3BoRyBo8PDyI9xfr7gbjGjRRNdktltrgwHuIraeFaaTtKaxNgdhmQsa2Xq4q2ydu
         ZyWYr5EhdMPk1C7PQ1Fk/IVLUSd0wXCwtcet73hKuiUCkJx0DTkQ1hUi3uedXAIsxQUj
         ueXxVJxGXD3fVZrD083EbXrWfaFnvI32DA7oMjDD0nCjrneM3y0gYuWcstyiWZFwuYoH
         0KlF/1oVKSBxxcaiC+DjO+QdQldUar34xh3cS5PBVedijCbM1oHh0tmObiH56bIZ9nKf
         qc1Q==
X-Gm-Message-State: AOAM531ZddWpoWUYIAA11ukhWYh2JjfciK9Dqfv5JEuxbgH6O0qTLQlI
        T7IbT8UIIhRa28/mh4X/6NYz4T1j7gD6Xg6lhyw=
X-Google-Smtp-Source: ABdhPJxq38m31ULKhAAb9MUCCS+d/LUXXUKXcwFsSw5nLSghaGpHGxhFsfHfbrgkuAdHrjrhd1s7ZQ==
X-Received: by 2002:a05:6512:3a91:: with SMTP id q17mr3495628lfu.38.1628792252123;
        Thu, 12 Aug 2021 11:17:32 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c2sm391392lji.57.2021.08.12.11.17.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 11:17:31 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id z2so15134729lft.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 11:17:31 -0700 (PDT)
X-Received: by 2002:a19:4f1a:: with SMTP id d26mr103422lfb.377.1628792251245;
 Thu, 12 Aug 2021 11:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210812112938.3748c7f5@oasis.local.home> <CAHk-=whHxeUjaNrWOLb0qx=-nibRZzQomwkw9xMPH_aHCf=BWQ@mail.gmail.com>
 <20210812133306.1c480741@oasis.local.home> <CAHk-=wj=8xh+AcwQ+w62-QHfVU6wXC2xW8L17VvVBaR6dR6Ttg@mail.gmail.com>
 <cef5b624-b5f8-7729-3b05-3543578c6e3e@infradead.org>
In-Reply-To: <cef5b624-b5f8-7729-3b05-3543578c6e3e@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Aug 2021 08:17:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiEK+RooMgy+-vUbvfJi2PXCVh2K+ENeJszo6HyzYb-Cw@mail.gmail.com>
Message-ID: <CAHk-=wiEK+RooMgy+-vUbvfJi2PXCVh2K+ENeJszo6HyzYb-Cw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes and clean ups for v5.14
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 8:04 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> I just used some default settings. I didn't choose to use -Wmain.

What broken distro, what broken gcc version?

We can certainly add a -Wno-main for this case. We already do that for
a lot of other idiotic warnings like -Wno-pointer-sign.

But when we do so, I want the exact tool and distro version named and
shamed. Because I sure don't see that warning, and from what I can
tell, most other people don't see it either.

So it's almost certainly your distro that has configured the gcc
install incorrectly - or some new gcc version that makes new insane
defaults. The commit message should talk about those kinds of details,
exactly so that people like me get an explanation for why we'd need
that odd '-Wno-main' flag.

Maybe even the line in the Makefile should have it. Like that
-Wno-pointer-sign thing does:

  # disable pointer signed / unsigned warnings in gcc 4.0
  KBUILD_CFLAGS += -Wno-pointer-sign

just because unexplained random compiler flags are a bad thing (the
same way unexplained random code changes due to them are bad)

                Linus
