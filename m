Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CF93397E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhCLUCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:02:05 -0500
Received: from mx1.riseup.net ([198.252.153.129]:47278 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234342AbhCLUBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:01:42 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4DxxXk4bSjzDqCH;
        Fri, 12 Mar 2021 12:01:42 -0800 (PST)
X-Riseup-User-ID: 48AD520682A172C0D2723F83ED3442DB99E29EB8E46036614C1E5308AF18023B
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4DxxXj6L1hz5wGG;
        Fri, 12 Mar 2021 12:01:41 -0800 (PST)
Subject: Re: [PATCH v5] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
From:   Jim Newsome <jnewsome@torproject.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210312173855.24843-1-jnewsome@torproject.org>
 <20210312102207.a347e38db375226a78cc37bf@linux-foundation.org>
 <ccfef0d5-c419-0a8d-cf75-9642e9d11f94@torproject.org>
Organization: The Tor Project
Message-ID: <e431450d-1b19-b4c0-5050-f94f5fffdb76@torproject.org>
Date:   Fri, 12 Mar 2021 14:01:41 -0600
MIME-Version: 1.0
In-Reply-To: <ccfef0d5-c419-0a8d-cf75-9642e9d11f94@torproject.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Re-sent without html part, which the list rejected)

On 3/12/21 12:47, Andrew Morton wrote:

> IOW, please spend a bit of time selling the patch!  What is the case
> for including it in Linux?  What benefit does it provide our users?

Ah yes - I'd included some context when I first reached out to Oleg, but
that never made it to the list :).

I'm helping develop a new ptrace-based version of Shadow [1] - a tool
for simulating a (potentially large) network. Shadow runs the network
user-space applications in an emulated environment, and routes network
traffic through a model of the network accounting for latency,
bandwidth, etc. The Tor Project plans to make increasing use of Shadow
both for focused evaluation of specific proposed software and parameter
changes, attacks, and defenses, and as a regular automated performance
evaluation prior to deployment of new versions.  Today Shadow is already
actively used in the research community for applications including tor
and bitcoin.

We're interested in running simulations including at least tens of
thousands of processes, with a stretch goal of being able to handle 1M
processes. Since each process is being ptraced, calling an O(n) waitpid
has a huge performance penalty at this scale, and results in simulation
performance growing ~quadratically with the size of the simulation.

We do have a workaround where we use a "fork proxy" thread to actually
fork all the processes, and we stop and detach inactive processes. (The
number of "active" processes is roughly fixed to the number of worker
threads, which is generally the # of CPUs available). i.e. this keeps
the number of children and tracees small and fixed, allowing us to scale
linearly. However, having to detach and reattach tracees adds a
significant linear overhead factor. This kernel patch would allow us to
get rid of the complexity and extra overhead of this workaround, and
benefit other applications that haven't implemented such a workaround.

We have some details and analysis of this issue in GitHub [2]. I haven't
added results with the patch yet, but plan to do so.

This should also help other applications that have a large number of
children or tracees. Ptrace-based emulation tools are probably the most
likely to benefit. e.g. I suspect it'll help User Mode Linux [3], which
IIUC uses a single tracer thread to ptrace every process running on its
kernel. Likewise it could help DetTrace [4], which uses ptrace for
deterministic software builds.

[1]: https://shadow.github.io/
[2]: https://github.com/shadow/shadow/issues/1134
[3]: https://en.wikipedia.org/wiki/User-mode_Linux
[4]: https://github.com/dettrace/dettrace
