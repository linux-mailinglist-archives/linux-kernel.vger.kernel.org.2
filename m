Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4218C3F08A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbhHRQBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:01:16 -0400
Received: from smtprelay0071.hostedemail.com ([216.40.44.71]:55190 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231938AbhHRQBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:01:15 -0400
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C1F6B18141EE1;
        Wed, 18 Aug 2021 16:00:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id CE1E7255112;
        Wed, 18 Aug 2021 16:00:37 +0000 (UTC)
Message-ID: <cc5801790fea258e20fa6b7e26de7806ae8e0dda.camel@perches.com>
Subject: Re: [RFC PATCH 1/5] checkpatch: improve handling of revert commits
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jkosina@suse.cz>,
        Willy Tarreau <w@1wt.eu>
Date:   Wed, 18 Aug 2021 09:00:34 -0700
In-Reply-To: <20210818154646.925351-2-efremov@linux.com>
References: <20210818154646.925351-1-efremov@linux.com>
         <20210818154646.925351-2-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 93j4y7dx68nmkxdds863bynmbntt7mab
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: CE1E7255112
X-Spam-Status: No, score=5.20
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+QdrUkNGfV/W0C0QZdDZuAywMOB7YW4jw=
X-HE-Tag: 1629302437-211171
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-08-18 at 18:46 +0300, Denis Efremov wrote:
> Properly handle commits like:
> commit f2791e7eadf4 ("Revert "floppy: refactor open() flags handling"")

Try this one:

https://lore.kernel.org/lkml/7f55d9d0369f1ea840fab83eeb77f9f3601fee41.camel@perches.com/

> 
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> �scripts/checkpatch.pl | 12 ++++++------
> �1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 461d4221e4a4..cf31e8c994d3 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3200,20 +3200,20 @@ sub process {
> �			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
> �			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
> �			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
> -			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
> +			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.+)"\)/i) {
> �				$orig_desc = $1;
> �				$hasparens = 1;
> �			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
> �				 defined $rawlines[$linenr] &&
> -				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
> +				 $rawlines[$linenr] =~ /^\s*\("(.+)"\)/) {
> �				$orig_desc = $1;
> �				$hasparens = 1;
> -			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
> +			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\(".+$/i &&
> �				 defined $rawlines[$linenr] &&
> -				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
> -				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
> +				 $rawlines[$linenr] =~ /^\s*.+"\)/) {
> +				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.+)$/i;
> �				$orig_desc = $1;
> -				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
> +				$rawlines[$linenr] =~ /^\s*(.+)"\)/;
> �				$orig_desc .= " " . $1;
> �				$hasparens = 1;
> �			}


