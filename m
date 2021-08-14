Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7370E3EC311
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbhHNOFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 10:05:14 -0400
Received: from ciao.gmane.io ([116.202.254.214]:57014 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238589AbhHNOFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 10:05:11 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Aug 2021 10:05:11 EDT
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1mEuCB-0005UQ-H9
        for linux-kernel@vger.kernel.org; Sat, 14 Aug 2021 15:59:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
Date:   Sat, 14 Aug 2021 15:59:22 +0200
Message-ID: <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
References: <20210805104353.GD26417@kili>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210805104353.GD26417@kili>
Content-Language: en-US
Cc:     kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Le 05/08/2021 à 12:43, Dan Carpenter a écrit :
> The "= {};" style empty struct initializer is preferred over = {0}.
> It avoids the situation where the first struct member is a pointer and
> that generates a Sparse warning about assigning using zero instead of
> NULL.  Also it's just nicer to look at.
> 
> Some people complain that {} is less portable but the kernel has
> different portability requirements from userspace so this is not a
> issue that we care about.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   scripts/checkpatch.pl | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 461d4221e4a4..32c8a0ca6fd0 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4029,6 +4029,12 @@ sub process {
>   			     "Using $1 is unnecessary\n" . $herecurr);
>   		}
>   
> +# prefer = {}; to = {0};
> +		if ($line =~ /= \{ *0 *\}/) {
> +			WARN("ZERO_INITIALIZER",
> +			     "= {} is preferred over = {0}\n" . $herecurr);
> +		}
> +
>   # Check for potential 'bare' types
>   		my ($stat, $cond, $line_nr_next, $remain_next, $off_next,
>   		    $realline_next);
> 

[1] and [2] state that {} and {0} don't have the same effect. So if 
correct, this is not only a matter of style.

When testing with gcc 10.3.0, I arrived at the conclusion that both {} 
and {0} HAVE the same behavior (i.e the whole structure and included 
structures are completely zeroed) and I don't have a C standard to check 
what the rules are.
gcc online doc didn't help me either.

To test, I wrote a trivial C program, compiled it with gcc -S and looked 
at the assembly files.


Maybe, if it is an undefined behavior, other compilers behave 
differently than gcc.


However, the 2 persons listed bellow have a much better Linux and C 
background than me. So it is likely that my testings were too naive.


Can someone provide some rational or compiler output that confirms that 
{} and {0} are not the same?

Because if confirmed, I guess that there is some clean-up work to do all 
over the code, not only to please Sparse!


Thanks in advance.
CJ



[1]: Russell King - 
https://lore.kernel.org/netdev/YRFGxxkNyJDxoGWu@shredder/T/#efe1b6c7862b7ca9588c2734f04be5ef94e03d446

[2]: Leon Romanovsky - 
https://lore.kernel.org/netdev/YRFGxxkNyJDxoGWu@shredder/T/#efe1b6c7862b7ca9588c2734f04be5ef94e03d446

