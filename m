Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB57363A11
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbhDSEH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:07:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52459 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237519AbhDSEFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:05:22 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVx3x8mz9vHj; Mon, 19 Apr 2021 14:04:41 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Yu Kuai <yukuai3@huawei.com>, benh@kernel.crashing.org
Cc:     zhangxiaoxu5@huawei.com, yi.zhang@huawei.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210407125712.4138033-1-yukuai3@huawei.com>
References: <20210407125712.4138033-1-yukuai3@huawei.com>
Subject: Re: [PATCH] macintosh/windfarm: Make symbol 'pm121_sys_state' static
Message-Id: <161880479055.1398509.2440866944867826442.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 20:57:12 +0800, Yu Kuai wrote:
> The sparse tool complains as follows:
> 
> drivers/macintosh/windfarm_pm121.c:436:24: warning:
>  symbol 'pm121_sys_state' was not declared. Should it be static?
> 
> This symbol is not used outside of windfarm_pm121.c, so this
> commit marks it static.

Applied to powerpc/next.

[1/1] macintosh/windfarm: Make symbol 'pm121_sys_state' static
      https://git.kernel.org/powerpc/c/13ddd0e3acf988a98b46800178ae691640b0cd00

cheers
