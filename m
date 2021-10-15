Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED9B42F701
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 17:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbhJOP2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 11:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbhJOP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 11:28:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4AFC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 08:26:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c29so8672260pfp.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iS/q0+UgVJbQqV3Q9KW/gMKSm2K7WnWW8AcEkaTN11M=;
        b=B6cDwuKwMEgEb+r66i3DN6N2B5h5WKnAWBmiyIlUS+cG58/ZgtrCXIPo7fnAcHxDkP
         Jd0yo52lCEFPHdqSDPuZmKco7SjwbtvxQSGHLQnjL6Zc5OGv7fQfDCu3mE9A4JjeiU/3
         L9ud+a7kg/ZHzzdZcqGhyIJJ5Q84HBsGMbqt3JMn6CrcNAqwdHDpqyegxpezuEKsyWBV
         REz0ov8V0MPN8qCklCNhUt5FcHY0afVvxJoN0eS2M9nNKK/MVjJgmbkGX5jJAXFgz8Zi
         QLF0cwVVVjXtzzTngVVCECjOcooU50Qw/Z6dz2g9fi3zOOwCfoFYp1NBKRl9lmbRCuO4
         5llQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iS/q0+UgVJbQqV3Q9KW/gMKSm2K7WnWW8AcEkaTN11M=;
        b=B/Z72ILugi75cP41SK4QthqzomYM5RrIINNNbvDzEbucwqaKMjfu9kB10oBL99m/PO
         7Hh0rSUd4wkGy/v9z5ch3K1xGP4CcK+x04IHB2T24jylvEGIu7ByTwSSILchHizujSI9
         GQzFDsitjsFviULUT1aNHhnxJR0K/Uxfdr9TCN67qvEhXb6GFK+MkcziNo8I9y6BL8GO
         neVOqR/rOMluADnAF1SOBJcyUt+vEFMeszAuJcbeokrXUCX1+tMuQdjhJ8Jlk/GEBvNJ
         NnfrNlb4fiCZZPTu/rby2g3dGKkJDlAyjrcofmy3ZV5B0LToiPib41Yk3x6fPn+VvX3B
         cf4A==
X-Gm-Message-State: AOAM530xFvM2vt5A/O4lFJa/GliXApPI7Dj0BLD0RDjBg2xUmZyrsRWl
        PgkBAKaNon7pkHgkw6y55PL05Js4UVnceSarCFSI9DYG37A=
X-Google-Smtp-Source: ABdhPJxMNZK8lvUlL76El1EAEmZ2UCdWVDcJef9RAvLtGAs4U5wMSx0cAOoTGJ6AvngNNplV2X0H5OeZo8sI3kC0l9Q=
X-Received: by 2002:a05:6a00:1a8d:b0:44d:72f1:96e5 with SMTP id
 e13-20020a056a001a8d00b0044d72f196e5mr12374520pfv.40.1634311575927; Fri, 15
 Oct 2021 08:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211014143507.4ad2c0f7@gandalf.local.home> <CAEbi=3d=yO+D_SjQavqizc2tHyWda3t9zXbN84cbvYYNP=epKA@mail.gmail.com>
 <20211015101814.6b372c10@gandalf.local.home>
In-Reply-To: <20211015101814.6b372c10@gandalf.local.home>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 15 Oct 2021 23:25:39 +0800
Message-ID: <CAEbi=3c3uWSCxQsGf5SVTBpMwwgkm-Kb2uShvwz6jAoVWpBqwQ@mail.gmail.com>
Subject: Re: [PATCH] nds32/ftrace: Fix Error: invalid operands (*UND* and
 *UND* sections) for `^'
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Zong Li <zong@andestech.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Alan Kao <alankao@andestech.com>, kclin@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=8815=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:18=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Fri, 15 Oct 2021 08:54:35 +0800
> Greentime Hu <green.hu@gmail.com> wrote:
>
> > loop in Alan and KC
>
> Any thoughts?
>
> This has passed my tests, and I want to send it off to Linus. But it woul=
d
> be nice to have an acked by from one of the nds32 maintainers.
>
> If I don't hear back today, I'll just send my queue without this update t=
o
> Linus, as I want to get my changes in before the next rc release.
>
> Thanks!

Acked-by: Greentime Hu <green.hu@gmail.com>
Thanks you, Steven.
