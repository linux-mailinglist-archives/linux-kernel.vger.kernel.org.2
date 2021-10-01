Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54B641F641
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 22:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354891AbhJAUYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 16:24:10 -0400
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:52488 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229888AbhJAUYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:24:09 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D3D661802B415;
        Fri,  1 Oct 2021 20:22:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id EC6441D42F6;
        Fri,  1 Oct 2021 20:22:22 +0000 (UTC)
Message-ID: <91569a87ac55da392fa894e8ad55292b98c558f3.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add check for continue statement in
 UNNECESSARY_ELSE
From:   Joe Perches <joe@perches.com>
To:     Utkarsh Verma <utkarshverma294@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 Oct 2021 13:22:13 -0700
In-Reply-To: <20211001192628.19179-1-utkarshverma294@gmail.com>
References: <20211001190927.GA18097@uver-machine>
         <20211001192628.19179-1-utkarshverma294@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: EC6441D42F6
X-Spam-Status: No, score=1.67
X-Stat-Signature: m6bekyi3afgc46tzyz46y4jygydzi1ba
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18wKpUgeD3fuGtE65P1O3GH+WpzJXivWjU=
X-HE-Tag: 1633119742-206079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-10-02 at 00:56 +0530, Utkarsh Verma wrote:
> UNNECESSARY_ELSE only checks for the usage of else after a return or
> break. But the same logic is also true for continue statement.
> 
> else used after a continue statement is unnecessary. So add a test
> for continue statement also.
> 
> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> ---
>  scripts/checkpatch.pl | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index c27d2312cfc3..f5a911aa6b64 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4011,15 +4011,16 @@ sub process {
>  
> 
>  # check indentation of any line with a bare else
>  # (but not if it is a multiple line "if (foo) return bar; else return baz;")
> -# if the previous line is a break or return and is indented 1 tab more...
> +# if the previous line is a break or continue or return and is indented 1 tab more...
>  		if ($sline =~ /^\+([\t]+)(?:}[ \t]*)?else(?:[ \t]*{)?\s*$/) {
>  			my $tabs = length($1) + 1;
>  			if ($prevline =~ /^\+\t{$tabs,$tabs}break\b/ ||
> +			    $prevline =~ /^\+\t{$tabs,$tabs}continue\b/ ||

I suppose this is ok.  I'd generally write this on one line.

			if ($prevline =~ /^\+\t{$tabs,$tabs}(?:break|continue)\b/ ||


