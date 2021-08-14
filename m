Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1136B3EC5FD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 01:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhHNXlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 19:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233613AbhHNXlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 19:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628984448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8sQcQ3MfKHjSyRvS2CzUaH0PtEjudnhFYbbiX4zYZjo=;
        b=XigQXc0fm25+C4b9KkD9OrqivbNOvx/XMB30AjKE3pys+LBss4mkHdjcqPjs+TL/9PIW+n
        lwepZQ2sgUASGk//jloQIzx1LfedYY39RDE1jqj8pxUZIhla4oAe05gLSlx9SL2lV68O3z
        6hV6yYgVsmOrI3TKq6pxtiu/Tub05IA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-ii6GDD7JM4Op2C_y8Q2Yjw-1; Sat, 14 Aug 2021 19:40:44 -0400
X-MC-Unique: ii6GDD7JM4Op2C_y8Q2Yjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 282A41008063;
        Sat, 14 Aug 2021 23:40:43 +0000 (UTC)
Received: from rh (vpn2-54-123.bne.redhat.com [10.64.54.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56C5C69CBB;
        Sat, 14 Aug 2021 23:40:42 +0000 (UTC)
Received: from [::1] (helo=rh)
        by rh with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <dchinner@redhat.com>)
        id 1mF3GX-0007ph-Sd; Sun, 15 Aug 2021 09:40:38 +1000
Date:   Sun, 15 Aug 2021 09:40:35 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@intel.com,
        zhengjun.xing@linux.intel.com
Subject: Re: [xfs]  6df693ed7b:  aim7.jobs-per-min -15.7% regression
Message-ID: <20210814234035.GE2959@rh>
References: <20210809064248.GB5761@xsang-OptiPlex-9020>
 <20210809093114.3179-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809093114.3179-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 05:31:14PM +0800, Hillf Danton wrote:
> On Mon, 9 Aug 2021 14:42:48 +0800
> > 
> > FYI, we noticed a -15.7% regression of aim7.jobs-per-min due to commit:
> > 
> > 
> > commit: 6df693ed7ba9ec03cafc38d5064de376a11243e2 ("xfs: per-cpu deferred inode inactivation queues")
> > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git xfs-5.15-merge
> > 
> > 
> > in testcase: aim7
> > on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
> > with following parameters:
> > 
> > 	disk: 4BRD_12G
> > 	md: RAID1
> > 	fs: xfs
> > 	test: disk_wrt
> > 	load: 3000
> > 	cpufreq_governor: performance
> > 	ucode: 0x5003006
> > 
> 
> See if scheduling can help assuming a bound worker should run as short as
> it could.
> 
> The change below is
> 1/ add schedule entry in inodegc worker, and as compensation allow it to
> repeat gc until no more c available.

Do you have any evidence that this is a problem?

I mean, we bound queue depth to 256 items, and my direct
measurements of workloads show that and typical inactivation
processing does not block and takes roughly 50-100us per item. On
inodes that require lots of work (maybe minutes!), we end up
sleeping on locks or resource reservations fairly quickly, hence we
don't tend to rack up significant amount of uninterrupted CPU time
in this loop at all.

> 2/ make inodegc_wq unbound to spawn workers because they are no longer
> potential CPU hogs (and this is not mandatory but optional).
> 
> to see if hot cache outweights spawning of workers.

NACK. We already know what impact that has:  moving to bound
workqueues erased a 50-60% performance degradation in the original
queueing mechanism that used unbound workqueues and required
inactivation to run on cold caches. IOWs, performance analysis lead
us to short bound depth per-cpu queues and single depth bound
per-cpu workqueues. We don't do complex stuff like this unless it is
necessary for performance and scalability...

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com

