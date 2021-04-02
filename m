Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53C2352BEC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhDBOpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 10:45:02 -0400
Received: from verein.lst.de ([213.95.11.211]:43825 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBOo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:44:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2051768BEB; Fri,  2 Apr 2021 16:44:56 +0200 (CEST)
Date:   Fri, 2 Apr 2021 16:44:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma-mapping: make map_benchmark compile into module
Message-ID: <20210402144455.GA19264@lst.de>
References: <1616552258-22282-1-git-send-email-tiantao6@hisilicon.com> <20210324071305.GB647@lst.de> <6153f9d247214d58b5eb7a76cb1258b3@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6153f9d247214d58b5eb7a76cb1258b3@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 07:33:23AM +0000, Song Bao Hua (Barry Song) wrote:
> The requirement comes from an colleague who is frequently changing
> the map-bench code for some customized test purpose. and he doesn't
> want to build kernel image and reboot every time. So I moved the
> requirement to Tao Tian.
> 
> Right now, kthread_bind() is exported, kthread_bind_mask() seems
> to be a little bit "internal" as you said, maybe a wrapper like
> kthread_bind_node() won't be that "internal", comparing to exposing
> the cpumask?

I really don't think we should be exporting more low-level kthread
APIs.  Especially as we've been trying to get most users off the
kthread API and to workqueues instead.
