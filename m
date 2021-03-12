Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFA733847C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 04:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhCLDua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 22:50:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:9090 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231925AbhCLDu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 22:50:28 -0500
IronPort-SDR: DW5xO5U1kUbT0f8QBnTYPV3FWBWerzNy/dcbdKDrzAwT09ZaF+w2UAGLl/8QXeKYq9oLDy1cX7
 5Fw3OpqhV09A==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="208612013"
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="scan'208";a="208612013"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 19:50:28 -0800
IronPort-SDR: DChjxjJZ+M4d7R20c+kxMyWt725BN9bCwT6E0jm2fdYO1G3sDHURR9W/qPPfYyhmPGggPDPNq7
 LTcvqSZ5EG2Q==
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="scan'208";a="410864649"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 19:50:26 -0800
Subject: Re: [kbuild-all] Re: [PATCH] gcov: fail build on gcov_info size
 mismatch
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210311130328.2859337-1-oberpar@linux.ibm.com>
 <202103120329.VU4uJ0yZ-lkp@intel.com>
 <CAHk-=whmwEJ-4tGamqOCw4BDJ-yjYrLRYxaFq5YurVc-XXO+hg@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <db88186a-d6af-33c9-f1fb-10b673b8fdd6@intel.com>
Date:   Fri, 12 Mar 2021 11:49:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whmwEJ-4tGamqOCw4BDJ-yjYrLRYxaFq5YurVc-XXO+hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/21 4:02 AM, Linus Torvalds wrote:
> On Thu, Mar 11, 2021 at 11:34 AM kernel test robot <lkp@intel.com> wrote:
>>>> kernel/gcov/geninfosize.sh: 13: [: =: unexpected operator
> Wth? I'm not seeing how this can fail on nds32 - doesn't look like a
> bashism, everything is properly quoted, etc etc. Plus it's a
> cross-compile anyway, so the shell in question should be the same as
> on all the other architectures.
>
> Presumably the nds32 assembly contains something odd and unexpected,
> but with the quoting, I can't see how even that could matter.
>
> Yeah, the test itself could probably be simplified to testing both
> conditions at the same time:
>
>    [ "$a $b" = ".size .LPBX0," ]
>
> but that's a separate issue.
>
> Funky. What am I missing? Presumably something really stupid.
>
>                 Linus

Hi Linus,

The issue is from a=!, and [ "$a $b" = ".size .LPBX0," ] can avoid the 
error.

+ [ ! = .size -a ABI = .LPBX0, ]
./kernel/gcov/geninfosize.sh: 13: [: =: unexpected operator

Best Regards,
Rong Chen
