Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6720836A0B1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 12:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhDXKvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 06:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhDXKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 06:51:15 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670EAC061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 03:50:36 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id c3so1571291ils.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 03:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=basnieuwenhuizen.nl; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+mHwqMkSV7d8GDDxFwm/55J+AuztD6O22so2z5EOHw=;
        b=a7MVtiU8QYSOayitVE9ceOETmQ/MO7GSffxWLukXX4tSRTB9hsa64h4KEbE/nurrJ+
         W3QB3Qf/qy4wEDzqA7Yvuz4CiTgmdZizX1wCEP+VepXhMIXQ51ZmkVlQBrEkypwsgtlo
         GlT+vvr4mT6GQoqEhUS9JMlElWeyiiOwco+hvWF9UU3BK1GC/fv7V2lILYVm9ydiIEgP
         JNhtrARQC3STFM6Or1qDG1NOqx7l0Xh+sZj6bhPlLMpTU9hs64TTZN0vfoZsL44yvQCs
         nJODDcDjAZzV9xBrprSu8lpG9SchVlM92wcXjiNmHrK4ttCAOQLjkRnzXI2R/aqyepRi
         FPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+mHwqMkSV7d8GDDxFwm/55J+AuztD6O22so2z5EOHw=;
        b=X1aTWGThDo7KZtX6P+Nu7LPG/Wz2bHlSGE98WcaVqix3GzKTB0HGGAlWs995yFkPxU
         D0WhkO6Mgb8Pm2+inNqmZ8M0UgI2++eHx6Gd6jFB2KMjq43IXLKE8zzCWP2vQ58SE4RO
         ky8+27nP2UsbHJ3cu1OMF5ykKO+kTSrQxG/NDaJI5dmn/ot079o9zOW002fY2W/4+758
         4JesXjSshRvIo3efXsBl/SdsSDONJ4dLBiCH3cbeYEk4jIJ4r3I98/3KVqWfLvhf2OOK
         DgQ8KFZVCZc3OShqKQOEPb64Ji7W6Qh+5iBwqgrAPOSsuc5pXwU1FI1BJ32ZAMaEZtAs
         Fntw==
X-Gm-Message-State: AOAM530edTeO4P7WLrLbNuU0CXh650qLwBaOjGQVtJkCnNpgVZ59+TIP
        p0iKHYFWXHqjmS3CiFd8CJYa0Ta8id05cbc7oNxlCg==
X-Google-Smtp-Source: ABdhPJwglY03kWTAHo+Ma2BIfMEi1r+Xk8kC9NAoJJ+nRaHu/pJl8r/+nkEg2YKQFg6b8sFQqWKhoQxhzRHbVJQHD9I=
X-Received: by 2002:a92:d68a:: with SMTP id p10mr6426348iln.40.1619261435744;
 Sat, 24 Apr 2021 03:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
 <20210308134957.23852-1-youling257@gmail.com> <CAAYoRsXec2eq=t-pSn5TOqNt0G6kfZCKkDuEhCnX5SgL0zgkBg@mail.gmail.com>
 <20210308161548.GA37664@chenyu-desktop> <CAAYoRsVkrHberSgM42dqYjdVwz8vumURJ1_DGeV1R5-=LMdjVA@mail.gmail.com>
 <20210312134114.GA21436@chenyu-desktop> <20210424014343.GA432544@chenyu-desktop>
In-Reply-To: <20210424014343.GA432544@chenyu-desktop>
From:   Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date:   Sat, 24 Apr 2021 12:50:30 +0200
Message-ID: <CAP+8YyE2KKgrxF+RV_iYao8Hc5vSjXiRPZ39WzL6Yj2qZ3QL8w@mail.gmail.com>
Subject: Re: [3/3,v3] tools/power turbostat: Enable accumulate RAPL display
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Bingsong Si <owen.si@ucloud.cn>,
        youling257 <youling257@gmail.com>, erwanaliasr1@gmail.com,
        lenb@kernel.org, rjw@rjwysocki.net,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(apologies for resend, seems my client switched to HTML before)

On Sat, Apr 24, 2021 at 3:40 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Hi Bas Nieuwenhuizen,
> On Fri, Mar 12, 2021 at 09:41:14PM +0800, Chen Yu wrote:
> > Hi Youling, Bas, and Bingsong,
> > On Wed, Mar 10, 2021 at 04:03:31PM -0800, Doug Smythies wrote:
> > > Hi Yu,
> > >
> > > I am just resending your e-mail, adjusting the "To:" list to
> > > include the 3 others that have submitted similar patches.
> > >
> > > ... Doug
> > >
> > Could you please help check if the following combined patch works?
> >
> > Thanks,
> > Chenyu
> >
> >
> > From 00e0622b1b693a5c7dc343aeb3aa51614a9e125e Mon Sep 17 00:00:00 2001
> > From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Date: Fri, 12 Mar 2021 21:27:40 +0800
> > Subject: [PATCH] tools/power/turbostat: Fix turbostat for AMD Zen CPUs
> >
> > It was reported that on Zen+ system turbostat started exiting,
> > which was tracked down to the MSR_PKG_ENERGY_STAT read failing because
> > offset_to_idx wasn't returning a non-negative index.
> >
> > This patch combined the modification from Bingsong Si and
> > Bas Nieuwenhuizen and addd the MSR to the index system as alternative for
> > MSR_PKG_ENERGY_STATUS.
> >
> > Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
> > Reported-by: youling257 <youling257@gmail.com>
> > Co-developed-by: Bingsong Si <owen.si@ucloud.cn>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> >
> Can I add your SOB here if you are not object to it?

Yes, seems fine by me. Thanks!

>
> thanks,
> Chenyu
