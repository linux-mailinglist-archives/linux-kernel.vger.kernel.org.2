Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F103639015D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhEYMxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232720AbhEYMxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:53:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 624AF6141C;
        Tue, 25 May 2021 12:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621947121;
        bh=03kv7R/rLgu3izvpoEherRjrBWVCpN1laPfcwdxrU+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XeL6+ZkoeX1VKArP0QmiQcY3fDl70hBv7Oo4NwgrDCVBr3X4rLn63/l36q0OqcUxS
         YEP4lVJlmq2u6Ff/A42bNtah3uHHUYGssY7ksJlV1DWICbYagtsM/6tdi0fsvyBuI7
         XOQI7U2AixiZPUPtg++fgz+rRarSIY+JInJt/xgoZg3CRmB8ngmkkdUs4zLqzQUSsM
         A7s//MOlR8wDw9w0hcH5pPuCgZH/dIoguqULKtseAdiWwFbWMSrC3pv3QeAMAVFROw
         BtpfMazsvlIvm3lheDZKQ1R/lmephAnlQAw4Z0geNBCOjJQaenzFvAn0YS7YtzMv2p
         /v1t6Jji+h3mw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 821984011C; Tue, 25 May 2021 09:51:58 -0300 (-03)
Date:   Tue, 25 May 2021 09:51:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] perf script: Find script file relative to exec path
Message-ID: <YKzy7hjv5QbL/2lH@kernel.org>
References: <20210524065718.11421-1-adrian.hunter@intel.com>
 <YKt0kMqeIq5ypW4O@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKt0kMqeIq5ypW4O@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 24, 2021 at 11:40:32AM +0200, Jiri Olsa escreveu:
> On Mon, May 24, 2021 at 09:57:18AM +0300, Adrian Hunter wrote:
> > Allow perf script to find a script in the exec path.
> > 
> > Example:
> > 
> > Before:
> > 
> >  $ perf record -a -e intel_pt/branch=0/ sleep 0.1
> >  [ perf record: Woken up 1 times to write data ]
> >  [ perf record: Captured and wrote 0.954 MB perf.data ]
> >  $ perf script intel-pt-events.py 2>&1 | head -3
> >    Error: Couldn't find script `intel-pt-events.py'
> >    See perf script -l for available scripts.
> >  $ perf script -s intel-pt-events.py 2>&1 | head -3
> >  Can't open python script "intel-pt-events.py": No such file or directory
> >  $ perf script ~/libexec/perf-core/scripts/python/intel-pt-events.py 2>&1 | head -3
> >    Error: Couldn't find script `/home/ahunter/libexec/perf-core/scripts/python/intel-pt-events.py'
> >    See perf script -l for available scripts.
> >  $
> > 
> > After:
> > 
> >  $ perf script intel-pt-events.py 2>&1 | head -3
> >  Intel PT Power Events and PTWRITE
> >             perf  8123/8123  [000]       551.230753986     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
> >             perf  8123/8123  [001]       551.230808216     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
> >  $ perf script -s intel-pt-events.py 2>&1 | head -3
> >  Intel PT Power Events and PTWRITE
> >             perf  8123/8123  [000]       551.230753986     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
> >             perf  8123/8123  [001]       551.230808216     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
> >  $ perf script ~/libexec/perf-core/scripts/python/intel-pt-events.py 2>&1 | head -3
> >  Intel PT Power Events and PTWRITE
> >             perf  8123/8123  [000]       551.230753986     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
> >             perf  8123/8123  [001]       551.230808216     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
> >  $
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

