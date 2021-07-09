Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8ED3C279A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhGIQfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 12:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhGIQfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 12:35:11 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBD2C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 09:32:27 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id b13so15581980ybk.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vO8Sr6hsS6w6E2PiDmqu8K8jLh8340IFcgCMK9Q53eg=;
        b=GXvKBVfbU3Q6MECdvqq54c6yO9nYvnkQsqBL/Drgc0ldCyNujDJlCHgVAsT3ZNPjx6
         Mnd7T3gW4T2VM3bnwYpJu8ganttdwGi3whFHJMYLEnDK4T5tUJLmpwyEF8KVm0ixULsH
         rkM2HmYcw1y8J6Ya6M2JNqud0hyRg+l2pNTqfHwzW6SCG7XLDoQqlSxydWRewSzHvc2l
         HZdmLoTlRxiFiVdB0hR+zPIWsd0hTUxSEcNKRYWKlB6CWy6VAxQ6+zQIs0K3IFIrRoRR
         R37FwqmnUD/+wvV+ZRKod9fpu7rRSCKMLAcPfq3byh/ZHuxrvSsQLefKQXzdpiSU8YdT
         yaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vO8Sr6hsS6w6E2PiDmqu8K8jLh8340IFcgCMK9Q53eg=;
        b=DbxGz+eudt/bUjqpcHLs6basj4bpOFpwCsPbt4j7XD+kuDeZWGuvXLbAlJZ5xElIXz
         KtO00PDr423IjaxwO2EZKsuMa5gAEO8koh3RMNYlsWvR1g6deM5ObSn1qeW6nFyECBrl
         92bATMlBZddtESc6nfuwEJbbTrYsmbJ18J1pmIjNFvHfW82yTnTkUz48pitCsjc6YBuC
         PkdQK/ItPuFjezY36Dim9LS7pdHLhGijToBpbzWBUAhkDckY5wulbCj6vxdIFxxkQW1l
         Mpw95+qkoFZ1XhG872ZotJCWrKcn5zLzlkQuy7K+EGHZWKqx7RYLPyAdcD83WyokPHHD
         qnww==
X-Gm-Message-State: AOAM5326Zvz/XMX2NXciuOtkw/59VN5K5jDQLm4zY02u5G3OcY2PH/+S
        mHschqHPFNCbVSdh51posjYx9NcuKOYv79VgP92GuA==
X-Google-Smtp-Source: ABdhPJxOw6+yvs4XrNvZ7Z1jaBQYfDJEpyCuTJWgTyZoEUxGY8U+apIzMlQ099hL5oMKWP+2TfF6Nu0AsbGb/tgJgBg=
X-Received: by 2002:a25:4212:: with SMTP id p18mr5274514yba.346.1625848346342;
 Fri, 09 Jul 2021 09:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210707162419.15510-1-cmllamas@google.com> <20210709085557.2bx2vojtyw23jzch@wittgenstein>
In-Reply-To: <20210709085557.2bx2vojtyw23jzch@wittgenstein>
From:   Carlos Llamas <cmllamas@google.com>
Date:   Fri, 9 Jul 2021 10:32:14 -0600
Message-ID: <CAFuZdDKxq-9MVPkzqsrXyNkZKqYCA7jjNU-Fpuzg7aHrhPqapg@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binderfs: add capabilities support
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Moreland <smoreland@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 2:56 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Jul 07, 2021 at 04:24:19PM +0000, Carlos Llamas wrote:
> > Provide userspace with a mechanism to discover binder driver
> > capabilities to refrain from using these unsupported features
>
> Hey Carlos,
>
> The model will be one file per feature?

Yes. I dropped a previous single bitmask file idea per Greg's suggestion.
The file per feature improves on a number of areas such as feature count
limit, readability and it's easier to manage (add/remove features).

>
> Instead of calling the directory "caps" should this maybe be called
> "features"? I'm not fuzzed about it and if you want to keep "caps"
> that's fine. The term is just a bit overused and makes me think of other
> things than this.

I have no problems switching over to "features".

>
> > in the first place. Note that older capabilities are assumed
> > to be supported and only new ones will be added.
>
> What if you ever want to deprecate one? :)

If the file for a feature doesn't exist then such feature is not supported.
So we can avoid creating such file if a feature were to be deprecated.

>
> >
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  drivers/android/binderfs.c | 45 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index e80ba93c62a9..f793887f6dc8 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -58,6 +58,10 @@ enum binderfs_stats_mode {
> >       binderfs_stats_mode_global,
> >  };
> >
> > +struct binder_capabilities {
> > +     bool oneway_spam;
> > +};
> > +
> >  static const struct constant_table binderfs_param_stats[] = {
> >       { "global", binderfs_stats_mode_global },
> >       {}
> > @@ -69,6 +73,10 @@ static const struct fs_parameter_spec binderfs_fs_parameters[] = {
> >       {}
> >  };
> >
> > +static struct binder_capabilities binder_caps = {
> > +     .oneway_spam = true,
>
> I know this is the oneway spam _detection_ feature but this file makes
> it sound like the binder driver has the capability to generate one-way
> spam. :) Maybe name at least name the file "oneway_spam_detection".

That's true. I'll rename it as suggested.

>
> > +};
> > +
> >  static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
> >  {
> >       return sb->s_fs_info;
> > @@ -583,6 +591,39 @@ static struct dentry *binderfs_create_dir(struct dentry *parent,
> >       return dentry;
> >  }
> >
> > +static int binder_caps_show(struct seq_file *m, void *unused)
> > +{
> > +     bool *cap = m->private;
> > +
> > +     seq_printf(m, "%d\n", *cap);
> > +
> > +     return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(binder_caps);
> > +
> > +static int init_binder_caps(struct super_block *sb)
>
> You can drop the goto here and just always return directly.

I also noticed this and I decided to keep it consistent with init_binder_logs()
structure. But I don't have a strong preference so I'll switch to
early returns.

>
> > +{
> > +     struct dentry *dentry, *root;
>
> Please name this "dir" instead of "root". "root" is conventionally used
> for sb->s_root and especially here in this file I only ever used it to
> indicate s_root.

ok, sounds good.

>
> > +     int ret = 0;
> > +
> > +     root = binderfs_create_dir(sb->s_root, "caps");
> > +     if (IS_ERR(root)) {
> > +             ret = PTR_ERR(root);
>
>         return PTR_ERR(root);
>
> > +             goto out;
> > +     }
> > +
> > +     dentry = binderfs_create_file(root, "oneway_spam",
> > +                                   &binder_caps_fops,
> > +                                   &binder_caps.oneway_spam);
> > +     if (IS_ERR(dentry)) {
> > +             ret = PTR_ERR(dentry);
>
>         return PTR_ERR(root);
>
> > +             goto out;
> > +     }
> > +
> > +out:
> > +     return ret;
> > +}
> > +
> >  static int init_binder_logs(struct super_block *sb)
> >  {
> >       struct dentry *binder_logs_root_dir, *dentry, *proc_log_dir;
> > @@ -723,6 +764,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >                       name++;
> >       }
> >
> > +     ret = init_binder_caps(sb);
> > +     if (ret)
> > +             return ret;
> > +
> >       if (info->mount_opts.stats_mode == binderfs_stats_mode_global)
> >               return init_binder_logs(sb);
> >
> > --
> > 2.32.0.93.g670b81a890-goog
> >

thanks,
carlos llamas
