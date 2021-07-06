Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42E83BDE0F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 21:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhGFTeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 15:34:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35998 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhGFTeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 15:34:21 -0400
Received: from usagi.middle.earth (ethbase.usagi.not.afront.org [IPv6:2620:137:e001:0:1897:4108:901b:c660])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 00C874D31EF5A;
        Tue,  6 Jul 2021 12:31:39 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: Add check for common mailing list helper
 checks
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <20210702223743.1240694-1-warthog9@eaglescrag.net>
 <b1592f359a7e68704c0faac77015b9b2aa8e4073.camel@perches.com>
From:   John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Openpgp: preference=signencrypt
Message-ID: <506ec749-63dc-3a08-48e7-5179c3df9a42@eaglescrag.net>
Date:   Tue, 6 Jul 2021 12:31:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b1592f359a7e68704c0faac77015b9b2aa8e4073.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Tue, 06 Jul 2021 12:31:40 -0700 (PDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/21 11:39 AM, Joe Perches wrote:
> On Fri, 2021-07-02 at 15:37 -0700, John 'Warthog9' Hawley (VMware)
> wrote:
>> From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
>>
>> Mailing lists in an attempt to try and avoid sending certain
>> administrative e-mails to the list, will check the first few lines
>> (usually ~10) looking for keywords.  If those key words are found it
>> shunts the e-mail to the list admin contact instead of potentially
>> passing it through to the list.
> 
> Perhaps the below is a bit better, but I believe a few of the tests
> are going to be tripped a bit too often.
> 
> Especially "cancel", "config" and maybe "subscribe" too.
> 
> For instance:
> 
> $ git log --grep='\bcancel\b' -P -i --pretty=oneline -10000 | wc -l
> 1693
> 
> $ git log --grep='^config\b' -P -i --pretty=oneline -10000 | wc -l
> 890
> 
> $ git log --grep='\bsubscribe\b' -P -i --pretty=oneline -10000 | wc -l
> 123

A part of getting this into checkpatch.pl is getting some better
feedback mechanisms for why patches may not be passing through the list
correctly with regexes that have been in place for at least 14 years.
These, aren't tripped over often, but have run into a instance at least
recently that triggered me trying to get at least some self check, and
notification, pieces in place.

> 
> ---
>  scripts/checkpatch.pl | 45 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 461d4221e4a4a..fcbcc26da875e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -865,6 +865,37 @@ our $allowed_asm_includes = qr{(?x:
>  )};
>  # memory.h: ARM has a custom one
>  
> +our $mailing_list_phrases = qr{(?xi:
> +	\bcancel\b |
> +	\badd\s+me\b |
> +	\bdelete\s+me\b |
> +	\bremove\s+me\b |
> +	\bchange\b.*\baddress\b |
> +	\bsubscribe\b |
> +	^sub\b |
> +	\bunsubscribe\b |
> +	^unsub\b |
> +	^\s*help\s*$ |
> +	^\s*info\s*$ |
> +	^\s*info\s+\S+\s*$ |
> +	^\s*lists\s*$ |
> +	^\s*which\s*$ |
> +	^\s*which\s+\S+\s*$ |
> +	^\s*index\s*$ |
> +	^\s*index\s+\S+\s*$ |
> +	^\s*who\s*$ |
> +	^\s*who\s+\S+\s*$ |
> +	^\s*get\s+\S+\s*$ |
> +	^\s*get\s+\S+\s+\S+\s*$ |
> +	^\s*approve\b |
> +	^\s*passwd\b |
> +	^\s*newinfo\b |
> +	^\s*config\b |
> +	^\s*newconfig\b |
> +	^\s*writeconfig\b |
> +	^\s*mkdigest\b
> +)};
> +
>  # Load common spelling mistakes and build regular expression list.
>  my $misspellings;
>  my %spelling_fix;
> @@ -2581,6 +2612,7 @@ sub process {
>  	my $has_patch_separator = 0;	#Found a --- line
>  	my $has_commit_log = 0;		#Encountered lines before patch
>  	my $commit_log_lines = 0;	#Number of commit log lines
> +	my $commit_log_missing = 0;	#Emitted a missing commit message warning
>  	my $commit_log_possible_stack_dump = 0;
>  	my $commit_log_long_line = 0;
>  	my $commit_log_has_diff = 0;
> @@ -2852,16 +2884,23 @@ sub process {
>  
>  		$cnt_lines++ if ($realcnt != 0);
>  
> +# check if words in the commit message may trip up common mailing list helpers
> +# to redirect email to the admin contact
> +		if ($in_commit_log && $commit_log_lines < 10 &&
> +		    $line =~ /($mailing_list_phrases)/) {
> +			WARN("MAILING_LIST_HELPER",
> +			     "Line matches common mailing list helpers and may not be delivered correctly - consider rewording '$1'\n" . $herecurr);
> +		}
> +
>  # Verify the existence of a commit log if appropriate
> -# 2 is used because a $signature is counted in $commit_log_lines
>  		if ($in_commit_log) {
>  			if ($line !~ /^\s*$/) {
>  				$commit_log_lines++;	#could be a $signature
>  			}
> -		} elsif ($has_commit_log && $commit_log_lines < 2) {
> +		} elsif ($has_commit_log && !$commit_log_missing) {
>  			WARN("COMMIT_MESSAGE",
>  			     "Missing commit description - Add an appropriate one\n");
> -			$commit_log_lines = 2;	#warn only once
> +			$commit_log_missing = 1;	#warn only once
>  		}
>  
>  # Check if the commit log has what seems like a diff which can confuse patch
> 

