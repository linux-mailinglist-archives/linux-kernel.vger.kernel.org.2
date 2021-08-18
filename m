Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807E93F0673
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbhHROVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbhHROT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:19:59 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF0CC061141
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:15:22 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t66so3205080qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QuwtlkiDGdVrCHQjEs+V1pH13gkXul/lhVEkHhu3sPg=;
        b=HGixUth5XmHhaExQjj0gkfLh0CcKhfT9fLJ8YT+dCDfj28MGFMjoiPk12fFJ75GriO
         T3vJh7OduH2ggAbsAw4pR2TMzK5OkotvAbwW5kg/WMKj9tVKuwutWoUoQqQ0mair1Ivn
         IXnMaAE+5G6/0DOyN2E24YF4TEN52GyJyeAHja0iPBTGhHdmzv72e37rv5SRqMwiX0jB
         0zAct3Jr3JADH5pG3y5yrxAkueO/MsBtxxTBZXMS87vYomrc7Gl69AVEtEHAd0dNxdAq
         BG3Rnqfq+rO/ArKUpIPfdWadeGYwTOuXPzo9l1ubVv0Dcpykxz3Wfu/DmKo5bFuvq0W4
         6vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QuwtlkiDGdVrCHQjEs+V1pH13gkXul/lhVEkHhu3sPg=;
        b=t4lhw2pD+z2pvxpBZ4soW7vbY/SO9sAqw4FpIHIbSCIc/A2aPPIAq4aAmWaw6NmEi2
         kp8fo3a+4oxACyKmFRy5+bZCu1TLZowID671D4oCViK88OJ00Ame2qk+MlnX0rRA7vJP
         G/p7roEZfEXMoCzTRCRYU8JKbXuOzBVu1OXpJJCRox0qBV06hYpoIieugo3pg6oA2TOP
         Dhq1CEqXyipmV5vw9E0itVoEjHKVowBt35//k5pJ5zull04AgehGjqLi9Hc9she7MLf8
         deCaxkeCTLnt65zLQyKAFZVrq8HxpzXvOTyMmLM4bvtvkr2+XaJZyExs6RLJuyjjYYrS
         SPjQ==
X-Gm-Message-State: AOAM532kXLpNFr+doVnlyUaheFUJGzedKkeuHX06hXwErX+vdX4tHaEF
        vNiBVa6iWosDU34TzxMWUFHVVw==
X-Google-Smtp-Source: ABdhPJzBvxuWBcQn6T0nzg4r0Ki9UxaU9vIgb2Te0VQ8siFV29T1isqOwegBqIHbenxfs1BwkxKiVw==
X-Received: by 2002:a05:620a:450e:: with SMTP id t14mr9583617qkp.93.1629296122062;
        Wed, 18 Aug 2021 07:15:22 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id f15sm59672qte.5.2021.08.18.07.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 07:15:21 -0700 (PDT)
Date:   Wed, 18 Aug 2021 10:16:59 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leon Yang <lnyng@fb.com>, Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
Message-ID: <YR0WW2VvgtUHK1HL@cmpxchg.org>
References: <20210817180506.220056-1-hannes@cmpxchg.org>
 <CALvZod7097PHnXoOUZzPpmkASKpL3rV+2UJ+zp-NCdkpVoFTWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7097PHnXoOUZzPpmkASKpL3rV+2UJ+zp-NCdkpVoFTWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 12:10:16PM -0700, Shakeel Butt wrote:
> On Tue, Aug 17, 2021 at 11:03 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > We've noticed occasional OOM killing when memory.low settings are in
> > effect for cgroups. This is unexpected and undesirable as memory.low
> > is supposed to express non-OOMing memory priorities between cgroups.
> >
> > The reason for this is proportional memory.low reclaim. When cgroups
> > are below their memory.low threshold, reclaim passes them over in the
> > first round, and then retries if it couldn't find pages anywhere else.
> > But when cgroups are slighly above their memory.low setting, page scan
> 
> *slightly
> 
> > force is scaled down and diminished in proportion to the overage, to
> > the point where it can cause reclaim to fail as well - only in that
> > case we currently don't retry, and instead trigger OOM.
> >
> > To fix this, hook proportional reclaim into the same retry logic we
> > have in place for when cgroups are skipped entirely. This way if
> > reclaim fails and some cgroups were scanned with dimished pressure,
> 
> *diminished

Oops. Andrew, would you mind folding these into the checkpatch fixlet?

> > we'll try another full-force cycle before giving up and OOMing.
> >
> > Reported-by: Leon Yang <lnyng@fb.com>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Should this be considered for stable?

Yes, I think so after all. Please see my reply to Roman.

> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thanks Shakeel!
