Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76F83FFFCC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 14:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349397AbhICMdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 08:33:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49251 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1349356AbhICMdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 08:33:33 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 183CWLYD024847
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Sep 2021 08:32:22 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B198215C33F9; Fri,  3 Sep 2021 08:32:21 -0400 (EDT)
Date:   Fri, 3 Sep 2021 08:32:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [LKP] [ext4] 05c2c00f37: aim7.jobs-per-min -11.8% regression
Message-ID: <YTIV1SozOGwT/DQw@mit.edu>
References: <20210227120804.GB22871@xsang-OptiPlex-9020>
 <a8947cee-11f5-8d59-a3ff-1c516276592e@linux.intel.com>
 <20210520095119.GA18952@quack2.suse.cz>
 <e9f776c4-1ade-42a6-54c4-7fe3442e2392@linux.intel.com>
 <20210521092730.GE18952@quack2.suse.cz>
 <YKfi6Pv+qwduKxuT@mit.edu>
 <20210525092205.GA4112@quack2.suse.cz>
 <20210531165746.GA2610@quack2.suse.cz>
 <20210603161004.GL23647@quack2.suse.cz>
 <8ac28fce-0cfb-cc4d-1a3d-2f104ff46767@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ac28fce-0cfb-cc4d-1a3d-2f104ff46767@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 01:28:25PM +0800, Xing Zhengjun wrote:
> Hi Jan,
> 
>      Do you have time to look at this? I re-test it in v5.13 and v5.14, the
> regression still existed. Thanks.

> > So as we chatted on today's call probably the best option is to leave the
> > code as is for now and instead work on moving away from orphan list
> > altogether. I'll revive my patches to do that.

The orphan_file feature has landed in for the 5.15 merge window.  When
enabled, it provides multiple blocks to store the set of orphaned
inodes, which provides parallelism for parallel truncate and unlink
operations.

It requires a development version of e2fsprogs to use, and so the
zero-day bot won't be able to test it for a little while.

Cheers,

						- Ted


