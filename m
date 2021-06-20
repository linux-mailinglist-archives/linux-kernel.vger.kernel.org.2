Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A4B3AECE9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFUP7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:59:53 -0400
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:41908 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229719AbhFUP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:59:52 -0400
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id EF9B3180B6EB7;
        Mon, 21 Jun 2021 15:57:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 68D7918A600;
        Mon, 21 Jun 2021 15:57:36 +0000 (UTC)
Message-ID: <eb064d63c63c3ba711eb46edb8617a9d20a272e6.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Do not complain about positive return
 values starting with EPOLL
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
In-Reply-To: <20210620154555.3848275-1-linux@roeck-us.net>
References: <20210620154555.3848275-1-linux@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date:   Sun, 20 Jun 2021 12:20:54 -0700
User-Agent: Evolution 3.40.0-1 
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.78
X-Stat-Signature: jgk3j93kj1mhajmkzfmdaa893ghqmyh6
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 68D7918A600
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18jfp58UmH44YNNkAe/eNGn3i4w6GzDTxI=
X-HE-Tag: 1624291056-595224
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-06-20 at 08:45 -0700, Guenter Roeck wrote:
> checkpatch complains about positive return values of poll functions.
> Example:
> 
> WARNING: return of an errno should typically be negative (ie: return -EPOLLIN)
> +		return EPOLLIN;
> 
> Poll functions return positive values. The defines for the return values
> of poll functions all start with EPOLL, resulting in a number of false
> positives. An often used workaround is to assign poll function return
> values to variables and returning that variable, but that is a less than
> perfect solution.
> 
> There is no error definition which starts with EPOLL, so it is safe to omit
> the warning for return values starting with EPOLL.

Seems OK but

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5458,7 +5458,8 @@ sub process {
>  # Return of what appears to be an errno should normally be negative
>  		if ($sline =~ /\breturn(?:\s*\(+\s*|\s+)(E[A-Z]+)(?:\s*\)+\s*|\s*)[;:,]/) {
>  			my $name = $1;
> -			if ($name ne 'EOF' && $name ne 'ERROR') {
> +			if ($name ne 'EOF' && $name ne 'ERROR' &&
> +			    rindex($name, 'EPOLL', 0) != 0) {

rindex is a bit harder to read so my preference would be for the simpler:

			if ($name ne 'EOF' && $name ne 'ERROR' && $name !~ /^EPOLL/) {

>  				WARN("USE_NEGATIVE_ERRNO",
>  				     "return of an errno should typically be negative (ie: return -$1)\n" . $herecurr);
>  			}


