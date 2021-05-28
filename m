Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A823942EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhE1MuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233711AbhE1Mt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:49:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D01CE6113D;
        Fri, 28 May 2021 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622206103;
        bh=yvzFgcOrunxu+8nn/nhsR/4J2pWfHyKsDlqm8ycutCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CbNeLnUECT5SJyf33QG1iacxDN6B/OLjocELhjbDn9wVlD5HRPP826sJwBR+F+n3M
         SbALTAm3997VJNbcyiYT03SB2S5SqTzMGLRey3XUONOmRiuMQl81qUkAnoNjwIK1Ba
         sG5uVmDXbIvrfUHspiQkFxEn055ymJ2wLZlInued4Rt21qwgjI12zG3jIpIzLW42o2
         87rJZegWX4KcHp8q43gGmY5E9020NeT0DYTOWRIbvUZ8cu2ivuhL0UWJdQjMf7aNlu
         gfIrIFh15YgMDDbEVMXmlsth3ZSoEKGZnhdyV4FUH34lRNNjc+D0BLmpTGN4f1a/G7
         K4DFq1nmC5EaA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E9C904011C; Fri, 28 May 2021 09:48:19 -0300 (-03)
Date:   Fri, 28 May 2021 09:48:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)" 
        <dzagorui@cisco.com>
Cc:     "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v8 2/3] perf tests: avoid storing an absolute path in
 perf binary
Message-ID: <YLDmk2l37WL16VQh@kernel.org>
References: <20210524111514.65713-1-dzagorui@cisco.com>
 <20210524111514.65713-2-dzagorui@cisco.com>
 <YK/OpLStd2zPdHS9@kernel.org>
 <BY5PR11MB40243EB953DC674006115729D9229@BY5PR11MB4024.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY5PR11MB40243EB953DC674006115729D9229@BY5PR11MB4024.namprd11.prod.outlook.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 28, 2021 at 11:13:09AM +0000, Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco) escreveu:
> 
> > I noticed this is failing the test, nothing is being appended. I'll
> > investigate later. Can you try to reproduce this? I build perf with:
> 
> Maybe this test should fail.

I don't think so :-)

> Path is being appended only if perf is invoked from the build
> directory (basically if there is python dir near perf binary this path
> will be added to sys.path)

And that is ok for a developer, but I agree with you, we shouldn't have
such hardcoded build directories in a production binary.

> I'm not sure if install-bin task installs perf.so to system i mean
> before this patch python binary contains an absolute path to its build
> directory and if this build dir is deleted this test also will fail.

That is what is happening, yes.

> Maybe we should use export PYTHONPATH=<build dir>/python for such test

Agreed, can you cook up a patch that does that in the Makefile that
runs the 'perf python' in tools/perf/tests/?

One other suggestion: When the test fails, say when we run 'perf test
python' directly, it could check if PYTHONPATH is set and if not, warn
the user, something like:

⬢[acme@toolbox perf]$ perf test python
19: 'import perf' in python                                         : FAILED! (Please set the PYTHONPATH env variable)
 
> Thanks,
> Denys
> 
> > alias m='perf stat -e cycles:u,instructions:u make -k CORESIGHT=1 BUILD_BPF_SKEL=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin && perf test python'
> > 
> >
> > ⬢[acme@toolbox perf]$ perf test python
> > 19: 'import perf' in python                                         : FAILED!
> > ⬢[acme@toolbox perf]$ perf test -v python
> > Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
> > 19: 'import perf' in python                                         :

-- 

- Arnaldo
