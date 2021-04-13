Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716F735E1EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbhDMOxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhDMOxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:53:35 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B92C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:53:14 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id g20so8673482vst.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpBExCiZQlQf9v/ukxaQqC4noDhKnFApocLLkZan05g=;
        b=AE4Kwg+qjn9BXqj7AtlOnUMIVDmSIf4+8RPHjDrL+7Q4/2FPFk43jr0ryh2SJNewX1
         gTbWtTgr39JeqZL/27PXabWcuKZJyrVbY0aSrg5d6oWcYZLOqgYfcGBA9GD3yE+24FEk
         bJ524/31JiGvNYqcBZczVB8JHF8Sg+I/h6nMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpBExCiZQlQf9v/ukxaQqC4noDhKnFApocLLkZan05g=;
        b=OtEQUhtFHLUkgvuZkBxEscxdf5BTQLnekRLKUvZhHLA51fdTGP6JKqeyhDa8fV3tcM
         Y6AI+LP6laAbMmoQHaYQcPSa0gr3Yj8XXmWStDLk++o7Py6UjaYt7pK1czoqoyv62VRX
         alYauFHEnYoQ/NMehuRj6Hrx0IN8fhp4OgXPt7x/il3x0P58bu9i/FOI0V6y2Vof7GJe
         WeMDtHTux5ilcKKSGiK6wMW1MaaxIo8wZHzVlEuSLy5kboomXxmsZcPAzIzilhdiZzOu
         z1Dp2+IrN9fAJJJCE3DFyRaq0+5f3lhFininlY1Oc8X/o3+GcI1ya6VJ7AUS4wKZiSmC
         QA5A==
X-Gm-Message-State: AOAM533p7yksQDNNJ4f0xBkLgkPCQeZI+eYYYhjdPNQ5/4iV4FJijd3s
        8UKxRI9AViX3aVk55Y12txzgR+8xKbSNsux5uO3cXA==
X-Google-Smtp-Source: ABdhPJyK2wmF7sCncs1jt4t34+HmKqjg4ZPOu8kXNhYBq0UbUb8sg4DuOIarkxF7MP9BTwZkLJ2j+MD8Qa99ScQ6+5M=
X-Received: by 2002:a67:6647:: with SMTP id a68mr21372885vsc.21.1618325592663;
 Tue, 13 Apr 2021 07:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210325193755.294925-1-mszeredi@redhat.com> <20210325193755.294925-2-mszeredi@redhat.com>
 <20210413144502.GP2531743@casper.infradead.org>
In-Reply-To: <20210413144502.GP2531743@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 13 Apr 2021 16:53:01 +0200
Message-ID: <CAJfpeguoKOpfCy1cJhKu1gWk53c=Od5Siyag=reT=KC1kqEuxQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/18] vfs: add fileattr ops
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
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

On Tue, Apr 13, 2021 at 4:46 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Mar 25, 2021 at 08:37:38PM +0100, Miklos Szeredi wrote:
> > @@ -107,6 +110,8 @@ fiemap:           no
> >  update_time: no
> >  atomic_open: shared (exclusive if O_CREAT is set in open flags)
> >  tmpfile:     no
> > +fileattr_get:        no or exclusive
> > +fileattr_set:        exclusive
> >  ============ =============================================
>
> This introduces a warning to `make htmldocs`:
>
> /home/willy/kernel/folio/Documentation/filesystems/locking.rst:113: WARNING: Malformed table.
> Text in column margin in table line 24.
>
> You need to add an extra '=' to the first batch of '=' (on all three lines of
> the table).  Like this:

Yep, already fixed in #fileattr_v6, which I asked Al to pull.

Thanks,
Miklos
