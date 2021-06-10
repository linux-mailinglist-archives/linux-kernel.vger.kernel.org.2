Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD63A372A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 00:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhFJWfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 18:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhFJWfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:35:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E40C613E7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 22:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623364386;
        bh=05+TvLpD8afqmEIB/fCJvbcqSr4HEeRL5MwUkTDAZOI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i8D1npTDntFQ+aIM3jJ0KQXd4BrdlNLQA0d3cdsv5aUWt2SPVJTQ3ntvbLbII0Yo6
         MbvsBRXJeArqMDW+TYxSN8ciCZHde0ijeb5PWgB2bHX3DPL4ne/c1HUNf75sqg5Vz2
         SQVcrHpfmNzCaA518ymmED1H8NQmI6atx5Zbm0z11QP9tbmm1pQ1UJLDTv1Th7LAGU
         5m2TLSID7Qdc1UAQbrEOdddi/MgI3T9nfzYWBw68fSAg9VK56dWF2oIrn6iLmvSDWl
         fWFAMSd8AjXI2jknvJd3PhJKiOfFBP0Y1SSiG5l6cdssDlfxD9VynPQug0XvXndsrD
         b/ulaSc47aVRg==
Received: by mail-qv1-f47.google.com with SMTP id t6so9703766qvp.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 15:33:06 -0700 (PDT)
X-Gm-Message-State: AOAM531AGpfFBAJxgQeZhoHMMlcX79DZPKRwiCYN5nfDCtxi+WAY/CpM
        kFdRbMWkreGWhOvPERAFF1tQ03yX6Y4bVoRVTzE=
X-Google-Smtp-Source: ABdhPJySFwlIudB4HaMUCIShInVYybm6kjEiekSvo4XR3iGQOvYw6VTcoXLchJNkx6BsMfsqZLmH63Ibp1m1DeqpOnM=
X-Received: by 2002:ad4:5343:: with SMTP id v3mr1897161qvs.45.1623364385190;
 Thu, 10 Jun 2021 15:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210518155921.4181-1-mail@anirudhrb.com> <20210519032014.GS4332@42.do-not-panic.com>
In-Reply-To: <20210519032014.GS4332@42.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Thu, 10 Jun 2021 15:32:53 -0700
X-Gmail-Original-Message-ID: <CAB=NE6Uq_t9Mbs8zN30QQrwH190p5Oz4M7OwDxmQgUeRRWS_6g@mail.gmail.com>
Message-ID: <CAB=NE6Uq_t9Mbs8zN30QQrwH190p5Oz4M7OwDxmQgUeRRWS_6g@mail.gmail.com>
Subject: Re: [PATCH v4] firmware_loader: fix use-after-free in firmware_fallback_sysfs
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 8:20 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, May 18, 2021 at 09:29:20PM +0530, Anirudh Rayabharam wrote:
> > This use-after-free happens when a fw_priv object has been freed but
> > hasn't been removed from the pending list (pending_fw_head). The next
> > time fw_load_sysfs_fallback tries to insert into the list, it ends up
> > accessing the pending_list member of the previoiusly freed fw_priv.
> >
> > The root cause here is that all code paths that abort the fw load
> > don't delete it from the pending list. For example:
> >
> >       _request_firmware()
> >         -> fw_abort_batch_reqs()
> >             -> fw_state_aborted()
> >
> > To fix this, delete the fw_priv from the list in __fw_set_state() if
> > the new state is DONE or ABORTED. This way, all aborts will remove
> > the fw_priv from the list. Accordingly, remove calls to list_del_init
> > that were being made before calling fw_state_(aborted|done)().
> >
> > Also, in fw_load_sysfs_fallback, don't add the fw_priv to the list
> > if it is already aborted. Instead, just jump out and return early.
> >
> > Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
> > Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> > Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > ---
> >
> > Changes in v4:
> > Documented the reasons behind the error codes returned from
> > fw_sysfs_wait_timeout() as suggested by Luis Chamberlain.
> >
> > Changes in v3:
> > Modified the patch to incorporate suggestions by Luis Chamberlain in
> > order to fix the root cause instead of applying a "band-aid" kind of
> > fix.
> > https://lore.kernel.org/lkml/20210403013143.GV4332@42.do-not-panic.com/
> >
> > Changes in v2:
> > 1. Fixed 1 error and 1 warning (in the commit message) reported by
> > checkpatch.pl. The error was regarding the format for referring to
> > another commit "commit <sha> ("oneline")". The warning was for line
> > longer than 75 chars.
> >
> > ---
> >  drivers/base/firmware_loader/fallback.c | 46 ++++++++++++++++++-------
> >  drivers/base/firmware_loader/firmware.h |  6 +++-
> >  drivers/base/firmware_loader/main.c     |  2 ++
> >  3 files changed, 40 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> > index 91899d185e31..f244c7b89ba5 100644
> > --- a/drivers/base/firmware_loader/fallback.c
> > +++ b/drivers/base/firmware_loader/fallback.c
> > @@ -70,7 +70,31 @@ static inline bool fw_sysfs_loading(struct fw_priv *fw_priv)
> >
> >  static inline int fw_sysfs_wait_timeout(struct fw_priv *fw_priv,  long timeout)
> >  {
> > -     return __fw_state_wait_common(fw_priv, timeout);
> > +     int ret = __fw_state_wait_common(fw_priv, timeout);
> > +
> > +     /*
> > +      * A signal could be sent to abort a wait. Consider Android's init
> > +      * gettting a SIGCHLD, which in turn was the same process issuing the
> > +      * sysfs store call for the fallback. In such cases we want to be able
> > +      * to tell apart in userspace when a signal caused a failure on the
> > +      * wait. In such cases we'd get -ERESTARTSYS.
> > +      *
> > +      * Likewise though another race can happen and abort the load earlier.
> > +      *
> > +      * In either case the situation is interrupted so we just inform
> > +      * userspace of that and we end things right away.
> > +      *
> > +      * When we really time out just tell userspace it should try again,
> > +      * perhaps later.
> > +      */
> > +     if (ret == -ERESTARTSYS || fw_state_is_aborted(fw_priv))
> > +             ret = -EINTR;
> > +     else if (ret == -ETIMEDOUT)
> > +             ret = -EAGAIN;
>
>
> Shuah has explained to me that the only motivation on her part with
> using -EAGAIN on commit 0542ad88fbdd81bb ("firmware loader: Fix
> _request_firmware_load() return val for fw load abort") was to
> distinguish the error from -ENOMEM, and so there was no real
> reason to stick to -EAGAIN. Given -EAGAIN is used typically to
> ask user to retry, but it makes no sense in this case since the
> sysfs interface is ephemeral, I think we should do away with it
> and document this rationale.
>
> I think we should stick to use -ETIMEDOUT. Its more telling of what
> happened. And so I think just removing the check should do it, but
> augmenting the comment should suffice.
>
> Since this change is already big, it would be good for this other
> change to go in as a separate change. If you can test to ensure the
> -ETIMEDOUT does indeed get propagated that'd be appreciated.
>
> Otherwise looks good. Thanks for your patience!

Anirudh, did you get a chance to test?
