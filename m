Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7500F42E3B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 23:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhJNVmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 17:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJNVms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:42:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC16C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:40:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u21so29634203lff.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bc/19Sw3gCuiuNL5yxr53ROwuXXqpzpfHWWhYwbvjUo=;
        b=kJBigErm8oj6naJt86CzR6I4CvyMKAEXIVyQZPIrMf9IoLfG6qoK2Nq9bXwvpuHo2J
         Lg08sgiU6TkZK1UvhW0mdBh5Q6WXOe6Sg2Kim3mdWddM4s0AeL5swVZ9//9wagHv1vru
         dKFtjaT5p68KyiXkhio3E5UpjxsKFkLvwyorZ7jYbL0T4QtRHO+lqnrOGSBYfJQeEmAB
         flP3P3UXqw3OSfk2f7NqFdB1B0cqZ2wiR4JUYJa76vUInbAI10oirsmSkwmdO0WMoSJX
         BqqkLINBbUlLRUwRI8ft2z3Qk5rShAsQGnFJqE6kcQrS+pNAELb8WaTBBINwKDNZzja7
         5aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bc/19Sw3gCuiuNL5yxr53ROwuXXqpzpfHWWhYwbvjUo=;
        b=Da2IF14WL0UKjx3dPWYiA3jdRIbJgXlOHxI7v5lpDMRTnHyaXg+yACWVK8WT6zx9Mn
         cXMXgb4IULN0X202BlS+UUFgLQJkwRQlA89XQMR0b7/U9w9vVKWV43iAbyNPD5ayD1fB
         IMNeS35BtAs7iwjy++baLzBdlIIPamfhzLlSzjcC7h9a0PpGldY4+2G8FQuN17tr3bPm
         Pwx1YhWS/XWh1kFW6TUrzF4no6etU0L/wEHDqEh5XsxZtkdyU/SGGAWL4xf+K5LLobUp
         H7nMu0SYcbq9uoElRc0qXkFGx6YcQw09VaLSBZNFLNCADF0U/CCom8IiqtS1B1FPyuuS
         rDBg==
X-Gm-Message-State: AOAM533Iaos7CK4dRcOHTfZt1iHtYyk8x4F6SeBRRYI4mUCTU72uReK4
        WNwDVEcTVo0BTNkfmkN/RFI41ezwdNI5zhYUSmGTsg==
X-Google-Smtp-Source: ABdhPJxPLLk8qMtDlWK65ixYe3AxwSYOuLQWzgY8dPGbhyExlDVFcUshw6mboG8LnO3GIAmGuyVWP85em6Bc1cncdkE=
X-Received: by 2002:a05:6512:13a5:: with SMTP id p37mr7406070lfa.403.1634247641451;
 Thu, 14 Oct 2021 14:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211012165614.2873369-1-tkjos@google.com> <CAHC9VhQ6W=8rX6hryk_d+iTc90MAoZOw=KVDhjXsXE5Laccn_A@mail.gmail.com>
In-Reply-To: <CAHC9VhQ6W=8rX6hryk_d+iTc90MAoZOw=KVDhjXsXE5Laccn_A@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 14 Oct 2021 14:40:27 -0700
Message-ID: <CAHRSSEwjFicpr2=4S37KmVTav+aNQqFwy1eUo8r_z1OPSX1LFw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] binder: use cred instead of task for security context
To:     Paul Moore <paul@paul-moore.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, keescook@chromium.org,
        jannh@google.com, Jeffrey Vander Stoep <jeffv@google.com>,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 2:34 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Oct 12, 2021 at 12:56 PM Todd Kjos <tkjos@google.com> wrote:
> >
> > This series fixes the possible use of an incorrect security context
> > when checking selinux permissions, getting a security ID, or lookup
> > up the euid.
> >
> > The previous behavior was to save the group_leader 'struct task_struct'
> > in binder_open() and using that to obtain security IDs or euids.
> >
> > This has been shown to be unreliable, so this series instead saves the
> > 'struct cred' of the task that called binder_open(). This cred is used
> > for these lookups instead of the task.
>
> Hi Todd,
>
> I just merged all three patches into selinux/next, thanks for your
> help patience on this patchset.  Ultimately I merged these patches
> into selinux/next as opposed to selinux/stable-5.15 because I felt
> that a couple of weeks in -next before going to Linus would be a good
> thing.  I'm also not certain how widespread binder is outside of
> Android so I figured the practical difference between next and
> stable-5.15 is likely very small.  Regardless, all of your Fixes and
> stable tags remain in the patches so as soon as they go up to Linus
> during the next merge window the stable folks will be notified.

Thanks Paul. This all sounds fine.

>
> --
> paul moore
> www.paul-moore.com
