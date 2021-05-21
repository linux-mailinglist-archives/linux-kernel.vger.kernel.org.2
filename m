Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E241E38D178
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 00:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhEUW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 18:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhEUW1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 18:27:49 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFBAC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:26:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a11so21691513ioo.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/XkWG9p3vuThMnzF5+jHBK0yD8kKyiYj1CsPVcIZG2k=;
        b=NbxYYDnKLkoxAba68BqL9ZpD3lb2ScBJAQcY7Ca85CXetGoTwjl6vkFeBlTcN0YXWC
         cakB/2NABQKb7tNbJ2MKqdWXSJWkXwDc/wdJ8H7ra+iLPE55/qTgRwSHMrd07MrYUY75
         Kgl+MdH4q6qoh3P/D/eA9hwhI9aygyHy6++nMr5XZJFn3YbAGBkxb+ubQgrwI1dJD3OY
         9vRWqUhp82BhFUfhdlge9Gw7weWCJYd2vfR0waS4FJhMBieNYCihC9+e4aQthIz0cPw7
         nPcq/dSyh3TQ2iYZM3164IV6Hk3xNVVeEtw/KweHzEb/39DcVr+NmfeTkJfTD0gaB7bH
         HDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/XkWG9p3vuThMnzF5+jHBK0yD8kKyiYj1CsPVcIZG2k=;
        b=rZmcJhEfDov4OTavZbj9VOm+8hA4FRlqoNc74jMSDyKKwq9dIvPWzPvQB62O5sMCFQ
         N7wpYRgUVH2qKmjbTs3f2mxPx9GZBg9/BGqGDH9uTvUwNMFt/wTrYr2FfOYiWbJ9IizM
         FohzEa6kC9MteiscOSoEIkYuHmhL8fOio54DZu0fuejKnzggtsRiyuvjHkem/WKtNgv0
         qKifdUH/ugOs+FqE+YhLDwNH/BJA7EQ5Ku4yKSZHAJ1x1eBavVhiMDjSl5A0OaHhzphi
         EnAZ7x+4O0jI2uIXb8rOFVZTDt5ZwwaqvUInNgwDNoVKBpNkzX9aLj+s6nYtHanlmgxL
         Taaw==
X-Gm-Message-State: AOAM531DN5mtVxHVkFUooN7lDc5JbilHePMX0g/zJujsAdBMUCsWdsCT
        VBOeXybBLIm/PG2MGj0Q2Be4bJce5OUas+IhaFpwpw==
X-Google-Smtp-Source: ABdhPJzlwY4snWFXpxBlNWlDJVr5O/yWYAqwfXJReVJK7U77qf3035eHhy3r6Qq2WuRy8RNFs9VDtvKPjIC+Z+H1LKQ=
X-Received: by 2002:a02:aa85:: with SMTP id u5mr7968024jai.75.1621635984233;
 Fri, 21 May 2021 15:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210521221211.29077-1-yu-cheng.yu@intel.com> <20210521221211.29077-14-yu-cheng.yu@intel.com>
In-Reply-To: <20210521221211.29077-14-yu-cheng.yu@intel.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 21 May 2021 15:25:47 -0700
Message-ID: <CAJHvVcjsecq-nOVE1ew1ctG2UpK0F0d0MjNncUgK0L=R4eyDqA@mail.gmail.com>
Subject: Re: [PATCH v27 13/31] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems reasonable to me. The particular bit used isn't so
important from my perspective. I can't think of a way this would break
backward compatibility or such. So:

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

On Fri, May 21, 2021 at 3:13 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> To introduce VM_SHADOW_STACK as VM_HIGH_ARCH_BIT (37), and make all
> VM_HIGH_ARCH_BITs stay together, move VM_UFFD_MINOR_BIT from 37 to 38.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c274f75efcf9..923f89b9f1b5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -373,7 +373,7 @@ extern unsigned int kobjsize(const void *objp);
>  #endif
>
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> -# define VM_UFFD_MINOR_BIT     37
> +# define VM_UFFD_MINOR_BIT     38
>  # define VM_UFFD_MINOR         BIT(VM_UFFD_MINOR_BIT)  /* UFFD minor faults */
>  #else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>  # define VM_UFFD_MINOR         VM_NONE
> --
> 2.21.0
>
