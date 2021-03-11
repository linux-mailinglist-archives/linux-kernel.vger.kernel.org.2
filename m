Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83BD336BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 07:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhCKGRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 01:17:49 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:54077 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229731AbhCKGRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:17:30 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lKEdR-003GLL-SZ; Thu, 11 Mar 2021 07:17:25 +0100
Received: from p5b13a966.dip0.t-ipconnect.de ([91.19.169.102] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lKEdR-001XVD-M1; Thu, 11 Mar 2021 07:17:25 +0100
Subject: Re: [PATCH] ia64: kernel: Few typos fixed in the file fsys.S
To:     Randy Dunlap <rdunlap@infradead.org>
References: <20210311061058.29492-1-unixbhaskar@gmail.com>
 <e26a1461-0d05-d79c-7688-de45d285e068@infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <356e2572-63cb-c7cb-2ebd-04ea21b161f0@physik.fu-berlin.de>
Date:   Thu, 11 Mar 2021 07:17:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <e26a1461-0d05-d79c-7688-de45d285e068@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.169.102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 3/11/21 7:15 AM, Randy Dunlap wrote:
> On 3/10/21 10:10 PM, Bhaskar Chowdhury wrote:
>>
>> Mundane spelling fixes.
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> but no maintainer Cc:ed to pick it up...

I guess Andrew's tree will just work fine in this case?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

