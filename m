Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C68372AC7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhEDNR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhEDNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:17:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471F7C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 06:17:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lduv4-00019t-6c; Tue, 04 May 2021 15:16:58 +0200
Subject: Re: [PATCH 12/13] ARM: dts: stm32: fix DSI port node on STM32MP15
To:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
 <20210415101037.1465-13-alexandre.torgue@foss.st.com>
 <ececc78c-4fca-bb93-ef62-5d107501d963@pengutronix.de>
 <96da49dc-f24d-aa12-e1d8-39b5a5b6fbc9@foss.st.com>
 <CAK8P3a1bGAUbqTGqyz+PB=7fuVLkJce0awtx1Z9PE3uiX6uysQ@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <5f12a950-ec62-89b4-e22f-4b4a84048f8f@pengutronix.de>
Date:   Tue, 4 May 2021 15:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1bGAUbqTGqyz+PB=7fuVLkJce0awtx1Z9PE3uiX6uysQ@mail.gmail.com>
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

Hello Arnd,

On 19.04.21 15:57, Arnd Bergmann wrote:
> On Thu, Apr 15, 2021 at 2:23 PM Alexandre TORGUE
> <alexandre.torgue@foss.st.com> wrote:
>> On 4/15/21 12:43 PM, Ahmad Fatoum wrote:
>>> I think my rationale for the patch above was sound, so I think the checker
>>> taking offense at the DSI cells here should be considered a false positive.
>>
>> If it's a "false positive" warning then we need to find a way to not
>> print it out. Else, it'll be difficult to distinguish which warnings are
>> "normal" and which are not. This question could also be applied to patch[3].
>>
>> Arnd, Rob what is your feeling about this case ?
> 
> I don't have a strong opinion on this either way, but I would just
> not apply this one for 5.13 in this case. Rob, Alexandre, please
> let me know if I should apply the other patches before the
> merge window, I usually don't mind taking bugfixes late before the
> merge window, but I still want some level of confidence that they
> are actually correct.
> 
> Ahmad, if you feel strongly about this particular issue, would you like
> to suggest a patch for the checker?

The check is certainly useful. If it's not feasible to fix the checker (e.g.
because it analyzes standalone DTSIs), I am fine with reverting my commit
with an indication that this is to avoid triggering a dt-validate false
positive.

I am not familiar with dt-validate's inner workings to offer a patch.

Cheers,
Ahmad

> 
>         Arnd
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
