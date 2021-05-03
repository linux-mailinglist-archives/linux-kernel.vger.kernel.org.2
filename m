Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A50372209
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 22:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhECUwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 16:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhECUwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 16:52:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ED4C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 13:51:41 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2so10058896lft.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 13:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QchQiqdMcNQVx97JOdVceYXer6ralkj9boXVuf2A0Nk=;
        b=DK1cvrYbhmCC9VBuZOKNbrdhPICJFNpQqZImiSGX0uUltQVSk1Sqxy1EbIQCAOkGYb
         0gkx1cKXd3YGCcU+GByfe5ZxjsbXfBiymh+8FqFONeC8DzLh/3u5/DXWuSuCOupaIzfi
         y+8fIZE15AH8dZ4EbLbXkL7SctvDm0WwtOhqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QchQiqdMcNQVx97JOdVceYXer6ralkj9boXVuf2A0Nk=;
        b=o35apSMI3bbUR06wovNWqaSyb5PFuGe86FTfpQcd1HXPWpJOQj8UXF22X8My0NwrNY
         E8boBfwGnoCdsk8EpqKoyLcDEltLml6ESctQss7QPecFbqFaB3iqE0gv/syvDw0vC8/P
         sl5HvPWUqABqwdFnSIA1dvLbzsqlCKN4Kj3WHpEpflcsU0rP21HTwiISX6dIXElb3LzA
         LUJdLutWWS012CRd5vGGvFsOVZPMpVVILriC+YZbQUtwNZ8n8jUaLbeXeZTW4txkDARr
         T7izm8kyViEeQGa8FD1ccb/dYuAMa7BLgL9EviyhmpyBLvF3Ves1Zup31ZoyD5YmTIDc
         m5kA==
X-Gm-Message-State: AOAM5336g+w2UrFSDV5Cp9t/gBN9qqcguhd0rFrynfR+7TgCpQFiedpk
        wg9/T8NPFPL7whLhA7/IAAdXnsKckv6tlPgjkwM=
X-Google-Smtp-Source: ABdhPJwiZqlZkDY6v7D/YTpF/owjFCekcuQ6RFBS6ZdvjrF+iXJkfMEfR8BfNogG6HfdiqLIxTvZ8w==
X-Received: by 2002:a05:6512:3056:: with SMTP id b22mr2758221lfb.526.1620075099495;
        Mon, 03 May 2021 13:51:39 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id e21sm1414053ljn.131.2021.05.03.13.51.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 13:51:39 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x20so10071665lfu.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 13:51:38 -0700 (PDT)
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr13913971lfu.201.1620075098436;
 Mon, 03 May 2021 13:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <YJBg7V02gxIRPrDx@ls3530>
In-Reply-To: <YJBg7V02gxIRPrDx@ls3530>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 May 2021 13:51:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgx8Y8zNCfYNxnYNwaTg5mHcqkJhHjk=eKLCGfgXKp=EQ@mail.gmail.com>
Message-ID: <CAHk-=wgx8Y8zNCfYNxnYNwaTg5mHcqkJhHjk=eKLCGfgXKp=EQ@mail.gmail.com>
Subject: Re: [GIT PULL] parisc architecture updates for kernel v5.13-rc1
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 1:46 PM Helge Deller <deller@gmx.de> wrote:
>
> please pull the parisc architecture updates for kernel 5.13-rc1 from:
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.13/parisc

Ooh, and with a fancy signed tag. Thanks, looking good,

          Linus
