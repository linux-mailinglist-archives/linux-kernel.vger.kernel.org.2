Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966824223E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhJEKwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233449AbhJEKwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:52:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8152761502;
        Tue,  5 Oct 2021 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633431011;
        bh=SLgYcczN9LsLWDYmQolP27i4eos161EtVoDB7lKNWms=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=L+zT0R5057LTJqOM8a8ye3OJiLpJotecIhHXJEuk2owUvRQsKay1wAA63Voni6AOD
         XpQRwbJBzThtEfzSyQiMUuqLeOjt/WWd4h/22J1Kucw+IZ3TDpPkZA4u9ioc5vMg+W
         2Uh3i6P3U3mCHLPBxHPjBRytXtDW0GjpqhesDmh7Q9vrlff5XHZSOS+6TBXhH5PpPf
         blY5tlkQqPj0r5qai9y5uCy7m3k6E0Ly7p3sGP3KCavhHUerRwhV7wshkR+EW0+ET4
         AFJjEwiIff5E34N6DgOrCwyxC8CKc6DycgLwmw3mFT1ubRMmHdqUaV3FwcJ7+jg36C
         JJFCzPOfyaGZQ==
References: <20211004141839.49079-1-andriy.shevchenko@linux.intel.com>
 <7019ca3e-f076-e65b-f207-c23a379ade29@gmail.com>
 <20211005085100.GB17524@pengutronix.de>
User-agent: mu4e 1.6.6; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     Ferry Toth <fntoth@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] usb: dwc3: gadget: Revert "set gadgets parent to
 the right controller"
Date:   Tue, 05 Oct 2021 13:49:32 +0300
In-reply-to: <20211005085100.GB17524@pengutronix.de>
Message-ID: <87ee8zzqxr.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Grzeschik <mgr@pengutronix.de> writes:

> [[PGP Signed Part:Undecided]]
> On Mon, Oct 04, 2021 at 10:35:57PM +0200, Ferry Toth wrote:
>>Hi,
>>
>>Op 04-10-2021 om 16:18 schreef Andy Shevchenko:
>>>The commit c6e23b89a95d ("usb: dwc3: gadget: set gadgets parent to the right
>>>controller") changed the device for the UDC and broke the user space scripts
>>>that instantiate the USB gadget(s) via ConfigFS.
>>
>> I confirm this regression on Intel Edison since at least 5.15-rc2
>> while in 5.14.0 it was working fine.
>>
>>This patch resolves the issue as tested on 5.15-rc4.
>>
>>Tested-by: Ferry Toth<fntoth@gmail.com>
>
> NACK! Why should we resolv an issue by reverting it to solve not working
> userspace. We already have this patch as a solution for solving a deeper

heh, there is only one rule in this community: thou shalt not break
userspace :-)

-- 
balbi
