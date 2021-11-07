Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47284471AD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 06:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhKGFlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 01:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhKGFlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 01:41:01 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13BC061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 22:38:19 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b15so29465433edd.7
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 22:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szkviDCi1rFLFmKYDtnPNNfzpZ/yxOSXHSDrNpkJtxg=;
        b=pyRV4InZ++O0zs45xoaLa2i7n/wNpbXEz0nYvi4X7HppBb86jRTNrjN9aXqMOKnS0c
         4CCHvH0GnlaaBLed0fyL8t4qIvLVuGpPMLTt7BQsnfFCF2xO//d9Oi0dUjcjJiWU2QFK
         mQNDC91trL1Q3N6ZOsE6fO5VKIX6G9JlgDqAMZqKHHri3Pi5iuy/Z0ji24nZt/S0ESWy
         ZpL+S/uHhGd/jPCxwmnYqIhKywGNyZ2tNR254nrsD4oKsLVKhHlJe2KTdrEfjSsIkoGG
         +dqP1gicgY+cGMYftpBoQsRCV05k9vUFySknezk2/7thoAhTiYvfjb7RkiZyzZqqPy07
         J6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szkviDCi1rFLFmKYDtnPNNfzpZ/yxOSXHSDrNpkJtxg=;
        b=ddi3aeSAkbeWbCYRnFr440MFL5wdGxwvxsXGnY0Q8cAnrs2rvqxf2+cKC7+7000Kbo
         0rLmBWBAtmrd2BktQC/CSRvSUGuoNNEFud35C4tu4i6jrcDpm6MjWA5E+I3mOadB00Gb
         pbv8XXCm7xQR4G0aA8s7kr2HOO8a/WZoSic/ZacO7j6vO/d0iKXpvMHqVVz7M3KGljYP
         kbZQNYx6Mp6kgiOO/KLXpjmUL4zzRObfOgDQeGjnA5pJ9IiI+6BBzN2yYcMVVhR/nmG5
         ok+P7lrI50Hk6Ceof3qpZR4AGpLanHogjeSplxyquK8Zyh7jW6a7pIRaDzInIdgSxLTD
         qIpQ==
X-Gm-Message-State: AOAM531fh94I1UxLr0a5tjg77GlrJCRJc9BwEA6UnRW3gqyHBs+2L9cS
        FeiZNKq3PnEhetw2Wq39zQsqMRixu1ZdX5jkmiVPfAjL1iA=
X-Google-Smtp-Source: ABdhPJwIcBzjtRupPnhttobautRts8gDFJbqYcZorDGq2TkQ4/gHLfkQoSkKvMBm3dfnD9VW0iO4/Zq3MbR8DukCwZU=
X-Received: by 2002:a05:6402:1801:: with SMTP id g1mr67748747edy.107.1636263498234;
 Sat, 06 Nov 2021 22:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211103152234.GA23295@pc> <CAOk_PdOsSjPHogrYJ9Nd7GdnZYw1G4zbaZFGUrK1rQ0dSq101A@mail.gmail.com>
 <0bb90ec7-65b2-1eb6-b9b5-57bea35179a2@tessares.net>
In-Reply-To: <0bb90ec7-65b2-1eb6-b9b5-57bea35179a2@tessares.net>
From:   Zackary Liu <zackary.liu.pro@gmail.com>
Date:   Sun, 7 Nov 2021 13:38:07 +0800
Message-ID: <CAOk_PdOpHbLXhHJZVzRCsJ1oJaMUqFbkeuJDXKJwEcqMJ_k7Bg@mail.gmail.com>
Subject: Re: [PATCH] scripts/tags: add space regexs to all regex_c
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     gregkh@linuxfoundation.org, ripxorip@gmail.com,
        maennich@google.com, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Sat, Nov 6, 2021 at 12:15 AM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Zackary,
>
> On 05/11/2021 16:50, Zackary Liu wrote:
> > Hi all,
> >     Excuse me, everybody.
> >     I submitted a patch yesterday. Now I have a question why the
> > maintainer's mailbox was not found during "get_maintainer.pl".
> >     It outputs the following information:
> >     ---
> >     linux-next$ scripts/get_maintainer.pl -f scripts/tags.sh
> >         Zhaoyu Liu <zackary.liu.pro@gmail.com>
> > (commit_signer:2/4=50%,authored:2/4=50%,added_lines:68/74=92%,removed_lines:72/74=97%)
> >         Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:2/4=50%)
> >         "Philip K. Gisslow" <ripxorip@gmail.com>
> > (commit_signer:1/4=25%,authored:1/4=25%,added_lines:5/74=7%)
> >         Matthias Maennich <maennich@google.com> (commit_signer:1/4=25%)
> >         Michael Ellerman <mpe@ellerman.id.au> (commit_signer:1/4=25%)
> >         Masahiro Yamada <masahiroy@kernel.org> (authored:1/4=25%)
> >         linux-kernel@vger.kernel.org (open list)
> >     ---
> >     Is it a bug in "get_maintainer.pl"?
>
> I guess the main issue here is that this tags.sh file has no official
> maintainer:
>
>   $ ./scripts/get_maintainer.pl --nogit --nogit-fallback \
>                                 --norolestats --nom -f scripts/tags.sh
>   $
>
> So I guess someone has to pick this in his tree.
>
> Maybe a maintainer of the PCI drivers could take that as the "issue" was
> found there? Or Marc?
> That might be quicker than waiting to have an official maintainer :)

Thank you for replying and giving me some advice, Matthieu.

Marc, I might even need your help.
I have seen other patches about "tags.sh", it seems that they are
reviewed and merged by the maintainer of the relevant subsystem.
Could you help me review it or send it to other maintainer.
Or give me some adivice?

Best Regards.
