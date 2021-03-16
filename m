Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E133DD65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbhCPTZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240397AbhCPTYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:24:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AFDC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:24:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s7so17422451plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=a1ue4t11OJbVivGpc6C3VCzhlUkhH8Mj6uX3JQk/WHc=;
        b=Nj8yYDluxqiAG+ej6jhoWTmPa96bXO9MvDia/puQbLS7/lpPxALfueZIRNjkZiCYCy
         Ljgk8A2MGIt5sqxHhcmGFj9bwRx66ATTPVkIOCfXJarh9XeLaTErjE/lVX2YPbMfkUTR
         weLoWOS0x3zLp07rZcrp0BhN98BIhcxt1Cq+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a1ue4t11OJbVivGpc6C3VCzhlUkhH8Mj6uX3JQk/WHc=;
        b=Z/bqBX0VUEHxUd8DekmtQK7LE3vmsFCO04fl5AnZMp2IncqP5gEUGLsb6LnVdjKYv5
         bl4G1iB5rxuKch+bEtIsT78+R36zqmuULVqg95rGqtiPHFpahQP7hUFZCVPiVR6uH/Zw
         Ja0UE5ptMaq92UKwXj/m15AfiCFv0bD3OypF7wP1HSZrCEFAcHQydEK5yd9hute0L2SU
         tUfU9pUUSnBo8swMeQl91sWLWkkBEA8RDQKj4vUeQK5+6O66O/Fhl2YcuNTLGuK/omit
         JkDE71H4JaP2zRNWfWKSreIa2+bHDYYXSd8R62OWtJ7a7JTTka2P913pgL0cE2+REtcI
         LC8w==
X-Gm-Message-State: AOAM533syNtGLf8klEf0XzffBH/OTooJ2HN2D4kxpAl7Kabzx25W7Olg
        NhYuKhd+1dfAvFLJA3lkG/0ssQ==
X-Google-Smtp-Source: ABdhPJxdA7UfbYsvEPf38xgnGsO41RyHj+iYp3b8oYOJD+h6SmdhD+HE5h/MgGyUxrpMOZysl7Shew==
X-Received: by 2002:a17:90a:b115:: with SMTP id z21mr594754pjq.162.1615922649291;
        Tue, 16 Mar 2021 12:24:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e1sm191065pjt.10.2021.03.16.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:24:08 -0700 (PDT)
Date:   Tue, 16 Mar 2021 12:24:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v4 1/1] fs: Allow no_new_privs tasks to call chroot(2)
Message-ID: <202103161221.8291CC3E6@keescook>
References: <20210316170135.226381-1-mic@digikod.net>
 <20210316170135.226381-2-mic@digikod.net>
 <CAG48ez3=M-5WT73HqmFJr6UHwO0+2FJXxcAgRzp6wcd0P3TN=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3=M-5WT73HqmFJr6UHwO0+2FJXxcAgRzp6wcd0P3TN=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 08:04:09PM +0100, Jann Horn wrote:
> On Tue, Mar 16, 2021 at 6:02 PM Mickaël Salaün <mic@digikod.net> wrote:
> > One could argue that chroot(2) is useless without a properly populated
> > root hierarchy (i.e. without /dev and /proc).  However, there are
> > multiple use cases that don't require the chrooting process to create
> > file hierarchies with special files nor mount points, e.g.:
> > * A process sandboxing itself, once all its libraries are loaded, may
> >   not need files other than regular files, or even no file at all.
> > * Some pre-populated root hierarchies could be used to chroot into,
> >   provided for instance by development environments or tailored
> >   distributions.
> > * Processes executed in a chroot may not require access to these special
> >   files (e.g. with minimal runtimes, or by emulating some special files
> >   with a LD_PRELOADed library or seccomp).
> >
> > Unprivileged chroot is especially interesting for userspace developers
> > wishing to harden their applications.  For instance, chroot(2) and Yama
> > enable to build a capability-based security (i.e. remove filesystem
> > ambient accesses) by calling chroot/chdir with an empty directory and
> > accessing data through dedicated file descriptors obtained with
> > openat2(2) and RESOLVE_BENEATH/RESOLVE_IN_ROOT/RESOLVE_NO_MAGICLINKS.
> 
> I don't entirely understand. Are you writing this with the assumption
> that a future change will make it possible to set these RESOLVE flags
> process-wide, or something like that?

I thought it meant "open all out-of-chroot dirs as fds using RESOLVE_...
flags then chroot". As in, there's no way to then escape "up" for the
old opens, and the new opens stay in the chroot.

> [...]
> > diff --git a/fs/open.c b/fs/open.c
> [...]
> > +static inline int current_chroot_allowed(void)
> > +{
> > +       /*
> > +        * Changing the root directory for the calling task (and its future
> > +        * children) requires that this task has CAP_SYS_CHROOT in its
> > +        * namespace, or be running with no_new_privs and not sharing its
> > +        * fs_struct and not escaping its current root (cf. create_user_ns()).
> > +        * As for seccomp, checking no_new_privs avoids scenarios where
> > +        * unprivileged tasks can affect the behavior of privileged children.
> > +        */
> > +       if (task_no_new_privs(current) && current->fs->users == 1 &&
> 
> this read of current->fs->users should be using READ_ONCE()

Ah yeah, good call. I should remember this when I think "can this race?"
:P

-- 
Kees Cook
