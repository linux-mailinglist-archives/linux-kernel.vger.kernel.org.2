Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A22E43543A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhJTUAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 16:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhJTUAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 16:00:33 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CCAC061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:58:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id e19so12865ljk.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sg0o6MwSr5cVKhIKZL14YkinrZh0wp6xkfDKA7tp+7w=;
        b=FLcpWYGZhutnNkkuvkw53ygCMmmg9LwqTbT6ZB9EQ+0BzZdpzhVrWJpY+Ah74l6Fo3
         fKf8k8NzXJylaUyv4Ra6xGmCX2vWkERwH8CUBgfCgiM8z7LawcVJNAlJdfqFLr3ydLCn
         VVaz28NJzgchYxZ7U6J+aXnVc+mjIfIDWQ7Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sg0o6MwSr5cVKhIKZL14YkinrZh0wp6xkfDKA7tp+7w=;
        b=pGTuXscJqFwiwM4siu+QHaOUEYRHw+zGxqmFe9sFnZUyoFWqpacMY0isy2kJ1AqZMJ
         JvYk7oC1Zq1DCrwhiban0HR2ZZt3HF8eDtEP/MVLaZa5bTUggRVsWL1O5e7q6wvlS3Hl
         bcqXfJbW3tYrfFUbELLBn9OtAfAKB8K90BloWuU4qybj7l3BgbQQ2eS9ejmjeMmHj6rB
         dXUjySmzlWHda3HVWle5XnF+I6BDm1Mqt1tjXbg9/06wsCDfiHOJDrSewTup4T+r6a53
         yR0vb7KfQWljgzhrl+i9MlchiklGplG5K5qBrKDmb2SSSYUCRb01nsA9tDiJIajPTcN5
         re2w==
X-Gm-Message-State: AOAM530rrLE3Xm68U6zObS75n28sUw11wadXZufRDKlemx4BYZ0WhGQj
        o8uuRQ0foqCIvsy88CJtuMei9h+Tvzc23sTR
X-Google-Smtp-Source: ABdhPJzUToIWifU7FB7+D6YG5rAdXSKSuoe1gaUu6FH7UoNabijV6vUEoZnsRZd08u3espm1FYxsRw==
X-Received: by 2002:a2e:5c04:: with SMTP id q4mr1154418ljb.250.1634759896851;
        Wed, 20 Oct 2021 12:58:16 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id g18sm289862lfr.120.2021.10.20.12.58.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 12:58:15 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 145so14539152ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:58:14 -0700 (PDT)
X-Received: by 2002:a2e:934d:: with SMTP id m13mr1155978ljh.191.1634759894116;
 Wed, 20 Oct 2021 12:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-6-ebiederm@xmission.com>
In-Reply-To: <20211020174406.17889-6-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Oct 2021 09:57:58 -1000
X-Gmail-Original-Message-ID: <CAHk-=whjqWwo16jtLduxb+0nbNetp8jNAz+go01wB4HGKX=jEQ@mail.gmail.com>
Message-ID: <CAHk-=whjqWwo16jtLduxb+0nbNetp8jNAz+go01wB4HGKX=jEQ@mail.gmail.com>
Subject: Re: [PATCH 06/20] signal/sh: Use force_sig(SIGKILL) instead of do_group_exit(SIGKILL)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 7:44 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> +                       force_sig(SIGKILL);

I wonder if SIGFPE would be a more intuitive thing.

Doesn't really matter, this is a "doesn't happen" event anyway, but
that was just my reaction to reading the patch.

            Linus
