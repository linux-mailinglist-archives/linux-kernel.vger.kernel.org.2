Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90EC4110D5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhITIU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235656AbhITIUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632125923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9hrk8C5FhsHt5Uf0cc3rsa2fa6Qte6s+4CwcCsttTk=;
        b=WGzpwQZjY5FtAy7SiwnMp2XUGPXjybFc1bN6HPRwbEVJguv/WFSXad/QVdwnxVm06cJHg6
        SmqWs2Sg5sliiduu5JApUzrx5ekwJ/55DGsg0kEP8UMCqhJT5MPddGClzjpEPNJ49K5JOu
        b1aY5rDHe8zQi1JVEIH70KpcnaPFFEc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-eVjxxwCVOl2U0L5bCtTTlQ-1; Mon, 20 Sep 2021 04:18:42 -0400
X-MC-Unique: eVjxxwCVOl2U0L5bCtTTlQ-1
Received: by mail-ed1-f71.google.com with SMTP id n5-20020a05640206c500b003cf53f7cef2so12163768edy.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M9hrk8C5FhsHt5Uf0cc3rsa2fa6Qte6s+4CwcCsttTk=;
        b=F6pGGSA/1+D/qadLWsWf06ltKmhkF9b9QbIhdR7P6g2QZyy5sHGbVirD/EtWWX4BRz
         6gx9CRYROH7MHVnqchf2qMqgXa4A01LwqZ90qwV6SGeoWBSOan7FR8avQGlzW/cGehL5
         /L75HY9s46lLn69T87g1iiNzM5UvDAL8eJ7iS/w7Kt8LDs1I773FVJW9ZFPa1NmKcrRO
         vSqus1KMU5vQ6x89cP7B1v+R0T/EwzHCivBi6T/nyOn3xSHTYCF79hmPGkdnp8wDTAAy
         OHKWWGVXNLTXhw1rb34xFb/DjhmEhFq9cmCFFGFWA1Hf3oADAYCat8C6owpesDUskTgA
         N7WQ==
X-Gm-Message-State: AOAM530bBwIkVsQCaub8DGVuO2i6h7Ls1eL03JO6EKysZI2erreDHbRX
        BUcrmJriJvzBfkV9yDTTAxGR0g1job1dgvJctNhVuXJueSwKnwmVqxqz9q+q/EAFHa07dspTEmX
        euzY6iOiJRgkGU6C902OY9XUT1lEYK7uK0CAlUaNltkKEHQ1fQREO1Z5DaFy9fEVPQLbrjNWFaF
        HR
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr5399844eji.434.1632125920527;
        Mon, 20 Sep 2021 01:18:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlErPDM1q4odTH/S6aensyrOxrk/2YSOq07b4Qv9xcGbmhn4P5ePtx1PcicybeKegkqz7TKA==
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr5399821eji.434.1632125920274;
        Mon, 20 Sep 2021 01:18:40 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id dj8sm6694564edb.53.2021.09.20.01.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 01:18:39 -0700 (PDT)
Subject: Re: [PATCH 0/5] lib: devres: Add managed helpers for write-combine
 setup
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, marcan@marcan.st,
        maz@kernel.org, akpm@linux-foundation.org, npiggin@gmail.com,
        thunder.leizhen@huawei.com, gregkh@linuxfoundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210916181601.9146-1-tzimmermann@suse.de>
 <9e5e73d1-bb7b-055f-8c48-a877a2e9c0fd@redhat.com>
 <70962c8d-ba1a-8c68-b509-393b6a2ecdca@suse.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d465f057-cb5e-4913-fdce-41d4c1ed99ca@redhat.com>
Date:   Mon, 20 Sep 2021 10:18:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <70962c8d-ba1a-8c68-b509-393b6a2ecdca@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/20/21 10:01 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 17.09.21 um 16:47 schrieb Hans de Goede:
>> Hi,
>>
>> On 9/16/21 8:15 PM, Thomas Zimmermann wrote:
>>> Add devm_arch_phys_wc_add() and devm_arch_io_reserve_memtype_wc() for
>>> automatic cleanup of writecombine setup.
>>>
>>> Several DRM drivers use the non-managed functions for setting their
>>> framebuffer memory to write-combine access. Convert ast, mgag200 and
>>> vboxvideo. Remove rsp clean-up code form drivers.
>>>
>>> Tested on mgag200 hardware.
>>>
>>> Thomas Zimmermann (5):
>>>    lib: devres: Add managed arch_phys_wc_add()
>>>    lib: devres: Add managed arch_io_reserve_memtype_wc()
>>>    drm/ast: Use managed interfaces for framebuffer write combining
>>>    drm/mgag200: Use managed interfaces for framebuffer write combining
>>>    drm/vboxvideo: Use managed interfaces for framebuffer write combining
>>
>> Thanks, the entire series looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> For the series.
> 
> Thanks. Let me know if I can review some DRM code for you, as Daniel suggested.

Thank you for the offer, ATM I don't have anything queued up in need of review,
but I will probably make use of your offer in the future :)
Regards,

Hans

