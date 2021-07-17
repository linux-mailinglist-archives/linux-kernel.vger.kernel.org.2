Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832AE3CC4A7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhGQRBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 13:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhGQRBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 13:01:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F01AC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 09:58:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 22so21279941lfy.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jbWRwx3vNpivElmMcM2Cy7N7lse3df9EYtEBR82SZo=;
        b=TW00OElWdldwhyck4ia1xSbAIrPzwakzZhTHlT/Wm7Rk9/2l94/pFpoLDmnvHTB7xq
         Xr6VkhHdreJ264xO8wQwtSE35BLr531jqX0D13715NJxc3Cd9oDDmqYCipRGHo03TZPS
         YkNM+jZo49wGSZtdvhgcUuYxGvG1QWoZG+nYbiuO7LojfNefn4nkuFsx8BTTfBklM/WC
         aLw3vkDkZOFUJANsX9YtHV9+5DyiDQdJrgHx7Z/tfyhNLqWLcs6HdXqtIXrlWn8h3v4O
         lGSngUm27yBN146gpT3syLh4UsNHXiU68U2nu94tuScpFpbjV3SynYF7r1gk8uFWSiNm
         YBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jbWRwx3vNpivElmMcM2Cy7N7lse3df9EYtEBR82SZo=;
        b=SuIYhlL5JVWQxkA8REDsihR6J8YQIyerl7ttJTc5wtcwMvYYeWRAw1c4MQjxO4TNqZ
         lZbB+rqdksPY/PCizhJVckjWpXikALBx20GdlUcNr6uJcfjMP4v8Eo7XqXeQ184D7tiQ
         vQjvKXt3+r03/7/pQUe6XbuQPL6BW8DYf1qSjxKd2/0KwNgZOP0pN5TlQEfV+tD/n2Pa
         qbT+9oQkOvaxpqCgHGKFCnoA26JMK8nhNUsWlNjk0vmFSaEeieV1hEhT6Xav8wqcmudW
         tEwtpCA314uaFC/T2w5h6K+uDzO5Cc+TTnLJn0YckvGmtGQB/N14SfP8+py6fuHoSYDq
         CjXA==
X-Gm-Message-State: AOAM533S74f5mJrk0Q6RiqQzNFAWQiZYPahuXvSLgip0n75UIYNx0B5w
        fQcXkdXqOY5fFxC8dEXhTRl15SzP/yxIj3Y4NLk=
X-Google-Smtp-Source: ABdhPJwrCrpsGopJrQu3ScHr6xqnj1uV7dwyg2XPuFn58dp3WjKS4HmlmmsJGZS9cogXbj2FtyVJ12VqTZxlkQEZt9E=
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr12291827lfc.117.1626541083299;
 Sat, 17 Jul 2021 09:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210716182126.4392-1-dwaipayanray1@gmail.com> <CAKXUXMyvOh0GvpEf4uX5iFJYOJLo43tmO16Uf34j4i6XD0vBcg@mail.gmail.com>
In-Reply-To: <CAKXUXMyvOh0GvpEf4uX5iFJYOJLo43tmO16Uf34j4i6XD0vBcg@mail.gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sat, 17 Jul 2021 22:27:52 +0530
Message-ID: <CABJPP5Dqy4XAob_6D5TSX+hURs5JX+ufz2Tg2o=bR7kbMoGzMA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: remove obsolete check for __dev* section markers
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 10:02 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Fri, Jul 16, 2021 at 8:21 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> >
> > Commit 54b956b90360 ("Remove __dev* markings from init.h")
> > completely removed the definitions of __dev* section
> > markers from init.h. They can no longer pop up in the kernel
> > and hence the check for those markers is unneeded now.
> >
>
> Generally, a good idea! I like this commit of removing obsolete checks
> in checkpatch. Can you identify more checks in checkpatch that are
> potentially obsolete and share them with us?
>

I identified this one while writing the verbose documentations for that
rule. I will probably get some more in this process. I will share if I get
something else, given nobody has any objections.

> I assume:
> If you run checkpatch on the whole latest kernel tree and you run
> checkpatch on the last 50,000 commits or so, all checks that were
> never triggered on those evaluations are potentially obsolete. I
> assume that only a handful of checks would qualify for that criteria,
> and then we could dig deeper into the history of those checks and see
> if they still serve a potential purpose or can be removed.
>
> If you need a powerful server to run such checkpatch evaluations, just
> let me know.
>

I do have the checkpatch evaluation on the whole kernel that I did about
last month on a cloud server. I can use that. And I have the 50k commit
checkpatch report from v5.4. That should suffice for now. But thanks, I
will share if I require any computing power.

> Just on the wording of your commit message:
>
> The first sentence reads very strange, because you are just repeating
> the commit message. So, you can probably just combine the first two
> sentences and make it much shorter:
>
> Since commit ..., the check in checkpatch for __dev* markings is obsolete.
>
> Remove this obsolete check.
>

That sounds logical.
This particular check was added by Joe in 2013 when the process for
__dev* marker removal was in progress. If he has no objections to it,
I can send in an updated patch.

Thanks,
Dwaipayan.
