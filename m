Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCE8392E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbhE0Mrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbhE0Mri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:47:38 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B422C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:46:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e17so7242620lfb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xKdx9IwmtQ3kQh5FjyyZXmziMdiD6yFvHaxu3WVJTOU=;
        b=OCe1eTqhpk/j7vzfd9aZlzKirJb7I1JLrY8ImH2WvZOFGH/v+S2AIXlxk7bvDgd0ao
         oajmplfKMedpZYai9AbVD5BLCrbjBhZt/eQwq0Z8t3TePGPstfVOnYDUu1WQSBj6RWGM
         kffUdBjLLyeAT05Me+FA+NmQ26vyGFj9HKruo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKdx9IwmtQ3kQh5FjyyZXmziMdiD6yFvHaxu3WVJTOU=;
        b=sj+NVrQKvUiPT0XLlfyYX5+G5gI8q8C72wrcSn8XmzBQsiCxRwHs2hfNrz/kHOAuAA
         Z/lGvciULgjPs16uR85YppyrSvlGqoK1fg35Dt19HaRbicSLNNcgCAbcEPUovvmg2t+e
         b85h9Ur4ZxCqn7A4EjW9vmeNWKa2sRwOQAHUxskDuWxs0bEbDf4Xs6FGiXj+RlFXktOF
         6AsmrRVQaGfz5I9j/8cUBNKDfvgdgGd7nQ5LGVHq9VS5dg0IXdkMZoBn34o6+Piz+y4s
         5J4FLvOylcw5j0iIFwnsjgis43VXQlN5alf2yKhEXBQj3njIwVig/dIYuIRGGzpcdahy
         hwIg==
X-Gm-Message-State: AOAM531qYDR2vXmCHz5f7qlik4qHFWn2SDrNAzGTAP5ZWtTZ+RMBt+zn
        /fkgd04iJebbPkyKJWpzsq30hY7GBxr5i5np5tcnRw==
X-Google-Smtp-Source: ABdhPJy3whwMlWSGTmxRoY7Lh7GgFnV18098vFJxqUb7bVjCMYzFe8X5soQ1YfTDLIAGoFcF1uSdjdekAVFbhBUEVGM=
X-Received: by 2002:a05:6512:128c:: with SMTP id u12mr2265660lfs.160.1622119562570;
 Thu, 27 May 2021 05:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210527032948.3730953-1-keescook@chromium.org>
In-Reply-To: <20210527032948.3730953-1-keescook@chromium.org>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Thu, 27 May 2021 14:45:26 +0200
Message-ID: <CACaBj2atO=2aAyK+BO5MPS0B3CQNwc98CSHiuy8X2wvkdvJNDQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/seccomp: More closely track fds being assigned
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sargun Dhillon <sargun@sargun.me>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 5:29 AM Kees Cook <keescook@chromium.org> wrote:
>
> Since the open fds might not always start at "4" (especially when
> running under kselftest, etc), start counting from the first assigned
> fd, rather than using the more permissive EXPECT_GE(fd, 0).
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Nice cleanup, thanks! Just in case, tested it here, works fine. Feel
free to add:

Reviewed-by: Rodrigo Campos <rodrigo@kinvolk.io>

I can improve the selftest to test the new addfd flag we just added
also in combination existing flags (like setting the fd number to
use), and maybe also split the big chunk test, if you think that is
valuable.

Best,
Rodrigo
