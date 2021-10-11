Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54CD428BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbhJKLXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:23:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:51373 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231281AbhJKLXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:23:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="226751137"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="226751137"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 04:21:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="490431900"
Received: from acleivam-mobl1.amr.corp.intel.com (HELO [10.249.40.144]) ([10.249.40.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 04:21:07 -0700
Message-ID: <52742f2b-0cde-26f4-1de2-abe83baa0095@linux.intel.com>
Date:   Mon, 11 Oct 2021 14:21:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] checkpatch: get default codespell dictionary path from
 package location
Content-Language: en-US
To:     apw@canonical.com, joe@perches.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
References: <20211011093748.2455-1-peter.ujfalusi@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20211011093748.2455-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2021 12:37, Peter Ujfalusi wrote:
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
> ---
> Hi,
> 
> Changes since v2:
> - Only try to check for dictionary path it is enabled or when the help is
>   displayed
>  - Move the check after the GetOptions()
>  - Set $help to 2 in case invalid option is passed in order to be able to use
>    correct exitcode and still display the correct path for dictionary.txt
> 
> Changes sicne v1:
> - add missing ';' to the line updating the $codespellfile with $codespell_dict
> 
> Regards,
> Peter
> 
>  scripts/checkpatch.pl | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index c27d2312cfc3..179e02acab6e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -130,7 +130,7 @@ Options:
>    --ignore-perl-version      override checking of perl version.  expect
>                               runtime errors.
>    --codespell                Use the codespell dictionary for spelling/typos
> -                             (default:/usr/share/codespell/dictionary.txt)
> +                             (default:$codespellfile)
>    --codespellfile            Use this codespell dictionary
>    --typedefsfile             Read additional types from this file
>    --color[=WHEN]             Use colors 'always', 'never', or only when output
> @@ -325,9 +325,19 @@ GetOptions(
>  	'kconfig-prefix=s'	=> \${CONFIG_},
>  	'h|help'	=> \$help,
>  	'version'	=> \$help
> -) or help(1);
> +) or $help = 2;
>  
> -help(0) if ($help);
> +print($help);
> +
> +# Override the codespellfile location based on codespell install location
> +if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {
> +	my $codespell_dict = `python -c "import os.path as op; import codespell_lib; print(op.join(op.dirname(codespell_lib.__file__), 'data', 'dictionary.txt'), end='')" 2> /dev/null`;
> +	$codespellfile = $codespell_dict if (-e $codespell_dict);

Hrm, I think this will prevent the use of --codespellfile

> +}
> +
> +# $help is 1 if either -h, --help or --version is passed as option - exitcode: 0
> +# $help is 2 if invalid option is passed - exitcode: 1
> +help($help - 1) if ($help);
>  
>  die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
>  die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
> 

-- 
Péter
