Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D97424E43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbhJGHvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhJGHvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:51:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1459EC061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tvaAy35J1UGqU3n7MVvnLPYDN8oXHxvNa5M7Uym2krM=; b=QaNrUmLw6uJjGL3ubgT9n7HnY/
        1h/q2HDwcTXwCYdbOxt6wLBW2jL0dOJ4pkcIx1LHNeazRSs5sHXLf01OIucfnRhoJTSAiz7H8aZzD
        XzGKHLV7tk9oS95TduTOFQA5o5jQS4wN0xfjDn0JiDAig90cUvhGGzf+r7+Dslx0/WIB0drSfJ+L+
        XkWlxgg2vCyyc+j+dGkH+gUPYezgqu4jWeExjS8riERxK2xem8+xOZRBw9qZ1vbyAljb1LBJYRKf3
        jRepmVkPePZYp7Heqj0DHGnUv694wf3Y1KI+Ofr6eDvKqsMc9hI6RgQp4qVd+paSMrcXRvQTYhs4g
        1voFx1hQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYO8x-001dho-Pr; Thu, 07 Oct 2021 07:48:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD8C698623A; Thu,  7 Oct 2021 09:48:43 +0200 (CEST)
Date:   Thu, 7 Oct 2021 09:48:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, yujie.liu@intel.com,
        oliver.sang@intel.com
Subject: Re: [peterz-queue:sched/cleanup 38/40] kernel/irq_work.c:44:6:
 warning: no previous prototype for function 'irq_work_single'
Message-ID: <20211007074843.GO174703@worktop.programming.kicks-ass.net>
References: <202110071515.2ivww4qz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110071515.2ivww4qz-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This mail has dodgy headers:

To: unlisted-recipients: no To-header on input <;

Is the robot sick?
