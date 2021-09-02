Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188723FEED8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345352AbhIBNkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345324AbhIBNkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:40:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB91C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 06:39:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id me10so4432598ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4KUdrdu2ZZlJB+kQ4qlKPGyeRskjNAqaMRoBQTyFAo=;
        b=vlmc0S2+CjLTalJLTUHRB2w+UL03UT2ZrNb0WEPqlHQw+gG/nsjJBxFdl8KfD9H5pA
         CrgkeGibHvHuekZmUEVHHyUZrRecRCe2NWsEYnGTHEPCb0FFlfzB1PyCGnF/GnHMPblZ
         GXdAXaS8nOwAOa8TWWdjwtKM7fN2aE4S+HmsY3h1hnA0o1y7MVaysgpvtXFLjjcRamRC
         38cU7S2U5yAawPIRWfcQ+SbzQI4wxhYCUHt4fQSGhIvigcq86sqnh2XJXPie2DjUb5xW
         WsRfTFI3Cv5976Lk80UB2KCACRVz4E0tW3JmUHJslGJw/iUdjpDYvLz2qb07G5hHqzFC
         ehIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4KUdrdu2ZZlJB+kQ4qlKPGyeRskjNAqaMRoBQTyFAo=;
        b=hwxhDreJNTKQfzB4JU3PzU0CsRtyJ9F8l73E3PG3ycSyCSNj1Hg2BggRBXIg4Dn0zB
         +gc16f+fo40jA/KxAfGpdlvxGnpHO9Tf6HDwOzG6tW36w+x+oM5T1v3Dvk2vNkpCCwgr
         U3AHQLAfitkEXVDSG/YYL3mfSfD+kJ16ThTi/UmX5WfJnlK2OwqBmZptioWcRXZGtMbH
         cJ+iat3CcdIjW5oC3UsfIG5wosgNyFENRs5EUYQfBTrsRyytLyYyeqKCj0oQ6O55eIBw
         coLU0yuhcYJeK891eCw14YB9Ab4+sIp8fOnBECJQAlr0WU33oV3RGlemZZTfnLh74oWF
         tZOA==
X-Gm-Message-State: AOAM533UiOpuK8/FQ/r7zPe5zmfW9UakNvFCfdqpx/oZd3sXQp+gp/t0
        kc+/kdzcCJH8XCtCTdXl7gMV5U9sqUNqRZhPeSP044eElJkfiQ==
X-Google-Smtp-Source: ABdhPJz9udbbnyzgbJD5xldwuRUycMikcJl/+KDjdm/OhLCJepZ2IOEhZmtamGL/jYj65Z5wC/Ha7JZnZ4rEHK7WVw4=
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr3880812ejc.247.1630589970870;
 Thu, 02 Sep 2021 06:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210824165607.709387-1-sashal@kernel.org> <20210824165607.709387-127-sashal@kernel.org>
 <CA+G9fYveOoHUydWRjRWtKcF3smTXt3F3ChxuZuDSoxCkDA1rPw@mail.gmail.com> <329ccdd224e763f1fe53f2ad88b8c835d76f55f0.camel@kernel.org>
In-Reply-To: <329ccdd224e763f1fe53f2ad88b8c835d76f55f0.camel@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Sep 2021 19:09:19 +0530
Message-ID: <CA+G9fYt-FHGTEkLTW6peO+sb+pYKMiaE5K6T-ijJH=eRtymWHQ@mail.gmail.com>
Subject: Re: [PATCH 5.13 126/127] fs: warn about impending deprecation of
 mandatory locks
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sept 2021 at 18:57, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2021-09-02 at 18:50 +0530, Naresh Kamboju wrote:
> > On Tue, 24 Aug 2021 at 22:35, Sasha Levin <sashal@kernel.org> wrote:
> > >
> > > From: Jeff Layton <jlayton@kernel.org>
> > >
> > > [ Upstream commit fdd92b64d15bc4aec973caa25899afd782402e68 ]
> > >
> > > We've had CONFIG_MANDATORY_FILE_LOCKING since 2015 and a lot of distros
> > > have disabled it. Warn the stragglers that still use "-o mand" that
> > > we'll be dropping support for that mount option.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  fs/namespace.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index caad091fb204..03770bae9dd5 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -1716,8 +1716,12 @@ static inline bool may_mount(void)
> > >  }
> > >
> > >  #ifdef CONFIG_MANDATORY_FILE_LOCKING
> > > -static inline bool may_mandlock(void)
> > > +static bool may_mandlock(void)
> > >  {
> > > +       pr_warn_once("======================================================\n"
> > > +                    "WARNING: the mand mount option is being deprecated and\n"
> > > +                    "         will be removed in v5.15!\n"
> > > +                    "======================================================\n");
> >
> > We are getting this error on all devices while running LTP syscalls
> > ftruncate test cases
> > on all the stable-rc branches.
> >
>
> You really don't want to run those tests anymore then. The "mand" mount
> option no longer works, so any tests that require mandatory locking
> won't function correctly.

I will communicate this warning with the LTP community.
Thank you.

- Naresh
