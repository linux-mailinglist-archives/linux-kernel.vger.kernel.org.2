Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF493D7529
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 14:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhG0MiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 08:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231931AbhG0MiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627389499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZDouoyOqLsKp2iTq9JOWK7JiKU0dCWcs56CWcoTOuA=;
        b=PvdBunLKj1mrbWRSmJsXd10DfoqMG42vYAn1PBQmNy22pfOkoh6Ip1InB4znMWxnYEZG7Y
        bLpx33xa00idgjJR/ddPq+LXD9XL0g2eCs4ZQzEjvbnPxRq0KlScYvtAsnw59d7KLsf6Hx
        VziBWraUID41l1XihS3b6nvayEuB3cY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-FapNnTiPNvud_klWay_o4A-1; Tue, 27 Jul 2021 08:38:17 -0400
X-MC-Unique: FapNnTiPNvud_klWay_o4A-1
Received: by mail-wr1-f70.google.com with SMTP id o11-20020a5d474b0000b02901533f8ed22cso4488574wrs.22
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 05:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IZDouoyOqLsKp2iTq9JOWK7JiKU0dCWcs56CWcoTOuA=;
        b=A+eo732o+lt+y1LhLlDDhtVRFMFIeD8k78776K9FMOOFPyBnsSszeZPNsmSpowlx4x
         vb+gv1vRFRfR7QYJxUKZOx44qxCTEyiya8+tj/N8Hwqs28yQRV+aPZo/1O+yahL4Nj9y
         UHmNKAGhLM81Fg3i3vkCXgiE3Gzh2Aiet0U9mYAZcKsZuVjbCh0G/X36RtUd6muw+Z1I
         MG/FUWW+rpOu80cnc3V3lArexl0rLtSwz4MGMQALmi/K/LZa0BE1dpVlF3jr/PBocFh3
         z6NFkJCqqdmICfOVL5HcdPFDFq/qFLPZYNVeX1C6gJGxyaxNtcAlA/kAZ7jY4ZZ3C1c2
         xSGA==
X-Gm-Message-State: AOAM530muAsbIuUMSpRt+P5dP5NwgnqGcWDZ+kgDG4a4xJokhQnJ3qGm
        3K0DPftS80jzP0Ju0tKAKsbvVW2PPhlSvFTR7rN/KAT8lk9hg4MJLxKurnPkHY3kc8/4J/3d8ad
        8EPLTj5UBnLgqOwXDqAOfh0zA
X-Received: by 2002:a05:600c:3587:: with SMTP id p7mr3887632wmq.27.1627389496616;
        Tue, 27 Jul 2021 05:38:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVQooG1f2mN8fZn4UGTF1VMJSG+9/gaqV9ps5c96Gbz/wRSWsucgKBUs2rgAFROKck95zraA==
X-Received: by 2002:a05:600c:3587:: with SMTP id p7mr3887614wmq.27.1627389496429;
        Tue, 27 Jul 2021 05:38:16 -0700 (PDT)
Received: from [192.168.1.136] ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id w9sm2939077wmc.19.2021.07.27.05.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 05:38:16 -0700 (PDT)
Message-ID: <a020a45ddea10956938f59bd235b88fe873d0e98.camel@redhat.com>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
From:   nsaenzju@redhat.com
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>, Peter Xu <peterx@redhat.com>
Date:   Tue, 27 Jul 2021 14:38:15 +0200
In-Reply-To: <20210727110050.GA502360@fuller.cnet>
References: <20210727103803.464432924@fuller.cnet>
         <20210727104119.551607458@fuller.cnet>
         <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
         <20210727110050.GA502360@fuller.cnet>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Tue, 2021-07-27 at 08:00 -0300, Marcelo Tosatti wrote:
> On Tue, Jul 27, 2021 at 12:48:33PM +0200, nsaenzju@redhat.com wrote:
> > On Tue, 2021-07-27 at 07:38 -0300, Marcelo Tosatti wrote:
> > > +Isolation mode (PR_ISOL_MODE):
> > > +------------------------------
> > > +
> > > +- PR_ISOL_MODE_NONE (arg4): no per-task isolation (default mode).
> > > +  PR_ISOL_EXIT sets mode to PR_ISOL_MODE_NONE.
> > > +
> > > +- PR_ISOL_MODE_NORMAL (arg4): applications can perform system calls normally,
> > > +  and in case of interruption events, the notifications can be collected
> > > +  by BPF programs.
> > > +  In this mode, if system calls are performed, deferred actions initiated
> > > +  by the system call will be executed before return to userspace.
> > > +
> > > +Other modes, which for example send signals upon interruptions events,
> > > +can be implemented.
> >
> > Shouldn't this be a set of flags that enable specific isolation features?
> > Something the likes of 'PR_ISOL_QUIESCE_ON_EXIT'. Modes seem more restrictive
> > and too much of a commitment. If we merge MODE_NORMAL as is, we won't be able
> > to tweak/extend its behaviour in the future.
>
> Hi Nicolas,
>
> Well, its assuming PR_ISOL_MODE_NORMAL means "enable all isolation
> features on return to userspace".
>
> Later on, if desired, can add extend interface as follows (using
> Christoph's idea to not perform automatic quiesce on return to
> userspace, but expose which parts need quiescing
> so userspace can do it on its own, as an example):
>
> #define PR_ISOL_QUIESCE_ON_EXIT (1<<0)
> #define PR_ISOL_VSYSCALL_PAGE   (1<<1)
> ...
>
> unsigned long bitmap = PR_ISOL_VSYSCALL_PAGE;
>
> /* allow system calls */
> prctl(PR_ISOL_SET, PR_ISOL_MODE, PR_ISOL_MODE_NORMAL, 0, 0, 0);
>
> /*
>  * disable quiescing on exit, enable reporting through
>  * vsyscall page
>  */
> prctl(PR_ISOL_SET, PR_ISOL_FEATURES, &bitmap, 0, 0);
> /*
>  * configure vsyscall page
>  */
> prctl(PR_ISOL_VSYSCALLS, params, ...);
>
> So unless i am missing something, it is possible to tweak/extend the
> interface. No?

OK, sorry if I'm being thick, but what is the benefit of having a distincnt
PR_ISOL_MODE instead expressing everything as PR_ISOL_FEATURES.

  PR_ISOL_MODE_NONE == Empty PR_ISOL_FEATURES bitmap

  PR_ISOL_MODE_NORMAL == Bitmap of commonly used PR_ISOL_FEATURES
  			      (we could introduce a define)

  PR_ISOL_MODE_NORMAL+PR_ISOL_VSYSCALLS == Custom bitmap

Other than that, my rationale is that if you extend PR_ISOL_MODE_NORMAL's
behaviour as new features are merged, wouldn't you be potentially breaking
userspace (i.e. older applications might not like the new default)?

--
Nicolás Sáenz

