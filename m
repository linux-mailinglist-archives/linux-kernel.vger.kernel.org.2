Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EBF352B07
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhDBNdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhDBNdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:33:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B33661006;
        Fri,  2 Apr 2021 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617370384;
        bh=g3+GdqG0qwnSIqz0T9FWl5i1nemtm/jnPIECoCz7vak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SwoA0MI17eqa7L34NbRBaci9vAKKqnfd5M2v2xgO/RMFFVWmWWh5umCnPLBlxce6l
         DW6hcg/LMKI6wEeLEgTQXcWpjXB4Oer6nuEd8C5fuP8+8h+ikVnzx3MAhvrSUQtDJS
         WcmHOKTQO4noeEju+133U/oKS4SL6N0ELMgtxk/H6xUm+Jcfg88Ai2MgiEkZSRrkG2
         a7ezhQpeRFgWN12lE+9i4jkQrnSwkJajJkr5C3/zLiFSB05USw/OuestFhqBZB9ah1
         P0gwQTOr2HxJ7jGLBa0C5PVBmOpZ7vdH3pQTQsv1iylvF0SDWigJisYXLCcPy+FSaE
         By0/+s6OxagSQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4499040647; Fri,  2 Apr 2021 10:33:02 -0300 (-03)
Date:   Fri, 2 Apr 2021 10:33:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf inject: Fix repipe usage
Message-ID: <YGcdDoPaVpkM1DBm@kernel.org>
References: <20210401103605.9000-1-adrian.hunter@intel.com>
 <YGXTGQwbz0wOWplZ@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGXTGQwbz0wOWplZ@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 01, 2021 at 04:05:13PM +0200, Jiri Olsa escreveu:
> On Thu, Apr 01, 2021 at 01:36:05PM +0300, Adrian Hunter wrote:
> > Since commit 14d3d5405253 ("perf session: Try to read pipe data from file")
> > perf inject has started printing "PERFILE2h" when not processing pipes.
> > 
> > The commit exposed perf to the possiblity that the input is not a pipe but
> > the 'repipe' parameter gets used. That causes the printing because perf
> > inject sets 'repipe' to true always.
> > 
> > The 'repipe' parameter of perf_session__new() is used by 2 functions:
> > 	- perf_file_header__read_pipe()
> > 	- trace_report()
> > In both cases, the functions copy data to STDOUT_FILENO when 'repipe' is
> > true.
> > 
> > Fix by setting 'repipe' to true only if the output is a pipe.
> > 
> > Fixes: e558a5bd8b74 ("perf inject: Work with files")
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

