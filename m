Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB82631F2DC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 00:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhBRXR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 18:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhBRXR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:17:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82FD164EB9;
        Thu, 18 Feb 2021 23:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1613690205;
        bh=VuEQvhYrUQRk+2hwk6NOio3v4yKDWE3Dxa3E4sAhabU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ue/bdei15LxfCoVUnsg10eEKBppOUxhEAviiZH5iGhrO//dPBrsp6A0q3vlwaIjeI
         h2Lenw3NHaPNJnbr/Qpk8XVt4eDLwXlo3EuN7JixwIs2jHPN0fat7hd9qypnGWDg80
         w1fLwCIq1HbJrwFa8RLrokUcLm9rQGsX3tZTW/NY=
Date:   Thu, 18 Feb 2021 15:16:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] percpu_counter: increase batch count
Message-Id: <20210218151644.df430e4f77f763b7db2a004f@linux-foundation.org>
In-Reply-To: <0bf90e07-8758-b238-b3f3-a330725a1134@kernel.dk>
References: <0bf90e07-8758-b238-b3f3-a330725a1134@kernel.dk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Feb 2021 14:36:31 -0700 Jens Axboe <axboe@kernel.dk> wrote:

> Currently we cap the batch count at max(32, 2*nr_online_cpus), which these
> days is kind of silly as systems have gotten much bigger than in 2009 when
> this heuristic was introduced.
> 
> Bump it to capping it at 256 instead. This has a noticeable improvement
> for certain io_uring workloads, as io_uring tracks per-task inflight count
> using percpu counters.
> 

It will also make percpu_counter_read() and
percpu_counter_read_positive() more inaccurate than at present.  Any
effects from this will take a while to discover.

But yes, worth trying - I'll add it to the post-rc1 pile.
