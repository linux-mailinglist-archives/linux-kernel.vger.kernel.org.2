Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474E33B7A18
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 23:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhF2VwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 17:52:20 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:52883 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233660AbhF2VwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 17:52:19 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lyLc2-001t9P-5m; Tue, 29 Jun 2021 23:49:46 +0200
Received: from p57bd964c.dip0.t-ipconnect.de ([87.189.150.76] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lyLc1-003Yvo-VO; Tue, 29 Jun 2021 23:49:46 +0200
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <be15fd85-1d35-0cba-5c27-8273f0647f94@physik.fu-berlin.de>
Message-ID: <33d4f0ef-0d7d-c0a5-102a-7ae862b8c12a@physik.fu-berlin.de>
Date:   Tue, 29 Jun 2021 23:49:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <be15fd85-1d35-0cba-5c27-8273f0647f94@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.150.76
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 6/28/21 12:26 AM, John Paul Adrian Glaubitz wrote:
>>  arch/sh/Kconfig.debug             |    1 
>>  arch/sh/include/asm/sfp-machine.h |    8 +++++
>>  arch/sh/math-emu/math.c           |   44 ++++++++++++++--------------
>>  3 files changed, 31 insertions(+), 22 deletions(-)
> 
> I'll test these tomorrow on my SH-7785LCR board. Would it be possible to queue
> them up for linux-next after verification?

Just as a heads-up: My fast EPYC server for kernel cross-compilation is currently down,
so I'll have to set up a new machine at SUSE tomorrow for that purpose. Hope to be able
to test the kernel after that.

Sorry for the delay, the other server is currently down due to an A/C failure at the university.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
