Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47EB453950
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 19:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbhKPSUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 13:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236111AbhKPSUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:20:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA04A61A79;
        Tue, 16 Nov 2021 18:17:15 +0000 (UTC)
Date:   Tue, 16 Nov 2021 18:17:12 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        zhangliguang@linux.alibaba.com
Subject: Re: [PATCH] arm64: clear_page: use stnp non-temporal instruction for
 performance optimizing
Message-ID: <YZP1qMj4dWCbDrN6@arm.com>
References: <1637075294-30747-1-git-send-email-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637075294-30747-1-git-send-email-guanghuifeng@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:08:14PM +0800, Guanghui Feng wrote:
> When clear page mem, there is no need to alloc cache for storing these
> mem value.

I theory, DC ZVA is supposed to trigger write streaming mode and all
writes go directly to memory avoiding cache allocation.

> And the copy_page.S have used stnp instruction for optimizing.
> So I rewrite the clear_page.S with stnp. At the same time, I have tested it
> with stnp instruction which will get about twice the performance improvement.

On which CPU implementation? Is the same improvement seen on a wider
range of CPUs?

-- 
Catalin
