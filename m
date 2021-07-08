Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02993BFA7A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhGHMpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:45:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14040 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhGHMpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:45:25 -0400
Received: from dggeme765-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GLG801Z1tzbbYs;
        Thu,  8 Jul 2021 20:39:28 +0800 (CST)
Received: from DESKTOP-E0KHRBE.china.huawei.com (10.67.103.82) by
 dggeme765-chm.china.huawei.com (10.3.19.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 8 Jul 2021 20:42:40 +0800
From:   Shaobo Huang <huangshaobo6@huawei.com>
To:     <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@arm.linux.org.uk>,
        <mhiramat@kernel.org>, <tixy@linaro.org>
CC:     <huangshaobo6@huawei.com>, <chenzefeng2@huawei.com>,
        <kepler.chenxin@huawei.com>, <liucheng32@huawei.com>,
        <nixiaoming@huawei.com>, <xiaoqian9@huawei.com>,
        <young.liuyang@huawei.com>, <zengweilin@huawei.com>
Subject: ping // [PATCH 4.4.y] arm: kprobes: Allow to handle reentered kprobe on single-stepping
Date:   Thu, 8 Jul 2021 20:42:40 +0800
Message-ID: <20210708124240.20048-1-huangshaobo6@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210302012449.23428-1-huangshaobo6@huawei.com>
References: <20210302012449.23428-1-huangshaobo6@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.103.82]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme765-chm.china.huawei.com (10.3.19.111)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On Sat, Feb 27, 2021 at 05:17:01PM +0800, huangshaobo wrote:
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> commit f3fbd7ec62dec1528fb8044034e2885f2b257941 upstream
> 
> This is arm port of commit 6a5022a56ac3 ("kprobes/x86: Allow to
> handle reentered kprobe on single-stepping")
> 
> Since the FIQ handlers can interrupt in the single stepping
> (or preparing the single stepping, do_debug etc.), we should
> consider a kprobe is hit in the NMI handler. Even in that
> case, the kprobe is allowed to be reentered as same as the
> kprobes hit in kprobe handlers
> (KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE).
> 
> The real issue will happen when a kprobe hit while another
> reentered kprobe is processing (KPROBE_REENTER), because
> we already consumed a saved-area for the previous kprobe.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> Fixes: 24ba613c9d6c ("ARM kprobes: core code")
> Cc: stable@vger.kernel.org #v2.6.25~v4.11
> Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
> ---
>  arch/arm/probes/kprobes/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
