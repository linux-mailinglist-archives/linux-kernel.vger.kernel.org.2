Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92A13C625F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 20:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhGLSKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 14:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhGLSKy (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 14:10:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59D6C61186;
        Mon, 12 Jul 2021 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626113285;
        bh=np4JNT0BJpCZ4vvOwewfHbchj+ZJLJ/rTIO40POtAFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFHh6VAczXldBn2wZnYsfbfubpt9RTVtEJoAyUvA0Q1JBxhWDAiH7Yij8BPTMN6xZ
         3uzhQ52Zunoxksl9ye5Kadokq9qo0prBxf0vl/MHep0d8FXqFl5qI42YDC3+VUv4HU
         4mOWTG6QxPotlguT6ThlvN0cIEde5PLwDEOejtIYp63xEQbfLdLDbrS8nOGqUs1TGF
         dKVmvMNEIgqkX7DiPqpP3BOh5ijW7kzKsDEerooDhBqlK2OcQmc6UOWE04ghx6IQM+
         7cBSSPN1d6ER6U8ctibSqPr7MfcpV8IMz4Y3L+sQ4hi9MVTuHjGd1dpGTw8wiQGlCW
         zfy0VzbLxNLpA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AFCF5403F2; Mon, 12 Jul 2021 15:08:02 -0300 (-03)
Date:   Mon, 12 Jul 2021 15:08:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 0/4] perf tool: Skip invalid hybrid PMU
Message-ID: <YOyFAtElgSVbWU6t@kernel.org>
References: <20210708013701.20347-1-yao.jin@linux.intel.com>
 <YOsT0NFC53WIku2k@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOsT0NFC53WIku2k@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 11, 2021 at 05:52:48PM +0200, Jiri Olsa escreveu:
> On Thu, Jul 08, 2021 at 09:36:57AM +0800, Jin Yao wrote:
> > On hybrid platform, such as Alderlake, if atom CPUs are offlined,
> > the kernel still exports the sysfs path '/sys/devices/cpu_atom/' for
> > 'cpu_atom' pmu but the file '/sys/devices/cpu_atom/cpus' is empty,
> > which indicates this is an invalid pmu. So we need to check and skip
> > the invalid hybrid pmu.
> > 
> > Also we need to update some perf test cases for core-only system.
> > 
> > Jin Yao (4):
> >   perf pmu: Skip invalid hybrid pmu
> >   perf tests: Fix 'Parse event definition strings' on core-only system
> >   perf tests: Fix 'Roundtrip evsel->name' on core-only system
> >   perf tests: Fix 'Convert perf time to TSC' on core-only system
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied to perf/urgent.

- Arnaldo

