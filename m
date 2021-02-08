Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB08312B56
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 08:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhBHH6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 02:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBHH6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 02:58:14 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8773DC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 23:57:28 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id v5so18662837lft.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 23:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VG1LiiS+OLuU2/TNT8nMqerA0shnJ5i/ySWOppULYpo=;
        b=r6D7M+IC6qGh6DxP/vMpbQm8u0LA0YnWhpU52gTuQhxbutJtO3Zy/MQ06WYSCjs7ZO
         LJTqajsq/s8LvekwJjIaGcvIbw/2sIHAHGch5hAHR7iQNDMaPZNDUNd/24O6Bw0ru2za
         e7xtvT5nETjhNOYZa0+cS5e8TGfjY5o1CYmfftOGbFAeaUm9LH8Jn3jm2xxkUkCcOj5H
         MaEgG2TJtbB/3tOGAh4WYsamZ7Qb/Za1ezzx/4/GcN9nqKdbVLLdCoe4t3GghhfZaO/G
         cQyvgxgjaQlWbL5NKclCkdO+A8zN+phAi2qI8gvvpz5/52MaelQjRuIi+YIV8s2sRD+2
         dPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VG1LiiS+OLuU2/TNT8nMqerA0shnJ5i/ySWOppULYpo=;
        b=Ur0t7zfOYclJ2T7B+udHe0iryak/7eNsqEML0Z960B1P38HCOCcph2ZvcbzuuD7zMX
         xfKdTNh32bgeZyhDz+eXvPWNxVr4KU0h+zf0xjfILB3egqCt5bPNwKwDx/vlZqMyQ7nq
         sBCc4lKCbyKF8i1PxE5uFOA1FZo7qcVHIPBsJfEXfNBBMbnoa5PQdvIc+284+4IdGFU7
         cVvnVNREf0CERrg5ouIZT3AabnpAbPdQWLJGaPWdVsQeVZpukwIOKmwVs8beTng9Rm+y
         jKJOx4R+Qoi3rnwNHukwwEbzSULtdqoNXSoxBj3WVIQHFuAjiUht2ypgS7Vcm0M0dHp+
         cBkw==
X-Gm-Message-State: AOAM530sOrjWPF7NFatA4Vgxi72JzhlpRPCuoSE/Swfim1Ep+sXpvl4e
        G/w4xIvdP3etZDfV2OF6rJWliJ6YYIK3+xyz066a+Q==
X-Google-Smtp-Source: ABdhPJyEpCy4OkP6RsMGFIjGo6cp55hrzqlVSynNb6AEwqxJnc+3Azji5v9wf9Zzn0Hk5vQYX2HSF1PkwIGhddTdXYY=
X-Received: by 2002:ac2:46d6:: with SMTP id p22mr3145726lfo.84.1612771047070;
 Sun, 07 Feb 2021 23:57:27 -0800 (PST)
MIME-Version: 1.0
References: <1612433660-32661-1-git-send-email-sumit.garg@linaro.org> <20210205173627.guzsj4lfczimvp6d@maple.lan>
In-Reply-To: <20210205173627.guzsj4lfczimvp6d@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 8 Feb 2021 13:27:16 +0530
Message-ID: <CAFA6WYMAe2G_z0Qy3qXNsDbEvpFOCGCzO_7eUxVc5YEg=tMkpg@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Refactor env variables get/set code
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, 5 Feb 2021 at 23:06, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>
> On Thu, Feb 04, 2021 at 03:44:20PM +0530, Sumit Garg wrote:
> > @@ -318,6 +318,65 @@ int kdbgetintenv(const char *match, int *value)
> >  }
> >
> >  /*
> > + * kdb_setenv() - Alter an existing environment variable or create a new one.
> > + * @var: Name of the variable
> > + * @val: Value of the variable
> > + *
> > + * Return: Zero on success, a kdb diagnostic on failure.
> > + */
> > +static int kdb_setenv(const char *var, const char *val)
> > +{
> > +     int i;
> > +     char *ep;
> > +     size_t varlen, vallen;
> > +
> > +     varlen = strlen(var);
> > +     vallen = strlen(val);
> > +     ep = kdballocenv(varlen + vallen + 2);
> > +     if (ep == (char *)0)
> > +             return KDB_ENVBUFFULL;
> > +
> > +     sprintf(ep, "%s=%s", var, val);
> > +
> > +     ep[varlen+vallen+1] = '\0';
>
> What is this line for? It looks pointless to me.
>

Yeah, it looks redundant to me as well.

> I know it's copied from the original code but it doesn't look like the
> sort of code you should want your name to appear next to in a git blame
> ;-) .
>

Sure, let me get rid of it in v3.

-Sumit

>
> Daniel.
