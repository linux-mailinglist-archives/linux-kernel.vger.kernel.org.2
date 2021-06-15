Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9F13A7AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhFOJiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231262AbhFOJiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:38:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07A2B613F1;
        Tue, 15 Jun 2021 09:35:58 +0000 (UTC)
Date:   Tue, 15 Jun 2021 10:35:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/kmemleak: fix the possible wrong memory scanning
 period
Message-ID: <20210615093555.GA26027@arm.com>
References: <20210613174022.23044-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210613174022.23044-1-yanfei.xu@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 01:40:22AM +0800, Yanfei Xu wrote:
> This commit contains 3 modifies:
> 
> 1.Convert the type of jiffies_scan_wait to "unsigned long".
> 
> 2.Use READ/WRITE_ONCE() for accessing "jiffies_scan_wait".
> 
> 3.Fix the possible wrong memory scanning period. If you set a large
> memory scanning period like blow, then the "secs" variable will be
> non-zero, however the value of "jiffies_scan_wait" will be zero.
> 
>     echo "scan=0x10000000" > /sys/kernel/debug/kmemleak
> 
> It is because the type of the msecs_to_jiffies()'s parameter is
> "unsigned int", and the "secs * 1000" is larger than its max value.
> This in turn leads a unexpected jiffies_scan_wait, maybe zero. We
> corret it by replacing kstrtoul() with kstrtouint(), and check the
> msecs to prevent it larger than UINT_MAX.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
