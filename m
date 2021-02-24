Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1A1324343
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 18:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhBXRlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 12:41:37 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:46550 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhBXRl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jnaSaxfEHhw1J07WY7gtDPPBBJbzuT1XJjGtuK7YTXI=; b=MJS5Q70T4+yXL8ga8J+OZv9CJz
        XQGpCeTUkjlzbWLOsIyPiaCqRp1h6JlPX3ouS1RgeUl8R6X8Ud2HcbScTXWxODs7HxjGTrd6LRUuB
        sZn/0JXlwaPUGeKcmei2J/KFK3Fsh4R8IFfnwNnLMUdU8cbBCNwhzOsBLD31nBFHN/b0=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1lEy9S-0002fd-5B; Wed, 24 Feb 2021 11:40:42 -0600
Subject: Re: [PATCH 2/2] perf buildid-cache: Add test for PE executable
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
References: <295f5380-93a1-78fa-884b-afd4319b96d7@codeweavers.com>
 <YDZYEKJ7w+XgqA7S@krava>
From:   Nicholas Fraser <nfraser@codeweavers.com>
Message-ID: <5766cbc3-1fc3-7776-561d-8916474e205a@codeweavers.com>
Date:   Wed, 24 Feb 2021 12:40:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDZYEKJ7w+XgqA7S@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-02-24 8:43 a.m., Jiri Olsa wrote:
> On Fri, Feb 19, 2021 at 11:10:34AM -0500, Nicholas Fraser wrote:
>> +		# the build id must be rearranged into a GUID
>> +		id=`objcopy -O binary --only-section=.buildid $1 /dev/stdout | \
>> +			cut -c 33-48 | hexdump -ve '/1 "%02x"' | \
>> +			sed 's@^\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)\(.*\)0a$@\4\3\2\1\6\5\8\7\9@'`
>> +		;;
> 
> wow ;-) could this have some more info on what's going on in here?
> what's the .buildid PE section format?
> 

The .buildid section is in the PE debug directory format. This has a 28-byte
header:

https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#the-debug-section

This contains a CodeView entry with a GUID only (no path). The GUID is 4 bytes in:

https://github.com/dotnet/runtime/blob/master/docs/design/specs/PE-COFF.md#codeview-debug-directory-entry-type-2

This means the GUID starts at byte 32 (or 33 since cut uses 1-based indexing.)
The snippet of code extracts the .buildid section with objcopy, cuts bytes
33-48, converts them to hex, and re-arranges the bytes to form a GUID (the
first three fields of a GUID are little-endian.)

Technically, bytes 20-24 contain a pointer to the data, which could be
anywhere. In practice the format of this section is fixed in order to support
reproducible builds (so the TimeDateStamp for example is always zero.) This is
something created by the MinGW (and Cygwin?) compilers only; as far as I know
it's not created by MSVC tools. So I don't think we need to do any more
complicated parsing than just pulling out those bytes.

Of course if there is a tool that can pull out the build-id directly we should
use that instead. I don't know of any at the moment though.

I'll supply another patch to fix the other issues here. I'll add a couple more
comments and a better commit message as well.

> 
> I'm getting lot of wine's output, we should redirect that

No problem, I can redirect the output. I left it in because if the output is
hidden it's not clear when the command hangs or fails. I could redirect it to a
temp file instead and leave the temp file in case of failure.

> 
> every other run I'm getting some small window popup saying it's
> updating wine and stuck forever.. could this be prevented?
> 

Hmm. It's possible it's stuck behind a GUI prompt. For example if you don't
have wine-gecko installed it might waiting on a dialog asking to install it.
I'll unset DISPLAY so it can't pop up any dialogs; this should make it fully
non-interactive.

Other than that, it could take some time to set up the wine prefix (the
location where wine stores its runtime configuration) and it might have
something broken in the prefix, for example if it was interrupted while setting
it up. I'll change it to use a temporary wine prefix instead. This means it
will have to do the initialization on every run but it should be more reliable.
