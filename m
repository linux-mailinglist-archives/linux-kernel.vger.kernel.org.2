Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B913380EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhENRbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 13:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhENRbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 13:31:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B815C061756
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 10:30:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2so44086765lft.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gCT3yFXN0nq6W0TvPfJDEC6ju7ngwBrbZ3V/R/ZJt4=;
        b=QrDM1vyn65+P14zzNE8NIxADOjzkXwgZ1OVSKlrR4yWXq5tE46/SGHEAy800t0p0KD
         09lTLzF24eD7OUZIM3qJyL3BYanjfr/ddscyzFIcuOxS77RMISzoNAQdTSU8ej9mIAeW
         QqV6REiHKfhF0o2ztdoumCpotG6fc5BTXat8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gCT3yFXN0nq6W0TvPfJDEC6ju7ngwBrbZ3V/R/ZJt4=;
        b=Yey/6/0MxBJJy4B0+2zXm7YPQwCWwPbO7c+wzlbzD6hsfG5NhkRdhgmlchFr3hYFxD
         H0iB+v60Sz2sJDA273Ewtx0p9yh2pQuPe6KHAdYL2Ao2PxAJUmM6nnuX6zX9AWXZcFO0
         6TzjxTfGroXooDYudrNEPt96V2O3vTccqcSoI1+ECmVhzgrwmj5ZFQeeheLdZMDtNuPJ
         ue0xCtTL5Vk9BlkKVy4rcEuviZLVHwMrJULmTlrrNgPHcoU/gOhbGcFZ61fDjw4H0zxC
         tW+tWBTB5ktMQtlCO5SUz/4lxD1c5ehgjCktgd1hyhLlTozQVUZiqgu7dZaUucyCO0jg
         ZNXg==
X-Gm-Message-State: AOAM532Bg4PvsSw7ar/Qco7odXfB0l4DLkJqa/5hzqd57AALwQDCR3L1
        8jLzCYjB6rfu9yTMNKI729gXna+rfYwUeijd
X-Google-Smtp-Source: ABdhPJyxdiIuHzlofub09JxxMy/kqBscbCtHOyRRLO81oPzMObS1VikeVds1AgO+5j2pdC3fzvcB2g==
X-Received: by 2002:a19:5f4f:: with SMTP id a15mr32783375lfj.662.1621013404673;
        Fri, 14 May 2021 10:30:04 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m9sm1291166ljh.6.2021.05.14.10.30.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 10:30:03 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id j10so44079956lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 10:30:03 -0700 (PDT)
X-Received: by 2002:ac2:4a9d:: with SMTP id l29mr270413lfp.201.1621013402775;
 Fri, 14 May 2021 10:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006bbd0c05c14f1b09@google.com> <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp> <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
In-Reply-To: <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 10:29:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com>
Message-ID: <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com>
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

On Fri, May 14, 2021 at 9:20 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Currently it is impossible to control upper limit of rows/columns values
> based on amount of memory reserved for the graphical screen, for
> resize_screen() calls vc->vc_sw->con_resize() only if vc->vc_mode is not
> already KD_GRAPHICS

Honestly, the saner approach would seem to be to simply error out if
vc_mode is KD_GRAPHICS.

Doing VT_RESIZE while in KD_GRAPHICS mode seems _very_ questionable,
and is clearly currently very buggy.

So why not just say "that clearly already doesn't work, so make it
explicitly not permitted"?

              Linus
