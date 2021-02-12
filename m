Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0804431A08B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhBLOVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:21:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232168AbhBLOUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:20:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B916264E3D;
        Fri, 12 Feb 2021 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613139600;
        bh=Uyda5wqPFSXXYn0InDCALReOlU9knHM6ts9+78opvV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GF1btb9C8VQhIWXaD+8A9iNaR2kr9UPOlayuqleqR5YRrTQZdqyDhZ2pV4WmaySJW
         7z17YmclVEMfyj7f6g2Z9DhfYjUSgdfmgH9GSbXb7R90s7ha2vl6Dgrx1zviEdDI4a
         3CokL4NYcN6pm91bkF4sJOME284fNp44OCX+Lfl4s2eywu9ZAepIzkdJ4tKM7NZCfG
         ESyUa/Ll0UVLDgmUPYs0aHevQctWlsZCFakiUwP/A0tmsC2XyM/JYL5nOFVuOp2BYE
         y+D47cWRBP9kan2dgTvY1zCMzSZDqAE1DPcmuReHOYSq1CCsRQ3ga5/IVmBs9VB88u
         jlD/gh/8ATrOQ==
Date:   Fri, 12 Feb 2021 15:19:57 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] nohz_full: only wakeup target CPUs when notifying
 new tick dependency (v5)
Message-ID: <20210212141957.GB94816@lothringen>
References: <20210128202134.608115362@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128202134.608115362@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 05:21:34PM -0300, Marcelo Tosatti wrote:
> When enabling per-CPU posix timers, an IPI to nohz_full CPUs might be
> performed (to re-read the dependencies and possibly not re-enter
> nohz_full on a given CPU).
> 
> A common case is for applications that run on nohz_full= CPUs
> to not use POSIX timers (eg DPDK). This patch changes the notification
> to only IPI the target CPUs where the task(s) whose tick dependencies
> are being updated are executing.
> 
> This reduces interruptions to nohz_full= CPUs.

Looks good. I'm queueing the series if Peter doesn't object.

Thanks!
