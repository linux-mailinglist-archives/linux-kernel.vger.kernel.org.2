Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2175E3EB49D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 13:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbhHMLgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 07:36:42 -0400
Received: from mta-14-3.privateemail.com ([198.54.127.110]:24182 "EHLO
        MTA-14-3.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbhHMLgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 07:36:41 -0400
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
        by mta-14.privateemail.com (Postfix) with ESMTP id 1053318000AE;
        Fri, 13 Aug 2021 07:36:15 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.243])
        by mta-14.privateemail.com (Postfix) with ESMTPA id 0B78018000A7;
        Fri, 13 Aug 2021 07:36:13 -0400 (EDT)
Date:   Fri, 13 Aug 2021 07:36:07 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH] checkpatch: fix an issue regarding the git commit
 description style test
To:     linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Message-Id: <780SXQ.MZOU8I5AWGU63@effective-light.com>
In-Reply-To: <20210714082608.28918-1-someguy@effective-light.com>
References: <20210714082608.28918-1-someguy@effective-light.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On Wed, Jul 14 2021 at 04:26:07 AM -0400, Hamza Mahfooz 
<someguy@effective-light.com> wrote:
> If we consider the output of the following command:
> 
> $ git shortlog | grep '"' | wc -l
> 14185
> 
> It becomes apparent that quite a number of commits have titles that,
> contain at least one quotation mark and if you attempt to refer to 
> those
> commits in a new patch, checkpatch throws a false positive. This is
> because, checkpatch disallows the use of quotation marks in commit 
> titles,
> only when referring to those commits in commit descriptions.
> 
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
>  scripts/checkpatch.pl | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 461d4221e4a4..cf31e8c994d3 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3200,20 +3200,20 @@ sub process {
>  			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
>  			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
>  			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
> -			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
> +			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.+)"\)/i) {
>  				$orig_desc = $1;
>  				$hasparens = 1;
>  			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
>  				 defined $rawlines[$linenr] &&
> -				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
> +				 $rawlines[$linenr] =~ /^\s*\("(.+)"\)/) {
>  				$orig_desc = $1;
>  				$hasparens = 1;
> -			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
> +			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\(".+$/i &&
>  				 defined $rawlines[$linenr] &&
> -				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
> -				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
> +				 $rawlines[$linenr] =~ /^\s*.+"\)/) {
> +				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.+)$/i;
>  				$orig_desc = $1;
> -				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
> +				$rawlines[$linenr] =~ /^\s*(.+)"\)/;
>  				$orig_desc .= " " . $1;
>  				$hasparens = 1;
>  			}
> --
> 2.32.0
> 


