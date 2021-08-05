Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319103E0C16
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 03:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbhHEBcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 21:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHEBcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 21:32:23 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DA1C061765
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 18:32:04 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id dk2so2149262qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 18:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YAY2Qb7WkkEBSO40d4z2FxXhlVqwrIfM7DdfegF+11A=;
        b=oYHCWdyF1pjme34fzDrFdwZKziOMp7upVq+xM0ncoBA0N8GvIjlBqOlFl9gcgKvdiI
         3JMm+rFVd9/bAKdars2xy6UTpgl3leFMmWYmeeDu8Dz2KyOrAT+CRoFDSfibqji+a9Fp
         4ZDmpvcETx38unSGLiDw5YOUyHzt4uYHhagVxab20nZpbnKwBWBjCvC+b/Vd7M7fmy1H
         hOxH3TDXfq7WoBXHpaRP4WQewOxB/yJJeumXPnHPWgGHxBXuNaQ8IVOicuNtHnC0n01d
         eUNN1HNiuoB6m9ijCPxSci89r0q42Q9mEVX0vVfZWj4dPXg2z6C6IjC0LC0ch0LNLxAd
         cs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YAY2Qb7WkkEBSO40d4z2FxXhlVqwrIfM7DdfegF+11A=;
        b=am5JxpPfb7MsfIiAr5i/8RpwlgFDjDUczMziKc10qWcZZxvwsTOQSJS0flsJjjTf/g
         BWqHDAaKPQykjSShPRDuiTxBB3KTAfDBPxAtLlY4lo7aVb6iH38ckzh7A9mzXBNJAoB1
         I3fgbzbFq0HfpKzlUNrGC0qjNh60CkKf8o78R90Fg0b7YnraAd7a61lOwkKahdzynSlu
         3oPfnTncm6dyKWvODSTJE3eYEEBIHnCz7utSJMx3MSHlUP1tlpVOiS3xJ9gTEDP5rTh1
         XGJ58p8Zn676Mop/XBrzo6X2GMF+XzS5p3ltDNZ7AMdEmmPuYU0+WvbmJTWMX9sORjGh
         /D7g==
X-Gm-Message-State: AOAM532aRUg1Wgm49OJgutFIQJ7/JBuMEQ1KZndwbclCTtvdJAkNp/x2
        qi3Dq20ZTfj16S+e5NAWY7NNxMGGgJabnjWRpRU=
X-Google-Smtp-Source: ABdhPJxn8VYtM2x1dqkiuk6cvTb/7aMUyJ6ikEzvDB1KNkAkgWmFP5FkNoAdR64QBCWsWsxnNYIA/SwMvysBsv+8lTk=
X-Received: by 2002:a05:6214:7f2:: with SMTP id bp18mr2558742qvb.9.1628127123631;
 Wed, 04 Aug 2021 18:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <DM8PR11MB57506E8A74FE33AC50899F81BDF19@DM8PR11MB5750.namprd11.prod.outlook.com>
 <DM6PR11MB2540671F57AA4E16782FB502F9F29@DM6PR11MB2540.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB2540671F57AA4E16782FB502F9F29@DM6PR11MB2540.namprd11.prod.outlook.com>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Thu, 5 Aug 2021 09:31:46 +0800
Message-ID: <CAJRGBZxncgsMP4qu+YbVgUaTBt=Uxp=2XPvAg1-QAvh+0p=Z_Q@mail.gmail.com>
Subject: Re: Questions on patch set: x86/fault: #PF improvements, mostly
 related to USER bit
To:     "Yu, Luming" <luming.yu@intel.com>
Cc:     "Lutomirski, Andy" <luto@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Han, Jing1" <jing1.han@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

try again.

On Thu, Aug 5, 2021 at 9:28 AM Yu, Luming <luming.yu@intel.com> wrote:
>
> Cc=E2=80=99 gregkh
>
>
>
> It would be nice if we can see the patch set available in 5.10-xx stable =
tree.
>
> But Jing=E2=80=99s finding on Linus tree about the commit seemed to indic=
ate the commit id
>
> Of the patch and the commit  log and patch could not lead to the  revisio=
n of arch/x86/mm/fault.c
>
> By the patch of the commit itself. So it is hard for Jing to do a clean b=
ack port with the inconsistent git log.
>
>
>
> BR
>
> Luming
>
>
>
> From: Han, Jing1 <jing1.han@intel.com>
> Sent: Wednesday, August 4, 2021 8:44 PM
> To: Lutomirski, Andy <luto@kernel.org>
> Cc: Yu, Luming <luming.yu@intel.com>
> Subject: Questions on patch set: x86/fault: #PF improvements, mostly rela=
ted to USER bit
>
>
>
> Hi Luto,
>
>
>
> When trying to backport your patch from upstream to 5.10.18: https://lore=
.kernel.org/lkml/cover.1612924255.git.luto@kernel.org/
>
> I find something wrong with this commit: 2cc624b0a7e68ba8957b18600181f7d5=
b0f3e1b6 x86/fault: Split the OOPS code out from no_context()
>
> The code after this commit in upstream does not align with the code showe=
d in the patch.
>
> To be exactly, the function name is =E2=80=9Cno_context=E2=80=9D in the p=
atch, while it is =E2=80=9Ckernelmode_fixup_or_oops=E2=80=9D in upstream co=
de.
>
> Could you please check what is the problem?
>
> (Another confusion is, there are 14 patches total in the link above, but =
13 patches in upstream code.)
>
>
>
> I do the backport it because it is preparation for CET, I will backport C=
ET to 5.10.18 when it is upstreamed as there is customer request.
>
> Will you provide the backport patch to 5.10 stable branch?
>
>
>
> Thank you very much,
>
> Jing
>
>
