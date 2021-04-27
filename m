Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1136C736
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbhD0NrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbhD0NrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:47:16 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9D4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 06:46:32 -0700 (PDT)
Received: from [IPv6:2003:e9:d71c:53c1:1a1c:f8ad:1ac5:c6ea] (p200300e9d71c53c11a1cf8ad1ac5c6ea.dip0.t-ipconnect.de [IPv6:2003:e9:d71c:53c1:1a1c:f8ad:1ac5:c6ea])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id DD014C03EF;
        Tue, 27 Apr 2021 15:46:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1619531189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvMw0YKaWA12l42R9rjCeXwrc0Chb5+/WPr5Qs2mP/8=;
        b=mGZBl1niMQ/LBifMas/Xl8qnDVmCklLNYjV65Gcu1jLL3q2/OZ7c5pGpOWETtUvZRHiELU
        uJMcGNPfUoVVTa/PTMhxuAiK0V5AppIVtaBQ8SUGT2iS466YjgByZmdLQ+0pvoVrEHu+mt
        JUXqNKRvDkZ52x8q4N477+FMx16rrZY0qoNYttjzAvRqABGtpvbWqU+h1WccmMHBOPyTlk
        sCILzNgYrJ9tkefG3PGeY70mYt41cnqq4VJCHl67q4bY9Zu2TNQhuoKPooWzaZ0ABv1cBU
        XKsrl2fkJ9FO2uBaPaDOMbX7Qw+VLVpflJ4zzo3ekknNbxETUcONTnA18zpcJQ==
Subject: Re: [PATCH 084/190] Revert "net: ieee802154: fix missing checks for
 regmap_update_bits"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Mukesh Ojha <mojha@codeaurora.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-85-gregkh@linuxfoundation.org>
 <4e9dad99-8a88-a617-33be-0cb17824bc62@datenfreihafen.org>
 <YIgUGtzV6GSYhCqb@kroah.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <c878e7bc-c9f2-e2d1-8d4f-bc3557fb7991@datenfreihafen.org>
Date:   Tue, 27 Apr 2021 15:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YIgUGtzV6GSYhCqb@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg.

On 27.04.21 15:39, Greg Kroah-Hartman wrote:
> On Wed, Apr 21, 2021 at 03:23:06PM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 21.04.21 14:59, Greg Kroah-Hartman wrote:
>>> This reverts commit 22e8860cf8f777fbf6a83f2fb7127f682a8e9de4.
>>>
>>> Commits from @umn.edu addresses have been found to be submitted in "bad
>>> faith" to try to test the kernel community's ability to review "known
>>> malicious" changes.  The result of these submissions can be found in a
>>> paper published at the 42nd IEEE Symposium on Security and Privacy
>>> entitled, "Open Source Insecurity: Stealthily Introducing
>>> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
>>> of Minnesota) and Kangjie Lu (University of Minnesota).
>>>
>>> Because of this, all submissions from this group must be reverted from
>>> the kernel tree and will need to be re-reviewed again to determine if
>>> they actually are a valid fix.  Until that work is complete, remove this
>>> change to ensure that no problems are being introduced into the
>>> codebase.
>>>
>>> Cc: Kangjie Lu <kjlu@umn.edu>
>>> Cc: Mukesh Ojha <mojha@codeaurora.org>
>>> Cc: Stefan Schmidt <stefan@datenfreihafen.org>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>    drivers/net/ieee802154/mcr20a.c | 6 ------
>>>    1 file changed, 6 deletions(-)
>>>
>>> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
>>> index 8dc04e2590b1..2ce5b41983f8 100644
>>> --- a/drivers/net/ieee802154/mcr20a.c
>>> +++ b/drivers/net/ieee802154/mcr20a.c
>>> @@ -524,8 +524,6 @@ mcr20a_start(struct ieee802154_hw *hw)
>>>    	dev_dbg(printdev(lp), "no slotted operation\n");
>>>    	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>>>    				 DAR_PHY_CTRL1_SLOTTED, 0x0);
>>> -	if (ret < 0)
>>> -		return ret;
>>>    	/* enable irq */
>>>    	enable_irq(lp->spi->irq);
>>> @@ -533,15 +531,11 @@ mcr20a_start(struct ieee802154_hw *hw)
>>>    	/* Unmask SEQ interrupt */
>>>    	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL2,
>>>    				 DAR_PHY_CTRL2_SEQMSK, 0x0);
>>> -	if (ret < 0)
>>> -		return ret;
>>>    	/* Start the RX sequence */
>>>    	dev_dbg(printdev(lp), "start the RX sequence\n");
>>>    	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>>>    				 DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);
>>> -	if (ret < 0)
>>> -		return ret;
>>>    	return 0;
>>>    }
>>>
>>
>>
>> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> 
> Thanks for the review, but in re-reviewing this, I'll drop the revert as
> it looks correct to me.

It is correct. We missed the return checking when the driver came in 
initially.

My Acked-by was really not about if the reverted patch was a security 
risk, but about the fact that you wanted to sort them out individually 
due to the Hypocrite Commits paper before getting them back in.

If you are happy to change the approach to only revert patches you are 
in doubt (this one is really not one of them) I am happy to keep this 
patch in.

regards
Stefan Schmidt
