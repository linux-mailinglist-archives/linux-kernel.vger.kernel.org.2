Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6127B37555C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 16:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhEFOEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 10:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbhEFOEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 10:04:20 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75657C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 07:03:21 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id j19so4037899qtp.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NyovqxOW82zPv/RMu7EY5sIzE8Yb18Rxnr+LgOzAj4I=;
        b=HcZWOxxQaQYJDGJk/dFdldXFYRZ/meKoTgEl/gH0/egGR1TaD1hHcJStlZoT1Y3n5o
         pnyvMGZMGooLQb8aLN6SgaLySQplBrxVn6KGmtsXAH2xNAkNsfA0eeBqCPtJK8HlKb37
         NIkgoIG80i6Kq1vHU1tesfwIJkXgzeahXzrRn4/6GzsGD3RxvQckVPubwk8PSmqzUO8v
         sjbugM2wiVxipmXXB9MAU7O4zx6qEaBB9zpw+zjbcPBWq1GfeVUpWHbHtatrxOAfslZj
         Upa2tMP1Q1ffh+MBVHA0Xe5K7q+QwdSTql3SZ5fZ0pQMqDQcaqcZoyq3GJG+C+TXPR7u
         Y7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NyovqxOW82zPv/RMu7EY5sIzE8Yb18Rxnr+LgOzAj4I=;
        b=ITanOdo/bU8Xdwkkq+Zgws4EfB+/+aoHb4x/uHoz/itKW8td6UaJUapzfEwJ388fEd
         XP8fNiyjA3E255FD35s0oM59Htxb9sfyuAgDI73AN0D+OabDkBdOtjvzsY2OCjhikRe7
         rQcH4ls9umJSwZNrjBvITKIOvveOfDc3ej5/JMmhsvdENAIZ6qoyJtBr5cXg3UAJbPkk
         dpcXmxY0Z67H2YMlrEMS9l/Ix7+oDUh5vOoX/PoxE/L1ICqN0106Ug3O8JBDxwnpi+2U
         kJNgEmynhQhuqzKAwe4rGYOUgKlqWTvLrT8QOWFGS2/WgxkxR/kXBHxXRXwvZdDFn2of
         TulA==
X-Gm-Message-State: AOAM532YbHNiOEUUdiHMoz25CjcrPk7+AeEL9OW0uU/c+vJV4pxduhM7
        fpt8QSEDGHvHSAw6pPisUXyNVA==
X-Google-Smtp-Source: ABdhPJxa/O1GQpQsv6qqgiYO7IU/n0nVvL+Gz4UOofbHoJlpYXIXciiKdeA/saKrF9y9UjzgPC8PHw==
X-Received: by 2002:ac8:7b26:: with SMTP id l6mr4446266qtu.136.1620309800753;
        Thu, 06 May 2021 07:03:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4c4b])
        by smtp.gmail.com with ESMTPSA id b7sm610066qte.80.2021.05.06.07.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:03:20 -0700 (PDT)
Date:   Thu, 6 May 2021 10:03:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, bsingharora@gmail.com, pbonzini@redhat.com,
        maz@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        riel@surriel.com
Subject: Re: [PATCH 3/6] sched: Simplify sched_info_on()
Message-ID: <YJP3JnHzfxs6vMzx@cmpxchg.org>
References: <20210505105940.190490250@infradead.org>
 <20210505111525.121458839@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505111525.121458839@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 12:59:43PM +0200, Peter Zijlstra wrote:
> The situation around sched_info is somewhat complicated, it is used by
> sched_stats and delayacct and, indirectly, kvm.
> 
> If SCHEDSTATS=Y (but disabled by default) sched_info_on() is
> unconditionally true -- this is the case for all distro kernel configs
> I checked.
> 
> If for some reason SCHEDSTATS=N, but TASK_DELAY_ACCT=Y, then
> sched_info_on() can return false when delayacct is disabled,
> presumably because there would be no other users left; except kvm is.
> 
> Instead of complicating matters further by accurately accounting
> sched_stat and kvm state, simply unconditionally enable when
> SCHED_INFO=Y, matching the common distro case.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
