Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C103917CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhEZMtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234281AbhEZMsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:48:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 790F460231;
        Wed, 26 May 2021 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622033207;
        bh=0a0OiJbiwyz5/cF6QjtqmloxI42zb7P774GdVsj9us0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgxwfndJRt68PtS5hsfXyiK+EsG0Epxh5xuwmnxyONaBseZ3wMmygpSj/iwEyicdM
         7zIQjy9M34mWxxIVnOjJ+XaeeJMOt4ZemHn3SPA9yppP5B2X/3hhy5Nt9Fd/76mdPN
         Ua5X4TFy3a71CndNUQz+1DDrhbsTyjmWJoP7+4c936QEb5FqZmHWqRvqYdnreAEEqR
         zJQC9migI4agIYf6uiPvnePhWD1OyP+K1MpWeCMlpXDvtV8dmUS6qCL9n156iR5qB3
         ZHFXrhmP4MbpU2uTLPCabUFW90m2fUzeKN4il/2DfDmRY+l8bXlqdF9NIk6HSplI/9
         qKTD8vlhKMjOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A65BE4011C; Wed, 26 May 2021 09:46:44 -0300 (-03)
Date:   Wed, 26 May 2021 09:46:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Denys Zagorui <dzagorui@cisco.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Subject: Re: [PATCH v8 1/3] perf report: compile tips.txt in perf binary
Message-ID: <YK5DNK6IfEe65kAO@kernel.org>
References: <20210524111514.65713-1-dzagorui@cisco.com>
 <YK428rtY1GsVFL4E@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK428rtY1GsVFL4E@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 26, 2021 at 01:54:26PM +0200, Jiri Olsa escreveu:
> On Mon, May 24, 2021 at 04:15:12AM -0700, Denys Zagorui wrote:
> > It seems there is some need to have an ability to invoke perf from
> > build directory without installation
> > (84cfac7f05e1: perf tools: Set and pass DOCDIR to builtin-report.c)
> > DOCDIR definition contains an absolute path to kernel source directory.
> > It is build machine related info and it makes perf binary unreproducible.
> > 
> > This can be avoided by compiling tips.txt in perf directly.
> > 
> > Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> 
> for patchset
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

