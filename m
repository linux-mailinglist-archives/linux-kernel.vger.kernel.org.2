Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B89331B8E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhCIATj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:19:39 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51429 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231969AbhCIATI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:19:08 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lJQ5a-0044oU-Hy; Tue, 09 Mar 2021 01:19:06 +0100
Received: from p57bd9fdc.dip0.t-ipconnect.de ([87.189.159.220] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lJQ5a-003dbK-B4; Tue, 09 Mar 2021 01:19:06 +0100
Subject: Re: [GIT] SPARC
To:     David Miller <davem@davemloft.net>, torvalds@linux-foundation.org
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210308.154619.729170517586257571.davem@davemloft.net>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <37859f29-dc59-d6c2-6f92-abaae32ee4ab@physik.fu-berlin.de>
Date:   Tue, 9 Mar 2021 01:19:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210308.154619.729170517586257571.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.159.220
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave!

On 3/9/21 12:46 AM, David Miller wrote:
> Just some more random bits from Al,  including a conversion over to generic exytables.

Is there a chance we could include this important fix by Rob Gardner for 5.12 as well?

> https://marc.info/?l=linux-sparc&m=161457847223456&w=2

It fixes a hard kernel crash under certain loads which we have seen in Debian quite frequently.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

