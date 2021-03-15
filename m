Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF833A9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 03:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhCOCcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 22:32:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:30761 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229661AbhCOCcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 22:32:36 -0400
IronPort-SDR: /htU0sR2WskbsACLvmL9wPOxKceUcAVtJpdZAtKBb8JGz73usCdsyP2bny/uoBcVCf7/NvncAg
 u3y0VffW7GaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="188387351"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="188387351"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 19:32:36 -0700
IronPort-SDR: qiRYHTeyZJR7NNbv0bBzWEpKYT2uQJMAMugrpDkwcuexGTShOrbDwqh8zaQk/w57fJeu3S08Fw
 v0TZ00EqNidw==
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="411686099"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 19:32:34 -0700
Subject: Re: [kbuild-all] Re: [PATCH] gcov: fail build on gcov_info size
 mismatch
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210311130328.2859337-1-oberpar@linux.ibm.com>
 <202103120329.VU4uJ0yZ-lkp@intel.com>
 <CAHk-=whmwEJ-4tGamqOCw4BDJ-yjYrLRYxaFq5YurVc-XXO+hg@mail.gmail.com>
 <db88186a-d6af-33c9-f1fb-10b673b8fdd6@intel.com>
 <CAHk-=wji=we4HQ2m6Z=fnUSM4UW8+X0eTnb9YPGYdcTqpVAL2Q@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <09373c3d-73e8-933a-24ad-5c4ba4fdc615@intel.com>
Date:   Mon, 15 Mar 2021 10:31:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wji=we4HQ2m6Z=fnUSM4UW8+X0eTnb9YPGYdcTqpVAL2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/21 1:52 AM, Linus Torvalds wrote:
> On Thu, Mar 11, 2021 at 7:50 PM Rong Chen <rong.a.chen@intel.com> wrote:
>>
>> The issue is from a=!, and [ "$a $b" = ".size .LPBX0," ] can avoid the
>> error.
>>
>> + [ ! = .size -a ABI = .LPBX0, ]
>> ./kernel/gcov/geninfosize.sh: 13: [: =: unexpected operator
> But that's not what the patch did.
>
> The patch used quotes around $a, so "$a" should still be fine.
>
> See:
>
>     [torvalds@ryzen ~]$ a="!" [ "$a" = ".size" ]
>
> is fine, but
>
>     [torvalds@ryzen ~]$ a="!" [ $a = ".size" ]
>     -bash: [: =: unary operator expected
>
> and the patch I saw, and that the test robot replied to, had that
> correct quoting, afaik.
>
> So I still don't see what the test robot is complaining about. Was
> there an earlier version of the patch without the quotes that I didn't
> see?
>
> Or is the shell on the test robot doing something really really odd,
> and it's somehow nds32-specific?
>
>                  Linus

Hi Linus,

It can be reproduced with '-a' option in dash:

     $ a="!"
     $ [ "$a" = ".size" ]
     $ [ "$a" = ".size" -a "$b" = ".LPBX0," ]
     sh: 2: [: =: unexpected operator

and there is a advice for the option at 
https://wiki.ubuntu.com/DashAsBinSh, I'm not sure it's the best practice 
or not.

     While dash supports most uses of the -a and -o options, they have 
very confusing semantics even in bash and are best avoided. Commands 
like the following:
         [ \( "$foo" = "$bar" -a -f /bin/baz \) -o ! -x /bin/quux ]
     should be replaced with:
         (([ "$foo" = "$bar" ] && [ -f /bin/baz ]) || [ ! -x /bin/quux ])

Best Regards,
Rong Chen
