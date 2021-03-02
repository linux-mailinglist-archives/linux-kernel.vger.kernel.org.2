Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82A132A0B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576389AbhCBE2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:28:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13017 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348821AbhCBBZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 20:25:48 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DqKBv1gxMzjV6J;
        Tue,  2 Mar 2021 09:23:19 +0800 (CST)
Received: from DESKTOP-E0KHRBE.china.huawei.com (10.67.103.82) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 09:24:49 +0800
From:   Shaobo Huang <huangshaobo6@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <chenzefeng2@huawei.com>, <huangshaobo6@huawei.com>,
        <kepler.chenxin@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@arm.linux.org.uk>,
        <liucheng32@huawei.com>, <mhiramat@kernel.org>,
        <nixiaoming@huawei.com>, <tixy@linaro.org>, <xiaoqian9@huawei.com>,
        <young.liuyang@huawei.com>, <zengweilin@huawei.com>
Subject: Re: [PATCH 4.4.y] arm: kprobes: Allow to handle reentered kprobe on single-stepping
Date:   Tue, 2 Mar 2021 09:24:49 +0800
Message-ID: <20210302012449.23428-1-huangshaobo6@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <YDzQaT6zTUb43LFt@kroah.com>
References: <YDzQaT6zTUb43LFt@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.103.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 1, 2021 at 11:30 AM, Greg KH wrote:
> On Mon, Feb 27, 2021 at 05:17:01PM +0800, huangshaobo wrote:
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > commit f3fbd7ec62dec1528fb8044034e2885f2b257941 upstream
> > 
> > This is arm port of commit 6a5022a56ac3 ("kprobes/x86: Allow to handle 
> > reentered kprobe on single-stepping")
> > 
> > Since the FIQ handlers can interrupt in the single stepping (or 
> > preparing the single stepping, do_debug etc.), we should consider a 
> > kprobe is hit in the NMI handler. Even in that case, the kprobe is 
> > allowed to be reentered as same as the kprobes hit in kprobe handlers 
> > (KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE).
> > 
> > The real issue will happen when a kprobe hit while another reentered 
> > kprobe is processing (KPROBE_REENTER), because we already consumed a 
> > saved-area for the previous kprobe.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > Fixes: 24ba613c9d6c ("ARM kprobes: core code")
> > Cc: stable@vger.kernel.org #v2.6.25~v4.11
> > Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
> > ---
> >  arch/arm/probes/kprobes/core.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> What about the 4.9.y tree as well?
> 
> thanks,
> 
> greg k-h

Yes, I tested on the 4.4.y tree. From the code analysis, the same problem
exists in the 2.6.25 to 4.11 trees, and of course the 4.9.y tree is also
included.

thanks,
ShaoBo Huang
