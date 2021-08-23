Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BAE3F4712
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhHWJDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbhHWJDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:03:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A83AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OgyTviJmKWdTdPGttUWCV7ojzrJFqomYeJvFCysoRxY=; b=MtatwbZ4eHAaWNb5gOriQPHA9G
        wxZdXurakcPiIaGf7PohI1b9WJYfHev2yjB0xAThCurNWJ8ZfEUS3oGk/aHCGQfjZ2go+MMVs9R9P
        zBjqAWTuYYYC9+oq6t7Founvzlkzs05QPw1RJeSCAnt1FKBScOfYqoSmWwfPUdtksCFNMd0rLM/Uj
        bvrcBrjL7udkffHnsBSHa2GGQg38a+Q3Vln6DjRuAnEbVCqEu3/+L0tsx8H/5UaNpT0MPpvn/xFtg
        enPZkk4a78wVwLlLwoeB3zinOjnI+hkDifiZFGYJis6KRuxcr7msL6pZArtZDGY7de0o1lwbPIXXO
        EyAzj2qA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI5qE-009WC9-Ll; Mon, 23 Aug 2021 09:02:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E427E300332;
        Mon, 23 Aug 2021 11:02:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3D4D213ADB20; Mon, 23 Aug 2021 11:02:00 +0200 (CEST)
Date:   Mon, 23 Aug 2021 11:02:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Will Deacon <will@kernel.org>, clang-built-linux@googlegroups.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Valentin Schneider <Valentin.Schneider@arm.com>
Subject: Re: [peterz-queue:sched/core 8/11] include/linux/sched.h:1722:57:
 warning: unused parameter 'dst'
Message-ID: <YSNkCAyMU0tJoedT@hirez.programming.kicks-ass.net>
References: <202108210940.aD3d42zA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108210940.aD3d42zA-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 09:20:50AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
> head:   234b8ab6476c5edd5262e2ff563de9498d60044a
> commit: b90ca8badbd11488e5f762346b028666808164e7 [8/11] sched: Introduce task_struct::user_cpus_ptr to track requested affinity
> config: i386-randconfig-a016-20210820 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d9c5613e856cf2addfbf892fc4c1ce9ef9feceaa)
> reproduce (this is a W=1 build):

Dear 0day folks; could you please blacklist me for all W=1 build output?
I'm 100% not interested in random compiler generated garbage.
