Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5EB332B97
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhCIQJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhCIQIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:08:44 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94CBC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 08:08:44 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id d9so14541585ybq.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 08:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=689xOchI/ah6zp0i6uvElTz+B+8kXLkkDTY5x4DUOZE=;
        b=SH4yTk303DzsNnZIptNW0bKPJ3or2YuDgJklTtQgbPUiiHgk4+WG4+2+TMvSVk92la
         3+X0Q84I2TjvB//SumHGxfU2pnDN2Z0APA3fRSe2wCDf3wy1WUhnbmre+sWMy418Kf7F
         8knjX3Be0mbSqEu02TyHXW+3GtzMfEkVfQ/I2W4YOWoyKY0FQ3QlPnGVo7opA84UJojZ
         PtwLe/yNlx+c2sFhSmFXN0eIdgnJAbhCixWjh9oRyL4ecf7Rg2jjiI2gIo7tMu0dgdLB
         czCnwXr3a1VYo2ShtAdij/Nsr5xwjrKpggJMJPZ+AoWBQIXYrvb+GwGvQr9zFUIMKMxF
         mWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=689xOchI/ah6zp0i6uvElTz+B+8kXLkkDTY5x4DUOZE=;
        b=XxufuoM8Si6/bUZO/GSlOn7N6IKjDq45nbE/oVjIpLUOEzzwLz4Ath3DacFJheHY6M
         Mr+dDS62A3AlelrLtHN1rUGh+ScJ+lyjhQuHdF8UjIGZQQju4YD/WnJAwNa54LP5zqx+
         vYzPnd9tV6sm0Ti7e8RagQM9TN/oon+49G6uNyXFHeRMXMNhwvg1n9ykhyds/ttO8rAP
         flOzwh3nrPIeMpx20gx0J58g5eapxrOddNsu3xTLm8VHFiq/81XZPpe5TDPt6udHcTKq
         x8yRWP7ozZyr+PyvacRpdG3OFDvTUcEx8osvMs8UXdqIJ7wo7v/HmJGPTU5ZEC0zCnQk
         QLxg==
X-Gm-Message-State: AOAM532Phr5kPVpyVt+MLfmH7oRu+kOyjqshrFfCAENTmdsm8bMOosz+
        jPQtH0zPeXAqGCm1tJgCjDDRqFgKNX8e4QXWAJlwsQ==
X-Google-Smtp-Source: ABdhPJxJoRn7pDzaCH0XVGwscn63NzmgI/9jKlzYT7ckXcNqN7dzcE6c3B3yWTXKPs6KuS9rxKcpmjzxCNmtEazJSV8=
X-Received: by 2002:a25:b682:: with SMTP id s2mr41053851ybj.407.1615306123734;
 Tue, 09 Mar 2021 08:08:43 -0800 (PST)
MIME-Version: 1.0
References: <1399790.1602853614@warthog.procyon.org.uk> <000000000000b9732805b1c970f5@google.com>
In-Reply-To: <000000000000b9732805b1c970f5@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 9 Mar 2021 17:08:06 +0100
Message-ID: <CACT4Y+aH0MrQu2c3fQfm8CD1sXzA5DhHKXLAqbPCjGKQjEoVJQ@mail.gmail.com>
Subject: Re: Re: general protection fault in strncasecmp
To:     syzbot <syzbot+459a5dce0b4cb70fd076@syzkaller.appspotmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Hillf Danton <hdanton@sina.com>, linux-afs@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 3:07 PM syzbot
<syzbot+459a5dce0b4cb70fd076@syzkaller.appspotmail.com> wrote:
>
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git        f25a7033ecb675101f8bc060a7c5fbe0c9076fd3
>
> "\tf25a7033ecb675101f8bc060a7c5fbe0c9076fd3" does not look like a valid git branch or commit.

Hi David,

Not sure if you are still interesting in this or not, but fwiw tabs
should be supported now:
https://github.com/google/syzkaller/commit/26967e354e030f6a022b7a60a7c9899ec25923aa
