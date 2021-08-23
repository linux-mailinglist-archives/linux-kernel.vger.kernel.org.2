Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8C3F4747
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhHWJVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhHWJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:21:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D5DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m2UWnbGr+3dho2sklP4AJF5cECMOSLkmwWKYuXFM05Y=; b=i3gqpBFmQlc+SNiLRQuhZTW3HU
        TTDGsfYk+mRI+EMk0AGLfWR1AVp2id2eOX2kKUHCbOOqP6zovjtTBBVQV37xpeoAO4wMwMohcKpiX
        FWqPcyXFBfddEQ8WAvKt3SgFDRpLNUS1PGczKGPUiUq4bSPLvOhUuQ02byHMiyhVzjdgAksdBLB6X
        wKE/nXWyahNEvxNryXMRHmJv2LMkoGJpsUxbjrUkrzwRRFbq0eXfbaHBEw6Qkosm1MOi5us2Q4ITN
        4hEFgkXvXYc7uWs9JN4AEr32kgXk8Xr7X6McM+3CiIwp6ygvzSOorcBopPuRsPwbo6vRD4OQzI/Kl
        t1DUWEOw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI673-009XDb-RH; Mon, 23 Aug 2021 09:19:36 +0000
Date:   Mon, 23 Aug 2021 10:19:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v5 0/3] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <YSNoHVsQXKqmJ9nO@infradead.org>
References: <20210818120530.130501-1-dwagner@suse.de>
 <YSNV6vpaEnzc0Yv4@infradead.org>
 <20210823091405.pmmkubzgxodwgjij@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823091405.pmmkubzgxodwgjij@carbon.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 11:14:05AM +0200, Daniel Wagner wrote:
> Hi Christoph,
> 
> On Mon, Aug 23, 2021 at 09:01:46AM +0100, Christoph Hellwig wrote:
> > applied to nvme-5.15.
> 
> Could you drop these patches again? James just sent me a new version of
> the series which addresses the points we discussed in this thread. They
> look good to me but I'd like to give them a spin and will post them
> shortly. Also James is giving them a test run.

Ok.
