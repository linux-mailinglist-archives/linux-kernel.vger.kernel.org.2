Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF13042A690
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhJLN7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:59:49 -0400
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:36592 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237132AbhJLN7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:59:35 -0400
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6DC6D182CED5B;
        Tue, 12 Oct 2021 13:57:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 7B27813D9B;
        Tue, 12 Oct 2021 13:57:30 +0000 (UTC)
Message-ID: <307188c4a27dc488437e74d5f8980dfcad65ecbd.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: get default codespell dictionary path
 from package location
From:   Joe Perches <joe@perches.com>
To:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, apw@canonical.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Oct 2021 06:57:28 -0700
In-Reply-To: <20211012112918.19166-1-peter.ujfalusi@linux.intel.com>
References: <20211012112918.19166-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.89
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 7B27813D9B
X-Stat-Signature: zxmwxpf1i3oeuaug5iuqgk87m9oru66a
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+yidMOXpPusMV77e6+YUwDL63pQxdUkW4=
X-HE-Tag: 1634047050-932530
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-12 at 14:29 +0300, Peter Ujfalusi wrote:
> The standard location of dictionary.txt is under codespell's package, on
> my machine atm (codespell 2.1, Artix Linux):
> /usr/lib/python3.9/site-packages/codespell_lib/data/dictionary.txt
> 
> Since we enable the codespell by default for SOF I have constant:
> No codespell typos will be found - \
> file '/usr/share/codespell/dictionary.txt': No such file or directory
> 
> The patch proposes to try to fix up the path following the recommendation
> found here:
> https://github.com/codespell-project/codespell/issues/1540

trivia:

> @@ -325,9 +326,31 @@ GetOptions(
>  	'kconfig-prefix=s'	=> \${CONFIG_},
>  	'h|help'	=> \$help,
>  	'version'	=> \$help
> -) or help(1);
> +) or $help = 2;
> +
> +my $python_codespell_dict = << "EOF";

Because you add a semicolon after "EOF"

> +import os.path as op
> +import codespell_lib
> +codespell_dir = op.dirname(codespell_lib.__file__)
> +codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
> +print(codespell_file, end='')
> +EOF
> +;

this is an extra semicolon

> +if ($user_codespellfile) {
> +	# Use the user provided codespell file unconditionally
> +	$codespellfile = $user_codespellfile;
> +} else {
> +	# Try to find the codespell install location to use it as default path
> +	if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {

and I would keep the my $python_codespell_dict definition local to this block.

> +		my $codespell_dict = `python3 -c "$python_codespell_dict" 2> /dev/null`;
> +		$codespellfile = $codespell_dict if (-e $codespell_dict);
> +	}
> +}

It's wrong to check which("python") and then exec `python3 ...`


