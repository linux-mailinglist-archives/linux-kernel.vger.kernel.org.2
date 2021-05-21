Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC438C0AC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbhEUHZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:25:34 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:50333 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232911AbhEUHZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:25:33 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ljzVw-000b5K-UL; Fri, 21 May 2021 09:24:08 +0200
Received: from p5b13a0fe.dip0.t-ipconnect.de ([91.19.160.254] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ljzVw-001igV-Nm; Fri, 21 May 2021 09:24:08 +0200
Subject: Re: [PATCH v1 1/1] kernel.h: split out panic and oops helpers (ia64
 fix)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
References: <20210520130557.55277-1-andriy.shevchenko@linux.intel.com>
 <f2420178-53d7-a1e4-eea7-5e1773835411@physik.fu-berlin.de>
 <YKZhcKqomWxH3eph@smile.fi.intel.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <41bbace7-1b09-8464-a082-e4152f07fdb4@physik.fu-berlin.de>
Date:   Fri, 21 May 2021 09:24:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKZhcKqomWxH3eph@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.254
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy!

On 5/20/21 3:17 PM, Andy Shevchenko wrote:
> On Thu, May 20, 2021 at 03:12:24PM +0200, John Paul Adrian Glaubitz wrote:
>> On 5/20/21 3:05 PM, Andy Shevchenko wrote:
>>> Note, this patch is untested. I have no ia64 compiler at hand.
> 
>> I can test it later today.
> 
> Appreciate it, thanks!
> 
> This is against Linux Next (where Andrew's patches are sitting for a while).

I just pulled linux-next and was able to build a kernel for my RX-2600 without any
problems. Since your patch is already in the tree, I assume it's correct.

Do you want me to test anything else? I can test-boot the kernel later, but I want
to avoid that now since I don't want to turn on the noisy server while at home :-).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
