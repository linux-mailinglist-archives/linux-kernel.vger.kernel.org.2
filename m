Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B30D3F8AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242914AbhHZPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:20:22 -0400
Received: from lb2.peda.net ([130.234.6.153]:56235 "EHLO lb2.peda.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242913AbhHZPUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:20:18 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2021 11:20:18 EDT
Received: from [84.251.221.37] (dsl-jklbng12-54fbdd-37.dhcp.inet.fi [84.251.221.37])
        by lb2.peda.net (Postfix) with ESMTPSA id 949AFD60119;
        Thu, 26 Aug 2021 18:10:34 +0300 (EEST)
To:     linux-kernel@vger.kernel.org
From:   Mikko Rantalainen <mikko.rantalainen@peda.net>
Subject: How about making oom_score_adj smarter?
Message-ID: <fb16b0e3-2470-3f38-6b71-881bda21df13@peda.net>
Date:   Thu, 26 Aug 2021 18:10:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I don't subscribe LKML so I'd prefer being CC'd in replies.]

Whenever OOM Killer is activated, it selects the victim by calling
oom_badness() in oom_kill.c. The logic in this function basicallytakes
actual memory usage of a process and adds (total_memory_in_system *
(oom_score_adj / 1000)) as extra RSS usage for the process while trying
to figure out the correct victim.

This results in poor selections for positive oom_score_adj values when
system has lots of RAM because this is in practice just a static amount
of extra memory with no smarts of any kind. The oom_score_adj is
basically same as "static_extra_rss_for_oom_selection_in_weird_unit".


How about doing following instead?

New definition: oom_score_adj is a non-linear multiplier that scales the
badness score, but the special value 1000 means select every time (as
currently) and -1000 means never select. Other values change the weight
for the actually used memory when selecting the process to be killed to
free RAM. Value zero means that the actual memory usage is counted for
the given process, values below zero discount the memory usage with
-1000 counted as not using memory at all and -500 meaning only half of
the actual memory usage is accounted for. However, the positive values
have non-linear effect with higher values having more effect.


I'd suggest that the code
https://github.com/torvalds/linux/blob/28e92f990337b8b4c5fdec47667f8b96089c503e/mm/oom_kill.c#L236

	/* Normalize to oom_score_adj units */
	adj *= totalpages / 1000;
	points += adj;

were replaced with

	/* Apply oom_score_adj as non-linear multiplier */
	if (adj >= 0)
		points *= 1.0 + adj * adj / 10000.0;
	else
		points *= 1.0 + adj/1000.0;


This would change negative oom_score_adj values to represent linear
multiplier under zero (0 being no change, -100 meaning taking 10% off
from the actual badness, -900 meaning taking 90% off).

However on the positive side the behavior would be non-linear with
values closer to 0 having less effect and higher values resulting in
greater multipliers. The value 999 would result in badness multiplied by
100.8 but value 500 would result in multiplier 26 and value 100 would
result in multiplier 2 (logically +100% badness). I would assume that
having 100x multiplier for the memory usage would be good enough to
correctly volunteer processes to be killed when system is running out of
RAM.

This would allow marking less important processes with high
oom_score_adj values without similar problems as currently. If such
process is well behaving and is using say 0.1% of the RAM, it doesn't
make sense to kill it even if it had oom_score_adj value of 800. With
current implementation such a process would get killed nearly every time.

For example, Google Chrome nowadays uses oom_score_adj value of 300 for
all non-critical child processes and those would get overcharged 9x
instead of current state where each process has static overcharged
overhead of 30% of the total system memory. With the above change Chrome
children would be charged according to real memory usage times 9 which
should result in correct child getting selected as victim more often.

If floating point math is not acceptable here, the above computation can
be re-ordered to avoid losing accuracy for oom_score_adj values close to
zero.

For example:

	if (adj >= 0)
		points += points * adj * adj / 10000;
	else
		points += points * adj / 1000;

As an additional optimization, the divider could be replaced with a bit
shift in roughly similar scale. I don't know if points * adj * adj could
overflow with real world values.

-- 
Mikko
