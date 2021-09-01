Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BA53FE053
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344156AbhIAQvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbhIAQvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:51:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C12C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 09:50:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p38so421488lfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6CphMFgf5XtmkIUIZdS3zg3lS0CLaheDoiUHPnX0Fk=;
        b=XWORPcX4JUiWNYhys31DRm5lPzmQ8u3sh4J6BqTmpr0mg4ugdlAnpEPUP/nDyLFoi4
         LXOKc1TEP4Rcp3WKfC9pWuacs8HoE5v93ke7gWjPkYyZRbmnql6lTS3lcu+Nee5S2CQs
         4KLUoQY7eshWi4Uj/Y8cdKSRMXIp/YYbL9Ypo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6CphMFgf5XtmkIUIZdS3zg3lS0CLaheDoiUHPnX0Fk=;
        b=JfuGzXqpnQ0gwXjotzjRokmFqHuUJ88vRSJrJivFzIogdauB1wmjL7mzs1qc1RN8df
         FiSZEc01YC+/mS6pr+wPds6iEEx9xrfAZw3Luh7DBUj+4tJxsruoIUAuLVybzlIstSdV
         5tUZAvzdUuyI415TCfbAKrLCv6nA2wJ9oq3pa5SSlTjnGbpWpNK3raZ50ICgThU672nL
         H5rab9skHZKwRg8vOamtfHKkAsuxbS0Dqy4C8TxfsEJX35rb2nwENFzKEDZdWAqWtIy5
         RlILQ3nuGwa8F+cDhUnTW8X+nB9iN+vTX7OV9CfORNWK7RuDsZDGTuI5WnwM4x+59FpM
         8siw==
X-Gm-Message-State: AOAM530imQ2xK0KC84Ogdm/zWgbqah/vef5AcwD2rn4gRd+CMq2zEQAM
        MpRRl0BScK6tt+mCseEaqvrL4mevK3/V55S+
X-Google-Smtp-Source: ABdhPJyaC5nZygLU2VtdQ29CLuiWrkY96LWmceeu9iC8sBNk2otpydeVqNoZNoWlz6vFaBJDVATF0A==
X-Received: by 2002:a05:6512:25d:: with SMTP id b29mr271374lfo.261.1630515005320;
        Wed, 01 Sep 2021 09:50:05 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id d20sm3081lfv.117.2021.09.01.09.50.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 09:50:04 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id bq28so276227lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 09:50:03 -0700 (PDT)
X-Received: by 2002:a05:6512:1053:: with SMTP id c19mr273608lfb.201.1630515003669;
 Wed, 01 Sep 2021 09:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <YS+LXqoDGk0CqU1Q@kroah.com>
In-Reply-To: <YS+LXqoDGk0CqU1Q@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Sep 2021 09:49:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqN1gAZk0ZD_4JxGemdbpnQkDaNFY9MjW==v-kb1J-fw@mail.gmail.com>
Message-ID: <CAHk-=whqN1gAZk0ZD_4JxGemdbpnQkDaNFY9MjW==v-kb1J-fw@mail.gmail.com>
Subject: Re: [GIT PULL] Staging / IIO driver changes for 5.15-rc1
To:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 7:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Lots of churn in some staging drivers, we dropped the "old" rtl8188eu
> driver and replaced it with a newer version of the driver that had been
> maintained out-of-tree by Larry with the end goal of actually being able
> to get this driver out of staging eventually.  Despite that driver being
> "newer" the line count of this pull request is going up.

Ugh.

So this had a conflict with the networking tree, and commit
89939e890605 ("staging: rtlwifi: use siocdevprivate") in particular.

Ok, so that conflict looked annoying but harmless - git saw the new
driver as a rename of the old one, and tried to actually apply the
changes from that commit to the new one.

And git actually did a reasonable job, everything considered. There
were enough similarities that it wasn't entirely crazy, and enough
differences that it caused conflicts.

HOWEVER.

Actually then looking at the root causes of the conflicts, as part of
just trying to finish what git had started, I notice that a lot of the
code in the new driver was just completely dead.

As of commit ae7471cae00a ("staging: r8188eu: remove rtw_ioctl
function") the only caller of rtw_android_priv_cmd() is entirely gone.

But rtw_android_priv_cmd() was kept around, and was in fact the only
reason that the files

    drivers/staging/r8188eu/include/rtw_android.h
    drivers/staging/r8188eu/os_dep/rtw_android.c

existed at all.

End result: instead of trying to fix up the conflict in dead code, I
just ripped out the code completely.

So my merge actually looks simple and clean: when you look at the
conflict diff of my merge, all you see is that I removed
'os_dep/rtw_android.o' from drivers/staging/r8188eu/Makefile.

What you don't actually see as a conflict, is that I removed those
files entirely. That removal doesn't show up as "conflicts", because
that filename didn't exist in my HEAD commit before the merge at all
(because my tree had that old "rtl8188eu" driver).

So this email is just a long explanation for what I did, to make
people aware that maybe I screwed up. It builds for me, and honestly,
it makes sense to me in ways that your git tree did not, but I can't
test any of it.

Added Arnd (for the siocdevprivate conversion) and Phillip/Larry (for
the r8188eu driver side) - can you please double-check what I did.

                   Linus
