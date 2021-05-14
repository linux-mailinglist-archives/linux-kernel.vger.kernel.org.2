Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56F0380F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 19:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhENRjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 13:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhENRjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 13:39:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04A9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 10:38:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i9so37578685lfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4eP2HKjmSPGQBFEyZcyYKZJWe+JMEKFqkR6pP/3cc9M=;
        b=JPqpxKZ6h3pPkH87PqOfka8i1IvLu5pzfn+4fmxzhXwXId5mvFlsZuxvc3IbwTgQ2+
         YAqCTph+MdHtowFy9sHdUp52ddR/WU1LlpaTEu7tOLf0Ng19sYa2m+RPBSfAz/RuGY7X
         d70/1XU+SVTEVIgb1aYeWNkl8HjlNXomO9/CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4eP2HKjmSPGQBFEyZcyYKZJWe+JMEKFqkR6pP/3cc9M=;
        b=X7CSU5kTGy1xHs5IXROIKa1KZ+gLDPOuhH+BHqzcQlIMZ7KwssM8AIiKj3O0137J4B
         r5hgNts39FNKco3lI6u7tXEDjwVdifwqQ7mc1wrAB0qyyvBUhfdy7pN27GtmWboFCRYg
         KNAXfVdkdt+FdNYHNDPh837hD9ykSznjYfgGKB50liHwLvE/hXZofoBlMT37KpFYKGWV
         Tq1LCns1zPP9BXO+zqs6z4PG9IYKo8xDbUyLqkuxPDlqF2vzO9pU9DABnEylu8hIkFZ9
         wMGoUbYxkqFZEdfaLPy7inONBqXdpXOCaz+TyejV6WGWwFn8gvw7SK2NB/nnXVQsC2Ts
         oEaA==
X-Gm-Message-State: AOAM531La3g31Ijx1N9c3LkrBpr5HsniGjvAODITduw04g2Q+Ok9AF1b
        dfZiEv2VBbx264Zsy7wHIDVi3QKpSAc5ucGWugQ=
X-Google-Smtp-Source: ABdhPJxL0BBRHWkVOO2AUgzf9k6C/kQbAwNzwrNdUUr0lWAfnhgFzE2+5UeRXtHosDe2ZmUOVCRIxQ==
X-Received: by 2002:a05:6512:24c:: with SMTP id b12mr34812581lfo.187.1621013885237;
        Fri, 14 May 2021 10:38:05 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id s28sm154568lfb.238.2021.05.14.10.38.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 10:38:04 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id z13so44147201lft.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 10:38:03 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr32359155lfs.377.1621013883280;
 Fri, 14 May 2021 10:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006bbd0c05c14f1b09@google.com> <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp>
 <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp> <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com>
In-Reply-To: <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 10:37:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whN=zrJ8BOLaGsJDH8d3sXLEoXA2DVsCq40OAUc1npOOw@mail.gmail.com>
Message-ID: <CAHk-=whN=zrJ8BOLaGsJDH8d3sXLEoXA2DVsCq40OAUc1npOOw@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: vga16fb: fix OOB write in vga16fb_imageblit()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Antonino A. Daplas" <adaplas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 10:29 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So why not just say "that clearly already doesn't work, so make it
> explicitly not permitted"?

IOW, something like this would seem fairly simple and straightforward:

  diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
  index 01645e87b3d5..f24e627b7402 100644
  --- a/drivers/tty/vt/vt.c
  +++ b/drivers/tty/vt/vt.c
  @@ -1171,8 +1171,13 @@ static inline int resize_screen(struct
vc_data *vc, int width, int height,
          /* Resizes the resolution of the display adapater */
          int err = 0;

  -       if (vc->vc_mode != KD_GRAPHICS && vc->vc_sw->con_resize)
  +       if (vc->vc_sw->con_resize) {
  +               // If we have a resize function but are in KD_GRAPHICS mode,
  +               // we can't actually do a resize and need to error out.
  +               if (vc->vc_mode == KD_GRAPHICS)
  +                       return -EINVAL;
                  err = vc->vc_sw->con_resize(vc, width, height, user);
  +       }

          return err;
   }

not tested, but it looks ObviouslyCorrect(tm), and since we know the
old case didn't work right, it seems very safe to do.

           Linus
