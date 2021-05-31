Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A3739699B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 00:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhEaWPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 18:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231585AbhEaWPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 18:15:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 862C36128A;
        Mon, 31 May 2021 22:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622499252;
        bh=ZqQ1KrKV9Rqa7/ZX1JLTfqxuphm1nTb9JrCr8ONojuw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GyZJzI4WGCVRTkWYg2NalB4HNFxREuSEZrt2Fr0nl7nZkKaZQvA78x8LrAmftxOZm
         Z2HgA3TtLMHdqd/KRrAomKwA3e/sl50OpmIATVMJoieCe89jvemY9tFNjdaIOzE8AE
         FGJ9lmB/r9CiT4yYQM0kgOLdCgKpc3EwAiPqXi48=
Date:   Mon, 31 May 2021 15:14:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Yang Shi <shy828301@gmail.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/migrate.c:1406:5: warning: stack frame size of 2096 bytes in
 function 'migrate_pages'
Message-Id: <20210531151412.4dad38dd703119cdd33ca395@linux-foundation.org>
In-Reply-To: <202105301728.lr6r1Eyr-lkp@intel.com>
References: <202105301728.lr6r1Eyr-lkp@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2021 17:46:48 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b90e90f40b4ff23c753126008bf4713a42353af6
> commit: dd4ae78a21fc05d91d841e499dddd057ad64a4df mm: migrate: simplify the logic for handling permanent failure

migrate_pages() isn't a good place to be using lots of stack.  

Am I correct in assuming that this is a bisection result?

I don't immediately see why dd4ae78a21fc05d91d would be the main cause
of this.


