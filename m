Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A80379D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhEKCxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:53:49 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:42518 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKCxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:53:48 -0400
Received: by mail-il1-f180.google.com with SMTP id m7so6564441ilg.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 19:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iU0M0ZbqIDJLXqwee/1fIbtlNZGkqZtflowWY8qsynI=;
        b=aO4W/4+GJ7TgtZZNVku0mcaxmwo/KmwS+V+saJFW58lPSy0G77B9HerZ6f6ItOuTLe
         kPEyyJ8V+2D9h1Qr7fRvIlH49Na3OBODdvqsZtHufcWZ8pfkf83w3oabrD47/ECZW4ml
         t1gYO79um4zLdr44T4zxYQL8IY4wpWuQAocZtOCeJTazhHOYrxC5vPRwJULT1Nf+bnpi
         8n+MpPfMkuHm4xoArbu/ID45LhXxRC/Uh7Q3UT+XL/7kHXjFIRHD5u+jhpIvbG8USONh
         MGeFJGNY4QSoeJAYbFxaCia1JrXh55AeKUu/C+Xci7KxxvEk20P9lmxzMz3U7sk1jd+U
         Pm7A==
X-Gm-Message-State: AOAM530TolUjIVBIaSBVTFU4WAPMmiox9b6O9Yz9PIdrT73nPMkgripH
        kDQ8wo71QEc3z5EU+g5gVEE=
X-Google-Smtp-Source: ABdhPJw8LB3Pj1gVC5PGI3RAnY9yz/rooYIzjc5U/OYD9rhYXZPyBTF2GdyOqw+rITTguU2iYBGC/Q==
X-Received: by 2002:a05:6e02:1069:: with SMTP id q9mr24648020ilj.217.1620701561192;
        Mon, 10 May 2021 19:52:41 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id p10sm6102274ios.2.2021.05.10.19.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 19:52:40 -0700 (PDT)
Date:   Tue, 11 May 2021 02:52:39 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Pratik Sampat <psampat@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: Re: [percpu]  ace7e70901:  aim9.sync_disk_rw.ops_per_sec -2.3%
 regression
Message-ID: <YJnxd7nw2T+1A0mf@google.com>
References: <20210427073448.GD32408@xsang-OptiPlex-9020>
 <YItcfQfZlNZTmQKR@carbon.dhcp.thefacebook.com>
 <40632FBD-8874-4B6C-A945-F2EBC96CF12B@fb.com>
 <20210507030606.GA27263@xsang-OptiPlex-9020>
 <YJV+Vn9eGfIlxDQE@carbon.dhcp.thefacebook.com>
 <YJWQE8AFjyYpsLYA@google.com>
 <20210511022614.GB8539@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511022614.GB8539@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 10:26:14AM +0800, Oliver Sang wrote:
> Hi Dennis,
> 
> On Fri, May 07, 2021 at 07:08:03PM +0000, Dennis Zhou wrote:
> > On Fri, May 07, 2021 at 10:52:22AM -0700, Roman Gushchin wrote:
> > > On Fri, May 07, 2021 at 11:06:06AM +0800, Oliver Sang wrote:
> > > > hi Roman,
> > > >  
> > > > On Thu, May 06, 2021 at 12:54:59AM +0000, Roman Gushchin wrote:
> > > > > Ping
> > > > 
> > > > sorry for late.
> > > > 
> > > > the new patch makes the performance a little better but still has
> > > > 1.9% regression comparing to
> > > > f183324133 ("percpu: implement partial chunk depopulation")
> > > 
> > > Hi Oliver!
> > > 
> > > Thank you for testing it!
> > > 
> > > Btw, can you, please, confirm that the regression is coming specifically
> > > from ace7e70901 ("percpu: use reclaim threshold instead of running for every page")?
> > > I do see *some* regression in my setup, but the data is very noisy, so I'm not sure
> > > I can confirm it.
> > > 
> > > Thanks!
> > 
> > Thanks Oliver and Roman. If this is the case, I'll drop the final patch
> > and just merge up to f183324133 ("percpu: implement partial chunk
> > depopulation") into for-next as this is v5.14 anyway.
> > 
> > Oliver, is there a way to trigger the kernel test robot for a specific
> > test?
> 
> sorry for late.

No worries. Thanks for all you work!

> not sure what kind of specific test you want robot to do?
> if you mean for-next branch, if the branch is monitored by kernel test robot,
> after merge, it will be tested by robot automatically and the bisect will be
> triggered if there is still regression.

In this case, we believe there is a regression in
"aim9.sync_disk_rw.ops_per_sec". I know my branches are monitored (hence
we suspect this regression), but it would be nice to be able to kick off
a test with a patch or set of patches on top to validate that the
regression is fixed on your hardware configuration. Unfortunately I
don't have a 100+ core machine lying around :P.

Sorry for the additional questions, but is there a time frame that the
kernel robot is expected scrape over my tree / what test suites get run
against any particular branch?

> I found the ace7e70901 has already been dropped from original branch (dennis-percpu/for-5.14),

Yeah I have temporarily dropped it to get the others into for-next for
now. I'll spend some time later this week digging deeper into this.

> and we have data for this branch as below. from data, the f183324133 (current
> branch tip) doesn't introduce regression comparing 5.12-rc7 in our tests.
> 
> f183324133ea5 percpu: implement partial chunk depopulation                 103673.09 102188.39 104325.06 104038.4 102908.57 104057.06
> 1c29a3ceaf5f0 percpu: use pcpu_free_slot instead of pcpu_nr_slots - 1      104777.31 102225.93 101657.6
> 8ea2e1e35d1eb percpu: factor out pcpu_check_block_hint()                   102290.78 101853.87 102541.65
> d434405aaab7d Linux 5.12-rc7                                               102103.06 102248.12 101906.81 103033.13 102043.33
> 

Thanks,
Dennis
