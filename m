Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECD03E4253
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhHIJSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:18:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42530 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbhHIJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:17:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 891A521F4B;
        Mon,  9 Aug 2021 09:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628500650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=swPXWKB8KKbLpgtlPkPycn0CdL+ZFW2x0pMMoKZN8f0=;
        b=N+CxYEToIwyG7uCIabn5tJCsiX9kJRZAi93Rcsk2GIFjPUxKfdnHKNLBnrd+q2se6VwerN
        +PLTR+ULz/Yzpinz+JDNlWUdmDouuN7/s/yot91cj9v6BTTnpgSXgfG/PFU9NrG7I2jotl
        pDsASnmdZSs+ZzVmV2xW6ONFbOowceM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 71613A3B88;
        Mon,  9 Aug 2021 09:17:30 +0000 (UTC)
Date:   Mon, 9 Aug 2021 11:17:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     chenguanyou <chenguanyou9338@gmail.com>
Cc:     akpm@linux-foundation.org, chenguanyou@xiaomi.com,
        gpiccoli@canonical.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        vbabka@suse.cz
Subject: Re: [PATCH v2] hungtask: add filter kthread
Message-ID: <YRDyquuwshpHNdz0@dhcp22.suse.cz>
References: <20210805164328.58213d35e45d81c363b2135e@linux-foundation.org>
 <20210807131600.27742-1-chenguanyou@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807131600.27742-1-chenguanyou@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 07-08-21 21:16:00, chenguanyou wrote:
> > Please explain this point in more detail?
> 
> In my work,the rootcause of more deadlocks often occurs in user threads.
> 
> exp:
> PID: 711 TASK: ffffffc13eb71d00 CPU: 0 COMMAND: "sensors@2.0-ser"
> #0 [ffffff80251cbcb0] __switch_to at ffffff80080866c4
> #1 [ffffff80251cbd20] __schedule at ffffff80090c0940
> #2 [ffffff80251cbd80] schedule_preempt_disabled at ffffff80090c0e4c
> #3 [ffffff80251cbde0] __mutex_lock at ffffff80090c2e58
> #4 [ffffff80251cbe40] __mutex_lock_slowpath at ffffff80090c1f78
> #5 [ffffff80251cbe50] mutex_lock at ffffff80090c1f60
> #6 [ffffff80251cbe60] __fdget_pos at ffffff800829ac84
> #7 [ffffff80251cbe90] sys_write at ffffff8008270550
> #8 [ffffff80251cbff0] el0_svc_naked at ffffff8008083fbc
> 
> PID: 843 TASK: ffffffc135832b80 CPU: 2 COMMAND: "sensors@2.0-ser"
> #0 [ffffff802554bb30] __switch_to at ffffff80080866c4
> #1 [ffffff802554bba0] __schedule at ffffff80090c0940
> #2 [ffffff802554bc00] schedule at ffffff80090c0d54
> #3 [ffffff802554bc50] xxx_sensor_show at ffffff8008bc043c
> #4 [ffffff802554bc80] dev_attr_show at ffffff8008668ce0
> #5 [ffffff802554bca0] sysfs_kf_seq_show at ffffff8008314e04
> #6 [ffffff802554bce0] kernfs_seq_show at ffffff8008314314
> #7 [ffffff802554bd10] seq_read at ffffff80082a250c
> #8 [ffffff802554bd70] kernfs_fop_read at ffffff80083135b8
> #9 [ffffff802554be20] __vfs_read at ffffff800826fcc0
> #10 [ffffff802554be40] vfs_read at ffffff800826ff08
> #11 [ffffff802554be90] sys_read at ffffff80082704c4
> #12 [ffffff802554bff0] el0_svc_naked at ffffff8008083fbc
> 
> The rootcause is deadlock caused by using same fd, and 843's file ops is block type;
> If we want to trigger panic in the first time through hungtask,
> must be avoid detect kernel threads on some platforms("mediatek"),
> because they("kernel threads") cause misjudgments.

This still suggests that the primary purpose of the interface is to
paper over real problems that should be fixed instead.
-- 
Michal Hocko
SUSE Labs
