Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B836BA38
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241611AbhDZTqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbhDZTqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:46:17 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A94C061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:45:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s9so7609441ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZO4kmNKLbEnSNeVac4oUitph0OSEkvoJcTmzFLrNOc=;
        b=YNlj+IwtjOUvERORkSXzpcVq5HacWyXge4byLQC17HNKgb/rO/rE+uFzlNFawMjkLe
         1lzT82DtdNkZXHWzGRjPP+b1FSJEWlWR8NQnBS/bA171m5RPEPJSsqdiMUK3zAYOYq+p
         qNK6JZXkWiCdLyWEcIfXDCiALLMUhYvlpe9C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZO4kmNKLbEnSNeVac4oUitph0OSEkvoJcTmzFLrNOc=;
        b=YBywEQS14b/SQMFEZhhLGRb1+07s+mopTfqHH4aXkIg1LIzv+B31a7VTYOdO/XXmLm
         e8zMBiB0I3uREwKkwX1iiWaAonesgbkh3OCbtD+7c+kmeO9T54vmMvmuDIAL8LAJZPFN
         AoTN6gUXWbfkeIB7X02BdB9uPWhhkk05qkyNypLZBSrrSy21sjqhhpW8gtvh4w2AqYez
         OzykLo7NaysEChmuASedKDbCo+gu/WgA8wZd7uYZaWisHoejuoKpN5ScMjvuDUwUNx90
         y0GW/b34/5iVRcdKx70jJ5onDVGunGv1hPyvMt9/Q0LAIEbVPFwokCuQBosqsAsokVXI
         EjOA==
X-Gm-Message-State: AOAM531pxys6JDXPCBbZpWAaOWc1HR/W4UQLOGqQYMCiih5K/g64fVAx
        q+qB8HBG1wdaVopVpwlQlUNVBDD7LW8dusfB
X-Google-Smtp-Source: ABdhPJye8OsjxyklAkyyBHKKmz8RXJCXDtyXTfGM4VOuHx53YUpVxKHC2xWgoxR2IAtLarDkArw6Yw==
X-Received: by 2002:a2e:2a05:: with SMTP id q5mr14096714ljq.398.1619466331885;
        Mon, 26 Apr 2021 12:45:31 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id l10sm101864ljc.119.2021.04.26.12.45.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 12:45:31 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id m7so54696443ljp.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:45:31 -0700 (PDT)
X-Received: by 2002:a2e:a17a:: with SMTP id u26mr14019906ljl.465.1619466331327;
 Mon, 26 Apr 2021 12:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
 <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
 <34d778fa-343f-912f-2fd7-a8ba49bd1b95@skogtun.org> <54debab9a79df628cff86a637dde13c281001578.camel@sipsolutions.net>
In-Reply-To: <54debab9a79df628cff86a637dde13c281001578.camel@sipsolutions.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Apr 2021 12:45:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvVMucgoAQKfi-x=jvYgKW1_LRmvnAfk3JGMkOSg9CQQ@mail.gmail.com>
Message-ID: <CAHk-=wjvVMucgoAQKfi-x=jvYgKW1_LRmvnAfk3JGMkOSg9CQQ@mail.gmail.com>
Subject: Re: [BISECTED] 5.12 hangs at reboot
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Harald Arnesen <harald@skogtun.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 12:38 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> >
> > dmesg from 5.12 without the revert is attached.
>
> That's it? There it just hangs? Not even printing something about tasks
> getting stuck?

I assume the dmesg is from before trying to shut the system down.
Useful mainly to see what the hardware is, than to debug the hang
itself.

So it looks like it's an Atheros AR9462. That doesn't sound too unusual.

Getting a dmesg from the actual shutdown is tricky, because the system
is obviously no longer usable at that point. You tend to need serial
consoles etc.

Shutdown hangs can be a bit nasty to debug for that reason (similar to
suspend/resume issues).

                      Linus
