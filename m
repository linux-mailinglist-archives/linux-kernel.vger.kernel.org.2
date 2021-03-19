Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC85F341BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCSLrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCSLrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:47:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8282C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:47:16 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lNDb1-00065Q-5l; Fri, 19 Mar 2021 12:47:15 +0100
Subject: Re: [PATCH v2 2/2] driver core: add helper for deferred probe reason
 setting
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210319110459.19966-1-a.fatoum@pengutronix.de>
 <20210319110459.19966-2-a.fatoum@pengutronix.de>
 <CAHp75VfMAaGTSvPC+_wvDcQFNwqvQwuf8erCPMteWyDpUOwcwQ@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <179ead41-e5ef-c319-bb22-338ea59cb682@pengutronix.de>
Date:   Fri, 19 Mar 2021 12:47:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfMAaGTSvPC+_wvDcQFNwqvQwuf8erCPMteWyDpUOwcwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19.03.21 12:15, Andy Shevchenko wrote:
> On Fri, Mar 19, 2021 at 1:05 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>
>> We now have three places within the same file doing the same operation
>> of freeing this pointer and setting it anew. A helper make this
>> arguably easier to read, so add one.
> 
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> One thing: Suggested-by?

I suggested it to myself while drafting the first patch.

Cheers,
Ahmad

> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
