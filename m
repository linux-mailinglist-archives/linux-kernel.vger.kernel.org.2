Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC0D3E8366
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 21:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhHJTGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 15:06:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:2425 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhHJTGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:06:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="195239243"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="195239243"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 12:05:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="515954777"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2021 12:05:44 -0700
Subject: Re: [PATCH 5/5] perf tools: Add dlfilter test
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20210810114813.12951-1-adrian.hunter@intel.com>
 <20210810114813.12951-6-adrian.hunter@intel.com>
 <YRLGTfQdg7pBcf29@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e0eba7e7-d9ae-eff4-254c-6fe16809a675@intel.com>
Date:   Tue, 10 Aug 2021 22:06:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRLGTfQdg7pBcf29@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/21 9:32 pm, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 10, 2021 at 02:48:13PM +0300, Adrian Hunter escreveu:
>> Add a perf test to test the dlfilter C API.
>>
>> A perf.data file is synthesized and then processed by perf script with a
>> dlfilter named dlfilter-test-api-v0.so. Also a C file is compiled to
>> provide a dso to match the synthesized perf.data file.
> 
> [root@five ~]# perf test dlfilter
> 72: dlfilter C API                                                  : FAILED!
> [root@five ~]# perf test -v dlfilter
> 72: dlfilter C API                                                  :
> --- start ---
> test child forked, pid 3358542
> Checking for gcc
> Command: gcc --version
> gcc (GCC) 11.1.1 20210531 (Red Hat 11.1.1-3)
> Copyright (C) 2021 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> dlfilters path: /var/home/acme/libexec/perf-core/dlfilters
> Command: gcc -g -o /tmp/dlfilter-test-3358542-prog /tmp/dlfilter-test-3358542-prog.c
> Creating new host machine structure
> Command: /var/home/acme/bin/perf script -i /tmp/dlfilter-test-3358542-perf-data --dlfilter /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so --dlarg first --dlarg 1 --dlarg 4198669 --dlarg 4198662 --dlarg 0 --dlarg last
> Failed with return value 139
> test child finished with -1
> ---- end ----
> dlfilter C API: FAILED!
> [root@five ~]# cat /etc/redhat-release
> Fedora release 34 (Thirty Four)
> [root@five ~]# cat /etc/os-release
> NAME=Fedora
> VERSION="34.20210721.0 (Silverblue)"
> ID=fedora
> VERSION_ID=34
> VERSION_CODENAME=""
> PLATFORM_ID="platform:f34"
> PRETTY_NAME="Fedora 34.20210721.0 (Silverblue)"
> ANSI_COLOR="0;38;2;60;110;180"
> LOGO=fedora-logo-icon
> CPE_NAME="cpe:/o:fedoraproject:fedora:34"
> HOME_URL="https://fedoraproject.org/"
> DOCUMENTATION_URL="https://docs.fedoraproject.org/en-US/fedora-silverblue/"
> SUPPORT_URL="https://fedoraproject.org/wiki/Communicating_and_getting_help"
> BUG_REPORT_URL="https://bugzilla.redhat.com/"
> REDHAT_BUGZILLA_PRODUCT="Fedora"
> REDHAT_BUGZILLA_PRODUCT_VERSION=34
> REDHAT_SUPPORT_PRODUCT="Fedora"
> REDHAT_SUPPORT_PRODUCT_VERSION=34
> PRIVACY_POLICY_URL="https://fedoraproject.org/wiki/Legal:PrivacyPolicy"
> VARIANT="Silverblue"
> VARIANT_ID=silverblue
> OSTREE_VERSION='34.20210721.0'
> [root@five ~]#
> 
> Trying to figure this out...

What does it give with two 'v''s ?
i.e.

perf test -vv dlfilter
