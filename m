Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1D131050A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 07:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhBEGnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 01:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhBEGn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 01:43:29 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8691C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 22:42:45 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id o7so418605ils.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 22:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WWy67zxMmAl68pT4mWx5+KJE1GMRdc0d+dtu28TFBI=;
        b=Jfhjr2phpP+qDRAwu4ZLu4fTjGVlt+XgZp0P2TYfgoa93Za+ulOBLmyv8HTHTPu8RP
         7cKggLmlwor1d2rGjNOx6rN6e/EGYwfqGYDLb8PcaHM/w2Ex+lCRRRhfjpFMsZzuCfND
         HrHffV9bDBLXnM9UlajTlNYA+1+0Y/JcYKA3Awjcue5+AOdquiHSbhaEvBG73nFH2gFT
         aRz3/qXwD0U9tUrwZq8E/Jn8qqFwM941g/p8B+0y8/IbicQ/9ZebtXepm71Ocqyt4lpN
         yk1yJUHBnbVXsDatr/hkk0yjz4gb59UJSuPEzPSKk5Hq7RGpngcD6CkfU3IbbDnpbqIa
         rrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WWy67zxMmAl68pT4mWx5+KJE1GMRdc0d+dtu28TFBI=;
        b=qIYJJG3KM5nr89bc8mQpc5nUo5CFQT96uPOT+AeRqsC2MA1mVG9yJUsM+sO4JBSf7n
         rShAWxBSbMTa9qTceGOjpYjVq82YDpAzClae9jPgcTscL0psuceoFelEsCF76TlmlCs6
         OkoG/kVXXoVGZzdI5w4btgIUTrPjiptOrqTBllN2jOu1OYTFZ1ffqhDhN7dM28RxkqDd
         6TR8IZygyv113N7zCGss9LBgad8Obm6LU2PnUnYOUWTMjaCLJXIcNJHGNLiKwX9a9EOq
         6H2yWoPhJvuTIxtcFT7xwqQADGxJRKLAptRvURtVfvH7/+xuy4o5LLK09jByJKroJ8YC
         q9zA==
X-Gm-Message-State: AOAM533RiO3mZ57GpF1hP0U9/84zDuX4+u6J2vqXdepNvoc0RuBIXUB6
        Sru0U0p7VQzWSteV26LpdFvuEtGKqDiPtHEQrj8=
X-Google-Smtp-Source: ABdhPJx+GzW/fMqDQBfo8lZVHKbAFkNg8tsirl2a83iQYndkFrQTpogK0PF/1hfVmbKVxxtBO3tjW/5dzSoJSBTiXk4=
X-Received: by 2002:a05:6e02:2196:: with SMTP id j22mr2676149ila.64.1612507364077;
 Thu, 04 Feb 2021 22:42:44 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMyRAer=0S9pxiRs2iF3pdkU8zW=JZw2a+nJJ30iPLPhCA@mail.gmail.com>
 <20210128165447.3da0d98e@lwn.net>
In-Reply-To: <20210128165447.3da0d98e@lwn.net>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 5 Feb 2021 07:42:33 +0100
Message-ID: <CAKXUXMxxz7Lffre67uYKzuoXgcMXwv_36Od0UCwX50RPc9DkTg@mail.gmail.com>
Subject: Re: Small student project idea on appropriate integration trees in MAINTAINERS
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     devel@lists.elisa.tech,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        =?UTF-8?Q?Ba=C5=9Fak_Erdamar?= <basakerdamar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 12:54 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Fri, 22 Jan 2021 09:22:24 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> > In this project, we can make use of:
> >
> > - gitdm [git://git.lwn.net/gitdm.git]: gitdm includes some scripts to
> > parse MAINTAINERS and obtain the integration tree patch of a commit.
>
> Look also at the 'treeplot' tool there, which determines which tree(s)
> each patch went through and makes pretty (OK, not hugely pretty) pictures
> from the result.

Thanks, we are well aware, and that is a good reminder for Basak and
me to get our gitdm treeplot patches in shape for proper submission.

>
> I suspect you'll find that the tree information is mostly correct.

Your suspicion, which is counter to my hypothesis, makes this
investigation worthwhile just to see how correct that information
really is.

> Developers need to know that to be able to base their patches properly; an
> incorrect entry would lead to a certain amount of maintainer misery.
>

Maybe the missing or wrong information in MAINTAINERS or the lack of
clear recommendation for new developers to a kernel subsystem on which
integration tree a patch shall apply to is one of the reasons for some
maintainers' misery.

Let us find someone interested to measure and investigate and then we
will see...


Lukas
