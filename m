Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A2932AA4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835618AbhCBTSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:18:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1579341AbhCBQrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:47:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23F9564F11;
        Tue,  2 Mar 2021 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614702270;
        bh=8uz1l9NTt3hs+m2jI4ElPQerrK5vVk9t1pZ2SpFgykQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGF9z6RgA0u650rXYe89FKmW51l3PMC+fL/yyNP33YHINw4FrR+vNdfrHc6OKDY8K
         MkKmFnHFF8ozsbCqYN5sMuuvQe4z0eaHVTVaKTbebfJ8PwqjR/TQ39XqY7roGECHNU
         sRULrB9zXc4FZ6ldvWNa5TEX9z3lpNc69neUmizzN0hNSpmn1p08/ZZYZo1hTan2M9
         y6IfptLafpwQUynNSBG09vkBJk/PazqGm3VPf9h2EmUXEpSClc+bI/Q0nsI40251jY
         qMWbAkk7VruGSQi3S3AczTwQmoZGmNqFWLDf00SeQAws8AKaxbrfTdzbt93FnnqeN1
         VvpD07fe8RjNA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E349640CD9; Tue,  2 Mar 2021 13:24:27 -0300 (-03)
Date:   Tue, 2 Mar 2021 13:24:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] coresight: Patches for v5.12 (perf tools)
Message-ID: <YD5mu7Df3fXiWZuk@kernel.org>
References: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
 <YD41GUtuq8fVa4Q6@kernel.org>
 <CAJ9a7ViKLg8vjBnuA1eWh8b5-PN7RryefyOV1qoX9Zu362Eq8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7ViKLg8vjBnuA1eWh8b5-PN7RryefyOV1qoX9Zu362Eq8Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 02, 2021 at 02:23:14PM +0000, Mike Leach escreveu:
> On Tue, 2 Mar 2021 at 12:52, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Wed, Feb 24, 2021 at 09:48:29AM -0700, Mathieu Poirier escreveu:
> > > I noticed there is a couple of patchsets [1][2] that haven't made it
> > > to your tree for the coming v5.12 cycle.  Do you think that can still
> > > be done?

> > > I tallied the patches here to make it easier for you to pick up.

> > > Applies cleanly on perf/core (84b7725536d8)

> > > [1]. https://lore.kernel.org/lkml/20210202214040.32349-1-mike.leach@linaro.org/
> > > [2]. https://lore.kernel.org/lkml/20210213113220.292229-1-leo.yan@linaro.org/

> > These are not applying right now, I've pushed what I have to
> > tmp.perf/core, please take a look, I'll get back to this after
> > processing fixes for v5.12 and what is outstanding for v5.13.
 
> I've tried [1] on both Linux-5.12-rc1 and your tmp.perf/core and it
> applies cleanly on both.

Can you please try one more time, these are the last csets on this
branch:

  $ git log --oneline acme/tmp.perf/core -10
  8e1488a46dcf73b1 (HEAD -> perf/core, five/perf/core, acme/tmp.perf/core, acme.korg/tmp.perf/core) perf cs-etm: Detect pid in VMID for kernel running at EL2
  47f0d94c203751dd perf cs-etm: Add helper cs_etm__get_pid_fmt()
  30cb76aabfb4deab perf cs-etm: Support PID tracing in config
  8c559e8d68630d64 perf cs-etm: Fix bitmap for option
  2bb4ccbd95d7fbf5 tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
  42b2b570b34afb5f perf cs-etm: Update ETM metadata format
  83bf6fb8b076c72f perf vendor events power9: Remove unsupported metrics
  34968b9327c83589 perf buildid-cache: Add test for PE executable
  9bb8b74bdb186bd3 perf docs: Add man pages to see also
  d9fd5a718977702f perf tools: Generate mips syscalls_n64.c syscall table
  $

I think it doesn't apply because I applied a series from Mathieu
touching files affected by those two patchkits.

- Arnaldo
 
> Let me know if there is anything else I can try.
> 
> Thanks
> 
> Mike
> 
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK

-- 

- Arnaldo
