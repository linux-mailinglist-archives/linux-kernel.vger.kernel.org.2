Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D673E4286D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhJKGbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 02:31:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:47880 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234080AbhJKGbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 02:31:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="213753493"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="213753493"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 23:29:12 -0700
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="490343504"
Received: from acleivam-mobl1.amr.corp.intel.com (HELO [10.249.40.144]) ([10.249.40.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 23:29:10 -0700
Message-ID: <8f0c41be-fffc-0f02-ab91-450dc198e860@linux.intel.com>
Date:   Mon, 11 Oct 2021 09:29:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] checkpatch: get default codespell dictionary path from
 package location
Content-Language: en-US
To:     apw@canonical.com, joe@perches.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
References: <20211011061839.4199-1-peter.ujfalusi@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20211011061839.4199-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2021 09:18, Peter Ujfalusi wrote:
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
>  scripts/checkpatch.pl | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index c27d2312cfc3..e8e416056066 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -73,6 +73,12 @@ my $git_command ='export LANGUAGE=en_US.UTF-8; git';
>  my $tabsize = 8;
>  my ${CONFIG_} = "CONFIG_";
>  
> +# Override the codespellfile location based on codespell install location
> +if (which("codespell") ne "" && which("python") ne "") {
> +	my $codespell_dict = `python -c "import os.path as op; import codespell_lib; print(op.join(op.dirname(codespell_lib.__file__), 'data', 'dictionary.txt'), end='')" 2> /dev/null`;
> +	$codespellfile = $codespell_dict if (-e $codespell_dict)

I have missed ';' at the end of the line (the checkpatch.pl worked as
expected, that's why I have not noticed it) sending v2 right away, sorry.

> +}
> +
>  sub help {
>  	my ($exitcode) = @_;
>  
> @@ -130,7 +136,7 @@ Options:
>    --ignore-perl-version      override checking of perl version.  expect
>                               runtime errors.
>    --codespell                Use the codespell dictionary for spelling/typos
> -                             (default:/usr/share/codespell/dictionary.txt)
> +                             (default:$codespellfile)
>    --codespellfile            Use this codespell dictionary
>    --typedefsfile             Read additional types from this file
>    --color[=WHEN]             Use colors 'always', 'never', or only when output
> 

-- 
Péter
