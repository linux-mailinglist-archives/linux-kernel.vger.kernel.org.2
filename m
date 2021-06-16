Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43393A959D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhFPJNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFPJNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:13:42 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A988C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:11:37 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 12so457976vkk.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jiD8Z4XvGnBbwGrshb7UXxHT652dqAyMkCuowMB3MT0=;
        b=nmmxCvEXPxXX714K3Ah58M3prp7FPXm5e0dbGyXk+UgncTPwPlVXjXsXU08PpM8eus
         H2zwAYPoDsUexMBqU2+Iaj0cMPUzXmcyCxrPE2ceTieDAjlYVPw7LMj+m5qVLkDvN3fL
         LrB8P3AMMg1jl0L34uchh+aloIhljQlPmNMUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jiD8Z4XvGnBbwGrshb7UXxHT652dqAyMkCuowMB3MT0=;
        b=HB0FL9F7HFNVFEIyYiNg+zkuPANUzMIihmz6KTqAU5D4wydfPwDNiN8/GqfrXKdRYH
         uRsc1Lw4gUFBJZXpdEfqQIdE3Xd6lvIXHL3u2LrSqAqlDcqge1cgkcES70d2Nr6+JZ4H
         dUYbHIM+gv/9YvOnWMVtk/8240bYPOog4rWsDxBTQJvsqMCmARjvTyejIjnivvdGR+FK
         7OYkA06BwvRFt4obsTP7vbbT18YXygD/6Wy6NJuuR1w4JnJknKBHHr7O23uncwidROwL
         o5Wl0f2ilZkeXJr+bRCautL/lNzrDCmKoTjTGDvK0mBO747Cu8tG6xtZRYFzLmwOVSOx
         AtKQ==
X-Gm-Message-State: AOAM530xXFub5xBX8BMNNrsoY0MstwACqxIsRxqeWbM/tSw5E+FnqZvT
        PbjoZd9gkzn43+Lx6GKlHGLX+f9kjH0iMfIq/9L3zA==
X-Google-Smtp-Source: ABdhPJyZ8Fh4vDeTPBSXAyBN+qYc9L8PH55Fh2rEBhC5gLAKhWPXbJkX/QSaqRzQ2faLmW7Rl9wn1UqCRaAbYMplXwo=
X-Received: by 2002:a1f:90c8:: with SMTP id s191mr8299008vkd.3.1623834695969;
 Wed, 16 Jun 2021 02:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
 <162375276735.232295.14056277248741694521.stgit@web.messagingengine.com>
In-Reply-To: <162375276735.232295.14056277248741694521.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 16 Jun 2021 11:11:25 +0200
Message-ID: <CAJfpegtgXvW+vyKQEvQauSXskYiO+GAjViDYo_84sa23eWCjdw@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] kernfs: add a revision to identify directory node changes
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 at 12:26, Ian Kent <raven@themaw.net> wrote:
>
> Add a revision counter to kernfs directory nodes so it can be used
> to detect if a directory node has changed during negative dentry
> revalidation.
>
> There's an assumption that sizeof(unsigned long) <= sizeof(pointer)
> on all architectures and as far as I know that assumption holds.
>
> So adding a revision counter to the struct kernfs_elem_dir variant of
> the kernfs_node type union won't increase the size of the kernfs_node
> struct. This is because struct kernfs_elem_dir is at least
> sizeof(pointer) smaller than the largest union variant. It's tempting
> to make the revision counter a u64 but that would increase the size of
> kernfs_node on archs where sizeof(pointer) is smaller than the revision
> counter.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
