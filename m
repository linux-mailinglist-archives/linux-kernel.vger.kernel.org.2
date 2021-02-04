Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A397030F957
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbhBDRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:16:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:40636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238363AbhBDRNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:13:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612458777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRbGxBcIWlQ5ydIcOc3/iCMnGIEF7Z8ZmPfjABG4AbA=;
        b=gI4CUFYG1Mx1jeaaXtRPYe3wMK9zHikzKOsFJ+pD3uxxfElu/0fvfkhxWhVVNFOeMJe9O4
        D15/g4UTR15bAM+TTmf8Disvopu1dFGP/kFnuKKWsx9/LiyEVvay0X/QmuDfN5ESJeZ9+9
        vsaXLSDArxZzJuWPfgVnKmap3cEdyw8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9EF07B18F;
        Thu,  4 Feb 2021 17:12:57 +0000 (UTC)
Date:   Thu, 4 Feb 2021 18:12:56 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Possible deny of service with memfd_create()
Message-ID: <YBwrGNS+Q4JMpuom@dhcp22.suse.cz>
References: <e7e6231d-8cf9-80a6-7459-5fec9ee547ba@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7e6231d-8cf9-80a6-7459-5fec9ee547ba@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-02-21 17:32:20, Christian König wrote:
> Hi Michal,
> 
> as requested in the other mail thread the following sample code gets my test
> system down within seconds.
> 
> The issue is that the memory allocated for the file descriptor is not
> accounted to the process allocating it, so the OOM killer pics whatever
> process it things is good but never my small test program.
> 
> Since memfd_create() doesn't need any special permission this is a rather
> nice deny of service and as far as I can see also works with a standard
> Ubuntu 5.4.0-65-generic kernel.

Thanks for following up. This is really nasty but now that I am looking
at it more closely, this is not really different from tmpfs in general.
You are free to create files and eat the memory without being accounted
for that memory because that is not seen as your memory from the sysstem
POV. You would have to map that memory to be part of your rss.

The only existing protection right now is to use memoery cgroup
controller because the tmpfs memory is accounted to the process which
faults the memory in (or write to the file).

I am not sure there is a good way to handle this in general
unfortunatelly. Shmem is is just tricky (e.g. how to you deal with left
overs after the fd is closed?). Maybe memfd_create can be more clever
and account memory to all owners of the fd but even that sounds far from
trivial from the accounting POV. It is true that tmpfs can at least
control who can write to it which is not the case for memfd but then we
hit the backward compatibility wall.
-- 
Michal Hocko
SUSE Labs
