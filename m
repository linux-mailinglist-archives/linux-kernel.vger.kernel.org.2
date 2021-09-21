Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8CD41366D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhIUPqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:46:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39770 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbhIUPqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:46:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 68D4D20165;
        Tue, 21 Sep 2021 15:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632239081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nWfIiRk8SwvJHkqqWpNtD+lexrjS+OYHtMwGR8knjjw=;
        b=DUz7+j2qlyD7dfx4dJY69O9WrXBoB0KARXL6nfiFfLqC27G4lhBbOg2iFFJ1/Q0LKQRPLO
        T6swjazRz8feOf8EiWCl+Ct6oBLdnCDrwQtQ6pATyfCo+kS6paAp7pSTAhBVOnkERHQ0r4
        3imdo1LZdgG1FO15ijNt4AbUrtkbyCk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 31F16A3B88;
        Tue, 21 Sep 2021 15:44:40 +0000 (UTC)
Date:   Tue, 21 Sep 2021 17:44:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, feng.tang@intel.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH] mm: Fix the uninitialized use in
 overcommit_policy_handler
Message-ID: <YUn95tAEvHEsT6R+@dhcp22.suse.cz>
References: <20210921140301.9058-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921140301.9058-1-chenjun102@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-09-21 14:03:01, Chen Jun wrote:
> An unexpected value of /proc/sys/vm/panic_on_oom we will get,
> after running the following program
> 
> int main()
> {
>     int fd = open("/proc/sys/vm/panic_on_oom", O_RDWR)
>     write(fd, "1", 1);
>     write(fd, "2", 1);
>     close(fd);
> }
> 
> write(fd, "2", 1) will pass *ppos = 1 to proc_dointvec_minmax.
> proc_dointvec_minmax will return 0 without setting new_policy.
> 
> t.data = &new_policy;
> ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos)
>       -->do_proc_dointvec
>          -->__do_proc_dointvec
>               if (write) {
>                 if (proc_first_pos_non_zero_ignore(ppos, table))
>                   goto out;
>
> sysctl_overcommit_memory = new_policy;
> 
> so sysctl_overcommit_memory will be set to an uninitialized value.

The overcommit_policy_handler (ab)use of proc_dointvec_minmax is really
an odd one. It is not really great that proc_dointvec_minmax cannot
really tell whether the value has been changed but likely nobody really
needed that so far.

I strongly suspect the intention was to do all the follow up handling
before making the new mode visible to others. Maybe this can be changed
so that the handler doesn't really need to do any hops.

Your fix is an easier part I would just initialize the to -1 so that we
can tell nothing has been done the handler can bail out without any
follow up work.
-- 
Michal Hocko
SUSE Labs
