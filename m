Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68DF3C1723
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 18:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhGHQgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 12:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhGHQga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 12:36:30 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0044BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 09:33:48 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id a16so9888696ybt.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 09:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+N6yJhrKVzAV6EzzvHkeALUJQA7raNyNlriPWvwDzJo=;
        b=uL/aprqV0GpaJURyOuSoHGLrdr0GF/ar31hlT24uEjaBpgFDB9ULe4ZhVNN51P4+sf
         Wzk8Qmw1VzThxv8lE10Swu9V6XG5v8DXJsqfUkaSveY4vwrt1IWyGe+mN6QkX1MgG4cO
         w4Z00YXwzAemSOg0KNcDKmoZriZ07CosoQbS5Wahbi4kH2UmIopuBs8MwWTXN8JdxKTE
         G7wJ9zGuOoQctBR7v3gghFQv7EvLIDKRzIkZ6Tcgf1aNlDbUbIBAdPOnEddFa2ezOXDl
         HZBpON0RK7GDOSCjw7bMornt194LWyLaHlq0nY20C4dVQYMzR3b40/hHi44VLlVxaGOe
         MAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+N6yJhrKVzAV6EzzvHkeALUJQA7raNyNlriPWvwDzJo=;
        b=LZXuoJwNB8TnilDscdbrg8276un4c01785kwJ2gY/aPNVQntMkfQ7AdG7KHuEN9tnC
         u4h+9HuX90TzDXw6f6qjjr19YYUU+Yusd/cTH/FUB+fkvMfhZ6qRxW4JHkBc1LDrGfXc
         V8jCV7DCFs4YwzZ27saDuchtUDuPTUgqJN16eMvzK7GzAM0jMPV6knHsQ8ZT5h1WMJ/j
         H1wb2hh+5DHekO2oalo4grFLdav14cCVetWTKrhC2DVKmIKXptKpJl1IXA+Mh5xKDfLw
         MmICpv1HvN+/UKIL77qln+aCa0upqJm/t30ZUJA5ZXJ7qQoUDA/lXENd3/dvbjRkuvCj
         HZOg==
X-Gm-Message-State: AOAM532z2AKmQtcpI4E3EiHkvOEGIWntRTHFEOVdyLevqVj4aAM6Re1c
        hPE4RzEJmvuJWv/yVlu93h+s4FpytmqK2cvROeTP6g==
X-Google-Smtp-Source: ABdhPJx/TQqcHFH5WH2cA2qDD7wqdxVyNQjR1FyZ6W1kzpd7wIoyPAIJKHS2qcfSwEAfOm7CEjKzKrxgzO5RK+RKWZk=
X-Received: by 2002:a25:73c6:: with SMTP id o189mr12082809ybc.61.1625762027797;
 Thu, 08 Jul 2021 09:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210707162419.15510-1-cmllamas@google.com> <YOXdgrmXAMV1ys/A@kroah.com>
In-Reply-To: <YOXdgrmXAMV1ys/A@kroah.com>
From:   Carlos Llamas <cmllamas@google.com>
Date:   Thu, 8 Jul 2021 10:33:35 -0600
Message-ID: <CAFuZdD+Dp02teLP-k3wQMguob5oUpKhEN-yKs_zjzdffZxAP3A@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binderfs: add capabilities support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
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

On Wed, Jul 7, 2021 at 10:59 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 07, 2021 at 04:24:19PM +0000, Carlos Llamas wrote:
> > Provide userspace with a mechanism to discover binder driver
> > capabilities to refrain from using these unsupported features
> > in the first place. Note that older capabilities are assumed
> > to be supported and only new ones will be added.
>
> What defines "new" vs. "old"?  Where was the line drawn?

Any feature after "one way spam" may be added to the capabilities.
I'll amend the commit message to indicate this.

>
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
> > +{
> > +     struct dentry *dentry, *root;
> > +     int ret = 0;
> > +
> > +     root = binderfs_create_dir(sb->s_root, "caps");
> > +     if (IS_ERR(root)) {
> > +             ret = PTR_ERR(root);
> > +             goto out;
> > +     }
> > +
> > +     dentry = binderfs_create_file(root, "oneway_spam",
> > +                                   &binder_caps_fops,
> > +                                   &binder_caps.oneway_spam);
> > +     if (IS_ERR(dentry)) {
> > +             ret = PTR_ERR(dentry);
> > +             goto out;
>
> If this fails, you still report that an error happened, yet you do not
> remove the directory?  Is that intended?

Propagating an error in this case will kill the super block along with the
capabilities entries. At a user level the binderfs will fail to be mounted,
so anything created up until this point is removed.

>
> And where is this new file documented?  Where are the existing binderfs
> files documented?

oh! we do have "Documentation/admin-guide/binderfs.rst". I'll add a
brief explanation of these new capabilities files there.

>
> thanks,
>
> greg k-h

thanks,
carlos llamas
