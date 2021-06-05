Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC5B39CA8C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 20:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFESrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 14:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhFESrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 14:47:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21F2C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 11:45:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a2so19118411lfc.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ST3+tylKwF+N2sfQqBcgjsUsWRCDiOqEmKbZ9q/pMb0=;
        b=f5lhgZ6d5NGWC+z8wfdYvaNCkyDYPbhUo7uJkdUJkFVozpikMYPY6yGP256Nff0Tsd
         QZV50wdGApn5YcgbKSYHhvSmfa8ve+iuMnLSH8T2hmhSf9/gGJWDMAN7T7ta4KqrpGi5
         Z04cK0xkMgfoNY85S+0wqv8tChfG3116JX+/PABtZrL+NJLZiowVKCJi51Iz4u6Iscec
         wCqJlXG77kjC/PNuTP1KV0b7+1BsKKyb5Ycy/CTcrnRrzNt9+IMqT0vx8epiBbwa5N0c
         CmkfZ2XnK0amvXVWSJsSlr3kpiLjzhzLqt1kxZPJBWSpXCS1Ck5PfUQ6HG1tXdJ+ODhD
         k7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ST3+tylKwF+N2sfQqBcgjsUsWRCDiOqEmKbZ9q/pMb0=;
        b=mWIt3s4YVTTFy5xSR9aiWnJGZHg6lPXw/lsw3ia8b6/WQku309hf+GTC6UMzYAjSRJ
         d1mopS+Nla0yn+wKj+r8ysd+M6qJ7+eYOdK7TUNiR1bdI+eb7i5GXZp4YykfW5tcKxrR
         /eeeo14Wn2pQZs7InHnSvHjatraI0bhOaUUR/2ny8Xp01yXqCdN2T2X4XIWy6y4tufG3
         Iar+bENnAMBKlC60DKjkBCcZJ5aMAkdAPblfv6i6w05Ifilftv/40kdn4CcKcvvsCWZH
         UzRIq5SqHekm8Q+nhyGDYfzlyVgMIST3VEBNMXmgb/dqjvuG8VvRpjOMw8Uzp42mc+hW
         57+w==
X-Gm-Message-State: AOAM532UfiJbG8lek5tp7w4in7lzRw0FPHWm+ZkkKHwk2I4BtFxT8m7+
        qNJDMoBFF6NM0biT/bxqOyYKL8+THxC60UIeXinDbpiNEjVntA==
X-Google-Smtp-Source: ABdhPJzvNTj/LXFiy1YUq1674Bt0Jw/0pox3Rm1620bUTpa7/PRqqRd5I0VAs/d+V+7e/FUqQQhR5WZqhjc2QMwZdK8=
X-Received: by 2002:a05:6512:358a:: with SMTP id m10mr6682751lfr.31.1622918701636;
 Sat, 05 Jun 2021 11:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210605161219.26421-1-dwaipayanray1@gmail.com>
 <eac3b988f4993a77f8eea3550a6dd5980b25e92f.camel@perches.com>
 <CABJPP5B3jZHnAprT15uEkuAbYPUT49VXRFT+pkubVVep-2=XmA@mail.gmail.com> <294bb4a2c3f5f8cf4a744cf59bfd37562653afb9.camel@perches.com>
In-Reply-To: <294bb4a2c3f5f8cf4a744cf59bfd37562653afb9.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 6 Jun 2021 00:14:50 +0530
Message-ID: <CABJPP5AOcCWydstxqKN9tjFN9nigk1OQeJY3DFnd+rFP_2+qaQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Fix check for embedded filename
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 12:03 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2021-06-05 at 23:03 +0530, Dwaipayan Ray wrote:
> > On Sat, Jun 5, 2021 at 10:51 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Sat, 2021-06-05 at 21:42 +0530, Dwaipayan Ray wrote:
> > > > When checkpatch is run on file contents piped through stdin,
> > > > it may generate false EMBEDDED_FILENAME warnings if the
> > > > --file flag is used.
> > >
> > > I think this is a "don't do that" scenario and this change
> > > is not necessary.
> > >
> >
> > Okay then. I will drop this.
> > Sorry for the noise.
>
> I think you want something like this:
> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index dad87c3686326..582f8e07d32d5 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -331,6 +331,7 @@ help(0) if ($help);
>
>  die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
>  die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
> +die "$P: -f/--file requires at least one filename\n" if ($file && $#ARGV < 0);
>
>  if ($color =~ /^[01]$/) {
>         $color = !$color;
>

Yes, that's nice.
Most of the checks don't work with piped input when --file
is specified. So disabling it will avoid any confusion.

I can send in a patch if it's okay with you.

Thanks,
Dwaipayan.
