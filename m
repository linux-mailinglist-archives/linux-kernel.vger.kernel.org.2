Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9948F3D1338
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhGUPXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:23:12 -0400
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:38094 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229903AbhGUPXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:23:09 -0400
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id ABD47180E69DD;
        Wed, 21 Jul 2021 16:03:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id BBB2A268E4D;
        Wed, 21 Jul 2021 16:03:42 +0000 (UTC)
Message-ID: <68b4f05607e9e44559e174d9b50e435fb58ef5aa.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add grammatical judgement for total output
From:   Joe Perches <joe@perches.com>
To:     Hu Haowen <src.res@email.cn>, apw@canonical.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jul 2021 09:03:41 -0700
In-Reply-To: <20210721151416.30530-1-src.res@email.cn>
References: <20210721151416.30530-1-src.res@email.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=6.54
X-Stat-Signature: tr77osmd61sfixb94f7fzpk89zxrefbd
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BBB2A268E4D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18/e3lHfr+GArUviSru02UDWiyvt1aSggs=
X-HE-Tag: 1626883422-829672
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-07-21 at 23:14 +0800, Hu Haowen wrote:
> There lacked a English grammatical identification within the final
> output of checkpatch.pl such as the following:
> 
>     total: 1 errors, 11 warnings, 4094 lines checked
>                   ^
> 
> Which violated the rule about the usage of the singular form and the
> plural form. Hence fix the issue up and make it output the proper
> sentence.

NAK

I appreciate the desire for precision but I don't want to require
any automated downstream user of checkpatch to be changed.

I think users understand the output even though it may not be
grammatically correct in some cases.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7439,9 +7439,14 @@ sub process {
>  	print report_dump();
>  	if ($summary && !($clean == 1 && $quiet == 1)) {
>  		print "$filename " if ($summary_file);
> -		print "total: $cnt_error errors, $cnt_warn warnings, " .
> -			(($check)? "$cnt_chk checks, " : "") .
> -			"$cnt_lines lines checked\n";
> +		my $errors_str = ($cnt_error == 1) ? "error" : "errors";
> +		my $warnings_str = ($cnt_warn == 1) ? "warning" : "warnings";
> +		my $checks_str = ($cnt_chk == 1) ? "check" : "checks";
> +		my $lines_str = ($cnt_lines == 1) ? "line" : "lines";
> +		print "total: $cnt_error $errors_str, " .
> +			"$cnt_warn $warnings_str, " .
> +			(($check)? "$cnt_chk $checks_str, " : "") .
> +			"$cnt_lines $lines_str checked\n";
>  	}
>  
> 
>  	if ($quiet == 0) {


