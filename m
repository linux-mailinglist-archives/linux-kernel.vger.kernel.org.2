Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F7E3A2932
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 12:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFJKUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 06:20:02 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:35792 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhFJKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 06:19:59 -0400
Received: by mail-pl1-f169.google.com with SMTP id x19so754008pln.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 03:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3j652hMSmumnPjiwDEzvETKW8nYLEioOK5CINNUshec=;
        b=vBYAOfgSwASBg0zI9JRdcm4Pyz8/ddzff5dfbynz/oO8GfgCbzW47MegVETl9bjakN
         ktlE+WPeWxs9leXWL/R+xXX5fge1J4vg+Xy5AeXQNarAe60IrBaNoMddhw6LcaAY4Cfa
         tQa4HoP/TJ79NzyNFCcDDc60yv5zEMn/mvU5ugACPthCuVPRzHar0jyQNYwNmob06yXE
         L97O4PtgaMM4ydG6D1vHKQd8ix2d0+3WFi16jBiY13MEJu79Z9zm8TFRLfFHsg/gupCp
         Cxg874UeTI0yINFqmB0FDOmD96hbbImxzIXD/xh0FslIk4bhsNBdxtYffN79cuECecw2
         6dQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3j652hMSmumnPjiwDEzvETKW8nYLEioOK5CINNUshec=;
        b=AzoNRmP/2TEE3P+EZu5FPQtcSRjNfdExm7zN4MQq7/YkrcTo/xrtK7yBHvlBXwaXmD
         6L9STqc8V9JgcWDvuXQsM1xG3FdkegQmOhRbsAqp7opVy+oIkXp20moWwsKvvTo2XxLv
         lObcF2VbKHAPC8c4OEuBkQgxL7xt1W1aQGjBJH/Aj44fin3CmSg0cnPjVNw5FQyZnkHs
         wlqG5oQFkG7isGS7lAJa/e8DLS5ot+LFUg+JXg7loDEDZ2SUir5Lng16vqCv5WGTMIeX
         W4bs+lwvXthvU6St/CTCfDh4XVW1KitarweJo1ZgvXuTTo6/hDFzFrCtXiUcJ3NGwKB0
         wmHQ==
X-Gm-Message-State: AOAM530Hw7cVfGdp2XZzA2i6uqzVxceCJQyh6nBsLYO/SLP6u+KGEOJ9
        APXZ0CgRI8A2y885Ey4BlXvh44ytMGInZ6B0ugI=
X-Google-Smtp-Source: ABdhPJwFnwjQNLsalt0geh3MXPOsUOTOv3Q+03lVckIBHeA/JbJqTjX6mF5dTdvP0O0fLSwKM3q2VVqR7Ok12zsKXOg=
X-Received: by 2002:a17:90b:818:: with SMTP id bk24mr2640093pjb.228.1623320209431;
 Thu, 10 Jun 2021 03:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <1623141934-7699-1-git-send-email-faiyazm@codeaurora.org>
 <CAHp75VcwW6RGALAjzcK4W9xy_hDPyFti4cNY_pCwJnjUr+VYVQ@mail.gmail.com>
 <b84892d5-06ed-fdbe-b5b3-0956140573ec@codeaurora.org> <78fc8848-bde8-769e-f8e9-6157d232a60f@suse.cz>
 <47842d8d-2747-3d0f-8695-122dc23d90e6@codeaurora.org> <7d652fca-23f3-fc03-c7b2-310edcafebb3@codeaurora.org>
In-Reply-To: <7d652fca-23f3-fc03-c7b2-310edcafebb3@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 13:16:33 +0300
Message-ID: <CAHp75Vc8itj5ZEeqSH2UueLoYuODqUqD_ode4WqAag=jk5uj_Q@mail.gmail.com>
Subject: Re: [PATCH v11] mm: slub: move sysfs slab alloc/free interfaces to debugfs
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>, glittao@gmail.com,
        vinmenon@codeaurora.org, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:57 AM Faiyaz Mohammed <faiyazm@codeaurora.org> wrote:
> On 6/8/2021 11:43 PM, Faiyaz Mohammed wrote:
> > On 6/8/2021 11:05 PM, Vlastimil Babka wrote:
> >> On 6/8/21 7:11 PM, Faiyaz Mohammed wrote:

...

> >> I *think* Andrew wouldn't have this issue, so maybe resend only if he says it's
> >> needed.
> > Sure, I will send if he ask.
> Do I need to send patch with new version number?.

Always make your intentions clear. Currently they are unclear (two
different submissions with the same versions => confusing).

> >> On the other hand I did have troubles to apply the last version locally, patch
> >> (tool) complained of patch (file) being malformed at the end. Did you add or
> >> delete lines from it after generating the patch? I had to use the recountdiff
> > Yes, I added one line manually, I think that causes the issue.
> >
> >> tool to fix this. If you're going to resend, please make sure it's without the
> >> same issue.
> >>
> > Okay


-- 
With Best Regards,
Andy Shevchenko
