Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6D24198B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhI0QRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:17:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54790 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhI0QRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:17:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id C8AD61F42FE9
Subject: Re: next/master bisection: baseline.login on qemu_arm-vexpress-a9
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <614ad319.1c69fb81.2a0c1.4782@mx.google.com>
 <8d6223d2-8ca7-0373-bb49-b62894e5fad7@collabora.com>
 <CAL_JsqJ9fDXkVgcXTiO+NM9T7OKO+p43NGmJPRvvLi3-_Bd4dQ@mail.gmail.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <1e8409b3-0649-5d7c-da3f-911880b15c2e@collabora.com>
Date:   Mon, 27 Sep 2021 18:15:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ9fDXkVgcXTiO+NM9T7OKO+p43NGmJPRvvLi3-_Bd4dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2021 21:05, Rob Herring wrote:
> On Thu, Sep 23, 2021 at 12:28 PM Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
>>
>> Hi Rob,
>>
>> Please see the bisection report below about a boot failure on ARM
>> Versatile Express.
>>
>> Reports aren't automatically sent to the public while we're
>> trialing new bisection features on kernelci.org but this one
>> looks valid.
> 
> Have you considered given you have the commit, if there's a Link tag,
> sending this as a reply to the original patch? That would be a bit
> easier to find IMO.

Absolutely, in fact it's also possible to search in Lore for the
original thread if there's no Link: trailer in the commit.  Then
if subsequent bisections get run, the bot could reply to
say "still failing" with new kernel revisions until it's fixed
and then reply to confirm it is.  That's the plan, there's still
a bit of work to do to have it all automated though.

>> Some more details can be found here, for Cortex A9:
>>
>>   https://linux.kernelci.org/test/case/id/614c36cf0c427f123799a2db/
> 
> I should have remembered there's a qemu model... Anyways, sending out
> a fix in a moment.
> 
> The log here was empty. Any reason 'earlycon' is not set here? I also
> noticed stdout-path is not set on many of the Arm Ltd boards. I'll
> send a patch for that, too. You really shouldn't have to set the
> console on the cmdline nowadays unless you want the non-default.

I believe earlycon is not set because it requires specific
options on different platforms, so there's some configuration
overhead involved here.  But it's a very good point that has been
raised in the past, I guess someone needs to take the time to
look into enabling it properly.  It shouldn't be that hard.

Thanks for the feedback and the quick fix!

Guillaume
