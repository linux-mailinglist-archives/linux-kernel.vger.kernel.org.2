Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F873BB476
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 01:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhGEABl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 20:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhGEABk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 20:01:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1789B613D0;
        Sun,  4 Jul 2021 23:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625443144;
        bh=m0kblN6hNdNA8DEWQiP9DvAg6qs/MoaiNtlaCeBXXCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=girBCqlUzJ1ALojSFoaEjAnpjiM0ZUVo/d+gRBsS0bEJ12FYTjWSKkFhO86ezVtpt
         IcTkkyWgqcamzUVxDD2F/3gtca6YrudzGwlSxW+1IwR7UtO/l0bSAwXbomrEzeRnsI
         8vtbtf1SUrafkWBev4lRqfqLzRP3djC/yuJ5tUHHTcxe0jm05KFjOnQ1M3FnGf2zbi
         ImLsb6R80aiozlW0qvbbp9yFY2CIgXZQWFNPMfrvycobcJzz1v34W01kYPEuWBvxi3
         8JQWxjc3K4JlnbEQUk/Y22CakLGQEpsxgJar0SybPV1q2SYDR8fNcEvE8PCjGF0qgY
         sPvbmAI+aF5dA==
Date:   Mon, 5 Jul 2021 08:59:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org, mattwu@163.com
Subject: Re: [PATCH] kretprobe scalability improvement
Message-Id: <20210705085901.20f97a48c37fdc533d554dc6@kernel.org>
In-Reply-To: <YOF8fyJIzJmZUhoC@infradead.org>
References: <20210703102818.20766-1-wuqiang.matt@bytedance.com>
        <YOF8fyJIzJmZUhoC@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jul 2021 10:16:47 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> Would it make sense to just reuse kernel/bpf/percpu_freelist.c for
> kretprobes?

Hmm, I don't think so.
It seems that what Wuqiang proposed is more efficient than the 
percpu_freelist, and it will be less efficient from the viewpoint
of memory usage because kretprobe freelist manages instance pool
among all CPUs (which can be unbalanced, sometimes 95% used by one
core, sometimes used evenly).

Actually, the best solution is to have per-task fixed-size instance
pool which is shared by all kretprobes (e.g. 4kb/task), because
the instance makes a "shadow stack" for each task. This may consume
more memory but is not increased by adding kretprobes, and should be
scalable.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
