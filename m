Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D8442642
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 04:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhKBD6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 23:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbhKBD54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:57:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD9DC061766
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 20:55:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c28so40169487lfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 20:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MxObBv8H76INeeI5Zw6ZqE2RPzF867spdvGE41UMuiQ=;
        b=f7IDIb6jAdJEHnD1slrYcpU990nL1KSt2xqyAJA1LvLjDoj4mcGpsFuzu0V8Z7ZKkc
         7K5pdKomGw5+GenYqflO3HEcn5gIeSwc6yHHw73BcmuU2NwGpf07yTEId8RGTuczOLVU
         BJkiplrWWhZmswV3CNC3g7cjYT6xigbVN/SRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxObBv8H76INeeI5Zw6ZqE2RPzF867spdvGE41UMuiQ=;
        b=0q1ROyJQmjdiIXl388e5tEzjfgsv8hMJGgh59y6/AMxX5FJcVJVjTj1thAMAtzMQI6
         kSlJ5odSOJHo6T0hfmAod8NBMKFOHdts83aLxogqbffUVi+vMCFHvFhMG5LVKatIxjLM
         vcqXtvH/D1VTTw1uth5MNzM9FmgFVaFfcOLC9nJYGkrpmq3gVBhSmqaqOakmeCh9rUcf
         yhxJGOStH06d+p7Qf3+BdLsvtVdkrtjz8QzI6momSDuppXZIo4eMjJs3vwTEh/r3iGGQ
         RZv2mseSUH4I+lhUUSyUaMC1mY1QKcD+orjjOaLg23UuPQMrYxhJSgRQ/iVge2VPPPez
         N9qw==
X-Gm-Message-State: AOAM530S5pZjTMazt5OnTql8gV8cBK62RurmWyKsX6xyF6Po+OwLD4DH
        icU0GDYxEjU3IiYmmFiJzE9XpUeSkDTJ1jKP
X-Google-Smtp-Source: ABdhPJzqbOvmhkSdE5pC+OznlCKPzPbyZsmpDc3bLWVNd5x9El+W6xy26udrkp4xe6FCnMU5f9GoMA==
X-Received: by 2002:a05:6512:214c:: with SMTP id s12mr21403103lfr.379.1635825320455;
        Mon, 01 Nov 2021 20:55:20 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id l26sm1568344lfh.247.2021.11.01.20.55.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 20:55:20 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id i3so10666208lfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 20:55:19 -0700 (PDT)
X-Received: by 2002:ac2:4e15:: with SMTP id e21mr33355238lfr.655.1635825319665;
 Mon, 01 Nov 2021 20:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
 <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com> <CAHC9VhS3LfGvuVyXW5ePTQNtQ0KeQ7vz3wLinoZrbGVjU6GuoQ@mail.gmail.com>
In-Reply-To: <CAHC9VhS3LfGvuVyXW5ePTQNtQ0KeQ7vz3wLinoZrbGVjU6GuoQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 20:55:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvZRaJSXirjcWKn75H-2H1tc54cru8p-vXE_2UyuvGNQ@mail.gmail.com>
Message-ID: <CAHk-=whvZRaJSXirjcWKn75H-2H1tc54cru8p-vXE_2UyuvGNQ@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.16
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 8:13 PM Paul Moore <paul@paul-moore.com> wrote:
>
> I felt I addressed that in the pull request cover letter, although it
> appears not in a way that you found adequate.

Yeah, it's actually quite adequate, but I wasn't seeing it.

Going back, I see that

  "The additional audit callouts and LSM hooks were done in
conjunction with the io-uring folks, based on conversations and RFC
patches earlier in the year"

So yeah, it was there, and I missed it. My bad.

It would have been good to have a link to said discussions in the
commits, or even just a "cc:" or whatever so that I see that the
proper people were aware of it.

Partly just for posterity, partly simply because that's actually what
I look at when doing conflict resolution.

I do obviously go back to the original email later to see if you then
had an example resolution (which I'll then compare against what I did
to see that I didn't miss anything), and to complete the commit
message. But in this case I didn't even get past the conflict when I
started going "but but but.."

> I felt the comment in the pull request was sufficient, however based
> on your response it clearly isn't.  Would you like me to edit the
> commits to add various discussion tags, is this follow-up sufficient,
> or would you like me to do something else?

This follow-up was sufficient. In fact, the original should have been
sufficient for me.

I just need to feel like I know that toes haven't been stepped on, and
that I don't have to fight a merge later..

             Linus
