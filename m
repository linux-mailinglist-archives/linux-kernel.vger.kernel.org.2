Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51142A346
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbhJLLay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:30:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:27834 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232808AbhJLLat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:30:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="227399716"
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="227399716"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 04:28:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="625914528"
Received: from anicol1x-mobl.ger.corp.intel.com (HELO [10.249.40.213]) ([10.249.40.213])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 04:28:46 -0700
Message-ID: <696c2de0-c0f5-285f-b46b-beb8f87d64e8@linux.intel.com>
Date:   Tue, 12 Oct 2021 14:28:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] checkpatch: get default codespell dictionary path from
 package location
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, apw@canonical.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
References: <20211011114952.26145-1-peter.ujfalusi@linux.intel.com>
 <510f7db524904e2f87fe4d52018f712e2df3b7bc.camel@perches.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <510f7db524904e2f87fe4d52018f712e2df3b7bc.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2021 19:50, Joe Perches wrote:
> On Mon, 2021-10-11 at 14:49 +0300, Peter Ujfalusi wrote:
>> The standard location of dictionary.txt is under codespell's package, on
>> my machine atm (codespell 2.1, Artix Linux):
>> /usr/lib/python3.9/site-packages/codespell_lib/data/dictionary.txt
>>
>> Since we enable the codespell by default for SOF I have constant:
>> No codespell typos will be found - \
>> file '/usr/share/codespell/dictionary.txt': No such file or directory
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> +	# Try to find the codespell install location to use it as default path
>> +	if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {
>> +		my $codespell_dict = `python -c "import os.path as op; import codespell_lib; print(op.join(op.dirname(codespell_lib.__file__), 'data', 'dictionary.txt'), end='')" 2> /dev/null`;
>> +		$codespellfile = $codespell_dict if (-e $codespell_dict);
>> +	}
> 
> This is really hard to read.
> 
> Can this be written something like
> 
> my $python_codespell_dict = << "EOF"
> import os.path as op
> import codespell_lib
> codespell_dir = op.dirname(codespell_lib.__file__)
> codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
> print(codespell_file)
> EOF
> ;
> my $codespell_dict = `python3 -c "$python_codespell_dict" 2> /dev/null`;

Yes, this definitely looks much better, thanks for the suggestion!

-- 
Péter
