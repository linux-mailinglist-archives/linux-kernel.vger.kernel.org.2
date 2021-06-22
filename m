Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6F33B098E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhFVPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:54:20 -0400
Received: from smtprelay0186.hostedemail.com ([216.40.44.186]:56760 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231997AbhFVPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:54:13 -0400
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E648C1AD87;
        Tue, 22 Jun 2021 15:51:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id BC628268E50;
        Tue, 22 Jun 2021 15:51:54 +0000 (UTC)
Message-ID: <4f49fc31e79f3ed3d1178120b6a76b37dedda149.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Do not complain about positive return
 values starting with EPOLL
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
In-Reply-To: <20210622004334.638680-1-linux@roeck-us.net>
References: <20210622004334.638680-1-linux@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date:   Mon, 21 Jun 2021 22:06:42 -0700
User-Agent: Evolution 3.40.0-1 
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.04
X-Stat-Signature: j5oiu8writwaem1j6d9bdde1u73fhzzy
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: BC628268E50
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/flB5YUkQGtnIDb9W5hfUvUwsrNYg11e8=
X-HE-Tag: 1624377114-254337
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-06-21 at 17:43 -0700, Guenter Roeck wrote:
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
> 
> Cc: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Replaced 'rindex($name, 'EPOLL', 0) != 0' with '$name !~ /^EPOLL/'

Acked-by: Joe Perches <joe@perches.com>

> 
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 23697a6b1eaa..9ab006df01fe 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5458,7 +5458,7 @@ sub process {
>  # Return of what appears to be an errno should normally be negative
>  		if ($sline =~ /\breturn(?:\s*\(+\s*|\s+)(E[A-Z]+)(?:\s*\)+\s*|\s*)[;:,]/) {
>  			my $name = $1;
> -			if ($name ne 'EOF' && $name ne 'ERROR') {
> +			if ($name ne 'EOF' && $name ne 'ERROR' && $name !~ /^EPOLL/) {
>  				WARN("USE_NEGATIVE_ERRNO",
>  				     "return of an errno should typically be negative (ie: return -$1)\n" . $herecurr);
>  			}


