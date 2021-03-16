Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C368833D8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbhCPQF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:05:28 -0400
Received: from tartarus.angband.pl ([51.83.246.204]:42928 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhCPQEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:04:52 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94)
        (envelope-from <kilobyte@angband.pl>)
        id 1lMC9T-00HMMy-6J; Tue, 16 Mar 2021 17:02:35 +0100
Date:   Tue, 16 Mar 2021 17:02:35 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
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
Message-ID: <YFDWmwgDa/FzFsIs@angband.pl>
References: <YFDSSxftYw9tCGC6@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFDSSxftYw9tCGC6@krava>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 04:45:02PM +0100, Jiri Olsa wrote:
> hi,
> when running 'perf top' on AMD Rome (/proc/cpuinfo below)
> with fedora 33 kernel 5.10.22-200.fc33.x86_64
> 
> we got unknown NMI messages:
> 
> [  226.700160] Uhhuh. NMI received for unknown reason 3d on CPU 90.
> [  226.700162] Do you have a strange power saving mode enabled?
> [  226.700163] Dazed and confused, but trying to continue
> 
> also when discussing ths with Borislav, he managed to reproduce easily
> on his AMD Rome machine

Likewise, 3c on Pinnacle Ridge.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ in the beginning was the boot and root floppies and they were good.
⢿⡄⠘⠷⠚⠋⠀                                       -- <willmore> on #linux-sunxi
⠈⠳⣄⠀⠀⠀⠀
