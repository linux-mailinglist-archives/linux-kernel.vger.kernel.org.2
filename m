Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DEC3827EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhEQJN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbhEQJLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:11:22 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4E0C06138B;
        Mon, 17 May 2021 02:09:56 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e190so7534374ybb.10;
        Mon, 17 May 2021 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrgZec0+5t9wx/OB//pEA28lTQmQK+5O6iq1XmtvjvI=;
        b=qPr5+iua63pK72Sch15KQpYV7uXzedr9OzNEtTBpMTpOOoww9iop1osq7x/rS9AsMO
         apPCLr1fShpqzcc8aZFChB0i06lw+oCAtcTDhPhvpru8CoUPItfs1M32PobSNUUnVERR
         bLC4knhu8WiIQAu+XQ2rFgkVf7hcIK7lLCY1mFPJRrtGmzf3wSsRK96L5DAbCOBez8RD
         IhUMUWCoHHZ0kDJfrftXbIzdFrXzUbXO7+6gh4R7yzbYOOkf/xFOj7qzN2NcB9pgxtdX
         886AY31FdsuT7kUfdqxfUew5GbkrE73D9OT/4pshHEHhqkRUBLwN3yAiPf9lriccWkAa
         XF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrgZec0+5t9wx/OB//pEA28lTQmQK+5O6iq1XmtvjvI=;
        b=MgBq2E56mWcdNnDvdhC7RS73GrJJRNBX/SmwxtcWhaJPoEK+yml8klbXWmd4jWAqet
         Zta1vuKPOZQoQ6Jc+YO/cefo0ShWRR4/BDow9aabaT7YDbRfQ4+STedayFaJ547/ufxD
         4O8yAM6YDnd/IOsnxmImS4JLag9bA59EM1mBpCKDf/aUHDSuSV65Mo02Ri1x+K/KVl7l
         u8oaddAcgbSmL8z7DbndzLBivcd/p4PktJmON3dCQXiktGSmjdLghi+X5vTwZHGrvQH7
         n/T3qH4CMJc/AvMpNBMK84Dfx+YDtOjhEZv9F2ASE5IZ+PcFYMNfHemliAT7uU5MgcsC
         8JGw==
X-Gm-Message-State: AOAM5318rZ/kHfqH4+bJLJefm6puCj9fOFR/qE4OO0KcUuPf6CRGDUEx
        5Y0L4hrPMCQ5ykiIttymXSBs8uKygyswUM2IuFw=
X-Google-Smtp-Source: ABdhPJz4wvDFxS+D5dRKo35ALQZOaOLYRpoJf8tcNqZTOJyPKo2Mcn8JT5ElOBcWINTj3ohoKZKTDRsGST5mbSUqRIk=
X-Received: by 2002:a25:e006:: with SMTP id x6mr83870529ybg.151.1621242595440;
 Mon, 17 May 2021 02:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <1621239159-21139-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1621239159-21139-1-git-send-email-yangtiezhu@loongson.cn>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 17 May 2021 11:09:44 +0200
Message-ID: <CAKXUXMwtMBCB6ovrG90BB5EruTkFSk=O8X-kxeikqhDgt8hryQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: checkpatch: add description if no
 filenames are given
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:12 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> After commit 45107ff6d526 ("checkpatch: if no filenames then read stdin"),
> if no filenames are given, it will read patch from stdin rather than exit
> directly, it is a bit confusing whether the script hangs, I do not quite
> know what to do next until I understood the code logic.
>
> It is unnecessary to print some info if no filenames are given, because it
> is like trying to make cat without command line arguments emit something,
> just add description for somebody that actually reads the available kernel
> documentation on checkpatch.
>

How about:
...
if no filenames are given, it will read patch from stdin rather than exit
directly. This means the script waits for input indefinitely, which
confuses new checkpatch users at first.

Add some basic documentation on this behaviour of checkpatch to lower
the confusion.
...

No need to mention that you were confused.

Other than that, it now looks good. Thanks for the patch, can we get a
quick v3 and then we are settled.

Lukas

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Documentation/dev-tools/checkpatch.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index 51fed1b..3eb9ead 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -22,6 +22,8 @@ Usage::
>
>    ./scripts/checkpatch.pl [OPTION]... [FILE]...
>
> +When FILE is -, or absent, checkpatch reads from standard input.
> +
>  Available options:
>
>   - -q,  --quiet
> --
> 2.1.0
>
