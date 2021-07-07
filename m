Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4243BE0C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 04:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhGGCG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 22:06:28 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:56482 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229949AbhGGCG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 22:06:28 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D7924837F24F;
        Wed,  7 Jul 2021 02:03:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id A57C5D1519;
        Wed,  7 Jul 2021 02:03:46 +0000 (UTC)
Message-ID: <b1b103f7ede65a2a31054bba817fec858d749129.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Don't show signatures in git-log
From:   Joe Perches <joe@perches.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Date:   Tue, 06 Jul 2021 19:03:45 -0700
In-Reply-To: <20210706223029.2377293-1-palmer@dabbelt.com>
References: <20210706223029.2377293-1-palmer@dabbelt.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.40
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A57C5D1519
X-Stat-Signature: r5wzhgqp5fjt4pef8sxim16xw8f8sasj
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/E9W/apzvJshL5TtOqRHykwe+qdVhVILA=
X-HE-Tag: 1625623426-211901
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-07-06 at 15:30 -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> I have git-log setup to show signatures.  I've recently noticed this
> breaking checkpatch error messages, which show something like
> 
>     ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit gpg: Signatu (":05 PM PDT")'
>     #8:
>     the module region by 3a02764c372c ("riscv: Ensure BPF_JIT_REGION_START
> 
> instead of something more helpful, like
> 
>     ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 3a02764c372c ("riscv: Ensure BPF_JIT_REGION_START aligned with PMD size")'
>     #8:
>     the module region by 3a02764c372c ("riscv: Ensure BPF_JIT_REGION_START
> 
> which shows up with this patch.  I'm not sure if these just started
> showing up for if I just noticed them or if they've been around forever.
> 
> I've only found it necessary to add --no-show-signature to the git-log
> invocation in git_commit_info(), but a cursory glance indicates that the
> other two invocations may suffer from similar problems so I've just
> added it everywhere.

Perhaps this should be in some standardized $git_log_options argument
so that if there are more of these no-<foo> that need to be added, like
for instance, --no-notes, it'd be easier to add everywhere.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -1103,7 +1103,7 @@ sub seed_camelcase_includes {
>  	$camelcase_seeded = 1;

somwhere above:

our $git_log_no_opts = '--no-show-signature --no-color"

> 
>  	if (-e "$gitroot") {
> -		my $git_last_include_commit = `${git_command} log --no-merges --pretty=format:"%h%n" -1 -- include`;
> +		my $git_last_include_commit = `${git_command} log --no-show-signature --no-merges --pretty=format:"%h%n" -1 -- include`;

So this could be:

		my $git_last_include_commit = `${git_command} log $git_log_no_opts --no-merges --pretty=format:"%h%n" -1 -- include`;

>  		chomp $git_last_include_commit;
>  		$camelcase_cache = ".checkpatch-camelcase.git.$git_last_include_commit";
>  	} else {
> @@ -1165,7 +1165,7 @@ sub git_commit_info {
>  
>  	return ($id, $desc) if ((which("git") eq "") || !(-e "$gitroot"));
>  
> 
> -	my $output = `${git_command} log --no-color --format='%H %s' -1 $commit 2>&1`;
> +	my $output = `${git_command} log --no-color --no-show-signature --format='%H %s' -1 $commit 2>&1`;

	my $output = `${git_command} log $git_log_no_opts --format='%H %s' -1 $commit 2>&1`;

etc...

>  	$output =~ s/^\s*//gm;
>  	my @lines = split("\n", $output);
> 
> @@ -1215,7 +1215,7 @@ if ($git) {
>  		} else {
>  			$git_range = "-1 $commit_expr";
>  		}
> -		my $lines = `${git_command} log --no-color --no-merges --pretty=format:'%H %s' $git_range`;
> +		my $lines = `${git_command} log --no-show-signature --no-color --no-merges --pretty=format:'%H %s' $git_range`;

		my $lines = `${git_command} log $git_log_no_opts --no-merges --pretty=format:'%H %s' $git_range`;

>  		foreach my $line (split(/\n/, $lines)) {
>  			$line =~ /^([0-9a-fA-F]{40,40}) (.*)$/;
>  			next if (!defined($1) || !defined($2));


