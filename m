Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FBE43F926
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 10:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhJ2Iqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 04:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhJ2Iqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:46:46 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25785C061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 01:44:17 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 131so10932618ybc.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 01:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENq4tjivAFtiLBoYaEjwhbRErXjlHM0kRyDue+qYR8s=;
        b=wRn5p+8tRNX5KLoW5FWn6gbyOOsxcJsU6RD5Ia1CYcJmX4QNemi4NBR1v1FhdoFBWN
         CxzEwVaSfJD7rqFooBD/Xk8DgteDg2OUUabV1EX8aimjdrJa6wA1aCjfKcW7drJbuph9
         LpCWC5/xpF1SQ2oZ2hTFijmDbGaaRKaAbbKuEPD5WjY1TlU66NyhY7lV9voUwhJnMK0B
         VEYBn+ZvcEMzCajC4hlEkqV0gEFFAGHQgIjEsY03dS/B0Hc8vjltNuATxMHLgP5Jy/Qh
         sJV1y6dl9Y58Bu5jSugY84sgQssseEqzx5/2u+2Crw6wMAsPBg81y0o0xcYh23URjyqC
         /ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENq4tjivAFtiLBoYaEjwhbRErXjlHM0kRyDue+qYR8s=;
        b=V7tZ0d2u66OW3gXpVyA88v2QYcoFIJT+3DxX9lFjYWnHcGP4Ud+OZge8jNusWN5N0m
         4lxSxxSgL27YCWhE/tOOY7wTtqMXWSMN7eCZZ9ERStMfSZwWrUhaAHDTC6duV4lJHlAX
         JB5cvOTDKGcG1LqnWsIdInQCtyjxhbVsJOnLJbPjl/CoxIGXvKF8VFRzLuH4YwilZuoG
         ltcHF4gToS50whF4imUfb3VAS4J5SWBU4YE4v9e0qsuOZkFnoK0lTCwHJwKl4uQUxgB4
         OOWHRNWQcEW95Qm5zkuttm0V3YL3h00zipgzVuL2b35H3zrtb7QY2Y+F2NtarJ59zZIL
         41Ig==
X-Gm-Message-State: AOAM530JaBRd0KgkIW1lCf2eaI+9dKXvJC3y5KFjfg/Rgb/qSpeDU9Pf
        W5uoS0JjfsnD0X6Jny6tAkqxOf69rAQ1Tn9M2goMFA==
X-Google-Smtp-Source: ABdhPJxyHQR9n5o6twKULKxgFVOpVVXROEmQZR/EKRl6qL52zK8Dzfugbqjb0Ygz5V+6TXY8xU3LBGJ13typbBD3Iro=
X-Received: by 2002:a25:ad02:: with SMTP id y2mr10484185ybi.141.1635497056643;
 Fri, 29 Oct 2021 01:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211029032638.84884-1-songmuchun@bytedance.com> <20211029082620.jlnauplkyqmaz3ze@wittgenstein>
In-Reply-To: <20211029082620.jlnauplkyqmaz3ze@wittgenstein>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 29 Oct 2021 16:43:40 +0800
Message-ID: <CAMZfGtUMLD183qHVt6=8gU4nnQD2pn1gZwZJOjCHFK73wK0=kQ@mail.gmail.com>
Subject: Re: [PATCH] seq_file: fix passing wrong private data
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     andriy.shevchenko@linux.intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, revest@chromium.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 4:26 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Fri, Oct 29, 2021 at 11:26:38AM +0800, Muchun Song wrote:
> > DEFINE_PROC_SHOW_ATTRIBUTE() is supposed to be used to define a series
> > of functions and variables to register proc file easily. And the users
> > can use proc_create_data() to pass their own private data and get it
> > via seq->private in the callback. Unfortunately, the proc file system
> > use PDE_DATA() to get private data instead of inode->i_private. So fix
> > it. Fortunately, there only one user of it which does not pass any
> > private data, so this bug does not break any in-tree codes.
> >
> > Fixes: 97a32539b956 ("proc: convert everything to "struct proc_ops"")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/seq_file.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> > index 103776e18555..72dbb44a4573 100644
> > --- a/include/linux/seq_file.h
> > +++ b/include/linux/seq_file.h
> > @@ -209,7 +209,7 @@ static const struct file_operations __name ## _fops = {                   \
> >  #define DEFINE_PROC_SHOW_ATTRIBUTE(__name)                           \
> >  static int __name ## _open(struct inode *inode, struct file *file)   \
> >  {                                                                    \
> > -     return single_open(file, __name ## _show, inode->i_private);    \
> > +     return single_open(file, __name ## _show, PDE_DATA(inode));     \
> >  }                                                                    \
> >                                                                       \
> >  static const struct proc_ops __name ## _proc_ops = {                 \
>
> Hm, after your change DEFINE_SHOW_ATTRIBUTE() and
> DEFINE_PROC_SHOW_ATTRIBUTE() macros do exactly the same things, right?:

Unfortunately, they are not the same. The difference is the
operation structure, namely "struct file_operations" and
"struct proc_ops".

DEFINE_SHOW_ATTRIBUTE() is usually used by
debugfs while DEFINE_SHOW_ATTRIBUTE() is
used by procfs.

Thanks.

>
> #define DEFINE_SHOW_ATTRIBUTE(__name)                                   \
> static int __name ## _open(struct inode *inode, struct file *file)      \
> {                                                                       \
>         return single_open(file, __name ## _show, inode->i_private);    \
> }                                                                       \
>                                                                         \
> static const struct file_operations __name ## _fops = {                 \
>         .owner          = THIS_MODULE,                                  \
>         .open           = __name ## _open,                              \
>         .read           = seq_read,                                     \
>         .llseek         = seq_lseek,                                    \
>         .release        = single_release,                               \
> }
>
> #define DEFINE_PROC_SHOW_ATTRIBUTE(__name)                              \
> static int __name ## _open(struct inode *inode, struct file *file)      \
> {                                                                       \
>         return single_open(file, __name ## _show, inode->i_private);    \
> }                                                                       \
>
> Can't you just replace the single instance where
> DEFINE_PROC_SHOW_ATTRIBUTE with DEFINE_SHOW_ATTRIBUTE() and remove
> DEFINE_PROC_SHOW_ATTRIBUTE completely?
>
> Christian
