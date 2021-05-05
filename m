Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035A8374AD8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhEEV4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:56:00 -0400
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:57496 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229691AbhEEVz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:55:59 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C29CA837F253;
        Wed,  5 May 2021 21:55:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 7CFF7C4171;
        Wed,  5 May 2021 21:55:00 +0000 (UTC)
Message-ID: <388ba4aa3ebbae03776aae3c70303077c19e1274.camel@perches.com>
Subject: Re: [PATCH] checkpatch: scripts/spdxcheck.py now requires python3
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Bert Vermeulen <bert@biot.com>
Date:   Wed, 05 May 2021 14:54:59 -0700
In-Reply-To: <20210505211720.447111-1-linux@roeck-us.net>
References: <20210505211720.447111-1-linux@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7CFF7C4171
X-Spam-Status: No, score=1.11
X-Stat-Signature: y49tg4e1995jpj69qarq9kn9fnchn3jf
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+RSkEc6ddYRhriR86/9MSUWMTmZ+xtu6A=
X-HE-Tag: 1620251700-530527
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-05-05 at 14:17 -0700, Guenter Roeck wrote:
> Since commit d0259c42abff ("spdxcheck.py: Use Python 3"), spdxcheck.py
> explicitly expects to run as python3 script. If "python" still points to
> python v2.7 and the script is executed with "python scripts/spdxcheck.py",
> the following error may be seen even if git-python is installed for
> python3.
> 
> Traceback (most recent call last):
>   File "scripts/spdxcheck.py", line 10, in <module>
>     import git
> ImportError: No module named git
> 
> To fix the problem, check for the existence of python3, check if
> the script is executable and not just for its existence, and execute
> it directly.
> 
> Cc: Bert Vermeulen <bert@biot.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Seems sensible, thanks.

> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index ccb412a74725..8a1b782dd7e7 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1084,10 +1084,10 @@ sub is_maintained_obsolete {
>  sub is_SPDX_License_valid {
>  	my ($license) = @_;
>  
> 
> -	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
> +	return 1 if (!$tree || which("python3") eq "" || !(-x "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
>  
> 
>  	my $root_path = abs_path($root);
> -	my $status = `cd "$root_path"; echo "$license" | python scripts/spdxcheck.py -`;
> +	my $status = `cd "$root_path"; echo "$license" | scripts/spdxcheck.py -`;
>  	return 0 if ($status ne "");
>  	return 1;
>  }


