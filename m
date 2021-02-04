Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1887430F72F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhBDQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbhBDQCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:02:15 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB190C061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 08:01:34 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id k193so3754042qke.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 08:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=csnC8vI9T1wPkKdVnk2T3EegCaTzDUoDkg3RtcvUQt0=;
        b=om9bw1733wlt1/kLEgKPgVnHc/NgppIyLl3gcn5uZTxcNLNlLmm/dcW3kKnRBqJ1kP
         VJckPkk8IWcl+e6iyWLb/rPmCsRwzIQS4d+o6d9mYr4g8FxKPqxG4vvn7XeKENY3r0IC
         1LaB5GlWS3YVKSJItCGIthyB1GthkrGXEpGx/4rzUptWXX5Y2aU8Lgrex7t0/LI3pGP6
         1gP1wf3yZ/nhn2phPWvvBuYwk2vpZC78juptyfdu00sQDAHwUSXeS0vsYhIx/E2wT+CI
         eXV1MkmzGpbjcRrPxWdQVedLBV1Rbp1D32tSh0qqx6W0CERrvFXvU9ryGCfamlzKIAa1
         2sAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=csnC8vI9T1wPkKdVnk2T3EegCaTzDUoDkg3RtcvUQt0=;
        b=cw9oeOvDwURCUecrFGfXDQWbpOgzzCOr5DgLjvYYT1DrMXOFsFpfDUWZ6Ap1qoFewo
         4fwoI8aXjViSI9HhDlV975PWh5uX8RWjJGppsnbpIIpKlptlGt+xoH6n5dLVEzKWt9Uk
         lgs8gEufzFKb04urmn8kH6LTHHoZO/dNnHpfHdhvWDqOo6K737PV7+xY57hmK1cRMleN
         zbhj5Xv6635Zwq5O3PZDIBgmCODCBPOehpjFRAsoMxlMA9xqiQRJLoFRtgb9st5e2gB4
         P5yqI+DjC8vFooF6nmRYDWgYD5RAaiwmbOXq+2UaVrnG8coVuEkM4Q6WzeAnr7eWNST3
         0Jjg==
X-Gm-Message-State: AOAM532akxi1jv7Zw6vIKTtyGJNnMN01NWRTBpREyw/8umnngG90rjNt
        t8xFgfBH6FInNuYgbM+tmMetOA==
X-Google-Smtp-Source: ABdhPJx32xnUx1I/2ZP4O2vFlTEG+H5002aJfu2W9Eo9vQWKWc/7ZcfPYxFwSGtfzojxNcEAaiJ5GA==
X-Received: by 2002:a37:788:: with SMTP id 130mr8415601qkh.390.1612454492267;
        Thu, 04 Feb 2021 08:01:32 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id r17sm4848993qta.78.2021.02.04.08.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 08:01:30 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:01:30 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/7] cgroup: rstat: support cgroup1
Message-ID: <YBwaWkJgqPNF3I3w@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-5-hannes@cmpxchg.org>
 <YBv5Dc1I9QpPH69n@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBv5Dc1I9QpPH69n@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 02:39:25PM +0100, Michal Hocko wrote:
> On Tue 02-02-21 13:47:43, Johannes Weiner wrote:
> > Rstat currently only supports the default hierarchy in cgroup2. In
> > order to replace memcg's private stats infrastructure - used in both
> > cgroup1 and cgroup2 - with rstat, the latter needs to support cgroup1.
> > 
> > The initialization and destruction callbacks for regular cgroups are
> > already in place. Remove the cgroup_on_dfl() guards to handle cgroup1.
> > 
> > The initialization of the root cgroup is currently hardcoded to only
> > handle cgrp_dfl_root.cgrp. Move those callbacks to cgroup_setup_root()
> > and cgroup_destroy_root() to handle the default root as well as the
> > various cgroup1 roots we may set up during mounting.
> > 
> > The linking of css to cgroups happens in code shared between cgroup1
> > and cgroup2 as well. Simply remove the cgroup_on_dfl() guard.
> > 
> > Linkage of the root css to the root cgroup is a bit trickier: per
> > default, the root css of a subsystem controller belongs to the default
> > hierarchy (i.e. the cgroup2 root). When a controller is mounted in its
> > cgroup1 version, the root css is stolen and moved to the cgroup1 root;
> > on unmount, the css moves back to the default hierarchy. Annotate
> > rebind_subsystems() to move the root css linkage along between roots.
> 
> I am not familiar with rstat API and from this patch it is not really
> clear to me how does it deal with memcg v1 use_hierarchy oddness.

That's gone, right?

static int mem_cgroup_hierarchy_write(struct cgroup_subsys_state *css,
                                      struct cftype *cft, u64 val)
{
        if (val == 1)
                return 0;

        pr_warn_once("Non-hierarchical mode is deprecated. "
                     "Please report your usecase to linux-mm@kvack.org if you "
                     "depend on this functionality.\n");

        return -EINVAL;
}
