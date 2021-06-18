Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A40B3AC2E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 07:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhFRFnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 01:43:00 -0400
Received: from phobos.denx.de ([85.214.62.61]:44218 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232456AbhFRFm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 01:42:57 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 43E6780563;
        Fri, 18 Jun 2021 07:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1623994846;
        bh=uNXPIXPD8fqjMp54pQS8vQeSgs5ZSHX/0gwovObOC0E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=soYQdyUYvzgSM4U5r9XFh4FEnd1GrO9vEHbdox17WFLfCvG82LXhiN5WEd579t8fw
         6U7DAWBWP4GITzRSBvB0gdoTYr55vQQGRu4HK5JVBUxQdFk+jEvsvbzjbCb0ewTnza
         Ks+m7VgZwyJ0Kc+gmf5D/znMnrrN+5255RJ83pHASG3ziL8hy40mss7ZDbt1h+4fDl
         QHZMI21mwoEvOc74PN5LLxj4OhboQrEpiBccE4XRtwQIlscdmR2MQH2FFYaY9gNqa0
         zZ9YLScdE0W98E+ts0qxZiINVmf4U1IWCBDVuDhl0PNlntPFFpNRfWoSfsRDf15Gy5
         KEyNmO+45tUsQ==
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: Fix null pointer dereference in
 remove callback
To:     Jonathan Liu <net147@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
References: <20210617111925.162120-1-net147@gmail.com>
 <YMtYoaSIIRhb85fh@pendragon.ideasonboard.com>
 <CANwerB0J9xKj3kjYPjzfeDvKV8JXPcDtoZaLMzkudCBz8=ZnVw@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <d708823a-3b28-2541-da06-86eb41484aaa@denx.de>
Date:   Fri, 18 Jun 2021 07:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CANwerB0J9xKj3kjYPjzfeDvKV8JXPcDtoZaLMzkudCBz8=ZnVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/21 5:06 AM, Jonathan Liu wrote:
> Hi Marek,

Hi,

>> Hi Jonathan,
>>
>> Thank you for the patch.
>>
>> On Thu, Jun 17, 2021 at 09:19:25PM +1000, Jonathan Liu wrote:
>>> If attach has not been called, unloading the driver can result in a null
>>> pointer dereference in mipi_dsi_detach as ctx->dsi has not been assigned
>>> yet.
>>
>> Shouldn't this be done in a brige .detach() operation instead ?
>>
> 
> Could you please take a look?
> I don't have a working setup to test moving the code to detach.

I just replied to your other email regarding bringing the chip up, so 
please bring your setup up first, then test this patch again, and then 
let's revisit this topic.
