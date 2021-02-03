Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C38D30E123
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhBCRfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:35:01 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:46830 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhBCRe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:34:57 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id DEDB2A15A4;
        Wed,  3 Feb 2021 18:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=6JriUFT4K4Gw
        YTQBWmEFwOKzOJIBhwKv+n4I3Bk9mZ4=; b=ZS9V4YZ72FWVi7jLDWcSYcAxKf+E
        q4/rbVgU+kTQKo0+HohUXRP4aRJctXkwRTS7slZVNXGVKEiK9xYezJH9qleb++ty
        JDcfELO4n6iMqRMMd0uR7JoH2qOXonsSXmUprzdqEdYgcb9UJ5qN8waT3PmM2XPN
        dlUUlFCn3FynQI2qXzqEURdH7WoJ1zk7yMy89/tIPNhS8TiZERrSlg8ybV0LKvN4
        OLsmqvjaD56VsoWRsLLSzTwfxCW8IgfMgG9uVJemr/v2fqHOTROjmkg4MgFGNlYR
        JULqEYM8W+YWDNKrq+WzFkkvkBm5hy9haTBbLVTHCkGRzuKehKmn9ICG+w==
Subject: Re: [virtio-dev] Re: [PATCH v2 2/9] ALSA: virtio: add virtio sound
 driver
To:     Takashi Iwai <tiwai@suse.de>
CC:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>,
        <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-3-anton.yakovlev@opensynergy.com>
 <8754dae8-114-6383-510-de2ba9dc4fa@intel.com>
 <52f71ac6-3ec7-2884-7a64-1995f416d20a@opensynergy.com>
 <s5h35yd9jf0.wl-tiwai@suse.de>
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <fb4808e7-28d6-996e-02fc-c63d0e1d8221@opensynergy.com>
Date:   Wed, 3 Feb 2021 18:34:12 +0100
MIME-Version: 1.0
In-Reply-To: <s5h35yd9jf0.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,


On 03.02.2021 17:59, Takashi Iwai wrote:
> On Tue, 02 Feb 2021 00:18:09 +0100,
> Anton Yakovlev wrote:
>>>> +/**
>>>> + * virtsnd_reset_fn() - Kernel worker's function to reset the device.
>>>> + * @work: Reset device work.
>>>> + *
>>>> + * Context: Process context.
>>>> + */
>>>> +static void virtsnd_reset_fn(struct work_struct *work)
>>>> +{
>>>> +     struct virtio_snd *snd =
>>>> +             container_of(work, struct virtio_snd, reset_work);
>>>> +     struct virtio_device *vdev = snd->vdev;
>>>> +     struct device *dev = &vdev->dev;
>>>> +     int rc;
>>>> +
>>>> +     dev_info(dev, "sound device needs reset\n");
>>>> +
>>>> +     /*
>>>> +      * It seems that the only way to properly reset the device is to
>>>> remove
>>>> +      * and re-create the ALSA sound card device.
>>>> +      *
>>>> +      * Also resetting the device involves a number of steps with
>>>> setting the
>>>> +      * status bits described in the virtio specification. And the
>>>> easiest
>>>> +      * way to get everything right is to use the virtio bus interface.
>>>> +      */
>>>> +     rc = dev->bus->remove(dev);
>>>> +     if (rc)
>>>> +             dev_warn(dev, "bus->remove() failed: %d", rc);
>>>> +
>>>> +     rc = dev->bus->probe(dev);
>>>> +     if (rc)
>>>> +             dev_err(dev, "bus->probe() failed: %d", rc);
>>>
>>> This looks very suspicious to me. Wondering what ALSA maintainers
>> will say
>>> to this.
>>
>> I'm also wondering what the virtio people have to say. This part is a
>> purely virtio specific thing. And since none of the existing virtio
>> drivers processes the request to reset the device, it is not clear what
>> is the best way to proceed here. For this reason, the most
>> straightforward and simple solution was chosen.
> 
> What is this "reset" actually supposed to do?  Reconfguring
> everything, or changing only certain parameters, devices, whatever?

It means bringing this particular device to its initial state.

After that, the driver can re-read the configurations from the device
and reconfigure everything.


> thanks,
> 
> Takashi
> 

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

