Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0057130EDA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhBDHp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhBDHpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:45:50 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF30C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 23:45:09 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e9so1318262plh.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 23:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgxkPUBlJj+m7PzcHNu0RuzFBoZ+BL1D5oU26v/3jtc=;
        b=dEOb1Bs1sP3/z5oYFbnSNfK2PIZUlSSt2acWLQ/74zn9vY+wUqfW/TAPGV3XtEGzKl
         1gsyUYF5VFvM5Rq20Z+yqr5sGHc97qGIVURk4P/y7NDwf6YsFrzysu6LaNlWuumgoWSe
         sYxTmRtMGnNJbKKJ+vAO2ZeUVPyayz8PvPwXfEQkdrXyh9k42Nsi9HxApzh2I4qzGuNd
         3vj6ysacX/ZnO63MNKDdq1Ue6U+jsit095NG/XgKhoRbfinXa5tOu20V4Vrqd0fAORvC
         gmPRw5PNOeGLLkQcCh+nEeezKc0NixIL/1WT/kKZrZKE5fEa77I6lnb7e7sV1D56PYwG
         JXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgxkPUBlJj+m7PzcHNu0RuzFBoZ+BL1D5oU26v/3jtc=;
        b=QbYs+XtCTlMOta6XER7GWe7Hz3T7RXYOSLgVo7Ar41RL59JhS/SJM5pY5Osviyfb8t
         2/P1fzPFcAZS6tqgLqYszp3q1MkSac4FGIRdaMhvxvbixfYMrhm3+MIHqKYj7DLCgNiF
         rGUOZtI9l4k6ok5vx3D8Akfv8dHoQQ4V+ON1Lt6nGI+ZAlNoeEZ59k3epUlDYjfOexw3
         rZCULK1k21APzxCahCZcjC7jdJCPbpXPWZgjEwhrhENgaHFJ2Vo9BR1sTJ9g0WdAmSe2
         Q9Ct5Uxd+SWFk0I/wyqg+y3QyuOa6q2MWkCwR8mGxmD45V9XUExH4UktwcIZ06vGydv6
         K8/w==
X-Gm-Message-State: AOAM530c2GkPQjxKfDIYozsignxDxDMDIBiMt2moCFbcIBvKj36yfkPy
        obtApAGbsvtW4jdAzg/B6LXK8QrYX4Q8jez/aJnq7Q==
X-Google-Smtp-Source: ABdhPJy05vgBYJxOXEdbRDVra76zNpviLVb46Q+2BWJB9L+q8Mdow/Rorl074tN+Fu/zU47B4SSfh0lp9AvwWaQHirY=
X-Received: by 2002:a17:90a:bf10:: with SMTP id c16mr7104915pjs.101.1612424709320;
 Wed, 03 Feb 2021 23:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20210204064037.1281726-1-ndesaulniers@google.com> <CA+icZUVVcP5MSUSDM18Wab46n-20eskRE59akdwfxXKpKXDOFg@mail.gmail.com>
In-Reply-To: <CA+icZUVVcP5MSUSDM18Wab46n-20eskRE59akdwfxXKpKXDOFg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Feb 2021 23:44:56 -0800
Message-ID: <CAKwvOdkYkgViVfzAn1J+SoSfzWn4aYVi+O3uwHhTsV92CVEeJQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Kbuild: DWARF v5 support
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chris Murphy <bugzilla@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 10:58 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> I guess I need to test harder to get a Tested-by credit :-)?

You're right Sedat, I'm sorry.  Your testing is invaluable; thank you
for taking the time to help and credit is a powerful incentive.

It can be difficult to know whether to carry forward tags or not when
a patch is revised.

Keeping track whether someone sent an explicit Tested By vs including
it based on feedback that implied they tried it.  If you've tested v7
or v8, please reply explicitly with tested by tags, or perhaps
Masahiro can apply those for you.

It can be difficult to know what's broken if you apply too many out of
tree patches though.
-- 
Thanks,
~Nick Desaulniers
