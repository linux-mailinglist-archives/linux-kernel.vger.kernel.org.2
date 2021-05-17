Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2AF3828A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhEQJoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbhEQJox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:44:53 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0352C061573;
        Mon, 17 May 2021 02:43:36 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id v188so7724864ybe.1;
        Mon, 17 May 2021 02:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwvHFB6haj1euq9Su3Ad3P6zDg3T5rwMjoT/7A2qF9Q=;
        b=j2oIbGcneuAjLHIOBGELY9i6ZL8owraNpkFL11JVjOPxsfeiXm8GELK8rLDoDOXXtl
         nGfkdTL2Ox/e7Vjzibrzs0zg8cYKD/2xGDzxdClLl3Ix2y4WVEtZ53YO64B5GqsitKn4
         wpWeA3LKDpPsvlzQscUv6LqPPfVwQR106HfCk3doEMSZz23h7ufI3W+Jr2yxn3PuAwkm
         UfYcAvxVxBmn/0xxdSDMFrcYdxNE7x5SqLfDDoRUFCy1J06n53uBvfS1SyblKRDcy0ef
         4BRbpIm0pn5Zt+Kg/cb1CcHIjSYybZhZDj04SIzOmqiv7mpiU0uX/HAQVIYA0tTKxUZj
         XwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwvHFB6haj1euq9Su3Ad3P6zDg3T5rwMjoT/7A2qF9Q=;
        b=f/sbnnfpLO3dWQgltPz6Ar63BLezfNO9vl2CfVa4khJURLHMgDEQm332OQj3sn7Opk
         ssuM9oBBedE9WhNXFmFgWDoVMvuJLA6phVItrgL0bFepNScYKB//27JQgLlS1ugVRjr5
         600XceUX7oPar0rJQWEnaxSBXdhPcHAq/64F2b79jGPckNooPGCuMEI/+FyAsW8GtrK3
         j5odkIxAI8bYtGEzZk3t35FBroWd6vnQVIWGKVQ8x2lYJDtLzveoNV9w/B0iS1e/XwRQ
         wllHO0SBG7U0EkaGTLqIEID51ZOTaNuqI1On0tKZrjlUxlxA91xmqxc+tF62u+bseIMV
         LM/Q==
X-Gm-Message-State: AOAM533RlheQLXtnmUnwlta2zzd1PS1mwtHgkUnTJs8oL+/3fta+w/GE
        EyDtjfvrzQVUqT+1PnuZIVrhl5IIo3yCiO00KEc=
X-Google-Smtp-Source: ABdhPJwdhBfReuRF8yxrUkfUKdOmXN1odV3COj5klkSVa8IFjyhv6BR219EtmiHpZB+NxwAccYRs9SmqWnZypbiRs+A=
X-Received: by 2002:a25:b112:: with SMTP id g18mr13098442ybj.281.1621244616068;
 Mon, 17 May 2021 02:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <1621243800-27702-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1621243800-27702-1-git-send-email-yangtiezhu@loongson.cn>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 17 May 2021 11:43:39 +0200
Message-ID: <CAKXUXMyVSf_HsjKhD2FeZzyz6pbA7JN=KkWrvdRswkba60OXww@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: checkpatch: add description if no
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

On Mon, May 17, 2021 at 11:30 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> After commit 45107ff6d526 ("checkpatch: if no filenames then read stdin"),
> if no filenames are given, it will read patch from stdin rather than exit
> directly. This means the script waits for input indefinitely, which
> confuses new checkpatch users at first.
>
> Add some basic documentation on this behaviour of checkpatch to lower
> the confusion.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> v3: Update the commit message, thank you Lukas.
>

Thanks.

Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Dwaipayan, can you acknowledge this as well?

Jonathan, I assume you will pick this up in your doc tree once
Dwaipayan ack is there, right?

Lukas

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
