Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7BB4376A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 14:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhJVMVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 08:21:10 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:29859
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbhJVMVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:21:06 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A0TmYvKprIPZbn3W674J/tD8aV5tWL9V00zEX?=
 =?us-ascii?q?/kB9WHVpm5qj5r+TdZMgpHrJYVcqKRMdcL+7U5VoLUm3yXcx2+cs1J2ZLXDbUR?=
 =?us-ascii?q?KTXflfBOnZrAEIaheOldK1vJ0IG5SWSueQMbEdt6vHCWKDc+rIruPqzEmAv5ah?=
 =?us-ascii?q?815dCS9rdoRp5ENcBh2UHnZ7XBVLH4d8NLf03Ls9mxOQPVoWc+GyDT0gU/PMq+?=
 =?us-ascii?q?bGjI7rewNDJz4LgTP+9w+A2frVEwW81hxbdDVTwbgj+2DZkwr/3amqqfe9oyWs?=
 =?us-ascii?q?qlP73tB5mMbFwtAGPdeLicQeN1zX+2KVTbUkdb2emTg/5Ni17lUnmsSJgxpIBb?=
 =?us-ascii?q?UV11rhOk+0vD7k0E3YyzAs53X+jWaRnHqLm72eeBsKT+RAmKdQeV/j51MkrJVf?=
 =?us-ascii?q?3LIj5RPki6Zq?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397071971"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 14:18:46 +0200
Date:   Fri, 22 Oct 2021 14:18:46 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     kushal kothari <kushalkothari285@gmail.com>
cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kush19992810@gmail.com, outreachy-kernel@googlegroups.com,
        fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mike Rapoport <mike.rapoport@gmail.com>,
        kushalkotharitest@googlegroups.com
Subject: Re: [Outreachy kernel] Re: [PATCH 0/4] v2 staging: rtl8723bs: core:
 Cleanup patchset for style issues in rtw_cmd.c
In-Reply-To: <CALtHPQt5jzcn4Obw8UCmz2XZK0FFZbEt6ebXEaTa5rwbAyHVOQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110221418400.7321@hadrien>
References: <cover.1634899405.git.kushalkothari285@gmail.com> <7977747.61zFHCMloo@localhost.localdomain> <CALtHPQt5jzcn4Obw8UCmz2XZK0FFZbEt6ebXEaTa5rwbAyHVOQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1273979325-1634905126=:7321"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1273979325-1634905126=:7321
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 22 Oct 2021, kushal kothari wrote:

> >Hi Kushal,
>
> >Version numbers ("v2" in this case) must be enclosed in square brackets,
> >between "PATCH" and "n/N".
>
> >Thanks,
>
> >Fabio
>
> Hi Fabio,
> Err, I made a mistake. :(
> So should I correct it now as v3?

Yes.

>
> On Fri, Oct 22, 2021 at 5:17 PM Fabio M. De Francesco <fmdefrancesco@gmail.com> wrote:
>       On Friday, October 22, 2021 1:37:34 PM CEST Kushal Kothari wrote:
>       > Kushal Kothari (4):
>       >   v2 staging: rtl8723bs: core: Remove true and false comparison
>       >   v2 staging: rtl8723bs: core: Remove unnecessary parentheses
>       >   v2 staging: rtl8723bs: core: Remove unnecessary space after a cast
>       >   v2 staging: rtl8723bs: core: Remove unnecessary blank lines
>       >
>       > Changes from v1:
>       >   [PATCH 1/4]: Moved unnecessary parentheses change in PATCH 2/4
>       >   [PATCH 2/4]: Added the extra parentheses change from PATCH 1/4 here.
>       >   [PATCH 3/4]: No Changes
>       >   [PATCH 4/4]: Fix whitespace error.
>       >
>       >
>       >
>       >  drivers/staging/rtl8723bs/core/rtw_cmd.c | 94 +++++++++---------------
>       >  1 file changed, 34 insertions(+), 60 deletions(-)
>       >
>       > --
>       > 2.25.1
>       >
>       Hi Kushal,
>
>       Version numbers ("v2" in this case) must be enclosed in square brackets,
>       between "PATCH" and "n/N".
>
>       Thanks,
>
>       Fabio
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/CALtHPQt5jzcn4Obw8UCmz2XZK0FFZbEt6ebXEaTa5rwbAyHVOQ%40mail.gmail.com.
>
>
--8323329-1273979325-1634905126=:7321--
