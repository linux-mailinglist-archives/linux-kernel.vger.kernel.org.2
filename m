Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8324134F5D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbhCaBKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:42 -0400
Received: from ozlabs.org ([203.11.71.1]:33747 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233089AbhCaBKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:19 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XV2DJJz9sWk; Wed, 31 Mar 2021 12:10:18 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, Davidlohr Bueso <dave@stgolabs.net>
Cc:     will@kernel.org, linuxppc-dev@lists.ozlabs.org, longman@redhat.com,
        linux-kernel@vger.kernel.org, paulus@samba.org, mingo@redhat.com,
        peterz@infradead.org
In-Reply-To: <20210309015950.27688-1-dave@stgolabs.net>
References: <20210309015950.27688-1-dave@stgolabs.net>
Subject: Re: [PATCH 0/3] powerpc/qspinlock: Some tuning updates
Message-Id: <161715296824.226945.611747739649915060.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:28 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2021 17:59:47 -0800, Davidlohr Bueso wrote:
> A few updates while going through the powerpc port of the qspinlock.
> 
> Patches 1 and 2 are straightforward, while patch 3 can be considered
> more of an rfc as I've only tested on a single machine, and there
> could be an alternative way if it doesn't end up being nearly a
> universal performance win.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/spinlock: Define smp_mb__after_spinlock only once
      https://git.kernel.org/powerpc/c/2bf3604c415c9d75311141b8eb6ac8780ef74420
[2/3] powerpc/spinlock: Unserialize spin_is_locked
      https://git.kernel.org/powerpc/c/66f60522138c2e0d8a3518edd4979df11a2d7525
[3/3] powerpc/qspinlock: Use generic smp_cond_load_relaxed
      https://git.kernel.org/powerpc/c/deb9b13eb2571fbde164ae012c77985fd14f2f02

cheers
