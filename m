Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E644E4216BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbhJDSne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238772AbhJDSnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:43:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4151EC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 11:41:43 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j5so70620883lfg.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwJ/zqt7sCVRhAQt8F67ZvvrrYXFdM9l2jKuaNl5LS0=;
        b=LUR4W64exUR/2QSQyLmvt0Qg+ozzBVoUP6Ir/OwXr+Y58/Ozbxtfj+n4uU0QvL25JA
         8J7TylCgANqJIWzdCvlKzbyHZdEXNZzBhxpKZuF9iahd53ILHLEo2/ofwgi3gMrtfMjl
         Ba3huy3t86y8lN7PiTmzMpzE3En65qsJQM4v/g7FDyRjX8+R1Jf9IECVqE9vZzI/hDBN
         AmjITkODx9Dj9KGQckYNC0A969or6h8UodbfKHdOsLB35D7P2RdQ3zaMYjPmSuM5zjv7
         8nYRkkPSp0vrCfBKKu/yX4EO/B/4UIFLogF59BKMNsHd42otvan3VKR2iuDTclZcZG5X
         276A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwJ/zqt7sCVRhAQt8F67ZvvrrYXFdM9l2jKuaNl5LS0=;
        b=6y4VqsRiFX4mRighzxa4QPZ5XPhKldqsFPUSooTQ/nmelLnYoJIZ1jof90opIHDtZa
         rtN2HLWuX2zAMMh/lFOzrtwR8CpbKyaPGbHhyXgTTuztTPv0MC/c9h5WqQsALoFpVbXZ
         sLEKNlSGJGgFEGP7WD8bxegtLiaYWW381tWLeoW4+T0J/ESBbCqqMp2dTi6j1YL1nZO6
         w/5JS3OO5zTxe5Je5gakKGa0rF1KO1JNRhTwRoNPwff99H5/00A+L3iDdJM+HZ/+Ggpo
         jvyO9vdQUkZdAaXzsKTePJUO13Z2V2n0B+I2U4cMPJfJLcMagdDqmwu5sbbClaRzc89d
         oF1g==
X-Gm-Message-State: AOAM531HYZqix5kiUGcnDZFUJmB9JAU4d46SoVDvtOHZWKwPjyEepRzn
        YnA+PGNAPlCQH2IaaRVOIWeTv+dllxmPn2mYtEBfYbYts46CuQ==
X-Google-Smtp-Source: ABdhPJw+asFPWMSH80SAvR6koXsapJZuSs+lSQl7yQoIZSpX3lp6RGT9Nv91qu9aK+J2O4PtXyMREi2Gf5xqjfAHuR0=
X-Received: by 2002:a2e:5059:: with SMTP id v25mr17300074ljd.128.1633372901345;
 Mon, 04 Oct 2021 11:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <202110020501.RKX4zca7-lkp@intel.com> <20211004162936.21961-1-ndesaulniers@google.com>
 <163337043811.3396838.458236649388694225.b4-ty@chromium.org>
 <CAKwvOdm5bBUE0df8jbXq+bSCf9U0AM3Wm4NsZeHu=Nuhi0yd-A@mail.gmail.com> <20211004183806.5weyuk554ppe5olb@meerkat.local>
In-Reply-To: <20211004183806.5weyuk554ppe5olb@meerkat.local>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Oct 2021 11:41:29 -0700
Message-ID: <CAKwvOdkzviryHByOZj1K6r6HVKcC+4Tc43jXn4Eqk9EXGVpucg@mail.gmail.com>
Subject: Re: [PATCH v6] kallsyms: strip LTO suffixes from static functions
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 11:38 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Mon, Oct 04, 2021 at 11:32:43AM -0700, Nick Desaulniers wrote:
> > $ git format-patch HEAD~
> > 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch
> > $ git send-email --suppress-cc=body --to keescook@chromium.org
> > 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch
> > patatt: E: -: Not a valid RFC2822 message
> > fatal: 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch:
> > rejected by sendemail-validate hook
> > fatal: command 'git hook run sendemail-validate -- <patch>' died with
> > exit code 1
> > warning: no patches were sent
>
> Woah. What git version is this?

$ git --version
git version 2.33.0.800.g4c38ced690-goog

Looks like some corporate version...anything else I can to do to help
debug? (Moving explicit CC's to BCC).
-- 
Thanks,
~Nick Desaulniers
