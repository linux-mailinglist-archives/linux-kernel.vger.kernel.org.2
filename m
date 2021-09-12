Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985D8408257
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 01:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhILXdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 19:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236662AbhILXdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 19:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631489550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xzTE9yjUoCB5GMFuVGpGO3mw7g+iYVf6cDy06tcZwZI=;
        b=HHh+KVHKruiusKwQfOxJxk015Sl96dXZgkeMKMKfYItNW9tZZbIRciI5tOshf65Io2J7w2
        954DIVlIOZpt9yAJI+9dLaErN4Qa3bpMGg7GKtmF7I179bENDrUNFV4qVayJ4umiwFP8As
        RhF0vcOSuYctLzifMHlzjcgR594uEvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-Q7vI-vrFNOON44iikLMR5Q-1; Sun, 12 Sep 2021 19:32:27 -0400
X-MC-Unique: Q7vI-vrFNOON44iikLMR5Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E60B31800D41;
        Sun, 12 Sep 2021 23:32:25 +0000 (UTC)
Received: from rh (vpn2-54-128.bne.redhat.com [10.64.54.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CB375C25A;
        Sun, 12 Sep 2021 23:32:25 +0000 (UTC)
Received: from [::1] (helo=rh)
        by rh with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <dchinner@redhat.com>)
        id 1mPYxR-0000wn-Pc; Mon, 13 Sep 2021 09:32:21 +1000
Date:   Mon, 13 Sep 2021 09:32:19 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com
Subject: Re: [xfs]  ab23a77687:  aim7.jobs-per-min -18.5% regression
Message-ID: <20210912233219.GB2335@rh>
References: <20210909142355.GA6270@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909142355.GA6270@xsang-OptiPlex-9020>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 10:23:55PM +0800, kernel test robot wrote:
> 
> 
> Hi Dave Chinner,
> 
> we reported "[xfs]  6df693ed7b:  aim7.jobs-per-min -15.7% regression" as [1]
> when this change is still on
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git xfs-5.15-merge
> 
> now this change is on mainline.
> so we report again to highlight we still observe similar performance regression
> on mainline.
> 
> previously we also tried to test by turning off RWSEM_SPIN_ON_OWNER per your
> guidance, but still observed similar regression, though we are not sure if our
> method to turn off RWSEM_SPIN_ON_OWNER is enough. the detail result is in [2]
> 
> [1] https://lore.kernel.org/all/20210809064248.GB5761@xsang-OptiPlex-9020/
> [2] https://lore.kernel.org/all/20210818085248.GA28771@xsang-OptiPlex-9020/

Did you look at the config that was generated before running the
tests again?

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86_64 5.14.0-rc4 Kernel Configuration
> #
....
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
....


So these tests were still run with the same RWSEM_SPIN_ON_OWNER=y
configuration, and so unsurprisingly the result was the same with
spin contention on the directory inode rwsem.

You'll save yourself (and everyone else) a lot of time by validating
that your config changes are valid before re-running tests...

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com

