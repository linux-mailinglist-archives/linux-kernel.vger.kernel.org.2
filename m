Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6542A454AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbhKQQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:14:26 -0500
Received: from marcansoft.com ([212.63.210.85]:46732 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239011AbhKQQOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:14:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 507B841F12;
        Wed, 17 Nov 2021 16:11:11 +0000 (UTC)
Subject: Re: [PATCH 2/2] usb: typec: tipd: Fix initialization sequence for
 cd321x
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sven Peter <sven@svenpeter.dev>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211117151450.207168-1-marcan@marcan.st>
 <20211117151450.207168-3-marcan@marcan.st> <YZUn+Svh+RwuI8a8@kroah.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <79201333-382c-7ca9-491b-d9282a086abd@marcan.st>
Date:   Thu, 18 Nov 2021 01:11:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZUn+Svh+RwuI8a8@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/11/2021 01.04, Greg Kroah-Hartman wrote:
> On Thu, Nov 18, 2021 at 12:14:50AM +0900, Hector Martin wrote:
>> The power state switch needs to happen first, as that
>> kickstarts the firmware into normal mode.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>   drivers/usb/typec/tipd/core.c | 33 ++++++++++++++++-----------------
>>   1 file changed, 16 insertions(+), 17 deletions(-)
> 
> Same question here, what commit id does this fix?
> 
> thanks,
> 
> greg k-h
> 

Logically speaking, this fixes the same commit too (though it does it by
moving everything around the hunk it introduced instead), so:

Fixes: c9c14be664cf ("usb: typec: tipd: Switch CD321X power state to S0")

Thanks,
-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
