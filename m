Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00274310993
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhBEKxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:53:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:60018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhBEKuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:50:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612522206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9U0KMSJeer5iuxUBgb27AQmqxqsG0SGRUB7HhfB5Yg=;
        b=Citoa9zCTa64ulzZF72SIRhyq1icMnqacsuF3+aBSX8v0Ay3+uSAwtuBpH6DPO4RdcUWI9
        /bbOOwGhOGwFGhQ8aLNe8y5T2n33xAn+nhDOmXxvW1w3cm0tGmfBMSKCUUZqsCFNgP+XKs
        oL986qV6hV6KO74AstcDYrEaT2us00Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1024CAD2E;
        Fri,  5 Feb 2021 10:50:06 +0000 (UTC)
Date:   Fri, 5 Feb 2021 11:50:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Possible deny of service with memfd_create()
Message-ID: <YB0i3a6fIhWG7zCP@dhcp22.suse.cz>
References: <e7e6231d-8cf9-80a6-7459-5fec9ee547ba@amd.com>
 <YBwrGNS+Q4JMpuom@dhcp22.suse.cz>
 <alpine.LSU.2.11.2102041627040.2796@eggly.anvils>
 <762ad377-ac21-6d8d-d792-492ba7f6c000@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <762ad377-ac21-6d8d-d792-492ba7f6c000@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 05-02-21 08:54:31, Christian König wrote:
> Am 05.02.21 um 01:32 schrieb Hugh Dickins:
> > On Thu, 4 Feb 2021, Michal Hocko wrote:
> > > On Thu 04-02-21 17:32:20, Christian Koenig wrote:
> > > > Hi Michal,
> > > > 
> > > > as requested in the other mail thread the following sample code gets my test
> > > > system down within seconds.
> > > > 
> > > > The issue is that the memory allocated for the file descriptor is not
> > > > accounted to the process allocating it, so the OOM killer pics whatever
> > > > process it things is good but never my small test program.
> > > > 
> > > > Since memfd_create() doesn't need any special permission this is a rather
> > > > nice deny of service and as far as I can see also works with a standard
> > > > Ubuntu 5.4.0-65-generic kernel.
> > > Thanks for following up. This is really nasty but now that I am looking
> > > at it more closely, this is not really different from tmpfs in general.
> > > You are free to create files and eat the memory without being accounted
> > > for that memory because that is not seen as your memory from the sysstem
> > > POV. You would have to map that memory to be part of your rss.
> 
> I mostly agree. The big difference is that tmpfs is only available when
> mounted.
>
> And tmpfs can be restricted in size per mount point as well as per user
> quotas IIRC. Looking at my desktop system those restrictions are actually
> exactly what I see there.

I cannot find anything about per user quotas for tmpfs in the tmpfs man
page. Or maybe I am looking at a wrong layer and there is a generic
handling somewhere in the vfs core?

> But memfd_create() is just free for all, you don't have any size limit nor
> access restriction as far as I can see.

Yes, this is unfortunate and a design decision that should have been
considered when the syscall has been introduced. But this boat has
sailed looong ago to change that without risking a userspace breakage.

> > > The only existing protection right now is to use memoery cgroup
> > > controller because the tmpfs memory is accounted to the process which
> > > faults the memory in (or write to the file).
> 
> Agreed, but having to rely on cgroup is not really satisfying when you have
> to maintain a hardened server.

Yes I do recognize the pain. The only other way to mitigate the risk is
to disallow the syscall to untrusted users in a hardened environment.
You should be very strict in tmpfs usage there already.

-- 
Michal Hocko
SUSE Labs
