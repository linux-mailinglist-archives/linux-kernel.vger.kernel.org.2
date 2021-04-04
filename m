Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5872353A27
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 01:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhDDXjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 19:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhDDXjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 19:39:10 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DF3C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 16:39:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j7so7413213qtx.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 16:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZmQ6lUbCDIme35q2pCJjSmVR9obrBu1GS0FA+sZ71gE=;
        b=Mxc5uUEEcQ3Hk+J/GXgw807i2HkPNGdxyWW0jxo9ecUKUwPdyofzTUQSr2nmXC+GTD
         fTxqc1qs0WecZCjOTs2BazBifn9FvqjgmKSQrTZKo/BmJxQIp7dgV4ZWfBmiq5Gp/m1E
         b86UZ2fccWmDpoQwfg3cBTEAUTsYP6fhqPGEWKBoM+q+J7yNEkAxDQApclcZ2RU/CCOs
         5/YMS3VV8/KjEyH4jDl42pW2iH9sOQz5lAaQUhx+h/IjlkvTLat24HdIBbj7q8oJiEnR
         irazsDt8Slb0qassMoRGvCWenJY2ux912bOZlPT90EztD6Qji6rTWn48Dj0Dm578mAiX
         BhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZmQ6lUbCDIme35q2pCJjSmVR9obrBu1GS0FA+sZ71gE=;
        b=OYZkRE0JPx6zvbEUi5ugHW5Uy35yxETJMWXstEbM/4qTZZV+iPvHNxINYJoS8r2MLR
         fxoyWhDgkJJbgsDLvtOQyY7liGUt36F2AZ/VQt4/UuIHBS1Abo9klXS1LjnhQi7OaKk7
         us/8R+ruO39RPuUlS43qwojobS8hj670ZIhczp218ZSAcyidLoIuRPQMAUKX3S4ZrO+u
         u6vdz9DeMriTlXIJviayQ/4pCIc6SiIee3B3PN3sPtjvxZN4kvT4+ZR7/0w0z0rGtbHC
         HWFHnahw8bbK7OkA8ovDu8DWaCkolFCp6kSsGGmQEDd3eeA5+JgZIRoaAP+qggbKwbxe
         zUCw==
X-Gm-Message-State: AOAM530xvQFMoe0zdfY9OERZdCMLSRf4kKjyzND+qxeQowCZ1K3w6KVP
        Z2srwlNnQVJnd84i3GzvfnM=
X-Google-Smtp-Source: ABdhPJzgFZNUnvD5lQ1awMTq/VpAcJZuwfALMTQgQ9cMaUdcULGFPM+7+BxlYrZd/ZPmRWyhicUNyA==
X-Received: by 2002:ac8:4415:: with SMTP id j21mr20195004qtn.87.1617579544571;
        Sun, 04 Apr 2021 16:39:04 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id y14sm10908059qtw.70.2021.04.04.16.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 16:39:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 4 Apr 2021 19:39:03 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
Message-ID: <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
References: <20210401131012.395311786@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401131012.395311786@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc'ing Michal and Christian who've been spending some time on cgroup
interface issues recently and Li Zefan for cpuset.

On Thu, Apr 01, 2021 at 03:10:12PM +0200, Peter Zijlstra wrote:
> The cgroup interface now uses a 'core_sched' file, which still takes 0,1. It is
> however changed such that you can have nested tags. The for any given task, the
> first parent with a cookie is the effective one. The rationale is that this way
> you can delegate subtrees and still allow them some control over grouping.

I find it difficult to like the proposed interface from the name (the term
"core" is really confusing given how the word tends to be used internally)
to the semantics (it isn't like anything else) and even the functionality
(we're gonna have fixed processors at some point, right?).

Here are some preliminary thoughts:

* Are both prctl and cgroup based interfaces really necessary? I could be
  being naive but given that we're (hopefully) working around hardware
  deficiencies which will go away in time, I think there's a strong case for
  minimizing at least the interface to the bare minimum.

  Given how cgroups are set up (membership operations happening only for
  seeding, especially with the new clone interface), it isn't too difficult
  to synchronize process tree and cgroup hierarchy where it matters - ie.
  given the right per-process level interface, restricting configuration for
  a cgroup sub-hierarchy may not need any cgroup involvement at all. This
  also nicely gets rid of the interaction between prctl and cgroup bits.

* If we *have* to have cgroup interface, I wonder whether this would fit a
  lot better as a part of cpuset. If you squint just right, this can be
  viewed as some dynamic form of cpuset. Implementation-wise, it probably
  won't integrate with the rest but I think the feature will be less jarring
  as a part of cpuset, which already is a bit of kitchensink anyway.

> The cgroup thing also '(ab)uses' cgroup_mutex for serialization because it
> needs to ensure continuity between ss->can_attach() and ss->attach() for the
> memory allocation. If the prctl() were allowed to interleave it might steal the
> memory.
> 
> Using cgroup_mutex feels icky, but is not without precedent,
> kernel/bpf/cgroup.c does the same thing afaict.
> 
> TJ, can you please have a look at this?

Yeah, using cgroup_mutex for stabilizing cgroup hierarchy for consecutive
operations is fine. It might be worthwhile to break that out into a proper
interface but that's the least of concerns here.

Can someone point me to a realistic and concrete usage scenario for this
feature?

Thanks.

-- 
tejun
