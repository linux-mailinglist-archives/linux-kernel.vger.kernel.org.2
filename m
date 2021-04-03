Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9647635346D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 17:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbhDCPCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 11:02:36 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:54202 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231821AbhDCPCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 11:02:33 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id EEBBB184558E0;
        Sat,  3 Apr 2021 15:02:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 0F57520D756;
        Sat,  3 Apr 2021 15:02:26 +0000 (UTC)
Message-ID: <1cd79d781cdcccf621ce8e104a9cdf1e90e7f803.camel@perches.com>
Subject: Re: [PATCH v3 00/30] staging: rtl8723bs: remove RT_TRACE logs in
 core/*
From:   Joe Perches <joe@perches.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Sat, 03 Apr 2021 08:02:25 -0700
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: f8y8xwjzigh8njpx8b1i1a3yycqrrokd
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 0F57520D756
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/4QJLtXCTzaD3/uBcvaBOi2jxvHRsyFM4=
X-HE-Tag: 1617462146-363510
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-04-03 at 11:13 +0200, Fabio Aiuto wrote:
> This patchset removes all RT_TRACE usages in core/ files.

and hal and include and os_dep

> 
> This is the first of a series aimed at removing RT_TRACE macro.
> 
> The whole private tracing system is not tied to a configuration
> symbol and the default behaviour is _trace nothing_. It's verbose
> and relies on a private log level tracing doomed to be
> removed.

It's nice, but individual patches per file done by hand are difficult
to review because you are interleaving removal patches with cleanup
patches.

I believe this should be a patch series with a single patch to remove
all RT_TRACE macro uses using coccinelle and then use separate patches
to do whatever cleanups around these removals you want to do.

All of these below should be done for all files in drivers/staging/rtl8723bs
at once instead of submitting per-file patches.

IMO something like:

Cover-letter: Explain why you are doing this
Patch 1 of N: Remove all RT_TRACE macro uses using a coccinelle script
              and include the coccinelle script in the commit message
Patch 2 of N: Remove commented out RT_TRACE uses
Patch 3 of N: Remove RT_TRACE macro definition
Patch 4 of N: Cleanup coccinelle generated {} uses, if/else braces and
              the now unnecessary if tests around the RT_TRACE removals
Patch 5 of N: Cleanup whitespace
Patcn x of N: Whatever else related to these RT_TRACE sites...

https://lore.kernel.org/lkml/c845d8ea7d0d8e7a613471edb53d780d660142a9.camel@perches.com/

Using a sequence like the above would be much easier to review and
would be a significant shorter patch set.

