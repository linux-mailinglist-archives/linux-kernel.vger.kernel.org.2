Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7882B3484F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbhCXW5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:57:41 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:43671 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238461AbhCXW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:57:16 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lPCR7-002cPH-4V; Wed, 24 Mar 2021 23:57:13 +0100
Received: from p57bd9564.dip0.t-ipconnect.de ([87.189.149.100] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lPCR6-000rLx-Tb; Wed, 24 Mar 2021 23:57:13 +0100
Subject: Re: [PATCH] ia64: mca: allocate early mca with GFP_ATOMIC
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <20210315085045.204414-1-slyfox@gentoo.org>
 <f351183c-7d70-359f-eed7-4d1722cf41c5@physik.fu-berlin.de>
 <20210323174724.78b61c02@sf>
 <4f7ccc08-7355-63a0-7239-16a5fb29207f@physik.fu-berlin.de>
 <20210324153934.963ac2cb8f44a4e529016612@linux-foundation.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <7c2b9840-b1ba-1e5d-1909-5482e8c04ca1@physik.fu-berlin.de>
Date:   Wed, 24 Mar 2021 23:57:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324153934.963ac2cb8f44a4e529016612@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.149.100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

On 3/24/21 11:39 PM, Andrew Morton wrote:
> On Wed, 24 Mar 2021 11:20:45 +0100 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
> 
>>>> #NEXT_PATCHES_START mainline-later (next week, approximately)
>>>> ia64-mca-allocate-early-mca-with-gfp_atomic.patch
>>
>> Great, thanks. We're still missing Valentin's patch for the NUMA enumeration issue
>> though. Should Valentin send the patch again with Andrew CC'ed?
> 
> I subscribed to linux-ia64 today, so I can go in there to find things. 

Good to know, thanks.

> But if there's anything presently outstanding, please do resend.
> 
> I presently have
> 
> module-remove-duplicate-include-in-arch-ia64-kernel-heads.patch
> ia64-kernel-few-typos-fixed-in-the-file-fsyss.patch
> ia64-include-asm-minor-typo-fixes-in-the-file-pgtableh.patch
> ia64-ensure-proper-numa-distance-and-possible-map-initialization.patch
> ia64-drop-unused-ia64_fw_emu-ifdef.patch

I send two patches today which fix two ia64-related build issues in tools,
not sure whether you should pick those as well or I should just wait for
the maintainers that get_maintainers.pl report to answer.

> https://marc.info/?l=linux-netdev&m=161652285123466&w=2
> https://marc.info/?l=linux-netdev&m=161652400124112&w=2

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

