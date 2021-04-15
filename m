Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2615435FF13
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 02:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhDOAuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 20:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhDOAuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 20:50:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EC5C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 17:49:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so3842227pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 17:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fOJI4hThVgEOLJyImgusGGiOxy9mpTSNJ/Mrm5n5Wk0=;
        b=lEI57So+mLNKqR8MOcAK5p3MZw4vqrkk9etbelECfBcXuY5eDWQoby3QMZLzSfY8Ld
         RvK2vdibjbtjGeqLJkWkmBpcWbieDeicodh6t61TVGzdFOeCO2Tfi3KhnWWSjua3I+7/
         zjdNxm+qgvPvgZ9WsJ9ZUeZ5YYiuAJh6XbZ6tEsTahjj4Zht3bVEskNbzX1vDUHFjevH
         xvzIDu3EKHqfEu4p4n1g3O6vhoUbUZUSS7b6TvAcCczNn3L241mIvi8mFqtGd8FZSgLw
         Yy8ROdcJrDJ/TYNZnks+IkY99l1c7xmHX3Jt5yK9PVXmr+doXnNzkHsWhkATfYP4LBZn
         OCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fOJI4hThVgEOLJyImgusGGiOxy9mpTSNJ/Mrm5n5Wk0=;
        b=g17Gd0BMsBMThS7zmfTghIPOfcP/D0glZiU85kNz8DAlx3olAU4GL7mrE+8HvI7nwS
         AmlmkeOWu4KRV+343O4DPQ/HrbkcyIqXha/0A69LqtrfrqKjWsG2S+edyMIb/MDKClQt
         5qUzxnItEV1QjQpNjvB2JU3ITItnJPAFAlytYKr3yG0XsaNh/AViCc1UoazA8Fg7g9SU
         cUHMkAgxqjmPGwUH0l2/jWF6gKa2eFiqwjwT8ttO1JrF+/mOJ/3YB5zKBro/yO190UcB
         r+GEZfa9/X9WUZaz08qI+4Z3FRAd2wT+g7i/NYXLn64immBjS0qTORQOIRd8nDYL+by8
         mqHQ==
X-Gm-Message-State: AOAM530xGvurcKEttu2Ay3ADBHhtr41Md+eENNgiHdP+aEGOSfPItPT7
        hrghls1B770HicI7BFZH7RMy9g==
X-Google-Smtp-Source: ABdhPJxRBMrjNapa9s3nteduAiJXZXONsLdWBJOaAaq7bl/eTin1t4vjjR9fsQXFfqGsZoPswRvjvQ==
X-Received: by 2002:a17:90a:fa0c:: with SMTP id cm12mr915481pjb.54.1618447785825;
        Wed, 14 Apr 2021 17:49:45 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id z29sm589556pga.52.2021.04.14.17.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 17:49:45 -0700 (PDT)
Date:   Thu, 15 Apr 2021 00:49:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2 0/3] KVM: Properly account for guest CPU time
Message-ID: <YHeNpUd1ZO1JVaAf@google.com>
References: <1618298169-3831-1-git-send-email-wanpengli@tencent.com>
 <YHXUFJuLXY8VZw3B@google.com>
 <CANRm+CzDW_5SPM0131OvRn3UPBp1nahxCykCP61XWeUpYeHU5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+CzDW_5SPM0131OvRn3UPBp1nahxCykCP61XWeUpYeHU5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021, Wanpeng Li wrote:
> On Wed, 14 Apr 2021 at 01:25, Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Tue, Apr 13, 2021, Wanpeng Li wrote:
> > > The bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=209831
> > > reported that the guest time remains 0 when running a while true
> > > loop in the guest.
> > >
> > > The commit 87fa7f3e98a131 ("x86/kvm: Move context tracking where it
> > > belongs") moves guest_exit_irqoff() close to vmexit breaks the
> > > tick-based time accouting when the ticks that happen after IRQs are
> > > disabled are incorrectly accounted to the host/system time. This is
> > > because we exit the guest state too early.
> > >
> > > This patchset splits both context tracking logic and the time accounting
> > > logic from guest_enter/exit_irqoff(), keep context tracking around the
> > > actual vmentry/exit code, have the virt time specific helpers which
> > > can be placed at the proper spots in kvm. In addition, it will not
> > > break the world outside of x86.
> >
> > IMO, this is going in the wrong direction.  Rather than separate context tracking,
> > vtime accounting, and KVM logic, this further intertwines the three.  E.g. the
> > context tracking code has even more vtime accounting NATIVE vs. GEN vs. TICK
> > logic baked into it.
> >
> > Rather than smush everything into context_tracking.h, I think we can cleanly
> > split the context tracking and vtime accounting code into separate pieces, which
> > will in turn allow moving the wrapping logic to linux/kvm_host.h.  Once that is
> > done, splitting the context tracking and time accounting logic for KVM x86
> > becomes a KVM detail as opposed to requiring dedicated logic in the context
> > tracking code.
> >
> > I have untested code that compiles on x86, I'll send an RFC shortly.
> 
> We need an easy to backport fix and then we might have some further
> cleanups on top.

I fiddled with this a bit today, I think I have something workable that will be
a relatively clean and short backport.  With luck, I'll get it posted tomorrow.
