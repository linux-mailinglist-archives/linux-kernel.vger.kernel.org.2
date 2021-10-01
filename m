Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB44641F6AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 23:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355178AbhJAVLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 17:11:15 -0400
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:51846 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1355080AbhJAVLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 17:11:06 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8C0A3180995DD;
        Fri,  1 Oct 2021 21:09:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id A4BE51124F4;
        Fri,  1 Oct 2021 21:09:19 +0000 (UTC)
Message-ID: <d15bba541aac03ebe24c733f24b6bda96d03a3ec.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add check for continue statement in
 UNNECESSARY_ELSE
From:   Joe Perches <joe@perches.com>
To:     Utkarsh Verma <utkarshverma294@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 Oct 2021 14:09:18 -0700
In-Reply-To: <20211001204705.7448-1-utkarshverma294@gmail.com>
References: <91569a87ac55da392fa894e8ad55292b98c558f3.camel@perches.com>
         <20211001204705.7448-1-utkarshverma294@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A4BE51124F4
X-Spam-Status: No, score=6.17
X-Stat-Signature: 1yxmnryimh8gfyunrfxp7ojkkq9ptajq
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX189yS0gSYU1iALO3xmt6CU+yHZePHjVIDk=
X-HE-Tag: 1633122559-58868
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-10-02 at 02:17 +0530, Utkarsh Verma wrote:
> UNNECESSARY_ELSE only checks for the usage of else after a return or
> break. But the same logic is also true for continue statement.
> 
> else used after a continue statement is unnecessary. So add a test
> for continue statement also.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4011,15 +4011,15 @@ sub process {
>  
> 
>  # check indentation of any line with a bare else
>  # (but not if it is a multiple line "if (foo) return bar; else return baz;")
> -# if the previous line is a break or return and is indented 1 tab more...
> +# if the previous line is a break or continue or return and is indented 1 tab more...
>  		if ($sline =~ /^\+([\t]+)(?:}[ \t]*)?else(?:[ \t]*{)?\s*$/) {
>  			my $tabs = length($1) + 1;
> -			if ($prevline =~ /^\+\t{$tabs,$tabs}break\b/ ||
> +			if ($prevline =~ /^\+\t{$tabs,$tabs}(?:break|continue)\b/ ||
>  			    ($prevline =~ /^\+\t{$tabs,$tabs}return\b/ &&
>  			     defined $lines[$linenr] &&
>  			     $lines[$linenr] !~ /^[ \+]\t{$tabs,$tabs}return/)) {
>  				WARN("UNNECESSARY_ELSE",
> -				     "else is not generally useful after a break or return\n" . $hereprev);
> +				     "else is not generally useful after a break or continue or return\n" . $hereprev);
>  			}
>  		}
>  
> 

Maybe make the output specific to the break/continue/return
(untested)

			if ($prevline =~ /^\+\t{$tabs,$tabs}(break|continue|return)\b/ &&
			    !($1 == "return" &&
			      defined $lines[$linenr] &&
			      $lines[$linenr] !~ /^[ \+]\t{$tabs,$tabs}return/)) {
				WARN("UNNECESSARY_ELSE",
				     "else is not generally useful after a $1\n" . $hereprev);


