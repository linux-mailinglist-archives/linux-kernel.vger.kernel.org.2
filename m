Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8E542D405
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJNHuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:50:39 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:40250 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229551AbhJNHuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:50:37 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 18E6926829;
        Thu, 14 Oct 2021 07:48:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 09F2EC4182;
        Thu, 14 Oct 2021 07:48:29 +0000 (UTC)
Message-ID: <5455eaf51072c821123ecd458ab810e50b6e8d94.camel@perches.com>
Subject: Re: [PATCH v7] checkpatch: get default codespell dictionary path
 from package location
From:   Joe Perches <joe@perches.com>
To:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, apw@canonical.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Oct 2021 00:48:28 -0700
In-Reply-To: <20211014064406.28052-1-peter.ujfalusi@linux.intel.com>
References: <20211014064406.28052-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 09F2EC4182
X-Spam-Status: No, score=1.60
X-Stat-Signature: hsgdm5o6qxtsph3mcck5ukg55ifua9ns
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19rjnAZ1+0ADbg0rpEVkC87QASbQAHAlSI=
X-HE-Tag: 1634197709-402016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-10-14 at 09:44 +0300, Peter Ujfalusi wrote:
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
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Acked-by: Joe Perches <joe@perches.com>

Thanks, Joe

> ---
> Hi,
> 
> Changes since v6:
> - do not try to look for codespell install dir if the default
>   /usr/share/codespell/dictionary.txt exists
> 
> Changes since v5:
> - move the $python_codespell_dict to local
> - drop extra semicolon
> - execute python, not python3
> 
> Changes since v4:
> - Use the readable version suggested by Joe Perches (store the pyhton snippet in
>   python_codespell_dict)
> 
> Changes since v3:
> - Do not try to override the use provided codespell file location
> 
> Changes since v2:
> - Only try to check for dictionary path it is enabled or when the help is
>   displayed
>  - Move the check after the GetOptions()
>  - Set $help to 2 in case invalid option is passed in order to be able to use
>    correct exitcode and still display the correct path for dictionary.txt
> 
> Changes sicne v1:
> - add missing ';' to the line updating the $codespellfile with $codespell_dict
> 
> Regards,
> Peter
> 
>  scripts/checkpatch.pl | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 91798b07c6cb..1784921c645d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -63,6 +63,7 @@ my $min_conf_desc_length = 4;
>  my $spelling_file = "$D/spelling.txt";
>  my $codespell = 0;
>  my $codespellfile = "/usr/share/codespell/dictionary.txt";
> +my $user_codespellfile = "";
>  my $conststructsfile = "$D/const_structs.checkpatch";
>  my $docsfile = "$D/../Documentation/dev-tools/checkpatch.rst";
>  my $typedefsfile;
> @@ -130,7 +131,7 @@ Options:
>    --ignore-perl-version      override checking of perl version.  expect
>                               runtime errors.
>    --codespell                Use the codespell dictionary for spelling/typos
> -                             (default:/usr/share/codespell/dictionary.txt)
> +                             (default:$codespellfile)
>    --codespellfile            Use this codespell dictionary
>    --typedefsfile             Read additional types from this file
>    --color[=WHEN]             Use colors 'always', 'never', or only when output
> @@ -317,7 +318,7 @@ GetOptions(
>  	'debug=s'	=> \%debug,
>  	'test-only=s'	=> \$tst_only,
>  	'codespell!'	=> \$codespell,
> -	'codespellfile=s'	=> \$codespellfile,
> +	'codespellfile=s'	=> \$user_codespellfile,
>  	'typedefsfile=s'	=> \$typedefsfile,
>  	'color=s'	=> \$color,
>  	'no-color'	=> \$color,	#keep old behaviors of -nocolor
> @@ -325,9 +326,32 @@ GetOptions(
>  	'kconfig-prefix=s'	=> \${CONFIG_},
>  	'h|help'	=> \$help,
>  	'version'	=> \$help
> -) or help(1);
> +) or $help = 2;
> +
> +if ($user_codespellfile) {
> +	# Use the user provided codespell file unconditionally
> +	$codespellfile = $user_codespellfile;
> +} elsif (!(-f $codespellfile)) {
> +	# If /usr/share/codespell/dictionary.txt is not present, try to find it
> +	# under codespell's install directory: <codespell_root>/data/dictionary.txt
> +	if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {
> +		my $python_codespell_dict = << "EOF";
> +
> +import os.path as op
> +import codespell_lib
> +codespell_dir = op.dirname(codespell_lib.__file__)
> +codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
> +print(codespell_file, end='')
> +EOF
> +
> +		my $codespell_dict = `python -c "$python_codespell_dict" 2> /dev/null`;
> +		$codespellfile = $codespell_dict if (-f $codespell_dict);
> +	}
> +}
>  
> 
> -help(0) if ($help);
> +# $help is 1 if either -h, --help or --version is passed as option - exitcode: 0
> +# $help is 2 if invalid option is passed - exitcode: 1
> +help($help - 1) if ($help);
>  
> 
>  die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
>  die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);


