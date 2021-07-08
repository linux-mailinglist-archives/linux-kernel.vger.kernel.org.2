Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D9C3C1403
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhGHNP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:15:27 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:10433 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhGHNPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:15:24 -0400
Received: from dggeme765-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GLGpc13BHzcb9Z;
        Thu,  8 Jul 2021 21:09:28 +0800 (CST)
Received: from DESKTOP-E0KHRBE.china.huawei.com (10.67.103.82) by
 dggeme765-chm.china.huawei.com (10.3.19.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 8 Jul 2021 21:12:40 +0800
From:   Shaobo Huang <huangshaobo6@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <huangshaobo6@huawei.com>, <chenzefeng2@huawei.com>,
        <kepler.chenxin@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@arm.linux.org.uk>,
        <liucheng32@huawei.com>, <mhiramat@kernel.org>,
        <nixiaoming@huawei.com>, <tixy@linaro.org>, <xiaoqian9@huawei.com>,
        <young.liuyang@huawei.com>, <zengweilin@huawei.com>
Subject: Re: ping // [PATCH 4.4.y] arm: kprobes: Allow to handle reentered kprobe on single-stepping
Date:   Thu, 8 Jul 2021 21:12:40 +0800
Message-ID: <20210708131240.32836-1-huangshaobo6@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <YOb1xv0a0U+0Wp1z@kroah.com>
References: <YOb1xv0a0U+0Wp1z@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.103.82]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme765-chm.china.huawei.com (10.3.19.111)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 09:56PM +0800, Greg KH wrote:
> > On Thu, Jul 08, 2021 at 08:42:40PM +0800, Shaobo Huang wrote:
> > ping
> 
> ???
> 
> What are you asking about here?  Please be specific, "naked pings" like this are not informative.
> 
> thanks,
> 
> greg k-h

This patch was merged in the 4.9.y branch last time, but the 4.4.y branch is still not merged,
please review the 4.4 branch merge.

thanks,
ShaoBo Huang


