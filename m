Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1FD3A3932
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 03:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhFKBRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 21:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhFKBRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 21:17:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B94C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 18:15:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a11so1970455ejf.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 18:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRj/l0AEwRVAqSoVJEOPnFwGQ+KdbAusCa2F2dhpq40=;
        b=kS3G4HqC1XZgwI5lS9w0vyh1F5M9I87AaPQImqoQZKzYto/gfW7VOoxTeCAfsI+CbB
         PvuNyVR4uAP8LrJ1lde9FKDnGCPKwQsF8ByJDtDEPim4BOlf7yj7IIbZS+k9+vISCorQ
         ti+IzDdm62N3v5A2exude6fhRZJxY0vApm0SaLQj4FLeEmxJoPB4auKNDXEjBwP8xevi
         xt20NWZs9OXv4elsO3imeHEj6Ep0fO/WLCDhCpcFH4cZjj4VTO/Zi1/2XWG11Q0BqCFL
         YQxs+nXtDF0ULD11uOyB8Hd40rRHqzJVKPQFwqrrs9DNlt6ibBMSfZNvXlvewP5s1JW7
         RJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRj/l0AEwRVAqSoVJEOPnFwGQ+KdbAusCa2F2dhpq40=;
        b=MG9jt5M+nSrFjClS2Ui5iFQ3nlY7o1ZeRYFyPaAiFvaklGUTrH6y0X4xyZMnnXslUD
         24gi9/0FQKbmPD8fHs+I4mmpNPrW1m9r0CRC8qfkFVOBv5G/Rxzget8FuYUcFIAGfeK4
         2M2IE6FcRV0G5QytwUp8LJCJUdOWOajYEvLBSgEU76kOWGlS62myh0Tty1s+4sN16dTa
         Ii723ODg6Wp7VDpaOW3kh0pLP5AEyF3Fy+6zzPwtSoAkanOe32jlDd58dDHrrvpQt8pp
         JqXHDvvxik4CG0CXrjyEyvQlxdk5TjuqeLGSpIfYBHEMMviSArSuz6mAfaryBUyqLG3s
         gt6Q==
X-Gm-Message-State: AOAM533lkjNq03uADsgM1VQoUNHKZ+PWND865jt7PItZZ7ivvCtxmhmU
        rwB7JF88DIRkuD8IsVsOwPeA+2BGePFTJW1BfvPE
X-Google-Smtp-Source: ABdhPJzEAjvM/V0QgJp83gEmaTf3sZIJulvlVdQmgrA9QgL7VpoWJNVnK8hghXR2Q1xbpOIhmiBRq/SGDgApvhRHJZU=
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr1073324ejb.542.1623374128945;
 Thu, 10 Jun 2021 18:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210609163717.2719253-1-minchan@kernel.org> <20210610160650.d2112a9db8130224c597bfaf@linux-foundation.org>
 <CAHC9VhTYeOmJqoyEniXLGMv3cJGBW4_BLc3LhDLBDhQCKtfp7Q@mail.gmail.com>
In-Reply-To: <CAHC9VhTYeOmJqoyEniXLGMv3cJGBW4_BLc3LhDLBDhQCKtfp7Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jun 2021 21:15:17 -0400
Message-ID: <CAHC9VhStg=5soOqXMJUoik_A9N1PLABMbU8pZZcZ8=k=_U_JxA@mail.gmail.com>
Subject: Re: [PATCH] selinux: use __GFP_NOWARN with GFP_NOWAIT
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 7:13 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jun 10, 2021 at 7:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Wed,  9 Jun 2021 09:37:17 -0700 Minchan Kim <minchan@kernel.org> wrote:
> >
> > > In the field, we have seen lots of allocation failure from the call path below.
> > >
> > > ...
> > >
> > > Based on [1], selinux is tolerate for failure of memory allocation.
> > > Then, use __GFP_NOWARN together.
> > >
> >
> > Thanks.  I trust that the selinux developers will process this patch.
>
> That's the plan; this is in my review queue for this evening.

Looks fine to me, merged into selinux/next - thanks!

-- 
paul moore
www.paul-moore.com
