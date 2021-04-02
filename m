Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BA23530F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 23:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhDBV7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 17:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231443AbhDBV7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 17:59:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDEDF61178;
        Fri,  2 Apr 2021 21:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617400775;
        bh=XO9W2tGPvoFG0+fp3fiEOn+pW0vP5nST5nM/mzrCnkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VdCr8AnzEu4UelCJ0z3ifSGzXZP5BoHAVrZcp4omJlNxcFF1U/AglvAJL1t1Ky1bg
         wqxK809AQ+C5QAQUn0j6159eqU9PR0KQwdFlsCrhMdrekCgWvCCvAW89hH/vdgmFHS
         GMpr4Ig0RMYBMpsV802HynsaF5kHoUY41y7Q7nyY=
Date:   Fri, 2 Apr 2021 14:59:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH-next 2/5] lib/test_vmalloc.c: add a new 'nr_threads'
 parameter
Message-Id: <20210402145934.719192be298eadbeecb321d2@linux-foundation.org>
In-Reply-To: <20210402202237.20334-2-urezki@gmail.com>
References: <20210402202237.20334-1-urezki@gmail.com>
        <20210402202237.20334-2-urezki@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Apr 2021 22:22:34 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> By using this parameter we can specify how many workers are
> created to perform vmalloc tests. By default it is one CPU.
> The maximum value is set to 1024.
> 
> As a result of this change a 'single_cpu_test' one becomes
> obsolete, therefore it is no longer needed.
> 

Why limit to 1024?  Maybe testers want more - what's the downside to
permitting that?

We may need to replaced that kcalloc() with kmvalloc() though...
