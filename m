Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B643382428
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhEQGWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhEQGWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:22:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B585FC061573;
        Sun, 16 May 2021 23:21:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i9so7004363lfe.13;
        Sun, 16 May 2021 23:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPO8MYRMBAA2HkZuMGPwQbW3GjmFXbW4z8o2wmyjkkg=;
        b=LzZP6tkhps6mIWWBVnZsE5IUWTcV/2XQKL0zDvo6ji1IbH1CDjcdmWTT70847zMB2C
         qup60cLCGqy1T4xI0Nn4afFWDjBfyUu68OXCgaH1kWVs9aPatU0L6j+37n9JEAdalR6W
         VjRLBytBDVg/yDjeKQcHyMmt1utZruJgQfLFYw01GaIH9oHahtcVvdFXrCJCWhAdKyzY
         av4rw9WbTkUAJJjqItco2ZP+FgWTaPcSWpELJzQzwbR7C5300BKndi9AR3eHC99pjM6W
         LYx2ffI2bbugKaS4My8BJnBHOlOcCtFkwnL2KQjnk1gnD2OChSqHzC72U6OmkBBiC6vJ
         BBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPO8MYRMBAA2HkZuMGPwQbW3GjmFXbW4z8o2wmyjkkg=;
        b=SHJ9q70HoEUhjM+7XHzd1d9TOK4iULFkUv1iJBqqVHPhwJ/pGrPdY2qheBbOk3kzZf
         WjSoYHNnTdsKvuJfVFH8Fl5zs050XJ36uOyN1cTeDe4X4iUxBXokZho2RFxYoacOYWA4
         bZ+rnatAsnBaWMVH9uZEBMAkM6nrbtJbDPGrTjtKkRJ0wYtKRfYRewDkO+IUYivyPGyG
         Kokmc85WfvKn9vPIARPbzTezUIrYEvK8u4maRwWrX6e3t1CA2gqFtY7cexGSYyylBjDt
         GelVIdSFgcmys20tR3ztGV2eJxhkhO/1lbHJwc40Ec9MHjbQrQzCvRDvcRpvmoETO5Mt
         m65g==
X-Gm-Message-State: AOAM530wrNoY4QDRDLUBk5jsMWRTPiL/wpEuilZ9ZDN/ZgHvvXDfNRzg
        ekWMgjaminu+WTQOgtDgOUQz31NVoKS998ayoZI=
X-Google-Smtp-Source: ABdhPJxpIJO8zf08T9tT91wZfPdBpytT/htslxH/athVYyMDm5E6aGmkDIivUzw9T3RtGkYFjAyKdNXFiFtuq2DBDlA=
X-Received: by 2002:a19:430e:: with SMTP id q14mr2140598lfa.117.1621232476122;
 Sun, 16 May 2021 23:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <1621224036-32092-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1621224036-32092-1-git-send-email-yangtiezhu@loongson.cn>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 17 May 2021 11:51:05 +0530
Message-ID: <CABJPP5DRw3pNs0da4HdCLXVHSa6sE88xJOO6C3c_oBESLoWq3A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: checkpatch: add description if no
 filenames are given
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Mon, May 17, 2021 at 9:30 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> After commit 45107ff6d526 ("checkpatch: if no filenames then read stdin"),
> if no filenames are given, it will read patch from stdin rather than exit
> directly, it is a bit confusing whether the script hangs, I do not quite
> know what to do next util I understand the code logic.

util -> until
>
> At the beginning, I want to print some info if no filenames are given [1],
> but as Joe Perches said, this is unnecessary. It's like trying to make cat
> without command line arguments emit something.
>
> So as Lukas Bulwahn suggested, add description for somebody that actually
> reads the available kernel documentation on checkpatch.
>
> [1] https://lore.kernel.org/patchwork/patch/1429026/
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Documentation/dev-tools/checkpatch.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index 51fed1b..181b95e 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -210,6 +210,8 @@ Available options:
>
>     Display the help text.
>
> +When FILE is -, or no filenames are given, read standard input.
> +

The addition is reasonable but the position of the text is a bit weird.
Let's have it after the Usage:: text:

-----------
diff --git a/Documentation/dev-tools/checkpatch.rst
b/Documentation/dev-tools/checkpatch.rst
index d4bb55723a86..7bf1e48207ce 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -22,6 +22,8 @@ Usage::

  ./scripts/checkpatch.pl [OPTION]... [FILE]...

+When FILE is -, or absent, checkpatch reads from standard input.
+
Available options:

 - -q,  --quiet
@@ -210,7 +212,6 @@ Available options:

   Display the help text.

-When FILE is -, or no filenames are given, read standard input.

Message Levels
==============
-------------

Thanks,
Dwaipayan.
