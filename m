Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646E330AD51
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhBARC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhBARCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:02:16 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9E0C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 09:01:36 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id e18so20474813lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 09:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9D9BjQCsP/BBIIM4bFem5G7Ivu76rlT1kOYtUbgHA9U=;
        b=OBG6OcX195i3qCdWRo3LO225VOEQZbfV2XFNhFqRSKDIYuI7GKge1Ixfdq91BOkkCN
         msEi9S2B3bIrjyNikLHfBTpoGGuq6KH6GxRSEQcMz+9vnq4jNQ4mxYHpqdbqrXv4iE1B
         +XsRnwh+RRaElaSxHF7pc79kmawuWFgU5QxpHim1bm5ctRmF6zkR5YiI5Fk6lhieEsO8
         JzdU8RsxTV8MdLY5/57mSOnN2umS2UNQSan5kd38R276ANmdY3xUtJJuXEJVN000MdAA
         4SAqeGtEc0TUXBG9+3bYV+1e9GOz8TmEAMyH6IS4cQKu3owYCW3v6ldmBsBzWpdjzEW6
         r0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9D9BjQCsP/BBIIM4bFem5G7Ivu76rlT1kOYtUbgHA9U=;
        b=jS6IDdluUoocZn8P3n0q4hlzrAmXQHFYogsKoQfEIi7opeiACfLSECw/E+FF/ZcGZj
         JIYLfA8xUe2ugPZixdDP7ob0gycmuruYbq3+57j4MAqta9+99Bu7Bd0OMZAIh82QTcZq
         39BhC0dMO9jtg/zYKQ8b5Oy042KVZxU+uIqjM4RpXskrgPz6Y59m0Qc2sH+ZgNVsNo/1
         +hEfU3CZiucyYiBmVsyebBmtGrZ2y91oTN0+wGIW8JcUc9JcnxuZVQQqPUacY7oKLOcf
         gSPSLLajDG9Y/M3zf1iMQWu14IuMs1qq8iqLqXxqKB0dwcPFDhvYZ8Y4TgM7wTwI1DlF
         1ADA==
X-Gm-Message-State: AOAM532G2R8QCosFSaprr/6q47x/23eRSeUuD3PRfm6y04qTlTeyJbDK
        3WFhwlREWk0KR/fGJfTWSWTHBQtPg+yp/syIVRQ=
X-Google-Smtp-Source: ABdhPJwbihW7q+v0w8MC26mCCXinKx9e4nlaayM1Qm04O4/K+BQt+9v55XEH3B5zESt/9GCAp3yx9bg44b51/FE3jb8=
X-Received: by 2002:a2e:9789:: with SMTP id y9mr10555804lji.482.1612198894409;
 Mon, 01 Feb 2021 09:01:34 -0800 (PST)
MIME-Version: 1.0
References: <CABJPP5AxB8-kafFEpsMydg8eMx8bH5ooT5g7r0fKWV2T2Hjtng@mail.gmail.com>
 <YBguQ/dENrfvtptJ@kroah.com>
In-Reply-To: <YBguQ/dENrfvtptJ@kroah.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 1 Feb 2021 22:31:33 +0530
Message-ID: <CABJPP5Ba9pDJco16R0CfcpXZedT7vPx_Md9QTRX=y_guQcwLww@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] Patches from the future - can checkpatch help?
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 10:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 01, 2021 at 10:04:01PM +0530, Dwaipayan Ray wrote:
> > Hi,
> > on linux-next,
> > $ git log --pretty=format:"%h%x09%ad" | awk '$6>2021 {print $1}'
> > gives:
> > 4a2d78822fdf
> > 12ca45fea91c
> > 09f2724a786f
> >
> > These are patches from the year 2085, 2037 and 2030 respectively.
> >
> > Would a checkpatch rule be helpful for these or are they too
> > isolated to waste runtime on?
>
> Dates come from your email client, not the patch itself, how is
> checkpatch going to catch this?
>

I was hoping that the maintainer could catch it before merging it
into his tree. Dates being a trivial thing might slip human eyes,
but checkpatch might detect it there.

Thanks,
Dwaipayan.
