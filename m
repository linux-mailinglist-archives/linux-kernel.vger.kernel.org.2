Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C61233D9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbhCPQs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:48:59 -0400
Received: from mail.ispras.ru ([83.149.199.84]:41790 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237230AbhCPQsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:48:22 -0400
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id C4AE540755F6;
        Tue, 16 Mar 2021 16:48:19 +0000 (UTC)
Date:   Tue, 16 Mar 2021 19:48:19 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Adam Borowski <kilobyte@angband.pl>
cc:     Jiri Olsa <jolsa@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86@kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stanislav Kozina <skozina@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Pierre Amadio <pamadio@redhat.com>, onatalen@redhat.com,
        darcari@redhat.com
Subject: Re: unknown NMI on AMD Rome
In-Reply-To: <YFDWmwgDa/FzFsIs@angband.pl>
Message-ID: <alpine.LNX.2.20.13.2103161945380.17743@monopod.intra.ispras.ru>
References: <YFDSSxftYw9tCGC6@krava> <YFDWmwgDa/FzFsIs@angband.pl>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021, Adam Borowski wrote:

> On Tue, Mar 16, 2021 at 04:45:02PM +0100, Jiri Olsa wrote:
> > hi,
> > when running 'perf top' on AMD Rome (/proc/cpuinfo below)
> > with fedora 33 kernel 5.10.22-200.fc33.x86_64
> > 
> > we got unknown NMI messages:
> > 
> > [  226.700160] Uhhuh. NMI received for unknown reason 3d on CPU 90.
> > [  226.700162] Do you have a strange power saving mode enabled?
> > [  226.700163] Dazed and confused, but trying to continue
> > 
> > also when discussing ths with Borislav, he managed to reproduce easily
> > on his AMD Rome machine
> 
> Likewise, 3c on Pinnacle Ridge.

I've also seen it on Renoir, and it appears related to PMU interrupt racing
against C-state entry/exit. Disabling C2 and C3 via 'cpupower' is enough to
avoid those NMIs in my case.

IIRC there were a few patches related to this area from AMD in the past.

Alexander
