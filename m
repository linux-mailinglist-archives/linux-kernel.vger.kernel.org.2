Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF171368EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhDWImL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:42:11 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:17534
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230007AbhDWImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:42:10 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A4G2ug6stEWm5EsPGI2AcM+bn7skDl9V00zAX?=
 =?us-ascii?q?/kB9WHVpW+afkN2jm+le6A/shF8qKRUdsP2JJaXoexjh3LFv5415B92fdSng/F?=
 =?us-ascii?q?ClNYRzqbblqgeAJwTb1spwkZhtaLJ/DtqYNykese/f7BOjG9gthPmrmZrJuc7k?=
 =?us-ascii?q?w31gTR5nZshbhm9EIz2WHUFsSA5NCYBRLuv+2uN8uzGidX4LB/7UOlA5WYH4y+?=
 =?us-ascii?q?HjqIjrelovCRIh9WC1/FGVwY+/Ilyj0hASXygn+9of2GLO+jaX2pme?=
X-IronPort-AV: E=Sophos;i="5.82,245,1613430000"; 
   d="scan'208";a="379461705"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 10:41:32 +0200
Date:   Fri, 23 Apr 2021 10:41:32 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 009/190] Revert "media: s5p-mfc: Fix a reference count
 leak"
In-Reply-To: <ed2859a3-0051-5ef4-483c-9abd4fa81b22@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2104231037400.4538@hadrien>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-10-gregkh@linuxfoundation.org> <b43fc2b0-b3cf-15ab-7d3c-25c1f2a3e658@canonical.com> <YIJy6AnG6QBlkV/5@kroah.com> <20210423100727.5a999c2e@coco.lan>
 <02966f20-342d-cf21-8216-d364b67753b7@xs4all.nl> <ed2859a3-0051-5ef4-483c-9abd4fa81b22@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Apr 2021, Krzysztof Kozlowski wrote:

> On 23/04/2021 10:10, Hans Verkuil wrote:
> > On 23/04/2021 10:07, Mauro Carvalho Chehab wrote:
> >> Em Fri, 23 Apr 2021 09:10:32 +0200
> >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> >>
> >>> On Fri, Apr 23, 2021 at 09:04:27AM +0200, Krzysztof Kozlowski wrote:
> >>>> On 21/04/2021 14:58, Greg Kroah-Hartman wrote:
> >>>>> This reverts commit 78741ce98c2e36188e2343434406b0e0bc50b0e7.
> >>>>>
> >>>>> Commits from @umn.edu addresses have been found to be submitted in "bad
> >>>>> faith" to try to test the kernel community's ability to review "known
> >>>>> malicious" changes.  The result of these submissions can be found in a
> >>>>> paper published at the 42nd IEEE Symposium on Security and Privacy
> >>>>> entitled, "Open Source Insecurity: Stealthily Introducing
> >>>>> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> >>>>> of Minnesota) and Kangjie Lu (University of Minnesota).
> >>>>>
> >>>>> Because of this, all submissions from this group must be reverted from
> >>>>> the kernel tree and will need to be re-reviewed again to determine if
> >>>>> they actually are a valid fix.  Until that work is complete, remove this
> >>>>> change to ensure that no problems are being introduced into the
> >>>>> codebase.
> >>>>>
> >>>>> Cc: Qiushi Wu <wu000273@umn.edu>
> >>>>> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> >>>>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>> ---
> >>>>>  drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 4 +---
> >>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>>>>
> >>>>
> >>>> This looks like a good commit but should be done now in a different way
> >>>> - using pm_runtime_resume_and_get().  Therefore I am fine with revert
> >>>> and I can submit later better fix.
> >>>
> >>> Great, thanks for letting me know, I can have someone work on the
> >>> "better fix" at the same time.
> >>
> >> IMO, it is better to keep the fix. I mean, there's no reason to
> >> revert a fix that it is known to be good.
> >>
> >> The "better fix" patch can be produced anytime. A simple coccinelle
> >> ruleset can replace patterns like:
> >>
> >> 	ret = pm_runtime_get_sync(pm->device);
> >> 	if (ret < 0) {
> >> 		pm_runtime_put_noidle(pm->device);
> >> 		return ret;
> >> 	}
> >>
> >> and the broken pattern:
> >>
> >> 	ret = pm_runtime_get_sync(pm->device);
> >> 	if (ret < 0)
> >> 		return ret;
> >>
> >> to:
> >>
> >> 	ret = pm_runtime_resume_and_get(pm->device);
> >> 	if (ret < 0)
> >> 		return ret;
> >
> > That's my preference as well.
>
> It won't be that easy because sometimes the error handling is via goto
> (like in other patches here) but anyway I don't mind keeping the
> original commits.

I tried the following semantic patch:

@@
expression ret,e;
@@

-     ret = pm_runtime_get_sync(e);
+     ret = pm_resume_and_get(e);
      if (ret < 0) {
              ...
?-            pm_runtime_put_noidle(e);
              ...
              return ret;
      }

It has the following features:

* The ? means that if pm_runtime_put_noidle is absent, the transformation
will happen anyway.

* The ... before the return means that the matching will jump over a goto.

It makes a lot of changes (in a kernel I had handy from March).  This is a
complicated API, however, and I don't know if there are any other issues
to take into account, especially in the case where the call to
pm_runtime_put_noidle is not present.

julia
