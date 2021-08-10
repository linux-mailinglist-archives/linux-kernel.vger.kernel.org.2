Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3841B3D7B63
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhG0QvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhG0QvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:51:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E29C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:51:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d17so22901997lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CluUB6u3e6vSvuTj9ZDWKd+9lXyRKKVlLnHCPzqySkA=;
        b=Y/LXubLHM6WaUYdSxC4yHzA/PTO+4Iqp9OsSGe3NsOGrtNlHl58r72AsYkXhdSCVQk
         D92+/e/bbScw3fEpORhyJziDUQ06Gip3vgD3hI415HLxOwopdy18WMhqzBtHqCVEgmxr
         SPY77804g9crzhfRDMDqNBaVg9Bl2zAu41NtTzjt29nfXSWgJUAXMlkN8MPczoEzISHv
         bbXgRZMI/bPixBkPOaTWs49nEb+UsiQSNOLJw9Q/S10QHZFu3H/OTvTsq+zZPxC0vjAh
         rrV7zb89dwiur8VffZobyLrz4fGDFLjJly+sTkMvJIcOfKoTB+1K2qPRuEuV0/d5a2z7
         XRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CluUB6u3e6vSvuTj9ZDWKd+9lXyRKKVlLnHCPzqySkA=;
        b=En15e0fT4B4L9cwGk/TX8QM6qsFxg7+nREbqr4daH0q5B8Bjm482L8rF4nEtCwd8RB
         PwAxKGqNL9RK4DXSHh/af1OgVMmt7Gkl2NMGW+mMxUAOig2xQKrM/Sh/QGYvl8y85uV/
         jalebArEI9aJb59eAKkk7a8FxI+W0A6ATVb4jvL/NurIbxsV16K+x1xHbBPseVe7tgHh
         jX8Y/aNSbXBwZZBCgy5OJkDjBF12vXmZP1567CINAXsYKwac91fhgJKCZquG/zNBeLcO
         TDqWoEsQnhI1nrSRiuy7ONad1pvr8M24AE9IiuIuWwLmFp7jpu5ZnhKUehplpSpF5JDg
         PqAQ==
X-Gm-Message-State: AOAM533/SlexsWGi1rU+6t8ootAHC/ZVvKVh6KvpZLR6ZSrPLhzkQ3sw
        mVwVmXSz3iA1LH36enS/u34EF0ZzdNBc1dvBbh8dIA==
X-Google-Smtp-Source: ABdhPJwinnOp7LjvAilkuinLLIl+9qfP8oHa34sG0n2oo4sUeXbIfm5KNwPE3aKhFouKSl1emBjwQ+N+PxaU3gf/2s8=
X-Received: by 2002:ac2:4d86:: with SMTP id g6mr17006316lfe.549.1627404671450;
 Tue, 27 Jul 2021 09:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210726150019.251820-1-hannes@cmpxchg.org> <2b0b08f9385b25fb7750dbe453516b0c8bb27604.camel@fb.com>
In-Reply-To: <2b0b08f9385b25fb7750dbe453516b0c8bb27604.camel@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 27 Jul 2021 09:51:00 -0700
Message-ID: <CALvZod5JmcSpym6oXMXEUXEq2u13SVLRaVGPg84ubeYZt-6w_g@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix blocking rstat function called from
 atomic cgroup1 thresholding code
To:     Rik van Riel <riel@fb.com>
Cc:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Kernel Team <Kernel-team@fb.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 8:19 AM Rik van Riel <riel@fb.com> wrote:
>
> On Mon, 2021-07-26 at 11:00 -0400, Johannes Weiner wrote:
> >
> > __mem_cgroup_threshold() indeed holds the rcu lock. In addition, the
> > thresholding code is invoked during stat changes, and those contexts
> > have irqs disabled as well. If the lock breaking occurs inside the
> > flush function, it will result in a sleep from an atomic context.
> >
> > Use the irsafe flushing variant in mem_cgroup_usage() to fix this
>
> While this fix is necessary, in the long term I think we may
> want some sort of redesign here, to make sure the irq safe
> version does not spin long times trying to get the statistics
> off some other CPU.
>
> I have seen a number of soft (IIRC) lockups deep inside the
> bowels of cgroup_rstat_flush_irqsafe, with the function taking
> multiple seconds to complete.

Can you please share a bit more detail on this lockup? I am wondering
if this was due to the flush not happening more often and thus the
update tree is large or if there are too many concurrent flushes
happening.

>
> Reviewed-by: Rik van Riel <riel@surriel.com>
