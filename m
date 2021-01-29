Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6F30833D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhA2B34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhA2B3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:29:54 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DD4C061573;
        Thu, 28 Jan 2021 17:29:13 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f1so10273156lfu.3;
        Thu, 28 Jan 2021 17:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9a+7oNJRCxFrNJOqccL2faO5Eau0vb9fXtZnpOrkLR0=;
        b=uPaqFT+3ZinDnW0ZgrzxVvIw+T4jYGaYOoHuLoKvr35YYy7OiroCIP7vXFFT69vGNx
         Anz9afbM6uJDpeZqGmDCDDIQeS6EozPlHfFxAeZmNritl8ftD2kgrffvA/XP8maaRnzm
         oMDba7gvxsbRmC64c9Ut0cJwaC9MSb0vTxrsu4y78C1iaHMnIBGCuDJzOUKoHL+B2wO4
         8cJX8DMPfnpBbdBk7linybIhK2rGv2cjt/0O+CqpLwjQwtYyBlCtvxmEDm1+axhQZRSm
         /BcEefd/KoicVDmX85wfNgKe9rAf7jJ3hDIR//z98gJi27uj6UCpuCpqlVP6PHK+GwHY
         3dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9a+7oNJRCxFrNJOqccL2faO5Eau0vb9fXtZnpOrkLR0=;
        b=ovWDWpN2JH3nTsBwYibu82fXWSL8YScJeG1xUwaYyf9be2YbLhCl3PgpB5XTmTbKwq
         HnMr9r6/61muXTyFiuldF993dL38vdZSqgIvEwJRjqlqeb/7tT5ccDhH6oqg/UjtIpK2
         D0d+gftgBJzOZyQ1yRwuqS9bs+z5NBE59nZlY4yIK0OZ1hIo4bCoh0qoc9JIFWmjU2q+
         bBnKqLGlK0mItKtNolSVOT/oQ/NzQwXk13eRpz6FvWXJOkTHG0ZrUiQtuYfCPM3XRdzH
         fo0kjAlatBqs298Kr0rihBXDHxgtDBEwqQdYV3wImGRxX5wySeID6cguTLujp3jgHKxy
         Hsaw==
X-Gm-Message-State: AOAM531Bql2yHrtL2MlnOFoMzDyvVGTilrCS9yFtu3ThotywSrrpioKG
        y/ElLmIzJRAqluwvhjs4aXQJ8rvQAiKi46CJtGk=
X-Google-Smtp-Source: ABdhPJwk+wTmFlhGzF/8Wq5stBatXQi5ZhZ4CiifprtDNeB9IAWTFKszWobd5Q09hqhvxkEoXYuHk0ZLov9FU/+O7OQ=
X-Received: by 2002:ac2:44b1:: with SMTP id c17mr829844lfm.556.1611883752325;
 Thu, 28 Jan 2021 17:29:12 -0800 (PST)
MIME-Version: 1.0
References: <20210126072443.33066-1-foxhlchen@gmail.com> <87zh0tg1bn.fsf@notabene.neil.brown.name>
In-Reply-To: <87zh0tg1bn.fsf@notabene.neil.brown.name>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Fri, 29 Jan 2021 09:29:00 +0800
Message-ID: <CAC2o3DL=831OcfpuCG5MU2Y9qCwa3LvRg101LuvKfeHTL6efxg@mail.gmail.com>
Subject: Re: [PATCH 00/12] docs: path-lookup: Update pathlookup docs
To:     NeilBrown <neilb@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, vegard.nossum@oracle.com,
        Al Viro <viro@zeniv.linux.org.uk>, rdunlap@infradead.org,
        grandmaster@al2klimov.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:58 AM NeilBrown <neilb@suse.de> wrote:
>
> On Tue, Jan 26 2021, Fox Chen wrote:
>
> > The Path lookup is a very complex subject in VFS. The path-lookup
> > document provides a very detailed guidance to help people understand
> > how path lookup works in the kernel.This document was originally
> > written based on three lwn articles five years ago. As times goes by,
> > some of the content was outdated. This patchset is intended to update
> > the document to make it more relevant to current codebase.
> >
> >
> > Fox Chen (12):
> >   docs: path-lookup: update follow_managed() part
> >   docs: path-lookup: update path_to_nameidata() parth
> >   docs: path-lookup: update path_mountpoint() part
> >   docs: path-lookup: update do_last() part
> >   docs: path-lookup: remove filename_mountpoint
> >   docs: path-lookup: Add macro name to symlink limit description
> >   docs: path-lookup: i_op->follow_link replaced with i_op->get_link
> >   docs: path-lookup: update i_op->put_link and cookie description
> >   docs: path-lookup: no get_link()
> >   docs: path-lookup: update WALK_GET, WALK_PUT desc
> >   docs: path-lookup: update get_link() ->follow_link description
> >   docs: path-lookup: update symlink description
> >
>
> Thanks for doing this.  I've responded individually to several of the
> patches.  As you can see from my comments, there is often more to it
> than just changing function names.  In some places you have capture the
> more general nature of the change fairly well.  In other places the
> result is incoherent or confusion.
> Making small updates to this sort of documentation is not easy.  You
> need to step have and see the "big picture", to overall story-arc.
> Sometimes you can fit changes into that arc, sometimes you might need to
> restructure or re-tell the story.
>
> This is part of why I haven't put much effort into the document -
> re-telling a story can be a lot of work.
>

Thanks for reviewing my patchset.  Yeah, sometimes it's difficult to
fit in the context and match the writing style. Most part of the
article is still valid, adding annotations may be better than rewrite.

Let me revise it and send in the v2, though It may take a while.


thanks,
fox

> NeilBrown
