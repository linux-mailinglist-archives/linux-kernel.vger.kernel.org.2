Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7335ADE7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhDJOCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:02:08 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43482
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234548AbhDJOCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:02:07 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ar6mAq67lpGrAOLVITwPXwCnXdLJzesId70hD?=
 =?us-ascii?q?6mlaTxtJfsuE0/2/hfhz726RtB89UGwt8OrqBICuWnXZnKQe3aAwOvOYUBDiqC?=
 =?us-ascii?q?+UKuhZjLfK5x3FN2nA+vVG1aFmGpIObeHYKVRhl8717E2ZPr8boOWvy6yjiefA?=
 =?us-ascii?q?w3oFd2gDV4ha4wh0EQqdGEFtLTM2ZqYRLoaW5cZMulObF0g/U8LTPBU4dtTYq8?=
 =?us-ascii?q?aOvJzrZgNuPW9E1CC+yQLt0rL8HhSCty1ybxpEy94ZnlT4rw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,212,1613430000"; 
   d="scan'208";a="378288243"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 16:01:51 +0200
Date:   Sat, 10 Apr 2021 16:01:51 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 4/4] staging: rtl8723bs: Change the
 type and use of a variable
In-Reply-To: <3114102.qbl0ZuBMXl@localhost.localdomain>
Message-ID: <alpine.DEB.2.22.394.2104101601100.2975@hadrien>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com> <2186059.xkuF2sVEJi@localhost.localdomain> <alpine.DEB.2.22.394.2104101524260.2975@hadrien> <3114102.qbl0ZuBMXl@localhost.localdomain>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Apr 2021, Fabio M. De Francesco wrote:

> On Saturday, April 10, 2021 3:24:43 PM CEST Julia Lawall wrote:
> > On Sat, 10 Apr 2021, Fabio M. De Francesco wrote:
> > > On Saturday, April 10, 2021 2:12:28 PM CEST Julia Lawall wrote:
> > > > On Sat, 10 Apr 2021, Fabio M. De Francesco wrote:
> > > > > On Saturday, April 10, 2021 1:37:30 PM CEST Julia Lawall wrote:
> > > > > > > That variable has global scope and is assigned at least in:
> > > > > > What do you mean by global scope?  None of the following look
> > > > > > like
> > > > > > references to global variables.
> > > > > >
> > > > > > julia
> > > > >
> > > > > I just mean that fw_current_in_ps_mode is a field of a struct in a
> > > > > .h
> > > > > file included everywhere in this driver and that the functions whom
> > > > > the following assignments belong to have not the "static" type
> > > > > modifier.
> > > >
> > > > OK, but a field in a structure is not a variable, and this is not
> > > > what
> > > > scope means.
> > >
> > > You're right, a field in a structure is not a variable.
> > >
> > > > int x;
> > > >
> > > > outside of anything is a global variable (global scope).
> > > >
> > > > int foo() {
> > > >
> > > >   int x;
> > > >   ...
> > > >
> > > > }
> > > >
> > > > Here x is a local variable.  Its scope is the body of the function.
> > > >
> > > > int foo() {
> > > >
> > > >   if (abc) {
> > > >
> > > >     int x;
> > > >     ...
> > > >
> > > >   }
> > > >
> > > > }
> > > >
> > > > Here x is a local variable, but its scope is only in the if branch.
> > >
> > > And you're right again: I needed a little refresh of my knowledge of C.
> > >
> > > I've searched again in the code for the purpose of finding out if that
> > > struct is initialized with global scope but I didn't find anything. I
> > > didn't even find any dynamic allocation within functions that returns
> > > pointers to that struct.
> > >
> > > Therefore, according to Greg's request, I'll delete that stupid 'if'
> > > statement in the patch series v2 that I'm about to submit.
> >
> > I'm really not clear on why the if should be deleted.
> >
> > julia
> >
> I'm supposed to delete it because of the review made by Greg. In a couple
> of previous messages he wrote:
>
> "If this is only checked, how can it ever be true?  Who ever sets this
> value?"
>
> and then:
>
> "Just delete the variable from the structure entirely and when it is
> used.".
>
> However, like you, I'm not sure yet.

Be sure.  Greg already said that he misinterpreted the patch, because he
thought that the name also changed.

julia


>
> Thanks,
>
> Fabio
> >
> > > I've really appreciated your help.
> > >
> > > Thanks,
> > >
> > > Fabio
> > >
> > > > julia
> > > >
> > > > > Thanks,
> > > > >
> > > > > Fabio
> > > > >
> > > > > > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:368:
> > > > > > > pwrpriv->fw_current_in_ps_mode = false;
> > > > > > >
> > > > > > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:380:
> > > > > > > pwrpriv->fw_current_in_ps_mode = true;
> > > > > > >
> > > > > > > drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:433:
> > > > > > > adapter_to_pwrctl(padapter)->fw_current_in_ps_mode = false;
> > > > > > >
> > > > > > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:981:
> > > > > > > pwrctrlpriv->fw_current_in_ps_mode = false;
>
>
>
>
>
