Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D8F3078C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhA1Oy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:54:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:48588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232308AbhA1Owi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:52:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611845511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0kDBuWxw3Nb3OaRdHygNvsWhNdY3D1HfTsqS61Zw/Uk=;
        b=sh3BA1fE2Esny3y6+eOQxcLEsoiZug8IbCXC3EYlCEAjgHEfLgW45Y4T60JH7vEZG72jsO
        ShVQHDcaTzrYl+6obV84Qd53pJolKzMxX/zMBCyz62T9KWfvXLfTNpkqNSKi+48lyAflxx
        vAQaRDP11SdpHXo141orj3SfrNTlDGk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15838AE3C;
        Thu, 28 Jan 2021 14:51:51 +0000 (UTC)
Date:   Thu, 28 Jan 2021 15:51:50 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [printk]  b031a684bf: INFO:rcu_tasks_detected_stalls_on_tasks
Message-ID: <YBLPhkHQ8cXFiY1X@alley>
References: <20210122081311.GA12834@xsang-OptiPlex-9020>
 <YAr7d6A4CkMpgx+g@alley>
 <YA+gAV1kW8Ru1+Bo@jagdpanzerIV.localdomain>
 <87bldaaxcc.fsf@jogness.linutronix.de>
 <YBJ2CjN2YntC1o3j@jagdpanzerIV.localdomain>
 <87czxpmhe1.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czxpmhe1.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-01-28 12:32:46, John Ogness wrote:
> On 2021-01-28, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> >> # modprobe rcutorture onoff_interval=3 onoff_holdoff=30 torture_type=tasks
> >> 
> >> (Those are the same modprobe parameters used by the lkp job.)
> >> 
> >> After about a minute I see:
> >> 
> >> [   47.268292] tasks-torture: rcu_torture_read_exit: Start of episode
> >> [   51.273365] tasks-torture: rcu_torture_read_exit: End of episode
> >> [   55.823306] smpboot: do_boot_cpu failed(-1) to wakeup CPU#0
> >> [   55.824350] tasks-torture:torture_onoff task: online 0 failed: errno -5
> >> [   55.830661] tasks-torture:torture_onoff task: online 0 failed: errno -5
> >> [   55.848524] tasks-torture:torture_onoff task: online 0 failed: errno -5
> >
> > Just out of curious, this is seen only with the printk commit in
> > question applied?
> 
> No. The error messages are not related to the commit. But they are
> really the only thing printk'ing when the rcu stall happens. So you
> probably do need to see them in order to reproduce this. (Assuming this
> is somehow printk related.)

If you are able to reproduce this, it might be interesting to see
backtraces from all CPUs when RCU stall gets detected. Or even printing
all processes, even the sleeping ones.

I am still curious how this could be printk() related.

Best Regards,
Petr
