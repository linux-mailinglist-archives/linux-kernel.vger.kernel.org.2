Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA34311B0F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhBFEpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:45:31 -0500
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:41896 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231617AbhBFD0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:26:10 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B6ECE181D3052;
        Sat,  6 Feb 2021 03:25:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6119:7652:7875:7903:9025:10004:10400:10848:11232:11658:11783:11914:12043:12297:12555:12740:12895:12986:13069:13311:13357:13439:13894:14181:14659:14721:21080:21451:21611:21627:21740:21972:21990:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mark49_3415804275ea
X-Filterd-Recvd-Size: 2178
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat,  6 Feb 2021 03:25:08 +0000 (UTC)
Message-ID: <90cf805f4be6ecf5887fe470af6db2d596dc46a3.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Don't warn about colon termination in
 linker scripts
From:   Joe Perches <joe@perches.com>
To:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Date:   Fri, 05 Feb 2021 19:25:06 -0800
In-Reply-To: <YBwhqsc2TIVeid3t@chrisdown.name>
References: <YBwhqsc2TIVeid3t@chrisdown.name>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-02-04 at 16:32 +0000, Chris Down wrote:
> This check erroneously flags cases like the one in my recent printk
> enumeration patch[0], where the spaces are syntactic, and `section:' vs.
> `section :' is syntactically important:
> 
>     ERROR: space prohibited before that ':' (ctx:WxW)
>     #258: FILE: include/asm-generic/vmlinux.lds.h:314:
>     +       .printk_fmts : AT(ADDR(.printk_fmts) - LOAD_OFFSET) {
> 
> 0: https://lore.kernel.org/patchwork/patch/1375749/

Remember to cc the checkpatch maintainers.

> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4f8494527139..3bcffc5574ae 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5046,7 +5046,7 @@ sub process {
>  				# A colon needs no spaces before when it is
>  				# terminating a case value or a label.
>  				} elsif ($opv eq ':C' || $opv eq ':L') {
> -					if ($ctx =~ /Wx./) {
> +					if ($ctx =~ /Wx./ and $realfile !~ m@.*\.lds\.h$@) {
>  						if (ERROR("SPACING",
>  							  "space prohibited before that '$op' $at\n" . $hereptr)) {
>  							$good = rtrim($fix_elements[$n]) . trim($fix_elements[$n + 1]);


