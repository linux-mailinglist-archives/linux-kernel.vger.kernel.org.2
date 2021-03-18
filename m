Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD6933FE40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 05:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCREhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 00:37:19 -0400
Received: from verein.lst.de ([213.95.11.211]:39854 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhCREg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:36:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 91B0768C4E; Thu, 18 Mar 2021 05:36:56 +0100 (CET)
Date:   Thu, 18 Mar 2021 05:36:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: kmap_local semantics
Message-ID: <20210318043656.GA26988@lst.de>
References: <20210312065413.GA29805@lst.de> <20210312153646.GE3014244@iweiny-DESK2.sc.intel.com> <878s6lzxsq.fsf@nanos.tec.linutronix.de> <20210318024418.GX3014244@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318024418.GX3014244@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 07:44:20PM -0700, Ira Weiny wrote:
> Agreed.  I'm Sorry, I did not word the above clearly enough.  Let me rephrase
> that.
> 
> Christoph, do you anticipate additional need to call kmap and hand the mappings
> to other threads?  If not then kmap_local is what you should use.  If so, I'd
> like to know why.

No.  Just looking into callers that want a mapping and then synchronously
wait for I/O.
