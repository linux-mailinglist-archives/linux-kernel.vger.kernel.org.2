Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493EB35E73D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346136AbhDMTph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346095AbhDMTpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:45:31 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A419C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 12:45:11 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e186so18291062iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upcJOzSdtmyTTQX1IXdafKF32BVsYJ7uv7HZcWzthW0=;
        b=MN9kHN7HuY6efFva11rZAeslcmoDAXpDz2MGjIPjeV9bb603YPTe+MCIwP7i6AOLl2
         z+JOkSxnmyu7qI3WTNPjR0lrhJ37w4S44bTA0xVYnQ43d0sYI6R1WyhDxOtJG8TRTsoT
         gaTfwWI0gIfuzH5Iqp1zIz5mlyBK9oXdesmzyfjkaHrGmBDTLD+LNYqRcg4ehYIzNAr1
         jZBdmiUtLMmHd4UlQV7aewF/VmRUkYwilQRXnHBePOJUy/nQ3RLwlVFoR+UfFDwDG1iJ
         ITTmEjfI0H9mOcUpwOBKJulSfLg+CW93RddQr7JFq3WuMGIyN/VgFOulnxm4k/njKwgV
         +c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upcJOzSdtmyTTQX1IXdafKF32BVsYJ7uv7HZcWzthW0=;
        b=VFbZHhWYnyPg+T6xom1TVBX/rcU1qmhF2MO+AT/xqDWyJpnuKu+UI4nu+PyVyPqhPj
         kN0mzD7z1nBBeiEcx10oxLMk/51N8lc3KY9VYNZ9sqhLUWEtdiExa2yL+RCe988gv8Vc
         v4xnEBJJjdtN1GC5v/wOBhiFAVAO5lcYJPqiv6K0dsHgChwgunPH2PNSoCkrwFJJ3oVC
         Pi5CH4gMLS3flCLS7XgQVVzqPCPC8yXzNav061LTTrU3j14Z/U6qGZmHZKFZF9pzFwJu
         0OatIcaBL0IJtqzGivAC7MUunbYXliibVLk4wEpx/l17Sz15sA4twHkXDWl8nCM3ua/u
         LWdQ==
X-Gm-Message-State: AOAM531h5TJNRI/HAbmBkeSdBTyFF6tXQWGRgB4zjv3CbHSStk8M0ncA
        tuqAmJDhWCYhDVm0fWlrmTIvw9jXSp1Y0dRRuE1zoy+B6OM=
X-Google-Smtp-Source: ABdhPJwbV8V06+saspZNqcwJyMAx5dOf3XUcNeGYjvdvGRErS6Zn3bUKmYLqizNeL1jLpDjx6JynHdRlOTfMwHzKh+s=
X-Received: by 2002:a05:6602:2089:: with SMTP id a9mr11754595ioa.90.1618343110996;
 Tue, 13 Apr 2021 12:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210413161952.750262-1-mathieu.poirier@linaro.org> <87sg3um8j1.wl-maz@kernel.org>
In-Reply-To: <87sg3um8j1.wl-maz@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 13 Apr 2021 13:45:00 -0600
Message-ID: <CANLsYkyyqSAe=9O2MyeX0z0sS501uD2+7NuDVv5V9LeAbbMDoQ@mail.gmail.com>
Subject: Re: [GIT PULL] coresight: Fixes for ETE and TRBE
To:     Marc Zyngier <maz@kernel.org>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvmarm@lists.cs.columbia.edu,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 at 10:52, Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Mathieu,
>
> On Tue, 13 Apr 2021 17:19:52 +0100,
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >
> > The following changes since commit 4fb13790417a7bf726f3867a5d2b9723efde488b:
> >
> >   dts: bindings: Document device tree bindings for Arm TRBE (2021-04-06 16:05:38 -0600)
> >
> > are available in the Git repository at:
> >
> >   git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git next-ETE-TRBE
> >
> > for you to fetch changes up to 68d400c079978f649e7f63aba966d219743edd64:
> >
> >   coresight: trbe: Fix return value check in arm_trbe_register_coresight_cpu() (2021-04-13 09:46:27 -0600)
> >
> > ----------------------------------------------------------------
> > Hi Marc,
> >
> > Please consider these two patches, they are ETE/TRBE fixes found by bots.
> >
> > Let me know if you want me to rebase on your next branch and send the
> > pull request from that.
>
> I've now pulled this into kvmarm/next. If you have additional fixes,
> just stick them on top of your next-ETE-TRBE branch like you did with
> these two patches.
>

Much appreciated - I owe you a beer.

> The kvmarm/next branch gets rebuilt every other day, so it isn't a
> stable branch on its own. Only the non-merge commits are stable, which
> is why I keep everything on topic branches.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
