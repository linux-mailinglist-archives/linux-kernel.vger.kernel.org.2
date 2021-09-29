Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B4541C817
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345053AbhI2PPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:15:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344945AbhI2PPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:15:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B3F461390;
        Wed, 29 Sep 2021 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632928438;
        bh=bj1UgBCFmevZyRRTk4d27X8GmaLhO5zMbKhLWuOOLe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m69bHFnlQW3S+J+Eo6Jscnw6Dw0tOPo2XjqfGSKd64VJUDeJ7rG8UVh3OXniucUtQ
         a87YHOZQJ7Vi4Lgwe7Ivcxrd+gDtmOX6SI5TSmFNhdNjJ0wh9dIUFr33BZSjqmjPGq
         NUcUeyRewZEKT4tYHPuk1DAQoEoOnE1lU+ZNcm+E=
Date:   Wed, 29 Sep 2021 17:13:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>, 0day robot <lkp@intel.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [driver core]  eedc73d4f3:
 BUG:kernel_reboot-without-warning_in_boot_stage
Message-ID: <YVSCs7BDC6ODf+oZ@kroah.com>
References: <1614590004-69592-1-git-send-email-yang.lee@linux.alibaba.com>
 <20210929150240.GB12854@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929150240.GB12854@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:02:40PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: eedc73d4f330cf7a8d18d64f327837ae9a00d003 ("[PATCH] driver core: Switch to using the new API kobj_to_dev()")
> url: https://github.com/0day-ci/linux/commits/Yang-Li/driver-core-Switch-to-using-the-new-API-kobj_to_dev/20210929-102216
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 5816b3e6577eaa676ceb00a848f0fd65fe2adc29

There is no such commit in my tree, or anywhere else I can see, so I
have no idea what is happening here :(

