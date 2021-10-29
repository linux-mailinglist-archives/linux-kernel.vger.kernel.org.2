Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD5843F8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 10:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhJ2IfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 04:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhJ2IfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:35:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05B3E6115B;
        Fri, 29 Oct 2021 08:32:51 +0000 (UTC)
Date:   Fri, 29 Oct 2021 10:32:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] ksefltest: pidfd: Fix wait_states: Test terminated
 by timeout
Message-ID: <20211029083248.7vttuxbwbtdylrnq@wittgenstein>
References: <20211029024528.8086-1-lizhijian@cn.fujitsu.com>
 <20211029024528.8086-2-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211029024528.8086-2-lizhijian@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 10:45:28AM +0800, Li Zhijian wrote:
> 0Day/LKP observed that the kselftest blocks foever since one of the
> pidfd_wait doesn't terminate in 1 of 30 runs. After digging into
> the source, we found that it blocks at:
> ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);
> 
> we can reproduce it by:
> $ while true; do make run_tests -C pidfd; done
> 
> a delay to ensure that the parent can see child process WCONTINUED.
> 
> CC: Christian Brauner <christian@brauner.io>
> CC: Shuah Khan <shuah@kernel.org>
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---

Not a fan of the usleep() solution but if it fixes it it's fine for
a test, I think.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
