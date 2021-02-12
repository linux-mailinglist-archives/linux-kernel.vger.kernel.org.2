Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBEE31A1C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhBLPfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhBLPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:34:52 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E470AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:34:10 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a22so12007298ljp.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=golang-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnSJrWIXDrR4SdgszlbiKJGOs4XpFQvM2/Z+tUum89c=;
        b=djI42P5xOLiLflD5ZImjvpowk0ziZM+eZsnGCAwDmZk5CS0w/I9qUmHpNeteIYu2vA
         Wc3wO+pot9h9Zc9LPmlVZyNQXi7FOPmChl2Am3cxco58YeEdOd/XenvXO46534gXG82t
         lIhETD7HBsX3ibtWX4YpNUZ6LFqxmKDKOgpW9HK8jcK0yP4XPZRVXEQaJOsFi/F6gCcD
         nrtWhR7VUn9J4wyYk81QW1IpmI7EsekEXy4RitZqZV5jOZOg3RlJ+lXTgnROalh/Z5tj
         b6LW09XNYZ8XBo0LTcYOzvbtCotRDey2na4EAExsnuSnpu3iN6wA9Dh9cdPH9bPYrACR
         f6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnSJrWIXDrR4SdgszlbiKJGOs4XpFQvM2/Z+tUum89c=;
        b=piMOHyE02W5J9eT7he3ZZPhyRBlpEnkO2+fb7KhUJyeiNtpPxy2oPoT1rzCdKbFG/6
         P8+yJh2B3XVqvYsTxS2nRDh/o7wwYVMMKEfNl4lV++dginhAx4pLxUCjYcrYuHFLQ/VX
         Fn+JV0feo3PHgC3sUtwnhnKX47dovcBXKFYtCQ/PrdosFcjZQe+STVT49+WM5QEhr5yg
         TgRznTbUP0CVtVe8vAWr3MCL5OAPopRBKT5RgY7p53LdJsfJU5D+yzv0YSMqbS53vEQy
         Ee1YKHzshkPhDAC2UUuyoKDu+KINoB+ZmFRthq+OnNy9D8BZz/GbnhkGDtsJJe2N9Fb6
         H37A==
X-Gm-Message-State: AOAM532/aUti700buWDh4yUe0Q1LJq9LyRpWYqFpzWNrhW4r+dPHu79s
        iCeZmiLzTUx9sjRdM5wnu8CazZA3CnFmtzm15aamag==
X-Google-Smtp-Source: ABdhPJyyof8JyS5LgslkTjPt53at92dLqvINeMxdzmqxXZ1pqGAxbiHWP+1K6bWY0NnL+6Lj25x/ZE/j65sHjSY478w=
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr2071178ljh.292.1613144049145;
 Fri, 12 Feb 2021 07:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com> <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
 <YCY+Ytr2J2R5Vh0+@kroah.com>
In-Reply-To: <YCY+Ytr2J2R5Vh0+@kroah.com>
From:   Ian Lance Taylor <iant@golang.org>
Date:   Fri, 12 Feb 2021 07:33:57 -0800
Message-ID: <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Lozano <llozano@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Why are people trying to use copy_file_range on simple /proc and /sys
> files in the first place?  They can not seek (well most can not), so
> that feels like a "oh look, a new syscall, let's use it everywhere!"
> problem that userspace should not do.

This may have been covered elsewhere, but it's not that people are
saying "let's use copy_file_range on files in /proc."  It's that the
Go language standard library provides an interface to operating system
files.  When Go code uses the standard library function io.Copy to
copy the contents of one open file to another open file, then on Linux
kernels 5.3 and greater the Go standard library will use the
copy_file_range system call.  That seems to be exactly what
copy_file_range is intended for.  Unfortunately it appears that when
people writing Go code open a file in /proc and use io.Copy the
contents to another open file, copy_file_range does nothing and
reports success.  There isn't anything on the copy_file_range man page
explaining this limitation, and there isn't any documented way to know
that the Go standard library should not use copy_file_range on certain
files.

So ideally the kernel will report EOPNOTSUPP or EINVAL when using
copy_file_range on a file in /proc or some other file system that
fails (and, minor side note, the copy_file_range man page should
document that it can return EOPNOTSUPP or EINVAL in some cases, which
does already happen on at least some kernel versions using at least
some file systems).  Or, less ideally, there will be some documented
way that the Go standard library can determine that copy_file_range
will fail before trying to use it.  If neither of those can be done,
then I think the only option is for the Go standard library to never
use copy_file_range, as even though it will almost always work and
work well, in some unpredictable number of cases it will fail
silently.

Thanks.

Ian
