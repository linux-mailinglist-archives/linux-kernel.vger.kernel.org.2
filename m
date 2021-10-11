Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76446428864
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhJKINx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:13:53 -0400
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:57216 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231300AbhJKINv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:13:51 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9B09518224D6E;
        Mon, 11 Oct 2021 08:11:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id BB1E8315D73;
        Mon, 11 Oct 2021 08:11:50 +0000 (UTC)
Message-ID: <ad5adffe862f33debdf869465cf90878224ea893.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: get default codespell dictionary path
 from package location
From:   Joe Perches <joe@perches.com>
To:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, apw@canonical.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Oct 2021 01:11:49 -0700
In-Reply-To: <20211011063231.6918-1-peter.ujfalusi@linux.intel.com>
References: <20211011063231.6918-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BB1E8315D73
X-Spam-Status: No, score=1.07
X-Stat-Signature: n84kimb4bz15b5jy74h8onyheou8gaxc
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+c2uvZBT6CEkWr7ldUfzQsdcr/dGbp+bE=
X-HE-Tag: 1633939910-285310
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-11 at 09:32 +0300, Peter Ujfalusi wrote:
> The standard location of dictionary.txt is under codespell's package, on
> my machine atm (codespell 2.1, Artix Linux):
> /usr/lib/python3.9/site-packages/codespell_lib/data/dictionary.txt
> 
> Since we enable the codespell by default for SOF I have constant:

If you enable it by default, you probably are using a .checkpatch.conf file.
--codespell is not a typical default so I think always doing this test
regardless of --codespell being enabled is inappropriate.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -73,6 +73,12 @@ my $git_command ='export LANGUAGE=en_US.UTF-8; git';
>  my $tabsize = 8;
>  my ${CONFIG_} = "CONFIG_";
> 
> +# Override the codespellfile location based on codespell install location
> +if (which("codespell") ne "" && which("python") ne "") {
> +	my $codespell_dict = `python -c "import os.path as op; import codespell_lib; print(op.join(op.dirname(codespell_lib.__file__), 'data', 'dictionary.txt'), end='')" 2> /dev/null`;
> +	$codespellfile = $codespell_dict if (-e $codespell_dict);
> +}
> +

Maybe add a function and/or use something like:

	if (($codespell || $help) &&
	    which(etc...

>  sub help {
>  	my ($exitcode) = @_;
>  
> 
> @@ -130,7 +136,7 @@ Options:
>    --ignore-perl-version      override checking of perl version.  expect
>                               runtime errors.
>    --codespell                Use the codespell dictionary for spelling/typos
> -                             (default:/usr/share/codespell/dictionary.txt)
> +                             (default:$codespellfile)

I think this should not be changed or only be shown as $codespellfile when
--codespell is added on the command line

>    --codespellfile            Use this codespell dictionary
>    --typedefsfile             Read additional types from this file
>    --color[=WHEN]             Use colors 'always', 'never', or only when output


