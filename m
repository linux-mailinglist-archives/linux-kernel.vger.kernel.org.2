Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED1736F24B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbhD2Vtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbhD2Vtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:49:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DDEC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:49:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gx5so10027682ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFtRq0o7RuprUm0fy/T67jArYpo21Pztk91Azl3wjtg=;
        b=o/cixS4CRZbDd83SPuQAK5YD+6j6vn3+ZYtnu796vMPM6nom+Z1jgBXU4vyshs+v3f
         bDjNTCv01xfBDTyicwEtiODcRTWLY31i4RgME9kkxdGatHmND3jM21krUgJb78tqSdQs
         k2jTufyxLr7TxuvRfTEb9DVFx80f0EFkh7cZHFSWa2Dyc4M2JmT4m2ht72MhLtPDqdOJ
         HNy3RTIwTT8fEiBVrgz7XzpKdHsRWWroGMsvR7Wx1d+NjK0B1bBWQ4rNIHuIq5WPFxLF
         8XokTE/X6+yjnHYscZtoLGF1i2Du976C8nBBmdR43TMm7ZF8p9Qoq+m69mHnPgSuOYSG
         Avig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFtRq0o7RuprUm0fy/T67jArYpo21Pztk91Azl3wjtg=;
        b=PWWlMmDPWxmhq9lcql00EAQZwcQCdxJu0C/AidpHX6HQdNT15WPaDLL3XJrSk3KK3u
         V/4Lg1mnoyEB6Zr2fX8qLaJeU01uEoco/Pa4J7kB0UzSeckyTXYqt6+TbW0LZmef+ref
         Jq+0/w2av9YqnRA6BEmht6SnaTqRaq6dMvqyRPUEJktVdvKm5EL7HAJj7XU0BCnagskc
         ne4oq71gXikY81oeZzUdrSDWczBkPpilLJgmlCCdSogh1C51ira3zuYI39BBLKiPefBf
         g3Iq1S1qdLtUVA9JUYa5FlThFJYEAntxw2UKSpLn1PvY0qNQMilIJZMszTU7Q7iGMkH3
         0lvA==
X-Gm-Message-State: AOAM532bY1BBXzzdFNFUtrEAU3ECYqQxhnhDTq+AGItuWkmeaGkkAejx
        cAZvPeSVxeI3qNtaRuqTgD+uNzF5tgLAK4Fe6R6eoA==
X-Google-Smtp-Source: ABdhPJyQyU2O0jYpRlsyCFt2+GwglBHD3jjZ9N0ybhOUD/OLmiDsbhRN5TleXQ8e/c27SblrD1RT9jPTyfcx7blZeA8=
X-Received: by 2002:a17:906:18e1:: with SMTP id e1mr589642ejf.341.1619732941590;
 Thu, 29 Apr 2021 14:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <161898872871.3406469.4054282559340528393.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87sg3bd8iv.fsf@meer.lwn.net>
In-Reply-To: <87sg3bd8iv.fsf@meer.lwn.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 29 Apr 2021 14:49:00 -0700
Message-ID: <CAPcyv4iDhrueShBUYMNAtUwMBmxtfrqOFjzoQ7KpN4aTTWrVpg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move nvdimm mailing list
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        nvdimm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 8:58 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > After seeing some users have subscription management trouble, more spam
> > than other Linux development lists, and considering some of the benefits
> > of kernel.org hosted lists, nvdimm and persistent memory development is
> > moving to nvdimm@lists.linux.dev.
> >
> > The old list will remain up until v5.14-rc1 and shutdown thereafter.
> >
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Oliver O'Halloran <oohall@gmail.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/ABI/obsolete/sysfs-class-dax    |    2 +
> >  Documentation/ABI/removed/sysfs-bus-nfit      |    2 +
> >  Documentation/ABI/testing/sysfs-bus-nfit      |   40 +++++++++++++------------
> >  Documentation/ABI/testing/sysfs-bus-papr-pmem |    4 +--
> >  Documentation/driver-api/nvdimm/nvdimm.rst    |    2 +
> >  MAINTAINERS                                   |   14 ++++-----
> >  6 files changed, 32 insertions(+), 32 deletions(-)
>
> Would you like me to take this through docs-next, or did you have
> another path in mind?

Thanks for the offer, I have a few other nvdimm related bits for this
cycle, so it can go through nvdimm.git.
