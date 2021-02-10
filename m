Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D992B316721
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhBJMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhBJMwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:52:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9F2A64DF2;
        Wed, 10 Feb 2021 12:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612961511;
        bh=3ANfLUPOdNsqF2xYY2mEKyOlMs90/0utz+hz6lvcaIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dn4UYauslhggonOTDbJKXimGJ1QCTklV6KplgNFsB6j31TDjFC6w20Nys/UmTT+iP
         EH4IntBMv2maimiaIBsOXFJjN6WuvthSjTBcjol8oimguwYqr9scnp8qIsiLn76PQh
         4BWXwQZvcUJEuGCKRLXEJyr4ZYxUMWIxh5wvO4o4ueTMrZbCcXjzXnjCDpuWR1LKMd
         tIRZy25g/Z0ckUQsXw0EEEGxWDqKPt+RmGwT2q0pReCx89yA926L1/woQSvlK08l2I
         LsshUO5WVPjt/3hiS4535pX04xv2x86ES6okI9F+AutfLLYUdbilJwAE6TDnfdR7Qu
         P85AuXZrciIdQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0D86C40513; Wed, 10 Feb 2021 09:51:47 -0300 (-03)
Date:   Wed, 10 Feb 2021 09:51:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 15/24] perf daemon: Add ping command
Message-ID: <20210210125146.GD1018564@kernel.org>
References: <20210208200908.1019149-1-jolsa@kernel.org>
 <20210208200908.1019149-16-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208200908.1019149-16-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 08, 2021 at 09:08:59PM +0100, Jiri Olsa escreveu:
> +
> +	if (!pollfd.revents & POLLIN) {
> +		pr_err("failed: did not received an ack\n");
> +		goto out;
> +	}
> +

Fixed up this, pointed out by clang on many build containers, including
fedora:34:

Committer notes:

Fixed up bug pointed by clang:

Buggy:

  if (!pollfd.revents & POLLIN)

Correct code:

  if (!(pollfd.revents & POLLIN))

clang warning:

  builtin-daemon.c:560:6: error: logical not is only applied to the left hand side of this bitwise operator [-Werror,-Wlogical-not-parentheses]
          if (!pollfd.revents & POLLIN) {
              ^               ~
  builtin-daemon.c:560:6: note: add parentheses after the '!' to evaluate the bitwise operator first


- Arnaldo
