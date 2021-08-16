Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEFC3ED340
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhHPLnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:43:02 -0400
Received: from smtprelay0169.hostedemail.com ([216.40.44.169]:53110 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231758AbhHPLnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:43:01 -0400
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 16CDE181A3499;
        Mon, 16 Aug 2021 11:42:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 0165B2EBFA0;
        Mon, 16 Aug 2021 11:42:27 +0000 (UTC)
Message-ID: <d6451fbddb3a17c7bad1c2d574e86e00e7295258.camel@perches.com>
Subject: Re: [PATCH] checkpatch: make email address check case insensitive
From:   Joe Perches <joe@perches.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Simon Thoby <simon.thoby@viveris.fr>,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Aug 2021 04:42:26 -0700
In-Reply-To: <20210816112725.173206-1-zohar@linux.ibm.com>
References: <20210816112725.173206-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0165B2EBFA0
X-Spam-Status: No, score=5.19
X-Stat-Signature: b167u5d3g89eykxws36dfw6xw8zz3qsc
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+b+rZ5MuvFtwEXrlsFy3pApEMYUCVTPTA=
X-HE-Tag: 1629114147-944958
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-16 at 07:27 -0400, Mimi Zohar wrote:
> Instead of checkpatch requiring the patch author to exactly match the
> signed-off-by tag, commit 48ca2d8ac8a1 ("checkpatch: add new warnings
> to author signoff checks.") safely relaxed this requirement.
> 
> Although the local-part of an email address (local-part@domain), may
> be case sensitive, exploiting the case sensitivity of mailbox
> local-parts impedes interoperability and is discouraged.  Mailbox
> domains follow normal DNS rules and are hence not case sensitive.
> (Refer to https://datatracker.ietf.org/doc/html/rfc5321#section-2.4.)
> 
> Further relax the patch author and signed-off-by tag comparison by
> making the email address check case insensitive.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Acked-by: Joe Perches <joe@perches.com>

> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 461d4221e4a4..1efa2997df62 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2909,10 +2909,10 @@ sub process {
>  					my ($email_name, $email_comment, $email_address, $comment1) = parse_email($ctx);
>  					my ($author_name, $author_comment, $author_address, $comment2) = parse_email($author);
>  
> 
> -					if ($email_address eq $author_address && $email_name eq $author_name) {
> +					if (lc $email_address eq lc $author_address && $email_name eq $author_name) {
>  						$author_sob = $ctx;
>  						$authorsignoff = 2;
> -					} elsif ($email_address eq $author_address) {
> +					} elsif (lc $email_address eq lc $author_address) {
>  						$author_sob = $ctx;
>  						$authorsignoff = 3;
>  					} elsif ($email_name eq $author_name) {


