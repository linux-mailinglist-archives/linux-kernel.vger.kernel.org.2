Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A5F3B4FE5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 20:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFZSsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 14:48:39 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:42016 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230046AbhFZSsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 14:48:38 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 467C8182CED2A;
        Sat, 26 Jun 2021 18:46:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id B698C1D42F7;
        Sat, 26 Jun 2021 18:46:14 +0000 (UTC)
Message-ID: <b8758249e142da8c2db9920e4cf71596ff7f9570.camel@perches.com>
Subject: Re: [PATCH 2/3] checkpatch: tweak extern in C warning
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20210626034016.170306-3-jim.cromie@gmail.com>
References: <20210626034016.170306-1-jim.cromie@gmail.com>
         <20210626034016.170306-3-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date:   Fri, 25 Jun 2021 21:31:42 -0700
User-Agent: Evolution 3.40.0-1 
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.88
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B698C1D42F7
X-Stat-Signature: nf4ctxqg3ixp5bytmftenw4ymfn3x7da
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18RUbBjK/SrVIuSA5z5BGzXkWaU6qoejjo=
X-HE-Tag: 1624733174-238155
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-06-25 at 21:40 -0600, Jim Cromie wrote:
> The extern-in-C rule has one important exception: the symbol is
> defined in/by the linker script.  By convention, these almost always
> contain: _start, _stop, _end.  Suppress the warning on such symbols.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> @@ -6910,7 +6910,8 @@ sub process {
>  		    $stat =~ /^.\s*extern\s+/)
>  		{
>  			WARN("AVOID_EXTERNS",
> -			     "externs should be avoided in .c files\n" .  $herecurr);
> +			     "externs should be avoided in .c files\n($stat)\n" .  $herecurr)
> +			    unless $stat =~ /_start|_stop|_end/;

nak.

As far as I can tell, there's no reason these symbols
should not be in .h files.

besides that:

output is single line, $stat should not be used and
using unless is not desired.


