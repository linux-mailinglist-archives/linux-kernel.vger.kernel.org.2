Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8784289B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbhJKJfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:35:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:32965 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235476AbhJKJfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:35:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="287715204"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="287715204"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 02:33:08 -0700
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="490398814"
Received: from acleivam-mobl1.amr.corp.intel.com (HELO [10.249.40.144]) ([10.249.40.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 02:33:05 -0700
Message-ID: <31b021d0-63e4-32f8-9df9-dcf4f0c4cb6f@linux.intel.com>
Date:   Mon, 11 Oct 2021 12:33:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] checkpatch: get default codespell dictionary path from
 package location
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, apw@canonical.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
References: <20211011063231.6918-1-peter.ujfalusi@linux.intel.com>
 <ad5adffe862f33debdf869465cf90878224ea893.camel@perches.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <ad5adffe862f33debdf869465cf90878224ea893.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 11/10/2021 11:11, Joe Perches wrote:
> On Mon, 2021-10-11 at 09:32 +0300, Peter Ujfalusi wrote:
>> The standard location of dictionary.txt is under codespell's package, on
>> my machine atm (codespell 2.1, Artix Linux):
>> /usr/lib/python3.9/site-packages/codespell_lib/data/dictionary.txt
>>
>> Since we enable the codespell by default for SOF I have constant:
> 
> If you enable it by default, you probably are using a .checkpatch.conf file.

It is enabled via a commit hook and started to fail after codespell
update to 2.1 (when the /usr/share/codespell/dictionary.txt no longer exist)

This is downstream port of checkpatch.pl in sof:
https://thesofproject.github.io

If I would have enabled it locally I would have also specified the
codespellfile in .checkpatch.conf.

> --codespell is not a typical default so I think always doing this test
> regardless of --codespell being enabled is inappropriate.

I tend to agree.

>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -73,6 +73,12 @@ my $git_command ='export LANGUAGE=en_US.UTF-8; git';
>>  my $tabsize = 8;
>>  my ${CONFIG_} = "CONFIG_";
>>
>> +# Override the codespellfile location based on codespell install location
>> +if (which("codespell") ne "" && which("python") ne "") {
>> +	my $codespell_dict = `python -c "import os.path as op; import codespell_lib; print(op.join(op.dirname(codespell_lib.__file__), 'data', 'dictionary.txt'), end='')" 2> /dev/null`;
>> +	$codespellfile = $codespell_dict if (-e $codespell_dict);
>> +}
>> +
> 
> Maybe add a function and/or use something like:
> 
> 	if (($codespell || $help) &&
> 	    which(etc...

Right, so I will move the check after the GetOptions() to have the
$codespell and $help options evaluated.

>>  sub help {
>>  	my ($exitcode) = @_;
>>  
>>
>> @@ -130,7 +136,7 @@ Options:
>>    --ignore-perl-version      override checking of perl version.  expect
>>                               runtime errors.
>>    --codespell                Use the codespell dictionary for spelling/typos
>> -                             (default:/usr/share/codespell/dictionary.txt)
>> +                             (default:$codespellfile)
> 
> I think this should not be changed or only be shown as $codespellfile when
> --codespell is added on the command line

If I run the 'scripts/checkpatch.pl -h' I would like to see the options
and defaults that will be used and I don't expect that the default of
the dictionary.tx would be different between

scripts/checkpatch.pl -h
 default:/usr/share/codespell/dictionary.txt)

scripts/checkpatch.pl --codespell -h
 (default:/usr/lib/python3.9/site-packages/codespell_lib/data/dictionary.txt)

I think this is not too intuitive.

Now I have a working and consistent version, let's see how that looks like.

> 
>>    --codespellfile            Use this codespell dictionary
>>    --typedefsfile             Read additional types from this file
>>    --color[=WHEN]             Use colors 'always', 'never', or only when output
> 
> 

-- 
Péter
