Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA684334B23
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhCJWHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhCJWHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:07:19 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD1CC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:07:19 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id k2so19698954ioh.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yg0o3VoZc2Igrv2WKaYIdci4mKdYRYHXxP6y4sgjMk=;
        b=GDwL5+aEG8LzO+VLWexjdVnLbmtF53yrvXdPdWxdCFmMqml9Bh/Ab2NmG+tFjIdIxm
         n1606YRVDxLCTirQ/87COiOR/TK22acOukM8TYX+dxxfQsdEboOZd4E2ocQ1cvQRtQP5
         +UevCGAtwW5uEoEfAszU0YXaY8v/9vv0gcwBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yg0o3VoZc2Igrv2WKaYIdci4mKdYRYHXxP6y4sgjMk=;
        b=jRwZ4mQSVBk4NjtfUxOM/5EF0aSYi2ltcsfD6Sz1Ij0GRE1lJ9Y06wb7yd7xg+uoL2
         Yna5uLOabqmj9oqY9GVgbqGHXel5oj0LJNc8fZ+GuSqlg6xJIsTPWwQsWeKHz6hTBL8P
         hgI0jZH6ThNeFvVfR45m7YMwtnhRUglo+PkmoxkTjMgLm6x12A9CzsobkX4kUMAFp0vb
         hAwGMYyRgWYM3PqzDpcf/G4OwQ/tSiAKCKzh7hx18hAirfNCf96RNpS26kPaM0RNGqoy
         PwMuqQw1dHrRWkkD9mWHxQiL/mbMKYqt7XwhcX6JuvcRweKBMHSGzwGnKUcezQisL406
         MZ2w==
X-Gm-Message-State: AOAM533XJehES3FjN4IMQKjPhjctltX2QrOUIRhEu2DwIciIUJDV2qtk
        SMms9G2ko1WNHgek0kCkO7rcfVZ5pywJRcS8UsEYkQ==
X-Google-Smtp-Source: ABdhPJynxBXyPUtfZbglWNYNzJlVBNFfyQwZyF3CPiNZNAOYH8HRtWJYDRZOeUYQvGR+FDs0Wk7/pilYq5+EX6jQC6E=
X-Received: by 2002:a02:a303:: with SMTP id q3mr652085jai.32.1615414038764;
 Wed, 10 Mar 2021 14:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20210310015455.1095207-1-revest@chromium.org> <f5cfb3d0-fab4-ee07-70de-ad5589db1244@fb.com>
 <eb0a8485-9624-1727-6913-e4520c9d8c04@fb.com> <CABRcYmK8m21sb8dHbr1wLT_oTCBpvr2Zg-8KHwKuJ2Ak0iTZ_A@mail.gmail.com>
 <454d2e4b-f842-624c-a89e-441830c98e99@fb.com> <CAEf4BzY8kRBM578iV+xMZZxT7gKazMFGp5CZjvc1ueyd9vf3KA@mail.gmail.com>
 <CAEf4BzbZ+96_WRCyHQ8LVW7gvLouf2rT95Pt6vHPFu7uGqX=WQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbZ+96_WRCyHQ8LVW7gvLouf2rT95Pt6vHPFu7uGqX=WQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 10 Mar 2021 23:07:08 +0100
Message-ID: <CABRcYmKq0VzyZywSjHCo6vr8hqFGQz==u4Bd5qNb3pw_5i4G2A@mail.gmail.com>
Subject: Re: [BUG] One-liner array initialization with two pointers in BPF
 results in NULLs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 10:51 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Mar 10, 2021 at 12:12 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Wed, Mar 10, 2021 at 8:59 AM Yonghong Song <yhs@fb.com> wrote:
> > > On 3/10/21 3:48 AM, Florent Revest wrote:
> > > > On Wed, Mar 10, 2021 at 6:16 AM Yonghong Song <yhs@fb.com> wrote:
> > > >> On 3/9/21 7:43 PM, Yonghong Song wrote:
> > > >>> On 3/9/21 5:54 PM, Florent Revest wrote:
> > > >>>> I noticed that initializing an array of pointers using this syntax:
> > > >>>> __u64 array[] = { (__u64)&var1, (__u64)&var2 };
> > > >>>> (which is a fairly common operation with macros such as BPF_SEQ_PRINTF)
> > > >>>> always results in array[0] and array[1] being NULL.
> > > >>>>
> > > >>>> Interestingly, if the array is only initialized with one pointer, ex:
> > > >>>> __u64 array[] = { (__u64)&var1 };
> > > >>>> Then array[0] will not be NULL.
> > > >>>>
> > > >>>> Or if the array is initialized field by field, ex:
> > > >>>> __u64 array[2];
> > > >>>> array[0] = (__u64)&var1;
> > > >>>> array[1] = (__u64)&var2;
> > > >>>> Then array[0] and array[1] will not be NULL either.
> > > >>>>
> > > >>>> I'm assuming that this should have something to do with relocations
> > > >>>> and might be a bug in clang or in libbpf but because I don't know much
> > > >>>> about these, I thought that reporting could be a good first step. :)
> > > >>>
> > > >>> Thanks for reporting. What you guess is correct, this is due to
> > > >>> relocations :-(
> > > >>>
> > > >>> The compiler notoriously tend to put complex initial values into
> > > >>> rodata section. For example, for
> > > >>>      __u64 array[] = { (__u64)&var1, (__u64)&var2 };
> > > >>> the compiler will put
> > > >>>      { (__u64)&var1, (__u64)&var2 }
> > > >>> into rodata section.
> > > >>>
> > > >>> But &var1 and &var2 themselves need relocation since they are
> > > >>> address of static variables which will sit inside .data section.
> > > >>>
> > > >>> So in the elf file, you will see the following relocations:
> > > >>>
> > > >>> RELOCATION RECORDS FOR [.rodata]:
> > > >>> OFFSET           TYPE                     VALUE
> > > >>> 0000000000000018 R_BPF_64_64              .data
> > > >>> 0000000000000020 R_BPF_64_64              .data
> > > >
> > > > Right :) Thank you for the explanations Yonghong!
> > > >
> > > >>> Currently, libbpf does not handle relocation inside .rodata
> > > >>> section, so they content remains 0.
> > > >
> > > > Just for my own edification, why is .rodata relocation not yet handled
> > > > in libbpf ? Is it because of a read-only mapping that makes it more
> > > > difficult ?
> > >
> > > We don't have this use case before. In general, people do not put
> > > string pointers in init code in the declaration. I think
> > > bpf_seq_printf() is special about this and hence triggering
> > > the issue.

Fair enough, the only reasonable usecase that I can think of is a
selftest like the one I wrote for bpf_snprintf and the macro in
bpf_tracing.h will be a good enough workaround for that.

> > > To support relocation of rodata section, kernel needs to be
> > > involved and this is actually more complicated as
> >
> > Exactly. It would be trivial for libbpf to support it, but it needs to
> > resolve to the actual in-kernel address of a map (plus offset), which
> > libbpf has no way of knowing.

Ah right, I see now, thanks! Indeed this would be quite complex and
probably not very useful.

> Having said that, libbpf should probably error out when such
> relocation is present, because there is no way the application with
> such relocations is going to be correct.

Good point, it would have helped me notice the problem earlier. :)
