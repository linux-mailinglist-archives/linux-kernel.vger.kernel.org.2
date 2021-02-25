Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29A5325542
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhBYSLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhBYSIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:08:46 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B090C061786
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:08:05 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d24so9911106lfs.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rj0OsYaNL34XbEioDj/Af/QfOoWUzIIX4i9RAcv1ZFg=;
        b=AKmQ/PwNRQXowoI7jUu6xYvVRJOCtwSnT8+QIWg0tFCHnyB2C7l7UvJDo48V+dGq1W
         vkN1eS9NAIJYUkBwgZaWuuswXJEPsgCIL+d92yFfZt0fPGco0R7LSN99JZT8OvGEOBZ/
         uLcPsWqjY+kvPAB5+N/H+VmK30sEW5cuixh/71u3VAVZRyu8yF7QXRxQDMvIS+/X8yn3
         jcO6xNQVFLk3D96j1tyQqRDneVlLsOA+NrkdutK44UbJ0cCEK24YaOtakHGzRLJ3AGKt
         hMuSolXtPlpv/P7S9bfTd3MlzUJHe4mKYqsB8dKqqYsSQQsy3mCcwFx4JJsRUoztcpZs
         vhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rj0OsYaNL34XbEioDj/Af/QfOoWUzIIX4i9RAcv1ZFg=;
        b=aUDj8RsJHv4O7LWHQAGXCWFzWpIu0ctDTLDRY3YKFnMc0x9y8ZFdEijBI7A+XIVgIR
         KN+yJGXq376byMN0RkyT/xE7eJ2voIBciERmlMq1ee4PuSkOjiLriCdscUWZTOMzBg4C
         UBmc/gjsc1BUhQuegYre3zgrbpqsCPuNhdvsuxhYwuZ8iaAxEgFBSZATr+zbuW7ZjfcP
         D8BWLhjMir+8kSRofd6eoS23hbpS9kmFyBzeQ47zvOLmyDBklJcSb6Z8mD/Y+G+ALfeS
         MKklFus2paW/v7qCwdZM4/FG8U4aAmesQZAPOwcUQsfsuSoU1Br1bJtr4ZCusgzUCLAZ
         /S4Q==
X-Gm-Message-State: AOAM533ZqUBw6VF2S7w440pC9eGI9pBIM8q8e/EOnkez9RKObRAleUUc
        PtedavGpjbUyi9iGSX0fwgoK9/eu2EfCiu+hKKQ=
X-Google-Smtp-Source: ABdhPJzBp9WAKL/MXPLAlb420Bf6OMU9LMbolckfnDjyuf4jlFqeYIq6CKaWAIh1AOxLlu6v8UZLsLhr4X+KSRZL+LU=
X-Received: by 2002:a19:c194:: with SMTP id r142mr2663295lff.342.1614276483823;
 Thu, 25 Feb 2021 10:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20210222075205.19834-1-dwaipayanray1@gmail.com> <bcee822d1934772f47702ee257bc735c8f467088.camel@perches.com>
In-Reply-To: <bcee822d1934772f47702ee257bc735c8f467088.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 25 Feb 2021 23:38:03 +0530
Message-ID: <CABJPP5AARO3h2mt-piPWuOD3kY_XzNfW-s2mi=btfOayVPURHg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] checkpatch: add verbose mode
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 11:03 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2021-02-22 at 13:22 +0530, Dwaipayan Ray wrote:
> > Add a new verbose mode to checkpatch. The verbose test
> > descriptions are read from the checkpatch documentation
> > file at `Documentation/dev-tools/checkpatch.rst`.
> >
> > The verbose mode is optional and can be enabled by the
> > flag -v or --verbose.
> >
> > The documentation file is only parsed by checkpatch.pl
> > if the verbose mode is enabled. The verbose mode can
> > not be used together with the --terse option.
>
> I don't have any real objection to this patch set, but as this
> might be added to the Documentation tree and in .rst format,
> perhaps Jonathan Corbet and/or Mauro Carvalho Chehab might have
> some opinion.
>
> Also I do not want to be a maintainer of this .rst file and
> likely neither Jon nor Mauro would either.  Perhaps you?
>

I could take it up if everybody is okay with it!

> Ideally, the patch order would be reversed so the .rst file
> is added first, then checkpatch updated to use it.
>

Sure, if Jonathan or Mauro has no objections to it, I will be happy
to resend it so that it can be picked up properly.

> And _a lot_ more types and descriptive content should be added.

Yes that's for sure. If this makes it I will try to get all of the
other types in.
And if Lukas agrees, a little help from my fellow kernel mentees will
be nice as well!

With warm regards,
Dwaipayan.

> >
> > Changes in v7:
> > - Add color coding support to --list-types option
> >
> > Changes in v6:
> > - Allow using verbose mode with --list-types option
> >
> > Changes in v5:
> > - Change the reference format to use absolute links.
> > - Print verbose descriptions only for the first time
> >   a message type is encountered.
> >
> > Changes in v4:
> > - Change the type description format
> > - Group the message types by usage
> > - Make handling of --terse with --verbose simpler
> >
> > Changes in v3:
> > - Simplify documentation file parsing in checkpatch
> > - Document a total of 33 message types for checkpatch
> >
> > Changes in v2:
> > - Use .rst Field Lists to specify the type descriptions.
> > - Add a few more type descriptions to documentation.
> >
> > Dwaipayan Ray (2):
> >   checkpatch: add verbose mode
> >   docs: add documentation for checkpatch
> >
> >  Documentation/dev-tools/checkpatch.rst | 525 +++++++++++++++++++++++++
> >  Documentation/dev-tools/index.rst      |   1 +
> >  scripts/checkpatch.pl                  | 133 ++++++-
> >  3 files changed, 639 insertions(+), 20 deletions(-)
> >  create mode 100644 Documentation/dev-tools/checkpatch.rst
> >
>
>
