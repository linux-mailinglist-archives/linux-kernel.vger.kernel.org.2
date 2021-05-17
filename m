Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C633822FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 05:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhEQDLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 23:11:52 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:36034 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhEQDLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 23:11:49 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 14H3AGhg020866;
        Mon, 17 May 2021 12:10:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 14H3AGhg020866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621221016;
        bh=4z/4ul1O8vysnvcKyyirJSaHuqdOsRJ/nOyIiviM9vo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KBD4LQOiZNwvh7FTa+W7pn/G17S9nxl982saqL96VjOsNsATUvye/wXOLb7h1uZwS
         xiy+9XfF0VEiskSMv5xxIM/tLm9lSJsRYNQFdzK9cGpykFaDl2eh9rpmu9cFwFUr3m
         Ar76Ue36XY9vR0C4k/aDvTX80nu5+peX0MpzVdhdzdmgTNBBPEPhesV2rUSResJf7N
         a5oKDaZSBNf4rZhWqssy09N11UryUWtZd7UNfuGnxlretHrX2wxqraxH8GI1oamV3V
         NpPMIXNJW7m85BIJZVSByGsQbh6gD5POrBvUItrMsRq6U2JHoKxNYRDEWMn5xdDQmH
         5bNzNVdz3DQqg==
X-Nifty-SrcIP: [209.85.216.54]
Received: by mail-pj1-f54.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so2881129pjb.3;
        Sun, 16 May 2021 20:10:16 -0700 (PDT)
X-Gm-Message-State: AOAM531HXzqLEtmRqOvuDv6f4rJK/rt+Jni8S18ojcZgtoXXbSWLLqjf
        xfxQQGk0cp/QtVJ++G3BXmsYIAmqigv99Uh8NaA=
X-Google-Smtp-Source: ABdhPJwGKiOhNj9TyFb1sPDWUs4XSxuGiDLv+346Sq08ltyZTRCo3yqCVzLUnf8KLvCeY73Wl06LD9un72fW1BczWro=
X-Received: by 2002:a17:902:541:b029:f0:3187:409b with SMTP id
 59-20020a1709020541b02900f03187409bmr15700355plf.47.1621221015740; Sun, 16
 May 2021 20:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210513162403.1726052-1-j.neuschaefer@gmx.net>
In-Reply-To: <20210513162403.1726052-1-j.neuschaefer@gmx.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 17 May 2021 12:09:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-mU=6TTwBHys04k9932d0n_HNMCMSg4k8NfNxf8AZ-A@mail.gmail.com>
Message-ID: <CAK7LNAS-mU=6TTwBHys04k9932d0n_HNMCMSg4k8NfNxf8AZ-A@mail.gmail.com>
Subject: Re: [PATCH RESEND] scripts/jobserver-exec: Fix a typo ("envirnoment")
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 1:24 AM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


Applied to linux-kbuild. Thanks.

> ---
>  scripts/jobserver-exec | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec
> index 0fdb31a790a81..1c779cd1ccb48 100755
> --- a/scripts/jobserver-exec
> +++ b/scripts/jobserver-exec
> @@ -10,7 +10,7 @@ from __future__ import print_function
>  import os, sys, errno
>  import subprocess
>
> -# Extract and prepare jobserver file descriptors from envirnoment.
> +# Extract and prepare jobserver file descriptors from environment.
>  claim =3D 0
>  jobs =3D b""
>  try:
> --
> 2.29.2
>


--=20
Best Regards
Masahiro Yamada
