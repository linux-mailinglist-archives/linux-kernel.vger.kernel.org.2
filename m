Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5690336CBD3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbhD0Tmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235719AbhD0Tmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:42:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85941611F2;
        Tue, 27 Apr 2021 19:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619552525;
        bh=lop0ny1ajUsRVY08u+taCG1Hkvn9+OimS8y9THlwrlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HOlKP1/f2YSCrPu4FeQGh3oaaDGBLP8fZlwy1V1NuHb7vzhQZl2jlUmKzU4BaPOHb
         rrJ5i72oGP0TVPBr/OHm6acKeFGpku24YNxRR1xONDgVPX2YgVq+gzwbRnxpMSXbha
         NXFqdsbvkoKosBMfvDANMrHTD0beVDAQQerzWjLGP5SxeN2dSZqACxcIFRMdE4buzm
         39+JQGJT4B/mG5R+LcPoTVfgpZ8kL7TEBiUEDHrXMI39MK6xYXwqHQlfMvgco1T/sG
         4AYGnc2EeSoPtJdPy/EFArmsYkAXOKZQY2x8BBSpmijCM49wQFhqYeMAc76S5eXBaX
         /ivy1IjULO2hw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 61EED40647; Tue, 27 Apr 2021 16:42:02 -0300 (-03)
Date:   Tue, 27 Apr 2021 16:42:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, songliubraving@fb.com
Subject: Re: [PATCH v5 5/5] perf-stat: introduce bpf_counter_ops->disable()
Message-ID: <YIhpCuTPWPwURiQh@kernel.org>
References: <20210425214333.1090950-1-song@kernel.org>
 <20210425214333.1090950-6-song@kernel.org>
 <YIhlmhyBPxTOZRZa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIhlmhyBPxTOZRZa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 27, 2021 at 04:27:22PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sun, Apr 25, 2021 at 02:43:33PM -0700, Song Liu escreveu:
> > Introduce bpf_counter_ops->disable(), which is used stop counting the
> > event.
> 
> [acme@five perf]$ perf test -v python
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
> 19: 'import perf' in python                                         :
> --- start ---
> test child forked, pid 1497924
> python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so: undefined symbol: bpf_counter__disable
> test child finished with -1
> ---- end ----
> 'import perf' in python: FAILED!
> [acme@five perf]$
> 
> I'll fix this up in my local tree, if you need to respin, please pick
> patches from tmp.perf/core, will refresh it later today.

Added this:


diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 278abecb5bdfc0d2..27940edb161c2d8c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -100,6 +100,11 @@ int bpf_counter__install_pe(struct evsel *evsel __maybe_unused, int cpu __maybe_
 	return 0;
 }
 
+int bpf_counter__disable(struct evsel *evsel __maybe_unused)
+{
+	return 0;
+}
+
 /*
  * Support debug printing even though util/debug.c is not linked.  That means
  * implementing 'verbose' and 'eprintf'.


