Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C5935FB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352680AbhDNTPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234378AbhDNTPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:15:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61B4C61220;
        Wed, 14 Apr 2021 19:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618427699;
        bh=FAgEyFazHYlkUuH6oBzBVSFblscpQVbM2nF7YBgIV8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7ZnN4y6nYNdcFEA2hVf143U4jRwds/WtbJBNebOZ1mp7idLRh9SNDapGkKGjlTz+
         Yj+KQEFuIt/SsDRCRlH7+zENQeITcEt2paak9Pd9VahyIqk4RdjbJKoZfB/RWvg9oj
         cnpqfVwdd94LkhEXtlTuuWPiAFeFVIUKs3a0JNlnUwEAoGkPSj/zcnZ5ElnNIOkITM
         mRxGQ3vFUehEl64NRknVew/orgfTlDj+em2/mhI+wLSzIeaJSe8KXL2ylcsYrsvz6+
         Qg15LMSHKFTrbCy0zZm6C6AhUXNXpxIAX56eb/59up+9D8vIVXdzgeLFNNZE7FDe3J
         hS86h3KhPFwuw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF90F40647; Wed, 14 Apr 2021 16:14:56 -0300 (-03)
Date:   Wed, 14 Apr 2021 16:14:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v2] perf beauty: Fix fsconfig generator
Message-ID: <YHc/MIPBaCGJVFFl@kernel.org>
References: <20210414182723.1670663-1-vt@altlinux.org>
 <YHc9nC6EYf/eP3GH@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHc9nC6EYf/eP3GH@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 14, 2021 at 04:08:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> [root@6db6d5ad9661 perf]# tools/perf/trace/beauty/fsconfig.sh
> static const char *fsconfig_cmds[] = {
> 	[0] = "SET_FLAG",
> 	[1] = "SET_STRING",
> 	[2] = "SET_BINARY",
> 	[3] = "SET_PATH",
> 	[4] = "SET_PATH_EMPTY",
> 	[5] = "SET_FD",
> 	[6] = "CMD_CREATE",
> 	[7] = "CMD_RECONFIGURE",
> };
> [root@6db6d5ad9661 perf]#
> 
> So I guess we can sweep thru tools/perf/trace/beauty/*.sh and simplify
> things in other table generators?
> 
> Please consider this.
> 
> Thanks, applied.

Its in my tmp.perf/core branch, will go to the main one after what is in
there passes my longish regression test suite,

- Arnaldo
