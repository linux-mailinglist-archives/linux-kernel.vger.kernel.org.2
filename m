Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8F43BAF69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 00:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhGDW4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 18:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhGDW4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 18:56:06 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B99C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 15:53:28 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u25so21991281ljj.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 15:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDM4UIZ790n+ppfiycyw7+PHwfmRhuVZBOQnWXK0gRI=;
        b=H7WvdvevCm0cGmGJA9aPF6RMGQiFgDi5yd5uh3Pks/+TNEJ7O1vhOWAhm4nYRDgd3C
         +Hoq74/tki4Zh8QMlUvZEbZs5sSI/vm1gNgjkjOCSrCG1jB3Dt/dL6xqCxo6XEH4s3Lg
         YZLhI/kKu+ovHr6TBNJ4aNEZlqXTpetGfA/Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDM4UIZ790n+ppfiycyw7+PHwfmRhuVZBOQnWXK0gRI=;
        b=uSloFmrNHFes3Bk4SH/wXlz3kDwmqo2GbCjN1moL2YB4pRSW7ekfkcV1j9R67ed21N
         Q1bc8+GImfszPAQrgMM2MjZgu8VYAf/ZdDSWrdcJL1HNyXOOuEGx2D6nTf+Qi5X2+Y3J
         AOpcriSADQJP00AbAAbk4QBX7G4ExRySNVt1yomn6q1nUWbFjtgF9WYWlqy4ftfFUNHu
         rJXKv/bY3A/ol+w7sXN4rr+MXnNQeJiiBCBVjPD4wTb42xNBMTlhihYg7OonctuV3p0M
         8yPIDTN4URQeOgi2IrLBMJSHE26PUDgSx9/aC6MhyMOX+svax4p7cIGKdiDIgO+buxtw
         pLtA==
X-Gm-Message-State: AOAM530f8ou8ZME+n+mipqyjFMCsLJBOiAEWKAIl1Qfg/EHhPcOEGsoF
        hBOG5eUc5v6wsE4fSIeoVkpATeSp2yvOQDn/
X-Google-Smtp-Source: ABdhPJziBkn/0STiwhGE34pDcpqWbNxsgSzIL1glKb129bMj9US9Q15QielSQn9fc0BYNc5O9YvE1Q==
X-Received: by 2002:a2e:9b46:: with SMTP id o6mr3234890ljj.501.1625439206902;
        Sun, 04 Jul 2021 15:53:26 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id bu12sm899829lfb.31.2021.07.04.15.53.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 15:53:26 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id p21so7301478lfj.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 15:53:25 -0700 (PDT)
X-Received: by 2002:a05:6512:15a2:: with SMTP id bp34mr8027515lfb.40.1625439205690;
 Sun, 04 Jul 2021 15:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210704172948.GA1730187@roeck-us.net> <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
 <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net> <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com>
 <19689998-9dfe-76a8-30d4-162648e04480@roeck-us.net> <CAHk-=wj0Q8R_3AxZO-34Gp2sEQAGUKhw7t6g4QtsnSxJTxb7WA@mail.gmail.com>
 <03a15dbd-bdb9-1c72-a5cd-2e6a6d49af2b@roeck-us.net> <CAHk-=whD38FwDPc=gemuS6wNMDxO-PyVbtvcta3qXyO1ROc4EQ@mail.gmail.com>
 <YOI6cES6C0vTS/DU@casper.infradead.org>
In-Reply-To: <YOI6cES6C0vTS/DU@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 15:53:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFOoSvSXfm0N_y0eHRM_C-Ki+-9Y7QzfLdJ9B8h1QFuw@mail.gmail.com>
Message-ID: <CAHk-=wjFOoSvSXfm0N_y0eHRM_C-Ki+-9Y7QzfLdJ9B8h1QFuw@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 4, 2021 at 3:47 PM Matthew Wilcox <willy@infradead.org> wrote:
>
>
> We could slip:
>
> #ifndef uaccess_user
> #define uaccess_user() !uaccess_kernel()
> #endif
>
> into asm-generic, switch the test over and then make it arm/m68k's
> problem to define uaccess_user() to true?

Yeah, except at this point I suspect I'll just remove that WARN_ON_ONCE().

I liked it as long as it wasn't giving these false positives. It's
conceptually the right thing to do, but it's also the case that only
CONFIG_SET_FS architectures can trigger it, and none of them get any
real testing or matter much any more.

All the truly relevant architectures have been converted away from set_fs().

And it's actually fairly hard to get this wrong even if you do have
CONFIG_SET_FS - because no generic code does set_fs() any more, so you
*really* have to screw up the few cases where you do it in your own
architecture code.

If it had been easy to fix I'd have kept it, but this amount of pain
isn't worth it - I just don't want to add extra code for architectures
that do things wrong and don't really matter any more.

             Linus
