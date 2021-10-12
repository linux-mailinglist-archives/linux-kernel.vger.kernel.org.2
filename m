Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8581142AB58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 19:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhJLR7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 13:59:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:14899 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhJLR73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 13:59:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="208029258"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="208029258"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 10:57:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="626042986"
Received: from fiegl-mobl.ger.corp.intel.com (HELO [10.249.40.252]) ([10.249.40.252])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 10:57:26 -0700
Message-ID: <77d10fa8-c07a-b679-d712-6fd05229e4d2@linux.intel.com>
Date:   Tue, 12 Oct 2021 20:57:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5] checkpatch: get default codespell dictionary path from
 package location
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, apw@canonical.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
References: <20211012112918.19166-1-peter.ujfalusi@linux.intel.com>
 <307188c4a27dc488437e74d5f8980dfcad65ecbd.camel@perches.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <307188c4a27dc488437e74d5f8980dfcad65ecbd.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/2021 16:57, Joe Perches wrote:
> On Tue, 2021-10-12 at 14:29 +0300, Peter Ujfalusi wrote:
>> The standard location of dictionary.txt is under codespell's package, on
>> my machine atm (codespell 2.1, Artix Linux):
>> /usr/lib/python3.9/site-packages/codespell_lib/data/dictionary.txt
>>
>> Since we enable the codespell by default for SOF I have constant:
>> No codespell typos will be found - \
>> file '/usr/share/codespell/dictionary.txt': No such file or directory
>>
>> The patch proposes to try to fix up the path following the recommendation
>> found here:
>> https://github.com/codespell-project/codespell/issues/1540
> 
> trivia:
> 
>> @@ -325,9 +326,31 @@ GetOptions(
>>  	'kconfig-prefix=s'	=> \${CONFIG_},
>>  	'h|help'	=> \$help,
>>  	'version'	=> \$help
>> -) or help(1);
>> +) or $help = 2;
>> +
>> +my $python_codespell_dict = << "EOF";
> 
> Because you add a semicolon after "EOF"
> 
>> +import os.path as op
>> +import codespell_lib
>> +codespell_dir = op.dirname(codespell_lib.__file__)
>> +codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
>> +print(codespell_file, end='')
>> +EOF
>> +;
> 
> this is an extra semicolon

Ah, I see. It shows that perl is not my fo to scripting language.

> 
>> +if ($user_codespellfile) {
>> +	# Use the user provided codespell file unconditionally
>> +	$codespellfile = $user_codespellfile;
>> +} else {
>> +	# Try to find the codespell install location to use it as default path
>> +	if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {
> 
> and I would keep the my $python_codespell_dict definition local to this block.

OK, I did it like this because to my eyes this looks strange:

if ($user_codespellfile) {
	# Use the user provided codespell file unconditionally
	$codespellfile = $user_codespellfile;
} else {
	# Try to find the codespell install location to use it as default path
	if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {
		my $python_codespell_dict = << "EOF";

import os.path as op
import codespell_lib
codespell_dir = op.dirname(codespell_lib.__file__)
codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
print(codespell_file, end='')
EOF

		my $codespell_dict = `python -c "$python_codespell_dict" 2> /dev/null`;
		$codespellfile = $codespell_dict if (-e $codespell_dict);
	}
}
 
>> +		my $codespell_dict = `python3 -c "$python_codespell_dict" 2> /dev/null`;
>> +		$codespellfile = $codespell_dict if (-e $codespell_dict);
>> +	}
>> +}
> 
> It's wrong to check which("python") and then exec `python3 ...`

Oops, you are right.

> 
> 

-- 
Péter
