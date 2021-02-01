Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F082B30AD12
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhBAQvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhBAQvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:51:38 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E44C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 08:50:56 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q7so4152864iob.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 08:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0q//F6ZP0U4h6C3Zdskf4kGUQLIK2PK8TU7pLmgs/wg=;
        b=XgPjQenGHfZeQHNjMJLXH7tiEIu7p8F1U4XRhzLrTVZwmzN7kAIaKVwqr2Sdcz5dFO
         wF00Qb+p8Z53/VVAkCJbQvTVnvHd3bOcerxmzrpGUYCE2taKHLRuAYw1LcQDxa3Qwso7
         8mBxGlxMK+0JJ+SDe2WdoMb/X3jG1GKDbVRJFdedFxhcGXSm8eVqW7UOmXIlN6WU/cVz
         YqkJH6pYYPqpkiAPcsVXhdVuHhJ2RC09lW0bhoPjfWMXIDYmH/rpUlARo5GhGEwxswkt
         hpAaQ5wpF0dYzHt/FKHzIhNHNvgD4FjYZAILhdF7aM/ZpSpisJ8zRGuTfSXKAL/xhCq0
         VsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0q//F6ZP0U4h6C3Zdskf4kGUQLIK2PK8TU7pLmgs/wg=;
        b=D4MoXm8NneLJT99vPFG2CIH17gEHKUY1P7S31g4zxR3pKepHPYZ2pkdZbDHCAmcFn+
         BetjtM08bAolWpTi9kociwWFXLF6YXnXy8Mbeb2luM8n/J8Xu2OLqJmL8JqDMLxbU29M
         NQt8cklyzFqhx+q1MO7C7IU/+IOKI3mzgq8ekf9xPj4mZN1+XjMzOYUBSagYasniobdu
         f7rQ7/VwklMgUpUdVVqvVqjaIHX3/dSdtJ0llgPi5SXCuxNqtTCsjFDQsaVHMSULNcwr
         gRjuDAW3lBORuAZ3x6DL60RzQSUwzPn9hAX6bw+/zI3ZHdunFJI+tJiawhi416lfgIRi
         Yl3A==
X-Gm-Message-State: AOAM532ZIHa7Vw6pSVHE77CP6rSqs6OU0MdYbm+Ov1EQpNVMY9uwuipJ
        7Y5UTxYQL39yj+mgWgQNJj1Iztsa02jEpkAgliw=
X-Google-Smtp-Source: ABdhPJx/nCxdkEX2xbEp9PrEgbMNtKW+kyE5zujTUhU19xGrlzGgyl2CYpPxjNBg90bgLCImXneYa9PAby5d1w4DxQA=
X-Received: by 2002:a5d:84d0:: with SMTP id z16mr4894724ior.114.1612198256195;
 Mon, 01 Feb 2021 08:50:56 -0800 (PST)
MIME-Version: 1.0
References: <CABJPP5AxB8-kafFEpsMydg8eMx8bH5ooT5g7r0fKWV2T2Hjtng@mail.gmail.com>
 <YBguQ/dENrfvtptJ@kroah.com>
In-Reply-To: <YBguQ/dENrfvtptJ@kroah.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 1 Feb 2021 17:50:45 +0100
Message-ID: <CAKXUXMwtXTYfs_9Asnmpd09zsucg8tRehMi2Shv8V49H-rs4xA@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] Patches from the future - can checkpatch help?
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 5:37 PM Greg KH <gregkh@linuxfoundation.org> wrote:
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

Dwaipayan, there are two ways:
- We build a bot listening to mailing lists and check. I like that
implementation idea for various other checks.
- Stephen Rothwell could include this as a check on linux-next and
inform the git author and committer.

I am wondering though if that is worth the effort, three instances of
a wrong date among 1M commits seems to be very seldom and the harm of
that mistake is quite small as well.

Lukas
