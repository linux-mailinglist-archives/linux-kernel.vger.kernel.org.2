Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F9A3CC475
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 18:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhGQQfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 12:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhGQQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 12:35:14 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2163FC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 09:32:17 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r135so20104250ybc.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3Jr+ib7KAhvoedwM1ypkCaUCOD91JhpXCt/GOvedbI=;
        b=skh7E6t7kNc+3aF+lFWBqBovhj5/eyxbXgejBsa6aN5gtd0QTgL7+egN6tjTxFlmN1
         xs/9I9gNJ1mZtOf46A/WZsIRaS3+lsV8WjDcc4HQDv4a5pAbx3st+2abdQBE/dAevheU
         XdtQrJiNjfmWd97HwDGhG36WPrRb/m/X6sQr7X+wePJgbLFUJNf7ZI4D1RVWqpBS2YXX
         DT/Os1rv7HCgMMoubp35V4MFmiOKjmjnUHI6XOBhUR/c31HpwkjBPLjixFvgc8KhFIX0
         5G1BrkdTkN3O/SvELkUGGpax2fCERWoEPmDh1/p45gOB+PavPoPYa08DZV+ZGMS9gyi3
         twIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3Jr+ib7KAhvoedwM1ypkCaUCOD91JhpXCt/GOvedbI=;
        b=id1S+EWdFUgHFoYSkFWxQvMXi6hu94f3EHe4tzJyIhb1qu5Mwwdsa92mAPGI6YnpO6
         SwLZ8gT3yWeYfOXOS0L4YBCbeTllFXIlnLmuCDolXvT3SAhrd6bbVtIMWr/69GdCHV7k
         G9JsZGTifi7fsVpySGXhi8RzXhCXLbd2qjsSBkyJtQQVGCC0bTL7CMFp3KsnyXClbN6v
         jAToGN5zOgZF38UuZ5H5BqHrI5IV7wuJlQYJMiID3t/0JhXP/MyAvPBlRXVYbqC1F64W
         H2GAjX6izbvCUwRKCcTQE4e0EpTJxVj4yrfz4S8VoM766CH4KDqU8ASi3jhd5Q4M8Yl+
         6baQ==
X-Gm-Message-State: AOAM532v8wzC6dqGNSr5lJigzRERwUnp37KCdW0z8hoElob5QphCIl6i
        faxg6AtOPq9jO4oXxe2ZyIxvmU4dOwZonqnSwCc=
X-Google-Smtp-Source: ABdhPJxsN4fwXG47GpGuEqqKI/eoDMUwjj0t15c/hxil1nBtC726Laerjttv/DaLd1SQKZH4WwGXq3RB+rQJNmaWWDI=
X-Received: by 2002:a25:b948:: with SMTP id s8mr20210430ybm.281.1626539536206;
 Sat, 17 Jul 2021 09:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210716182126.4392-1-dwaipayanray1@gmail.com>
In-Reply-To: <20210716182126.4392-1-dwaipayanray1@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 17 Jul 2021 18:32:05 +0200
Message-ID: <CAKXUXMyvOh0GvpEf4uX5iFJYOJLo43tmO16Uf34j4i6XD0vBcg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: remove obsolete check for __dev* section markers
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 8:21 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> Commit 54b956b90360 ("Remove __dev* markings from init.h")
> completely removed the definitions of __dev* section
> markers from init.h. They can no longer pop up in the kernel
> and hence the check for those markers is unneeded now.
>

Generally, a good idea! I like this commit of removing obsolete checks
in checkpatch. Can you identify more checks in checkpatch that are
potentially obsolete and share them with us?

I assume:
If you run checkpatch on the whole latest kernel tree and you run
checkpatch on the last 50,000 commits or so, all checks that were
never triggered on those evaluations are potentially obsolete. I
assume that only a handful of checks would qualify for that criteria,
and then we could dig deeper into the history of those checks and see
if they still serve a potential purpose or can be removed.

If you need a powerful server to run such checkpatch evaluations, just
let me know.

Just on the wording of your commit message:

The first sentence reads very strange, because you are just repeating
the commit message. So, you can probably just combine the first two
sentences and make it much shorter:

Since commit ..., the check in checkpatch for __dev* markings is obsolete.

Remove this obsolete check.

Lukas


> So remove __dev* section markers check from checkpatch.
>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  scripts/checkpatch.pl | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 461d4221e4a4..e29c0961b25e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4023,12 +4023,6 @@ sub process {
>                              "CVS style keyword markers, these will _not_ be updated\n". $herecurr);
>                 }
>
> -# check for old HOTPLUG __dev<foo> section markings
> -               if ($line =~ /\b(__dev(init|exit)(data|const|))\b/) {
> -                       WARN("HOTPLUG_SECTION",
> -                            "Using $1 is unnecessary\n" . $herecurr);
> -               }
> -
>  # Check for potential 'bare' types
>                 my ($stat, $cond, $line_nr_next, $remain_next, $off_next,
>                     $realline_next);
> --
> 2.28.0
>
