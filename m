Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B896134D2A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhC2OqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:46:07 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:54954 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229955AbhC2Opf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:45:35 -0400
Received: from omf06.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C9429100E7B46;
        Mon, 29 Mar 2021 14:45:33 +0000 (UTC)
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA id CBA142448B4;
        Mon, 29 Mar 2021 14:45:32 +0000 (UTC)
Message-ID: <a5994bec32107fb63e39d35dd2f1e93eedf2d820.camel@perches.com>
Subject: Re: [PATCH] sched,psi: fix typo in comment
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Xie XiuQi <xiexiuqi@huawei.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Date:   Mon, 29 Mar 2021 07:45:31 -0700
In-Reply-To: <YGGDRtg7cMvQcLjm@hirez.programming.kicks-ass.net>
References: <20210327124610.7276-1-xiexiuqi@huawei.com>
         <YGGDRtg7cMvQcLjm@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CBA142448B4
X-Spam-Status: No, score=0.10
X-Stat-Signature: k1xrqe7g4ympdjrfc6sp3oeao4a7f1aa
X-Rspamd-Server: rspamout01
X-HE-Tag: 1617029132-734471
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-29 at 09:35 +0200, Peter Zijlstra wrote:
> On Sat, Mar 27, 2021 at 08:46:10PM +0800, Xie XiuQi wrote:
> > s/exceution/execution/
> > s/possibe/possible/
> > s/manupulations/manipulations/
> > 
> > Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> 
> Xie, if you'd have bothered to check the development tree of the code
> you're patching, you'd have found it's long since fixed.

March 18, 2021 doesn't seem a long time ago to me.

commit 3b03706fa621ce31a3e9ef6307020fde4e6aae16
Author: Ingo Molnar <mingo@kernel.org>
Date:   Thu Mar 18 13:38:50 2021 +0100

    sched: Fix various typos

> I'm getting sick and tired of people wasting bandwidth with this
> nonsense.

This seems more like a large overreaction IMO.

