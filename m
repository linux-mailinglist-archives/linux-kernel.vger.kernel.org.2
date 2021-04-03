Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2063534A6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbhDCQJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 12:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhDCQJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 12:09:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CBDC061788
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 09:09:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id dd20so1043988edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhg8iWx5EuotOjw+AANL2MrLOvNjMkZMWFCX/mESM94=;
        b=bRDZvs0WFj2Jlcf87Tfbcs5eBBHthxIPo0dCekCLmbudPTW5c08px+SYIikz7YwWWr
         z/p28H+lSWwRrD1k3LKXLeXzB1Fa8qjgvtBecaJRXIa5QTi/pxI9Rl6iBGx5dBt312Kd
         pfhp5vpPIQ/z/K1DkC0lYBhUO/7O60yZ9Tc23+PpucKCb/AA6KDfHRZHyao1qDJfTGjb
         n38WrtiQUT9qfJbYB3jaw/zbrPI1w9rNaYvrpKWy7C2yaLs5n7NGqZjEajUhNNrWKXyl
         VskXMJONNkhO7XR+5xTvgwUNOY///DQYhXJD3mbNzgawxXlr5IshFWGX+WQFQWlocH5t
         /pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhg8iWx5EuotOjw+AANL2MrLOvNjMkZMWFCX/mESM94=;
        b=g8RMYft5YEyftkibA8IY6uZneXf3XswhWlQViCsl+paWhDtYaEt4N7g045/7Ytuxoy
         k/DEPJrcmNZrvEnujGUTOR+khaS6G6yHml8Dw+ID1nxqgrRbNre5azcSPd3iKVu5AvOb
         Qywk0JhVUwItOlm6aBC+6u8qV0H3H5CTMC466VZ4uG1Ihrurvq/hWB6cvBZSOtCDZcDn
         tzwzHhBLVPfBr/CNz+jeejdBGdB30hZK6eGvbbV+53Q58Igo3g/zwm/O9SCA9QG2c4Ls
         WRiuFSqnPBuIVkhmuXbgXacxqzSFk8I3ysjdKnwa9Y7b2M2OZr3o7TJpNEtDyueeXFdN
         SECQ==
X-Gm-Message-State: AOAM530rfKyU/poc9wVEKu8R7f40z8e+JOMPRdCtYgUBfJ/HZGCBDxLD
        UV6WK0kGO6O7xzKppW1Gj+KlZqISKhSuy87m6MG9
X-Google-Smtp-Source: ABdhPJztif72esYry9x6VAvneWY6Abw6duPiwCZaBpJwYYzDZUFG56Mh0IKvIQdBoF7HmmMtfknlT4yuoB2EXtzFn1Q=
X-Received: by 2002:a05:6402:105a:: with SMTP id e26mr21872755edu.164.1617466159221;
 Sat, 03 Apr 2021 09:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <3c63e34b-e54f-9b01-bad4-8fde8528a64d@linux.microsoft.com>
 <CAHC9VhTD2iXw7CkxgwnOx1zNN_AqMV+x1Vy8FijdMQE1m4AOJA@mail.gmail.com> <CAFqZXNvZCiE=cKhjBqvxOmebDi3vNr0gS563cCMqTTwpcM6JAw@mail.gmail.com>
In-Reply-To: <CAFqZXNvZCiE=cKhjBqvxOmebDi3vNr0gS563cCMqTTwpcM6JAw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 3 Apr 2021 12:09:08 -0400
Message-ID: <CAHC9VhSfOfJ2kN3yqJBWzwT4=FhmSfoOQLd9MYSu7GYdE3C8hQ@mail.gmail.com>
Subject: Re: [BUG] Oops in sidtab_context_to_sid
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 3, 2021 at 11:21 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Sat, Apr 3, 2021 at 4:33 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Apr 2, 2021 at 6:35 PM Vijay Balakrishna
> > <vijayb@linux.microsoft.com> wrote:
> > >
> > > Seeing oops in 5.4.83 sidtab_context_to_sid().  I checked with Tyler (copied),  he said it might be
> > >
> > > https://lore.kernel.org/selinux/CAFqZXNu8s5edDbSZuSutetTsy58i08vPuP2h-n9=kT34HcPc4w@mail.gmail.com/
> > >
> > > Ondrej, can you confirm?  Unfortunately, we don't have a on demand repro.
> >
> > I'm guessing this may be the problem that Tyler reported earlier and
> > which appeared to be fixed by the patch below:
> >
> > https://lore.kernel.org/selinux/20210318215303.2578052-3-omosnace@redhat.com
>
> Nope, if that's really 5.4.83 with no extra backports, then it can't
> be this issue as it has been introduced only in v5.10.

Of course, good catch.

-- 
paul moore
www.paul-moore.com
