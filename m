Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0474D3F5697
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 05:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhHXDTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 23:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhHXDTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 23:19:47 -0400
X-Greylist: delayed 127 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Aug 2021 20:19:03 PDT
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC246C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 20:19:02 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1mIMxn-0001N0-0G; Mon, 23 Aug 2021 23:18:59 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id BD53956006F; Mon, 23 Aug 2021 23:18:58 -0400 (EDT)
Date:   Mon, 23 Aug 2021 23:18:58 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 5.14-rc breaks iotop swap io monitoring.
Message-ID: <20210824031858.GA3263@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210824031648.GA2725@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824031648.GA2725@codemonkey.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 11:16:48PM -0400, Dave Jones wrote:
 > I just noticed that in 5.14-rc running iotop, it complains on startup
 > that "CONFIG_TASK_DELAY_ACCT not enabled in kernel, cannot determine
 > SWAPIN and IO %" and sure enough a bunch of columns show up as
 > 'unavailable'.
 > 
 > My suspicion is this commit, which I've not confirmed yet as it doesn't
 > cleanly revert.  I'll poke at it some more in the morning, but figured
 > I'd bring it up sans-evidence in the hope that I'll wake up to someone
 > having an Ah-ha moment.

Forgot to mention, my config has both SCHEDSTATS, SCHED_INFO and TASK_DELAY_ACCT set
to =y

 	Dave
 
