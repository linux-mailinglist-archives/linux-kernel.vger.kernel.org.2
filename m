Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBC6363A10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbhDSEH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:07:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48177 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237513AbhDSEFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:05:21 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVw6Rd3z9vHR; Mon, 19 Apr 2021 14:04:40 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Yu Kuai <yukuai3@huawei.com>, benh@kernel.crashing.org
Cc:     zhangxiaoxu5@huawei.com, yi.zhang@huawei.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210407125803.4138837-1-yukuai3@huawei.com>
References: <20210407125803.4138837-1-yukuai3@huawei.com>
Subject: Re: [PATCH] macintosh/via-pmu: Make some symbols static
Message-Id: <161880479109.1398509.777689260617554743.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 20:58:03 +0800, Yu Kuai wrote:
> The sparse tool complains as follows:
> 
> drivers/macintosh/via-pmu.c:183:5: warning:
>  symbol 'pmu_cur_battery' was not declared. Should it be static?
> drivers/macintosh/via-pmu.c:190:5: warning:
>  symbol '__fake_sleep' was not declared. Should it be static?
> 
> [...]

Applied to powerpc/next.

[1/1] macintosh/via-pmu: Make some symbols static
      https://git.kernel.org/powerpc/c/95d143923379ffb0e706b064305681d44c05ec4b

cheers
