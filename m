Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79568365BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhDTPOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:14:00 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:54893 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230260AbhDTPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:13:56 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id Ys3vl5TJaXsivYs3ylst79; Tue, 20 Apr 2021 17:13:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1618931603; bh=3C0exdyZaQiSGldksQpZfnPH4H6n3fld0R4rJ3LKuto=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=faFGkgmY+B8OeIIURy0DFsuAbHMupaVe/9aNrM6VvIbe/W57NLoMWWSMESk5QY8Mv
         n6tLBR4pyo0o91lIGrn6sNl2wmwznlxE830j3WOD2ZfPootYrQ6IRQKP/VtAIl1ytH
         tLKU4eu62zu42AMFf8fe6XzdBOyF+afxCtaDmzt/mlWZJJWLnOEY1rUWO4QNtp4Mec
         npKbjyUmVTp0Hp3A15qu/8EDhxNQ5DFdXCP92YdkBt/lBhWs/fAwbLxE/9NyyPADYl
         MdiH7nRqCaGbMTQ/QfFG1OD+JyUnocoiNtNTkk4/9F0bsfYjzjysfhBmP+JidXVYI8
         rRKYhktmGtP0A==
Subject: Re: [PATCH 0/2] drm/bridge: dw-hdmi: disable loading of DW-HDMI CEC
 sub-driver
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     jernej.skrabec@siol.net, jonas@kwiboo.se,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robert.foss@linaro.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20210416092737.1971876-1-narmstrong@baylibre.com>
 <YHlfqJIlUh7eytty@pendragon.ideasonboard.com>
 <96b9e144-0791-4c19-3e3c-b0e9efb86138@baylibre.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <cbea511c-5d5c-8c59-f91f-fedc8eec1e39@xs4all.nl>
Date:   Tue, 20 Apr 2021 17:13:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <96b9e144-0791-4c19-3e3c-b0e9efb86138@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDW8hEuWfrPrGvMc0olaEqO/1NZZ2yQB6WunaYVqq8MMrH5Sc3f2aTH42A3BAjZZ79UDFNJG6FEQbmiNEveAXU3jrDh9BPb7rKQsNBZlxBJ8G9LkTDpz
 qxD/6CMKaS6Mod/qRe9vKOOIJ0qV7CLLV9nRS4hIecITZIXQXzbDAlVTCwWTqHMCorEplxuE+o/YBuut6nfaMaa3Ijr5cKzPw6kVDFlBvZNyPxmRhGZQxrDD
 lbnmm4/1h7S6WfPi9kBv4XRwTHRmUUsfEvn1n1x31yag5ccdCETr3Mu11F844QoH7Hz9pZ9wJL57yz6y41Ka0ZRq+bj2Wspex/50krDYACnhAjPyU5Urmtjo
 +lusK7ss2EGSSUnMMynnA9PjXZfNZZo1Y8DpEMmCV6OVxRhhWm2kwStujrbXHcMLFNrrLNmvGJgJIAnhdi9X54VlwkATGdoQUB7XzhATvxXrj2qFPLhowZCr
 VTzjeVy+XJaKyFVHeN2b+67qyM+FfTCKZWdvDaO7ypk6d4e2gqPC34T4vMA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2021 13:38, Neil Armstrong wrote:
> On 16/04/2021 11:58, Laurent Pinchart wrote:
>> Hi Neil,
>>
>> On Fri, Apr 16, 2021 at 11:27:35AM +0200, Neil Armstrong wrote:
>>> This adds DW-HDMI driver a glue option to disable loading of the CEC sub-driver.
>>>
>>> On some SoCs, the CEC functionality is enabled in the IP config bits, but the
>>> CEC bus is non-functional like on Amlogic SoCs, where the CEC config bit is set
>>> but the DW-HDMI CEC signal is not connected to a physical pin, leading to some
>>> confusion when the DW-HDMI CEC controller can't communicate on the bus.
>>
>> If we can't trust the CEC config bit, would it be better to not use it
>> at all, and instead let each platform glue logic tell whether to enable
>> CEC or not ?
> 
> Actually, the CEC config bit is right, the HW exists and should be functional, but
> this bit doesn't tell if the CEC signal is connected to something.
> 
> This lies in the IP integration, like other bits under the "amlogic,meson-*-dw-hdmi"
> umbrella.
> 
> The first attempt was by Hans using DT, but adding a property in DT for a vendor
> specific compatible doesn't make sense. Another idea would be to describe the
> CEC signal endpoint like we do for video signal, but I think this is out of scope and
> this solution is much simpler and straightforward, and it's more an exception than
> a general use case to solve.

While a DT property might not make sense in this particular case, I still
believe that it is a perfectly valid approach in general: whether or not
the CEC pin is connected is at the hardware level decision, it is not
something that software can detect. If the designer of the board didn't
connect it, then the only place you can define that is in the device tree.

Anyway, for meson I am fine with this solution. At least it prevents creating
a non-functioning cec device. So for this series:

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> 
> Neil
> 
>>
>>> Jernej Skrabec (1):
>>>   drm/bridge/synopsys: dw-hdmi: Add an option to suppress loading CEC
>>>     driver
>>>
>>> Neil Armstrong (1):
>>>   drm/meson: dw-hdmi: disable DW-HDMI CEC sub-driver
>>>
>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
>>>  drivers/gpu/drm/meson/meson_dw_hdmi.c     | 1 +
>>>  include/drm/bridge/dw_hdmi.h              | 2 ++
>>>  3 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

