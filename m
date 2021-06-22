Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1E43AFDB5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhFVHUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVHUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:20:46 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D82C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:18:30 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bm25so22111256qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rwLQYaU/N4sr4nRtE+zb7ktHcDZLDzWE6lThz8M9haY=;
        b=ukw6w3mzqc8uqtJXdKiU1qySXvImdDn7rUz1EP2sTUHqrI8pMc2KFiwkGCQrmYHLy8
         pRnAc4yhmMjS3wJFhAfXEz8MiYZi/2Rt9RJqjxREXFpjXc84kxwSBYKG9sWRUOon+77V
         Tgaa9jCVK1q8522qQa5ERsl93Po/Sxda6oNiQDP6tvU5KY8OhMTk3atsACewq7trfjrw
         RtjztgETGqEvX1MBhdIyfPovXsqUXmRgcbiUXEMY1XJNNL4Hu/yR6vhfdqn6NSQj31ek
         BHpzbQ24zXwEi82DDwZ2v/fPbJLmv9+tS/HA+oFxw/1agz0NxT1wmcd1EC9gz/9uAEV9
         nqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rwLQYaU/N4sr4nRtE+zb7ktHcDZLDzWE6lThz8M9haY=;
        b=dVHWv3xI+ObfnOUPOpAobJkg01v6xlTwZuoCvVJ+S0+10aR32s2yfuP17vjqA4Sb2Q
         AYH8GsKIrYC5rhESiaHzr1j8jWnoUXYN2mC6FOX3xecii+1z9Ip7FZviT9FTHkkJ4Rvl
         3rjcXB6Ne6sEpyiC730cXF5nKvSUd+l7DHQxoX5TqEvRCB3rtN/KfbyJJT3OcyesuTbj
         HGGtio9/G39LBHC8L8HxraY/vIW6Zo8v5xTVFBxlmBwOdWIIYUd8A2+iWC2tbKZBke2M
         RgXSnG8phAtlC7ZYnZ969FYjHV8oGTOg8luQZQ1QK8AfupZemMXwHmk/yJ99Pd3RH67y
         jAQw==
X-Gm-Message-State: AOAM530ZhIq21HOeR+s9W1Xi8ItTJnXVVgBpE9Y01FKIUnwlfp5iiPE6
        ftL7FEJrBfMLzavIUmrfgVY=
X-Google-Smtp-Source: ABdhPJyTLfr9N0KuIcUx9DWpSMGmS4RSSlJSddhTv3TwaMQTYfD69qchjMsl5VrPGKrGuJyg/FBDCw==
X-Received: by 2002:a37:557:: with SMTP id 84mr2767669qkf.124.1624346309198;
        Tue, 22 Jun 2021 00:18:29 -0700 (PDT)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id q207sm6886756qke.72.2021.06.22.00.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 00:18:28 -0700 (PDT)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id 377872B19C;
        Tue, 22 Jun 2021 03:18:28 -0400 (EDT)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id 336A9600468; Tue, 22 Jun 2021 03:18:28 -0400 (EDT)
Date:   Tue, 22 Jun 2021 03:18:28 -0400
From:   nick black <dankamongmen@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: why were GIO_FONTX/PIO_FONTX dropped? i was using them
Message-ID: <YNGOxMfGuxQfwtiJ@schwarzgerat.orthanc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri et al,

I'm the author of Notcurses, a library for "blingful terminal
UIs". As part of this, I was using the GIO_FONTX and PIO_FONTX
ioctl()s to reprogram the Linux console fonts. I proposed this
functionality on 2019-12-22 in Notcurses bug #201:

 https://github.com/dankamongmen/notcurses/issues/201

On 2020-05-13, I began using these two ioctls (along with their
_UNIMAP equivalents), as documented in console_ioctl(2), to
recover the font, scan it for Unicode block- and line-drawing
characters, and add them if absent:

 https://github.com/dankamongmen/notcurses/pull/795/files
 https://github.com/dankamongmen/notcurses/pull/794/files

some happy initial results were saved for posterity; i've
reproduced them here:

 https://nick-black.com/images/you-stole-my-ioctls.jpg

this worked perfectly, and I extended my Quadblitter to it, and
cheerfully considered this a completed feature. You can see the
results in this video from September 2020. it starts at 192s in,
though you ought just watch the whole thing because it's
awesome [0]:

 https://www.youtube.com/watch?v=cYhZ7myXyyg&t=192s

How sad, then, when a few weeks back I noticed that this
working code was no longer working on newer kernels:

 https://github.com/dankamongmen/notcurses/issues/1726

I assumed it was my bug, having heard something over the years
of Linux's commitment to APIs and not breaking working code. but
today i went through the console_ioctl(2) man page (2017-09-15),
and my code, and strace, and finally the kbd 2.3.3 source, where
i found out about KDFONTOP. ok, but why weren't FONTX working?
then i found ff2047fb755d4415ec3c70ac799889371151796d:

 "As was demonstrated by commit 90bfdeef83f1 (tty: make FONTX ioctl use
  the tty pointer they were actually passed), these ioctls are not used
  from userspace, as:
  1) they used to be broken (set up font on current console, not the open
     one) and racy (before the commit above)
  2) KDFONTOP ioctl is used for years instead"
    
as hopefully demonstrated here, they *were* used from userspace.
i'm happy to move to KDFONTOP (since it doesn't appear to be in
the 5.11 man pages, maybe i'll write it up), but this was
somewhat rude, and maybe the ioctls weren't as broken as you
think?

also, i notice the definitions weren't removed. if no userspace
was using them, they could have been, right? that would have
been better than the ioctl()s mysteriously failing with ENOTTY.

i'll go ahead and switch to KDFONTOP, and send in a patch for
the man page. hack on! and watch out for we little poeple =].

--nick

[0] just kidding, that one's old. check this out:
    
    https://www.youtube.com/watch?v=dcjkezf1ARY
   
    or if you hate youtube,

    https://notcurses.com/notcurses-3-the-saga-continues.m4v

-- 
nick black -=- https://www.nick-black.com
to make an apple pie from scratch,
you need first invent a universe.
