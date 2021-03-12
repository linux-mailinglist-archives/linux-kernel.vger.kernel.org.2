Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B69133917E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhCLPhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:37:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:35462 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbhCLPgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:36:47 -0500
IronPort-SDR: glKYYngS4gBMZB3UT+dLcIaXda0XGE+bbXwfPd9cBXZ7b+jdmwGvPnK5NtrkkQ2DSe6hC3+Wcz
 sM6EKWU9ZYHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="273889718"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="273889718"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 07:36:47 -0800
IronPort-SDR: 7JEfHbJjz8l1Prs3sKYe2V/Wc9/rtE0D5/VqJqvsvM7T71U9JDnnqyZuOtN0i3hIBOGCoV49lg
 Tj9eFz/xJ1zw==
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="411038510"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 07:36:46 -0800
Date:   Fri, 12 Mar 2021 07:36:46 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: kmap_local semantics
Message-ID: <20210312153646.GE3014244@iweiny-DESK2.sc.intel.com>
References: <20210312065413.GA29805@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312065413.GA29805@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 07:54:13AM +0100, Christoph Hellwig wrote:
> So with the new kmap_local interface is it possible / advisable to
> use local kmaps over code that might schedule(), e.g. to wait for I/O?

It is possible yes.  "Advisable" I think so.  Thomas knows better than I what
performance would be.

FWIW I have been working on converting kmaps to kmap_local.  Most of the
instances don't schedule AFAICT.

What I really don't want to see is any kmap'ings handed to another thread.  I
am working hard to eliminate the use of kmap for that use.  Is that going to be
a problem?

Ira
