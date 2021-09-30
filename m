Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A1F41E015
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352579AbhI3RYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352565AbhI3RYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:24:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF1DC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:23:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id e15so28421928lfr.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8Db515P2u3wr8eXpxbK+mdL07rAEGHZYTKLOrQ0Ezw=;
        b=BLudoU1R5T/CW89tzCG/kuhg5sdEQS1uJDH9zxbhJO16UL5oDpz87cOexihq6kA0GQ
         sfvfHJEXVSEKxpc4dG6OIUZ+biW+n9i/NjdbEc4QgrozJY5506juVmjJfXLkX6ZD6fh9
         D3o7GNWJEvwNHDxhF694ejAjzK1CpMMUJxxDWz7MxszI5XZPKG7F9YhYU/jzaA3hIcvJ
         AFbLyOIkHHZfNuL+z1mlniTqeo5VhnJfGAye/bZlcP43dq8u0O+K5qj+QHJA4e60VGIb
         f5CBFez0yMwbHYeNzDgpiSzFFPM4+N58pVNaALuRu1BkxWOq5xqnJlLdkOzUsfCw+ryt
         ODgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8Db515P2u3wr8eXpxbK+mdL07rAEGHZYTKLOrQ0Ezw=;
        b=yrbLrzbD5pLB6hvINqGAhqNTQ6RYfrv67T1jzxbY70Hw8n1pj+uBbxZjCssvTcETZJ
         HDx0UHPoSwFVQhNqYjFhgMHRY8ViAduInRwUF3cD6YILKN5VO8H4uK85ZOYtTp8pSRsS
         ogHelnxqF/ogoqCVyx8oSumfbFjDaP+R7qtwPGm/CzPB3MqaUZGzhgLy57H9C76/jN0x
         N230WMeroCGmACJ8vxUZsxG0Hp+igyODDY8CDvib0m/xwxQNY0+nfUghdjOnTAB1Tb02
         TNf0zGf7Ax8n3aK7VQLl7k0ZtbEMaATNiaMlOGGoGKw9znosVVwEiwC/IX0Xh3wSWbGV
         tufw==
X-Gm-Message-State: AOAM531lUZ5U7ovGvZwq4ugNejTpyphB1LAwv7e9JZVlG92ty5bHh/aq
        lM0c39FA2Fg2M8gXUUiYVzjojmm1YdDE9nB3grXw1w==
X-Google-Smtp-Source: ABdhPJyvjrJEB0rRbVB9O+YguaIBi4LthEutwQhoaWse0IUnkg0n/FYjG3RqA3+pw+y/Sq3ipUz9tZwJgyVXblJ7cmQ=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr393783lfg.550.1633022580476;
 Thu, 30 Sep 2021 10:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210930162302.2344542-1-nathan@kernel.org> <CADnq5_PBMGdUG8VMUQ2UOSdd9qXbZ7QoyGH2RTgUPnTjdzKqFA@mail.gmail.com>
In-Reply-To: <CADnq5_PBMGdUG8VMUQ2UOSdd9qXbZ7QoyGH2RTgUPnTjdzKqFA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Sep 2021 10:22:49 -0700
Message-ID: <CAKwvOdk56-7UQDs_EAn+WK397mnd5H7_JMrsjROPk5ZFCw2QLw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Return NULL instead of false in dcn201_acquire_idle_pipe_for_layer()
To:     Alex Deucher <alexdeucher@gmail.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:10 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Applied.  Thanks!
>
> Alex
>
> On Thu, Sep 30, 2021 at 12:23 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Clang warns:

Any chance AMDGPU folks can look into adding clang to the CI roster?
-- 
Thanks,
~Nick Desaulniers
