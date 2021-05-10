Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F441379682
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhEJRz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhEJRzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:55:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E356CC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:54:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2so24669411lft.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DBXjIiwreoSMBulhj9z8uemdOR1wtk9OGoK/dlXrlw=;
        b=kI1VsBmqooHdHR2wK2FW9Ig7MpJ6Jnv+jFiPsF6HkNbF+b8VVl8DmxTNTfP5pPtQ0j
         C8zlDuqgm/LpY1XPq7E4zUQF+oP7CNQOxUuqeu7z0rmWPZFLICPCptijhGZoFoUI0z1P
         HkpbxputLmAYvIty3BfaS3q9IUM57VE3AEcSHFdM7BZNoA74uJVuzUNAtKNxZQqzdWyK
         GRmIvjRxARlykjpWe3DKrjUD64qa1fEpTEaTDBpLus1aQawDnXIulbOhihD+9zVBG0MQ
         w//+PNR8qjOB9U2QX/JPuKXPlZS33XkTNz5VBENgXSJKkcJuCmhPnAb72HMK9sDuocaZ
         EMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DBXjIiwreoSMBulhj9z8uemdOR1wtk9OGoK/dlXrlw=;
        b=op4dXPJMWH52dtBDZXMUF/nSiaa7N5poEUf5XcuLE6DRxTOF8w9QZsHyRNhYZ8pNCj
         l/YPHPvN49LVq1Vo2yQr9qF5Q28V1tsLatqEVp+KeJy0nN8N6+x2mrBbUWgc2A3ltAvt
         M5YZKP4W40QsiPbEJX+kZstoiYYZTsPYcxxwGDTEf8g/We+ssrCJpssLSC92MZiExCHW
         LETYk4vMGipkr9nJ+77EcjljqqCmVVGIC0pAlFcq8BGC7mRwfJcy5qY+WEUJgmN8Ae3w
         WIy1PXQwICyzUIOsss8rTM/FeATMTr/vDifAwJS7YzOhHzBXZDeCAiPWHaS+2fJqKVQ3
         1WyQ==
X-Gm-Message-State: AOAM530sOD/FmcJGVb27UdVSbqZ46PLZdZbL106SsDmq07xpZRBfGw72
        UMf0iy0isJhgF8Oz2KJjVSpoisO47wkFHFLjJdMlF5nJiMNFkw==
X-Google-Smtp-Source: ABdhPJwo5TWc/WJMj1S2Zoc4U+lAbTeIU0HdWWA4HSEX93HD9gsFS/u34fNra0aplKIpc2fLmFcM3hmrUd20VVcAoPc=
X-Received: by 2002:a05:6512:1190:: with SMTP id g16mr18626589lfr.342.1620669254344;
 Mon, 10 May 2021 10:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210510171127.15056-1-dwaipayanray1@gmail.com> <630fc44bfb88f8d3d542c084c2d9f7c0a6d8aea7.camel@perches.com>
In-Reply-To: <630fc44bfb88f8d3d542c084c2d9f7c0a6d8aea7.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 10 May 2021 23:24:02 +0530
Message-ID: <CABJPP5BsSCH6ZX0M8_p2_QoSUZeq29e0VNFB8M2xkvafKZ6BGw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: auto detect codespell dictionary path
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 11:09 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2021-05-10 at 22:41 +0530, Dwaipayan Ray wrote:
> > The codespell dictionary was moved from
> > `/usr/share/codespell/dictionary.txt` to data/dictionary.txt
> > under the codespell_lib installation directory.
> >
> > Checkpatch still uses a default absolute path for it which will
> > no longer work on new codespell installations unless the path
> > is specified through --codespellfile.
> >
> > Detect the codespell dictionary path dynamically during
> > runtime if the default path or the user provided dictionary
> > path does not exist.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -889,6 +889,13 @@ if (open(my $spelling, '<', $spelling_file)) {
> >  }
> >
> >
> >  if ($codespell) {
> > +     if (! -e "$codespellfile" && which("python3") ne "") {
> > +             my $output = `python3 -c "import codespell_lib; print(codespell_lib.__file__, end='');" 2>/dev/null`;
>
> It doesn't seem to me that using python3 is a great way to invoke python.
> Maybe test the external command return $? when codespell isn't installed.

Sure, I will add that.
>
> > +             my $dictionary_path = dirname($output) . "/data/dictionary.txt";
>
> Unlikely, but this could still end up with a existing file of /data/dictionary.txt
> that is not a codespell file.
>

So does testing for the return status give us some guarantee here? The
dictionary
path should be relative to the codespell_lib directory, that's what
the codespell
people writes.

> > +             if (-e "$dictionary_path") {
> > +                     $codespellfile = $dictionary_path;
> > +             }
> > +     }
> >       if (open(my $spelling, '<', $codespellfile)) {
> >               while (<$spelling>) {
> >                       my $line = $_;
>
>
