Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF7330AD80
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhBARMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhBARMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:12:16 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144A8C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 09:11:36 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id r14so20579967ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 09:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSPw/fBYIyhRfckoXNVPoWECxEnxFCcki9n6TzTl56c=;
        b=p4HKVnvrA0s7JvNr1TGoHlg2+K/dnjyGEXUGOrtnUC+Xt6iughcCUvwp62QPtoMzue
         2SUIZ9H6y7wNhVzeDOQBCZUUYl1uHaIiDwKwJcYHOgF+TK9JAYGdRO6lU04IzwylWg47
         N+DP7XE03GHXr8NYHzqXKq3AqFio8zCnZcA9hGeybCKrjdB86dq/aHSLvtl9GSl2WK41
         DAYZZbmo1ROti/RNCyxmhA/rrL+7SWLX+X2Dw5+2AMIVTNkWKzWJl6DohoT3Zf2yn2+4
         mRu68u/wFP/ssLicwA9AQ4MoEDHrljhhDuzpXsNod3ZL6vFkpVmYTitVbXb6iG9Vx5hY
         XLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSPw/fBYIyhRfckoXNVPoWECxEnxFCcki9n6TzTl56c=;
        b=IH5hXZ286urFosd74wmjZ8uNv65C+oAkuGPSYkT5VbWh8d4EAEKtyp+nQihqUBRsRd
         FyqSQvpQcShikopDXagVwyBc0hfdiNd5f9bL4LeFjRx/QVIRpL/t6oDjtGRbYCcri8qJ
         oegdNtYkDUupxphAORTMnDkS6briOdrbHV6bmtmpTPXsteYHAQkEB2GpuyR3R1P9ULKf
         UFgC+0BoBmIGi/rKtoHMiKcCvECRunBW3CBYCCBx9yPcbzwPkPxSwzcffInNEgcdbMPb
         yu4wN2KcrqMCozgrK1AvRWKCWZ6RXRGDhxO8Eou3mcAgBvpdhUOkmul/o/16GvzfUCAs
         RGHQ==
X-Gm-Message-State: AOAM533EVf5c50ck14T99rXfrc2XWWyOnk6cDtmt1zzn87bYQKRXXL4S
        hVa8qrOC6/t7xzYkqYJX+iWHv2tMP9qGU/fiF0E=
X-Google-Smtp-Source: ABdhPJw8nSUGznpaS6dc1UPgQRIduQpA43hvr7kpNblSAILitmlqG44MzwQXd11rJwdPAAuWRaH7mVOIklRsAvjg+7Q=
X-Received: by 2002:a2e:7403:: with SMTP id p3mr10835574ljc.373.1612199494275;
 Mon, 01 Feb 2021 09:11:34 -0800 (PST)
MIME-Version: 1.0
References: <CABJPP5AxB8-kafFEpsMydg8eMx8bH5ooT5g7r0fKWV2T2Hjtng@mail.gmail.com>
 <YBguQ/dENrfvtptJ@kroah.com> <CAKXUXMwtXTYfs_9Asnmpd09zsucg8tRehMi2Shv8V49H-rs4xA@mail.gmail.com>
In-Reply-To: <CAKXUXMwtXTYfs_9Asnmpd09zsucg8tRehMi2Shv8V49H-rs4xA@mail.gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 1 Feb 2021 22:41:33 +0530
Message-ID: <CABJPP5Dt6KyoaMr-dS9425rozKoCyiPgx9WfoeY2541Aq3MF=w@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] Patches from the future - can checkpatch help?
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 10:20 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Mon, Feb 1, 2021 at 5:37 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Feb 01, 2021 at 10:04:01PM +0530, Dwaipayan Ray wrote:
> > > Hi,
> > > on linux-next,
> > > $ git log --pretty=format:"%h%x09%ad" | awk '$6>2021 {print $1}'
> > > gives:
> > > 4a2d78822fdf
> > > 12ca45fea91c
> > > 09f2724a786f
> > >
> > > These are patches from the year 2085, 2037 and 2030 respectively.
> > >
> > > Would a checkpatch rule be helpful for these or are they too
> > > isolated to waste runtime on?
> >
> > Dates come from your email client, not the patch itself, how is
> > checkpatch going to catch this?
> >
>
> Dwaipayan, there are two ways:
> - We build a bot listening to mailing lists and check. I like that
> implementation idea for various other checks.
> - Stephen Rothwell could include this as a check on linux-next and
> inform the git author and committer.
>
> I am wondering though if that is worth the effort, three instances of
> a wrong date among 1M commits seems to be very seldom and the harm of
> that mistake is quite small as well.
>

I agree. I felt it was isolated as well but it might affect people who do
static analysis on the commits or such.

The idea of a bot seems nice though in general.
People do have all the style checking scripts at their disposal, but still
we see style issues on the list.

Something similar to the kernel test robot, but for style issues seems nice.
Is it something the community would like?

Thanks,
Dwaipayan.
