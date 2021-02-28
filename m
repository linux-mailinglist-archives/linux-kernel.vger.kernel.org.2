Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35DF3273D3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 19:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhB1Sig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 13:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhB1Sie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 13:38:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B849DC061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 10:37:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b13so8579372edx.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 10:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppGDpTFzSXWWlGE51pox82buiuX04gD9pOg1/3MREt0=;
        b=fzIMkkwc6VXyZF+e5HqKudARIH8IhkbVBJP3UmfsNZH67f1544pHFaGHfwP/FO36aI
         eTSEfVcBj+15O4ZH9c65NPAXPNS3HPUC/Lm6ORbep6aFgY9jZXo9hKM0YDEubl3+QEEZ
         CTINTi3RBSFnHKFgHzTHtKafez9J1PpeLBJgvLAMNYRdB+n/LXfvrTkSGFjkKSvOOACN
         lQ+pJPOjN0mQW6ezEaU7zEYzzEYj97uZ8TZJy1kw/65Ggsci3ud9bVJe2aGxqI+x28ZU
         XhGu8leiG3yJ2v35aoyo/GnuI1DqaQTUDEY1OwvcWuHmN18TQj7bw84yqAETo1MoFfPz
         ZqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppGDpTFzSXWWlGE51pox82buiuX04gD9pOg1/3MREt0=;
        b=U2yeqO6PnYHRjee5O8X8/a7GEASUp9PFjWVz1pkn5vBmREv3Lyjt6O7GOKmUSxa96W
         sNSqvEqHuBY2eIitmthimk4Ro/O8FtFrnEEReOUjZLQYDce8V60n2Ufwk7PpJ+LJedN4
         JcaYQSmrWil/pPB4TjEGW6TEuQi3ZFYzPVg/bsGB5fwyz+y46KYxK1Q/gpMmbYKQlEQy
         43MfS5zliwcD23Srls6y0EXQTZGg1iKx3EQZggmeqpS8rHujApmAMof/OZRiacwY2bQg
         IQOElSJf2GLLJK1uwEdvZrdbwoZXtYXMLht74f/MdUC5vo6EvpFErBdoBf38ECdsoVdz
         O91Q==
X-Gm-Message-State: AOAM533a/zNVQsedH9HAWNJyRR02+S0sBDDlbf0Z7YBbdxCVDncxsBIO
        WzWN38ABIHm9YWuB492P5MqgxZCCVSHa0YCG/c19
X-Google-Smtp-Source: ABdhPJy8sTRUUiKp4ovwElzch6ia8u+MqZN0LydyVqnFlDPVOkQGZgCct6BclpSvPM0shzYvLlp2pVEOiDGHubcT/R0=
X-Received: by 2002:a05:6402:c96:: with SMTP id cm22mr13096764edb.128.1614537472148;
 Sun, 28 Feb 2021 10:37:52 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain> <YDvNF+QVOv3vqDbm@localhost.localdomain>
In-Reply-To: <YDvNF+QVOv3vqDbm@localhost.localdomain>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 28 Feb 2021 13:37:41 -0500
Message-ID: <CAHC9VhTr0=WGvacsCGgpwiPwU_ziQeThV88ZqZRdVXqO+HafYQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] pragma once: convert scripts/selinux/genheaders/genheaders.c
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 12:04 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> From 097f2c8b2af7d9e88cff59376ea0ad51b95341cb Mon Sep 17 00:00:00 2001
> From: Alexey Dobriyan <adobriyan@gmail.com>
> Date: Tue, 9 Feb 2021 00:39:23 +0300
> Subject: [PATCH 09/11] pragma once: convert scripts/selinux/genheaders/genheaders.c
>
> Generate security/selinux/flask.h and security/selinux/av_permissions.h
> without include guards.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>  scripts/selinux/genheaders/genheaders.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

My LKML subscription must have died at some point due to mail bounces,
or maybe I dopped it (?), because I'm not seeing the rest of this
patchset for context.

However, unless the rest of the kernel transitions to this, or there
is some other big win that I'm missing, I don't see much of a reason
for this; can you provide some compelling reason for why we should
make this change?  A quick search on "#pragma once" seems to indicate
it is non-standard, so why replace the simple #ifdef/#define solution
for this?

> diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
> index f355b3e0e968..e13ee4221993 100644
> --- a/scripts/selinux/genheaders/genheaders.c
> +++ b/scripts/selinux/genheaders/genheaders.c
> @@ -74,8 +74,8 @@ int main(int argc, char *argv[])
>                         initial_sid_to_string[i] = stoupperx(s);
>         }
>
> +       fprintf(fout, "#pragma once\n");
>         fprintf(fout, "/* This file is automatically generated.  Do not edit. */\n");
> -       fprintf(fout, "#ifndef _SELINUX_FLASK_H_\n#define _SELINUX_FLASK_H_\n\n");
>
>         for (i = 0; secclass_map[i].name; i++) {
>                 struct security_class_mapping *map = &secclass_map[i];
> @@ -109,7 +109,6 @@ int main(int argc, char *argv[])
>         fprintf(fout, "\treturn sock;\n");
>         fprintf(fout, "}\n");
>
> -       fprintf(fout, "\n#endif\n");
>         fclose(fout);
>
>         fout = fopen(argv[2], "w");
> @@ -119,8 +118,8 @@ int main(int argc, char *argv[])
>                 exit(4);
>         }
>
> +       fprintf(fout, "#pragma once\n");
>         fprintf(fout, "/* This file is automatically generated.  Do not edit. */\n");
> -       fprintf(fout, "#ifndef _SELINUX_AV_PERMISSIONS_H_\n#define _SELINUX_AV_PERMISSIONS_H_\n\n");
>
>         for (i = 0; secclass_map[i].name; i++) {
>                 struct security_class_mapping *map = &secclass_map[i];
> @@ -136,7 +135,6 @@ int main(int argc, char *argv[])
>                 }
>         }
>
> -       fprintf(fout, "\n#endif\n");
>         fclose(fout);
>         exit(0);
>  }
> --
> 2.29.2

-- 
paul moore
www.paul-moore.com
