Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C0942C150
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhJMNYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231372AbhJMNYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:24:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B919860C40;
        Wed, 13 Oct 2021 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634131361;
        bh=YjHSmUH3vWx4UbmoS8XoCf1Q1iUtkT/FFwYDre9n7/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOtqi+GjGAjM8ekNIZsD5hq8oIFaItCF6cNQ4UP4DwyK1EcS+xQeSVchup8gyxeV2
         amjvISBOrrCcVhqnAadA9tZMjkmeH1YB4oErxlvXixDdldcUt1zwP/P4KtvfxQ+aoT
         qDJ+MrVAnHb2tHL4viOly9FkB7mu0qJwguzLCXAo=
Date:   Wed, 13 Oct 2021 15:22:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] dynamic debug for -next
Message-ID: <YWbdnsUjHA4Mmss3@kroah.com>
References: <20211012183310.1016678-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012183310.1016678-1-jim.cromie@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 12:33:05PM -0600, Jim Cromie wrote:
> hi Greg, Jason, 
> 
> Please consider these "more selective verbose info" patches for your
> -next tree:
> 
> - show module name in query from $module.dyndbg="...;..."
> - don't log command input with quotes user might use, it only confuses.
> - silence log of empty/tail query.
> - refine verbosity: summary..detail: 1..4
> 
> While doing stress testing with (something like):
>   echo "+p; -p; +p; -p; +p; -p; +p; -p; +p; -p" > control
> 
> The existing v2pr_info("changed:") is called ~30k times (~3k
> callsites, 10x) on my desktop kernel, and the syslog work completely
> overwhelms and hides the static-key IPI overheads (using this
> workload).
> 
> While verbose=1 silences this, it also stops most parsing vpr-infos,
> as I found while submitting 4kb command buffers, and seeing short
> writes and resulting bad commands kernel-side.  I needed to hide the
> "changed" messages, but still see the parsing error (and submit
> context), where the short write and resulting illegal command revealed
> itself.
> 
> The script fix was to syswrite the prepared multi-command string,
> avoiding perl's buffered io, but the kernel-side tweaks made it easier
> to isolate and debug my userspace problem filling the 4kb command
> buffer.
> 
> With these changes, the script elicits this log; with last of 96
> queries logged at v=3, then benchmarked with v=0.
> 
> FWIW, the script runs 299k simple flag changes @ 125x/s.
> For static-key changes, its MUCH slower, taking 4s each.
> 500x cost is not unreasonable, considering systemwide IPI.
> 
> model name	: AMD Ryzen 7 5800H with Radeon Graphics (16 core)
> 
> v=3 messages, per query.
> [  727.006884] dyndbg: query 95: <file "*" module "*" func "*"  -mf # off > mod:<*>
> [  727.007268] dyndbg: split into words: <file> <*> <module> <*> <func> <*> <-mf>
> [  727.007657] dyndbg: op=<->
> [  727.007813] dyndbg: flags=0x6
> [  727.007973] dyndbg: *flagsp=0x0 *maskp=0xfffffff9
> [  727.008320] dyndbg: parsed: func=<*> file=<*> module=<*> format=<> lineno=0-0
> [  727.009205] dyndbg: applied: func=<*> file=<*> module=<*> format=<> lineno=0-0
> 
> v=2 message, summarizing command buffer submission.
> [  727.009584] dyndbg: processed 96 queries, with 299040 matches, 0 errs
> 
> benchmark 2 queries: 1- a wildcard in all terms, 2- baseline, no terms
> 
> qry: ct:48 x << 
>   file "*" module "*" func "*"  +mf # on ;  file "*" module "*" func "*"  -mf # off 
>  >>
> len: 4080, 576
> Benchmark: timing 10 iterations of no_search, wildcards...
>  no_search:  0 wallclock secs ( 0.00 usr +  0.08 sys =  0.08 CPU) @ 125.00/s (n=10)
>             (warning: too few iterations for a reliable count)
>  wildcards:  1 wallclock secs ( 0.00 usr +  0.16 sys =  0.16 CPU) @ 62.50/s (n=10)
>             (warning: too few iterations for a reliable count)
> 
> Conclusion: Wildcarding isn't terribly expensive, so it is fair game
> for format matching, just like the other fields.
> 
> qry: ct:49 x << 
>   file "*" module "*" func "*"  +p # on ;  file "*" module "*" func "*"  -p # off 
>  >>
> len: 4067, 490
> Benchmark: timing 10 iterations of no_search, wildcards...
>  no_search: 40 wallclock secs ( 0.00 usr + 40.08 sys = 40.08 CPU) @  0.25/s (n=10)
>  wildcards: 40 wallclock secs ( 0.00 usr + 40.37 sys = 40.37 CPU) @  0.25/s (n=10)
> bash-5.1# 
> 
> Here, +p -p static-key toggle dominates the workload, and is MUCH
> slower than comparable simple-flag toggling above.
> 
> 
> I do hope that verbose= is not frozen API.
> It has always been an integer, not a boolean, implying range.
> 
> It has also seen refinement since its origin:
> 
> commit 74df138d508e ("dynamic_debug: change verbosity at runtime")
> 
> This made verbose usable as a knob, w/o requiring reboot, but also
> (implicitly) made it API, because it got exposed to userspace ?
> 
> commit 481c0e33f1e7 ("dyndbg: refine debug verbosity; 1 is basic, 2 more chatty")
> 
> This altered the callsite "changed" info to verbose=2 (amongst others),
> but that really wasn't enough selectivity to cope with the situation
> described above.

I took the first patch here, I wanted to take patches 4 and 5 as well,
but they did not apply because I didn't want to take 2 and 3 right now.

thanks,

greg k-h
