Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD57430F7E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbhBDQ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbhBDQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:27:15 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D44BC06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 08:26:34 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id r77so3811975qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 08:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ACIgalIASwLRIdWMuW6Oj7uCmIS5PMrqjcUMfzNwZKE=;
        b=MhxcF478bHTzeOjaqn3t+dgrOQ2TemimDwkXVDLohFRJNl95pHbGa9lLMm7eUh47yK
         hqGCwPMieGsvldBevk/GTzZFLDZryCRd8tlWXVG8uYNf9AohQdvgTb+LxFJwSEjutywo
         3E18OctPqEd11DhJx4NgXE4Yj0fHAQ0WIyhu+wgSKgvMnTRsuVjDtnLBrLvkb4TXY9Om
         LcJVZVFkYyCc7nEmtuJiow7He54ZkAWBEXGmmJe/6WxLOur+I/zZe0/QnliUXFYnnBc3
         +cNlrBxAgNgbdTKF95BPokovA+P0SqJ0wm/w/bqBYg83pfhDJKy0DV+MBi+sqDRpT+Bx
         ZldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ACIgalIASwLRIdWMuW6Oj7uCmIS5PMrqjcUMfzNwZKE=;
        b=VLpGQwzgx2geKYU8k3W56pduL2AARPcW4GUzQKKrYW8kHl1D6x2+w0rbB3jTICyqOi
         i8QpjDq3M2ktnK9ntwCI715OXAwgcdI2JrQ2HckldeSYX7YxktnD+WYoa2il6StczTl6
         2agbD2hIFeuhmoj8RtuV1TAFVCBNBTyO6xCKnMeUb5B6EhnLI8oM6FWc0TCHsmsYt9x8
         cLZZ4ke/JlnbpdIKSt781oyhF5BQc5VHW6boYKO+J0yxi1/Dgy3oBGkoh2PmIB6VSQ19
         Pd3KwYHHv0LSUmVVb9wyrXiAngrLBwCwGVxRUZvkVJMUIBLVENeA54pWjyILMDhBwP9w
         bffA==
X-Gm-Message-State: AOAM531HUG9OukONUETe0YymHremW+TRIckk5K4T+FNzRKs+urKKgc5L
        QGoHHO5B9/E80EB7skCjTEjhHA==
X-Google-Smtp-Source: ABdhPJxIV4CD4lGok1rJ7D4sC9j6L8cQiM/cMuIlBrELVi3sX2eGXEMa9a2jlGvNzQjeqYhitY/mZA==
X-Received: by 2002:a05:620a:5ae:: with SMTP id q14mr8254731qkq.156.1612455993552;
        Thu, 04 Feb 2021 08:26:33 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id k25sm5549112qkk.66.2021.02.04.08.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 08:26:32 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:26:32 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/7] mm: memcontrol: switch to rstat
Message-ID: <YBwgOHL8dTjJpnKU@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-7-hannes@cmpxchg.org>
 <20210203014726.GE1812008@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203014726.GE1812008@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 05:47:26PM -0800, Roman Gushchin wrote:
> On Tue, Feb 02, 2021 at 01:47:45PM -0500, Johannes Weiner wrote:
> >  	for_each_node(node) {
> >  		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
> > +		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = {0, };
>                                                               ^^
> I'd drop the comma here. It seems that "{0}" version is way more popular
> over the mm code and in the kernel in general.

Is there a downside to the comma? I'm finding more { 0, } than { 0 }
in mm code, and at least kernel-wide it seems both are acceptable
(although { 0 } is more popular overall).

I don't care much either way. I can change it in v2 if there is one.
