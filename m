Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9947434C7ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhC2ISe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 04:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbhC2ILQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:11:16 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE328C061756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 01:11:15 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id v23so3698861uaq.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KyXZAFuwOYhxAgXWFKTUrqvxhBl3gUV3leFB61HCCGE=;
        b=Xumd5+4iiY02rE2zcOAJB+hvoRfWyNtZuJ0zcw+wJCMyGjCptgWr2z5r1HFqrLi5GO
         N/MkUNwHM85eLan4SopgRe32hi+gs6fUrduTPM+icIRXgK0EPTAEBEXLaHRbnaffD4T4
         Pf0aCG0pKkZEq2aq43Te4618vuTwsw0HUBjro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyXZAFuwOYhxAgXWFKTUrqvxhBl3gUV3leFB61HCCGE=;
        b=AjRDbGlLcF0Mgzpq5uPekrvbCZ3DuqVuCzPtN/rNzU4XWyN6UfUE0zETtB7zIXdtRE
         3Y39TIvIpc8+G64a8rQ6LaB7FOWh2izp0gQb1uQd36sgxrnVXu963CSAinKn0eSMQAYQ
         BCK2UR6xhzsLc1GJ3XmdBJlvP4DFb6jEaSotBjssXPNyUdQoT6gqP5yTshjaxmZY/sUT
         KZlIJ2LXK+tu88z9aYFB1ptrBauT4JoEaxJYnpcDsI/vJRooCNYaYNi8D8Id1oqm/Ek1
         Os8CsMyPrn6IrJMsJA3+xymA0YVKSrecVxDYYSmqAmG5cglJYzZEqZiIN9kvd3So707C
         TLbA==
X-Gm-Message-State: AOAM532eQVlk1KX38hcRhM2im+zJfyx9HQGkfsAy6AhEvc0SKWzEIMZN
        opze/eP6ibZ8ZCYflPtxIY1GZ4QbleXm9oW4x4K68Q==
X-Google-Smtp-Source: ABdhPJzPIKwiQSw/m/LEZA7ulIDXxkFrI1xAiHGO82QoBBgyGwefB2SteAsHy5HvNE/woHJ2f4tLc64WjbPA4jyytGM=
X-Received: by 2002:ab0:738e:: with SMTP id l14mr13943357uap.72.1617005474926;
 Mon, 29 Mar 2021 01:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210325193755.294925-1-mszeredi@redhat.com> <20210325193755.294925-2-mszeredi@redhat.com>
 <YGDFxh7+724niztd@zeniv-ca.linux.org.uk>
In-Reply-To: <YGDFxh7+724niztd@zeniv-ca.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 29 Mar 2021 10:11:04 +0200
Message-ID: <CAJfpegsKkFV6yky8rm+XWJNKRChwvVR9NnuWzTCLreB3pf8X2Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/18] vfs: add fileattr ops
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 8:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Mar 25, 2021 at 08:37:38PM +0100, Miklos Szeredi wrote:
>
> > +int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
> > +{
> > +     struct inode *inode = d_inode(dentry);
> > +
> > +     if (d_is_special(dentry))
> > +             return -ENOTTY;
>
> FWIW - why?  For uses via ioctl() you simply won't get there with
> device nodes et.al. - they have file_operations of their own.

Yes it will: this is called by the vfs, not the filesystem.

> If we add syscall(s) for getting/setting those, there's no reason
> for e.g. a device node not to have those attributes...

Fair enough, but I guess filesystems will need to explicitly enable
support for these attributes on special files.

We can move that check inside filesystems now, or we can move it
later, when actually needed.  Which do you prefer?  (only a couple of
filesystems are affected, IIRC, which don't have separate i_ops for
regular and special files).

Thanks,
Miklos
