Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A6F30F3AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhBDNJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:09:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236197AbhBDNJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:09:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F6D064F45;
        Thu,  4 Feb 2021 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612444149;
        bh=UjdJ73HbJD+0e3GwpEzNT1ALjs4/MoJIMxhVHJjaxfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ux1R6MUSIR+1K0n/08zUHm6tfyiNueKGGf7gcXbQAntjzWo3uUxvJrnwfGRd2RkxW
         zdhZ5kukn1Y5dEfWcYFlAoMyI57jBY264E13bjbzhJHbcPKx0sPjfow1/hggA4wJhX
         UUilhb3+wQCuzCtzliT7mLehDWH7Y0C0KogrvjA+2ZPBWoDSr6iEadJjUpYODpf4/a
         uF+IvZwkn5wF+kxE5uyBuHxS3yyNH/qBWDRVMdQzom5jnwU5ZRfcaOoKQAzZQaz+y6
         wgyuArFiBlcY9F3NjHJFBFjslPviHK0qV2O7aKH7E+K4JiPMTBlYYzobh+/lgOVfQA
         t+xkmRzpkHwhg==
Date:   Thu, 4 Feb 2021 13:09:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: convert sysfs sprintf/snprintf family to
 sysfs_emit
Message-ID: <20210204130905.GE20468@willie-the-truck>
References: <1612409571-56451-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612409571-56451-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:32:51AM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/perf/arm-cci.c:708:8-16: WARNING: use scnprintf or sprintf.
> ./drivers/perf/arm-cci.c:699:8-16: WARNING: use scnprintf or sprintf.
> ./drivers/perf/arm-cci.c:528:8-16: WARNING: use scnprintf or sprintf.
> ./drivers/perf/arm-cci.c:309:8-16: WARNING: use scnprintf or sprintf.
> 
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/perf/arm-cci.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Looks like the same issue exists for other drivers under drivers/perf/. How
about fixing them all together?

Will
