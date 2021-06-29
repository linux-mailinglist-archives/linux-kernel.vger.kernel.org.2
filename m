Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD93B76AA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 18:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhF2Qvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 12:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhF2Qvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:51:41 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D406CC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 09:49:13 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id ay19so4873774vkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gs6ng6eXSeLBE7G02zVESPi05shOhO+DT8DF5/0FKo=;
        b=HDbdu3aMS8NbTPubgZ/GPenboxVpoxZtyjgzxgOoq3xf7iBcr6a8wCDn8tSZ8/dbFn
         4XhlroFvKZom9e8gX0Goj0Bh+oAUG/UoBWBFw1SVbQVBpUOTSzkjdZ3KfVjERMkcrrPG
         ts87Y7U8MvAUiBZNvd1mTUxQzlP23BXeW2YR+/NNeLUjypHPpQsn5mEOl65caIN3tIKj
         kddjXi+9yjrBPMGc6RPnz+7Fg7+IROBv2tEvea3F/GmUeSWGZC7ZwFMNp53cD8W8TsZT
         EFClJOfdDnpWfWGVO1s04mKTE4ULXFlOGCti+2frJ9J0Jd/8gscJ36W/qWHcjVerTvli
         QKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gs6ng6eXSeLBE7G02zVESPi05shOhO+DT8DF5/0FKo=;
        b=WutYK+bluIFGZ7besVeCV99Ru4MdFqVKCkqbvPt7yUcNaOP0xzDaqupwDOKIr2H7qS
         3EruhBt8DzaOTLMCuL3aUSWEQuuI7rqT+xLdC9LJo7X8RZtd1Tthi85C8Vgvt/gUjfXL
         ZY08rddqrlAiuHFeumztKXu+3XxBrjrj6YArP5ALwqmJNBRHEAw1mcTsMYLg+kOme1k8
         wvGKhAtfYqra37YHmAcFRBDGbwFNjOEuiS91l8LUrgLaCg17kdeJMecDkhGUD215t+Jj
         hRfEuEm9MQ1J26ay2QI94i1lNojUUhzTeuJUNAd/CJxlzMdQyjMh6+3F//LS6m0i1cVS
         F/wg==
X-Gm-Message-State: AOAM533szoIFEXSzcKgsTZxN64x7EGz95NwXtEGndXX1V4/pVqIxuqYx
        HEQuzbV/SOPKOtk9pSRmBnS2fbconkA9MmTTMz9IwOjSzMH7QQ==
X-Google-Smtp-Source: ABdhPJw+8HPPSWPTsuhEfVq2FqJD8ZwvvVpAvSCw41k8Hf0ed+tkoJVxJb40Fc8zgjAC4CoeM0E/MGfOGluZqZ7lIZ4=
X-Received: by 2002:a1f:290:: with SMTP id 138mr10727153vkc.3.1624985352970;
 Tue, 29 Jun 2021 09:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210626034016.170306-1-jim.cromie@gmail.com> <20210626034016.170306-2-jim.cromie@gmail.com>
 <075e07c40b99f93123051ef8833612bc88a55120.camel@perches.com> <CAJfuBxxzBevMJYSWq5feO20S4h_T-+EZoifOTYJ1NB4B+J1hqQ@mail.gmail.com>
In-Reply-To: <CAJfuBxxzBevMJYSWq5feO20S4h_T-+EZoifOTYJ1NB4B+J1hqQ@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Tue, 29 Jun 2021 10:48:46 -0600
Message-ID: <CAJfuBxywc=oc00F7b=dJU9y_vgrncCUYzvLNgM5VaMsuOiDAyg@mail.gmail.com>
Subject: Re: [PATCH 1/3] checkpatch: skip spacing tests on linker scripts
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Joe,

> >
> > This .lds.h test is also used in one other place.
> >
> > It might be better to avoid all tests in .lds.h files by using a
> > "next if" much earlier.
>

checkpatch: subtle decrufting

sub process() uses a next-if statement to end a block of tests early,
because following tests pertain only to certain types of source files.
That statement has some history:

 $ grep -P 'sub process|next if \(\$realfile' blame-check
 0a920b5b666d0 (Andy Whitcroft      2007-06-01 00:46:48 -0700 2558)
sub process {
 d6430f71805aa (Joe Perches         2016-12-12 16:46:28 -0800 3621)
next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
 de4c924c26504 (Geert Uytterhoeven  2014-10-13 15:51:46 -0700 3712)
next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 b9ea10d691ecb (Andy Whitcroft      2008-10-15 22:02:24 -0700 3973)
next if ($realfile !~ /\.(h|c)$/);

Commit:b9ea adds the early-block-termination line, then 2 subsequent
commits (de4c, d643) copy that line up/earlier in sub process (with
different filetype selection), largely masking the purposes of the
older/later lines (block-early-terminate to skip file-type specific
tests).

This code is hurting my brain.
its the combo of
3 different multiple file-type selections, each stricter than previous
early block terminate semantics
!~ (one more logical inversion)

commit:de4c   allows further testing on *.pl files
but commit:d643  doesnt allow those same files to reach that spot
ISTM this wasnt quite intended.

The 3rd/original usage still has some effect,
forex when a dts file reaches that line

How to resolve these issues ?
changing d643 to allow *.pl to fall thru for further testing
is probably the best small move.

FWIW, one version of a 1-line fix for *.lds.h files.
this one adds the new line after the 1st of the 3 blame-lines.
Maybe it should be added after the SPDX check (which would complain)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6469870837d0..1655d88fe5e3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3633,6 +3633,7 @@ sub process {

 # check we are in a valid source file if not then ignore this hunk
                next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
+               next if ($realfile =~ /\.lds\.h$/); # linker scripts
arent real *.h

 # check for using SPDX-License-Identifier on the wrong line number
                if ($realline != $checklicenseline &&
