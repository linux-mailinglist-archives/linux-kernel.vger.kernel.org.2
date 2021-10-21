Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709C7436A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhJUSgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232041AbhJUSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634841227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R8NRWj30fOIwdXURO/nuW9fLSSQ/mcQoafJ2KYOfKWQ=;
        b=ZOgyUUau73mGj6K42kSY4lgpuM7t2tO71fufgxJ76KvV3tVme55YDN3fl246WL1hC6F+yG
        2wKOqVqLGuuJ3oB/P98Wa7rB/9uG2VNtQiHTDsIi7Fd7lBILnHJJ//Ps5N2jaQXN/oRUzl
        iElO1frac4CmdOPaYvU/OKe+nVC0r5Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-NP6zfdehN1yEQtEIzbyDww-1; Thu, 21 Oct 2021 14:33:46 -0400
X-MC-Unique: NP6zfdehN1yEQtEIzbyDww-1
Received: by mail-ed1-f70.google.com with SMTP id p20-20020a50cd94000000b003db23619472so1225891edi.19
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 11:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R8NRWj30fOIwdXURO/nuW9fLSSQ/mcQoafJ2KYOfKWQ=;
        b=Qt3y6o46C3rgNmnWlW+9h+hUSvdI0QxRgMH0SMDXy86LJ4jkBgKG3yiAMbLEpVfHVe
         WAO5kkFZjgVZ577h33vJ3+FWyOZ0cSx1OqmNpstv0CiFyYk5lFjeSyjUZjNnKeqFWppk
         r5bIoMqfuHrF45CzdG6QU/6pTIrchxI4XhEeMvSXHwaIKM+VU/RbkyxNslM6Xx2L2ZV1
         GuJi3DBkQTvJfi3b8BNlRNiVR26F7E+h4RGmVc+5iC40eNx12RpaUM8/A6GE+jb5uy78
         km2NFrsm8U6MhOxXZlKWx9XLggQkGodRk9NoWIUpJhD0R8uv0X14+uHLIjoYC/xDrvfx
         TvnQ==
X-Gm-Message-State: AOAM533SmY1rm1U0FHl2FjJXKk3DJUGmOcpOI9O8e4kjb0KZJU7b35jv
        gnKbk9jIuwsuewFOTBjIxodvxGbA8HJ9A4fFLnPGHEj6UrheZ8noRzWnplU0bhKHmIVDu+X7Pti
        qMu7duquf2u61u165I1DQcSgy
X-Received: by 2002:a17:906:68c2:: with SMTP id y2mr9391433ejr.18.1634841225098;
        Thu, 21 Oct 2021 11:33:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyknNQQUbRgcsCMUK3RfAdm8Suvp8umEPd+1xlwOxyoSPUMx59PDqppM0w9G26bWiWym3jf2g==
X-Received: by 2002:a17:906:68c2:: with SMTP id y2mr9391419ejr.18.1634841224958;
        Thu, 21 Oct 2021 11:33:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z4sm3756571edd.46.2021.10.21.11.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 11:33:44 -0700 (PDT)
Message-ID: <1e99ab2b-c5c3-49c9-18c3-1f103c4dbe85@redhat.com>
Date:   Thu, 21 Oct 2021 20:33:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/3] platform/surface: aggregator: Add support for Surface
 Laptop Studio
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211021130904.862610-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211021130904.862610-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/21/21 15:09, Maximilian Luz wrote:
> This series adds Surface Aggregator Module (SAM) support for the new
> Surface Laptop Studio (SLS).
> 
> This is mostly straight-forward addition of devices to the Surface
> Aggregator registry, but the Surface HID driver needs a couple of small
> changes. Specifically, we need to allow it to probe against SAM devices
> with target ID 1 and also need to use the corresponding registry for
> those.
> 
> I hope it's okay that I've CCed stable to get these included in v5.14+
> stable kernels. The changes are fairly small and enable keyboard and
> touchpad on the SLS. Most other things (except touch) should already
> work well on the latest stable kernels, so back-porting this series
> would make the SLS a usable device on those.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
> Maximilian Luz (3):
>   platform/surface: aggregator_registry: Add support for Surface Laptop
>     Studio
>   HID: surface-hid: Use correct event registry for managing HID events
>   HID: surface-hid: Allow driver matching for target ID 1 devices
> 
>  drivers/hid/surface-hid/surface_hid.c         |  4 +-
>  .../surface/surface_aggregator_registry.c     | 54 +++++++++++++++++++
>  include/linux/surface_aggregator/controller.h |  4 +-
>  3 files changed, 58 insertions(+), 4 deletions(-)
> 

