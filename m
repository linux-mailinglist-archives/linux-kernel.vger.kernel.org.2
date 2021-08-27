Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B163F923E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 04:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbhH0CNJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Aug 2021 22:13:09 -0400
Received: from seshat.vectro.org ([212.24.108.39]:39120 "EHLO
        seshat.vectro.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhH0CNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 22:13:08 -0400
Received: from [IPv6:2603:7000:7f02:f340:5ea4:fd1d:9a:71e3] (2603-7000-7f02-f340-5ea4-fd1d-009a-71e3.res6.spectrum.com [IPv6:2603:7000:7f02:f340:5ea4:fd1d:9a:71e3])
        by seshat.vectro.org (Postfix) with ESMTPSA id 8EE941008A2;
        Fri, 27 Aug 2021 05:12:13 +0300 (EEST)
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20201009144047.505957-1-benjamin@sipsolutions.net>
 <20201028091043.GC1947336@kroah.com> <20201106104725.GC2785199@kroah.com>
 <YR+nwZtz9CQuyTn+@lorien.valinor.li>
 <077990d1e354777c4c6a33866a0916bed6a97ed5.camel@sipsolutions.net>
 <bd81136b-3b52-fbda-780a-9dc58bdeb268@vectro.org>
 <YSCd0aBXNX4rj3Vb@eldamar.lan>
From:   Ian Turner <vectro@vectro.org>
Subject: Re: [PATCH 0/2] UCSI race condition resulting in wrong port state
Message-ID: <f0216270-8b39-1eaf-c4b6-c5d455c8bac3@vectro.org>
Date:   Thu, 26 Aug 2021 22:12:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YSCd0aBXNX4rj3Vb@eldamar.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 2:31 AM, Salvatore Bonaccorso wrote:
> Ah apologies, I was under the impression that you confirmed that this
> was already the right fix. It is pretty close to what you describe, so
> if you can additionally confirm the fix, that would be great.
>
> Regards,
> Salvatore

Well, it would seem that I owe everyone here an apology.

Not only did I not observe this issue with a patched kernel, but I'm 
also now unable to reproduce it booting into a stock kernel. I can only 
speculate about the reasons for this.

I'll come back here if I learn more. Sorry about the noise.

Ian Turner


