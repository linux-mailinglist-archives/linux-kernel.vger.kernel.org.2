Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B6C3513EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhDAKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:49:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:40458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233817AbhDAKtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:49:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D87BFB154;
        Thu,  1 Apr 2021 10:49:37 +0000 (UTC)
Subject: Re: [PATCH v2 0/6] Add support for Actions Semi Owl socinfo
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <20210401052438.GB14052@work> <20210401094041.GA1993499@BV030612LT>
 <20210401102717.GF14052@work>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <252dd954-c8f1-fa2a-c37a-ede386fc9d43@suse.de>
Date:   Thu, 1 Apr 2021 12:49:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210401102717.GF14052@work>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01.04.21 12:27, Manivannan Sadhasivam wrote:
> On Thu, Apr 01, 2021 at 12:40:41PM +0300, Cristian Ciocaltea wrote:
>> On Thu, Apr 01, 2021 at 10:54:38AM +0530, Manivannan Sadhasivam wrote:
>>> On Tue, Mar 30, 2021 at 04:48:15PM +0300, Cristian Ciocaltea wrote:
>>>> This patchset adds a socinfo driver which provides information about
>>>> Actions Semi Owl SoCs to user space via sysfs: machine, family, soc_id,
>>>> serial_number.
>>>>
>>>> Please note the serial number is currently available only for the S500
>>>> SoC variant.
>>>>
>>>> This has been tested on the S500 SoC based RoseapplePi SBC.
>>>>
>>>
>>> Is this the soc_id provided by the vendor bootloader (uboot)? If so, under
>>> what basis it provides? I don't think the SoC has the provision for
>>> soc_id based on HW parameters.
>>
>> No, the soc_id is not provided by the bootloader, or at least I couldn't
>> identify any related implementation. Instead, I provided this via the
>> driver itself, since I've encountered this approach in some other soc
>> drivers as well (e.g. imx/soc-imx.c, versatile/soc-integrator.c). 
>>
> 
> Sorry, I was referring to serial_number. Since your comment says so, can
> you point to the corresponding code?

Seconded that this needs to be better understood. If this is just a
convention of some downstream U-Boot that's not implemented in mainline
(and maybe not even for Guitar or Labrador? tested on RoseapplePi only),
it might not be worth its own reserved-memory based kernel driver?

Implementing a standard interface such as DMI tables or a DT property in
mainline U-Boot may be more useful then. Is it still Mani's S900 only?

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
