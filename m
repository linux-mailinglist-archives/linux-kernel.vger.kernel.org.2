Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBA336328E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 00:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbhDQWMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 18:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhDQWMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 18:12:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E2C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 15:12:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id o5so1975488ljc.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YOjTok1ja7/6itKWpyudalV8VLi+Uvt4/y+1cqETJo=;
        b=FQKwGiOW9jgCKW4PHPBlhmZgxF3YF8NmFeufKyHyndb7jrFHeDS3JL9KNJPkJFoNvE
         +9FKlJ/CaG594RSCuXcvE3Ci6VcuYJnXmwKXGRbTYaUXLp+qKvyp6Wa+WAqO+9sjDIms
         TV1RXrT+urloum+8BSf8sCC3MUupKvJUm7CPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YOjTok1ja7/6itKWpyudalV8VLi+Uvt4/y+1cqETJo=;
        b=NjFbokfvrrFbASkJcLIwpGfAJueGu3v61FCbJVebCtDowatZsA1eAJXtDwPG9G7NVR
         h9Bxl22LrQ74j3jLOrA8C2IJmemh38/blSXCjjAANwFfKNG4c8QwzbKtcB0R0/Sd5Iny
         8sAbdSjQEQQ88MIo59oiyJSfvmwZB/w11WIu499oSARRMTaoMxIjpOnOZyAa/BgoeRlK
         yisgXzAUI8kYovXVwr6uC4DnoqW1SdJqWQUZe6NTT2QGVDE/HbBS3omlu00jxrB9NMOS
         ODX2BOgcVe23yXq9UUHUK2OK1jMDxeq7YAUXSSStzne14cKJDydjxHbwYGmGOtCuLidX
         peXw==
X-Gm-Message-State: AOAM531qXB0OJaI+btsJvRLraNFP0TmfFYoiHXlB9wlMUnh5nkfIheqT
        yDE0BAWjyr492GzIXZJw+okqZrZeKVUs81DF
X-Google-Smtp-Source: ABdhPJyTZuHdWCP4LOdVE2bo3lzQO3+VBByaSy/+8adpUb+4YYMcUlgeZFH4x8yo8iLMR6G9U8j5aA==
X-Received: by 2002:a2e:9953:: with SMTP id r19mr6532417ljj.132.1618697526032;
        Sat, 17 Apr 2021 15:12:06 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id i8sm1383772lfc.115.2021.04.17.15.12.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 15:12:05 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 12so50022633lfq.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 15:12:05 -0700 (PDT)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr6968301lfo.201.1618697525005;
 Sat, 17 Apr 2021 15:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210416192413.1514419-1-eric.dumazet@gmail.com>
 <CAHk-=wjbvzCAhAtvG0d81W5o0-KT5PPTHhfJ5ieDFq+bGtgOYg@mail.gmail.com>
 <CAHk-=wgdyusj4Sz6zVOGvD8pNiYmPik3t4-o0TXB9cTUgz_0uw@mail.gmail.com>
 <CAHk-=wjYVZZpqDGH2Q=kMOyOqBhpbt8t8JdEWZHDGrPiV=_ifA@mail.gmail.com>
 <YHskaCSFOE1AYyoP@zeniv-ca.linux.org.uk> <YHtFciNvBWYJ0ku2@zeniv-ca.linux.org.uk>
 <YHtGhqBXhWlUHHRm@zeniv-ca.linux.org.uk>
In-Reply-To: <YHtGhqBXhWlUHHRm@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Apr 2021 15:11:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+8sz1kjpVnZ_MNbX0YNzGBXTTu4UyiR+1RWrFdbJ7Hw@mail.gmail.com>
Message-ID: <CAHk-=wi+8sz1kjpVnZ_MNbX0YNzGBXTTu4UyiR+1RWrFdbJ7Hw@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 1:35 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> No, wait - we have non-NULL buf->prev_reclen, so we'll hit
> with buf->error completely ignored.  Nevermind.

Yeah, I'm pretty sure I even tested that -EINTR case at one point.

Of course, it could easily have gotten broken again, so that's not a
strong argument.

That said, the "buf->err" handling has always been very confusing, and
it would be lovely to get rid of that confusion.

I don't remember why we did it that way, but I think it's because
low-level filesystems ended up changing the error that the filldir()
function returned or something like that.

         Linus
