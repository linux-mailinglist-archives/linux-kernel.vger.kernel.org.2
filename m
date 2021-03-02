Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7018F32A7C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839629AbhCBQh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351356AbhCBOQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:16:53 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0FCC0617AB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 06:04:40 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id e2so16886098ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 06:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKIPhQfsZni+86U7eT/CjC/gdypCfwjbiypiFzphvH4=;
        b=rqOtrilo+88HPgFYhOfQnS1v7z94Lr5BObD2hEuR6ILDox0IoCwksbv4VyYlIaGzeL
         tvTW5lzVYMwiA+AjpdlIRIiZ+BGgakFUIgcOGS4UJ0p8/E9MKPI9T+QXAcKXgBfKh3hg
         od4tD3EfJ9UvaaPTIGw47yuhSacH5YrgabNuKiB9zVtTeL+4mEtR1WzVSQtvvIUvIdX9
         sJ/cwEpuzelFyhe1V5WR1sFlWu/y2xM5WU6/yfhkj3PHl2EzHUyd7AOA3EP7KQ5vtECS
         fCIKoKxVEXDGTA5YMwC+SAIgrAyVso9925mq8zn7h+MsU+FI6oNNpfQZGxOaA+SmEGU0
         vE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKIPhQfsZni+86U7eT/CjC/gdypCfwjbiypiFzphvH4=;
        b=h26FP7tehwSNRn52MVt4xhYlWLkReipjb2gbAfgeQSB4NimQMbCGRyKLRIoTQbI9NN
         Ufk9FsalZETtPX9PDzaKIiYG1guBsWqqhMeQc5uELcj4X08Llx2E6sL0tiNbb5ZXxN4b
         Fy8LqzwK7uZobtWiTv5wP1wxmEw+Z2HIonhSHBVRqreYLOSmlcJHaCjoXPjQcvhX6Mu1
         El+qOggME2oaBE/rF3vpAlG14Fn9ta6vt+ZLmqxnrptBtuU9ATU+uWAWrKsuhl2+TlM3
         1AwjdH5ZDlY7Ui0RJ0SibYCr9SjjUhdircAAEURzg+7QPc7VgSAsCzkvjOqWnp2FbNyX
         ZjZA==
X-Gm-Message-State: AOAM531CJiE9PwYPQB8Nfd4fLETciVymzFd3R8/apt2zw8nYaNc87Byt
        UTES75Knuelz0crgHvn3Xfp7LNj1fmP2JXeXUypNxQ==
X-Google-Smtp-Source: ABdhPJwkuZvjQXJQ91dicLDXjkN3dz8z9r01lux5UTO5tuqK4Be/btKAgKd71suK/IkyBxGZ4e6kDT/v5KR8cw2TH7k=
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr3342913ljj.34.1614693878385;
 Tue, 02 Mar 2021 06:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20210302073733.8928-1-songmuchun@bytedance.com>
 <YD36+i1PZX/CH1jf@dhcp22.suse.cz> <CAMZfGtX=EmE8iOLfO3duCyMWOmu-OYra9Rk4mKsknds+5MueMg@mail.gmail.com>
 <YD4GkRnTN6RK5CyG@dhcp22.suse.cz>
In-Reply-To: <YD4GkRnTN6RK5CyG@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 2 Mar 2021 06:04:25 -0800
Message-ID: <CALvZod43npnPvsmVSfjEKy3HY-87TRx+jP1cntryUEGp2C47_w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix kernel stack account
To:     Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 1:34 AM Michal Hocko <mhocko@suse.com> wrote:
>
[snip]
> > Yeah, imprecision may
> > not be a problem. But if this is what we did deliberately, I think that
> > it is better to add a comment there. Thanks.
>
> Yes the comment is quite confusing. I suspect it meant to say
>         /* All stack pages are accounted to the same node */
>

Most probably I meant to say "For simplicity let's just assume all
stack pages are on the same node." but we can easily make this more
accurate.
