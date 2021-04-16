Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF279362767
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbhDPSFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:05:12 -0400
Received: from smtprelay0118.hostedemail.com ([216.40.44.118]:49326 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244245AbhDPSFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:05:10 -0400
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id AA32D100E7B46;
        Fri, 16 Apr 2021 18:04:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 6B20D2550F6;
        Fri, 16 Apr 2021 18:04:43 +0000 (UTC)
Message-ID: <579ee13e8e3805cbc6e6070becbd60bcc1ed3ff6.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Improve ALLOC_ARRAY_ARGS test
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Fri, 16 Apr 2021 11:04:42 -0700
In-Reply-To: <205fc4847972fb6779abcc8818f39c14d1b45af1.1618595794.git.christophe.jaillet@wanadoo.fr>
References: <205fc4847972fb6779abcc8818f39c14d1b45af1.1618595794.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B20D2550F6
X-Spam-Status: No, score=1.60
X-Stat-Signature: roxonjmcn84wxgak965jhyzwqxbqcgqm
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19l1PdXJFOCfAr7IgnvYsFMLmiILi2NcME=
X-HE-Tag: 1618596283-393397
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-16 at 19:57 +0200, Christophe JAILLET wrote:
> The devm_ variant of 'kcalloc()' and 'kmalloc_array()' are not tested
> Add the corresponding check.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: use a cleaner regex as proposed by Joe Perches

Acked-by: Joe Perches <joe@perches.com>

> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 44b9dc330ac6..23697a6b1eaa 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7006,7 +7006,7 @@ sub process {
>  		}
>  
> 
>  # check for alloc argument mismatch
> -		if ($line =~ /\b(kcalloc|kmalloc_array)\s*\(\s*sizeof\b/) {
> +		if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
>  			WARN("ALLOC_ARRAY_ARGS",
>  			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
>  		}


