Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E364139C123
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFDUUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230022AbhFDUUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622837912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5AKmMvs/+u+KfG4w0sgMq72rTrYGw3m3QsVKTiR88GI=;
        b=ILxnhBpeqErANr7Ed/lNPMXZjUPAkPpvx4R6Pn+0w4025wBQHGdixlP7z0XHKTJ8UJDlQY
        +3HwwTjgv/6nqiB8FrjwCVnT4Fxq9BWYyZZzMbT+CyRmwupekS2H4FsEIqzZT1slxa99Rv
        KKJX5zfaAtOIpNVI05DZrF1yf3C0UhQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-JDFeHUxyNxu7TvqmUxysXw-1; Fri, 04 Jun 2021 16:18:31 -0400
X-MC-Unique: JDFeHUxyNxu7TvqmUxysXw-1
Received: by mail-ej1-f71.google.com with SMTP id gv42-20020a1709072beab02903eab8e33118so3933127ejc.19
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 13:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5AKmMvs/+u+KfG4w0sgMq72rTrYGw3m3QsVKTiR88GI=;
        b=qOf8QpL91Xcv8BdtvPSCsxc9V6dmxu/eEsEaE37dnEjWpHmH9vwxqWGOWwT2L0LHQ/
         8qly7MXcGDMA3S6J4DFhz65l9ONCofz969wHDm+QX/j+Q2fKa1iItUTa+GmF/mxQ6vm9
         NCLhl5UBM/DLgy/zZMntdZEBgcj7qhdRf0k452O+C7VCCql915BiH9ezmNdvTwz6fFfL
         z+D8ZwrhzkXgBLgwryhWIjWo1N+cM0LTrZzyfcNPSmMYMGryPja2Fwzc2PUAea86ibMP
         phVmEgC3G7JAIsozw+Tphb7hNEqknv8ntDrD3Fd4+8xSmdnrTtr7mR4EihlBSk/ILv6A
         +X/w==
X-Gm-Message-State: AOAM532KlORoVnJQTl1XjcqWPuAwNpXPUeHNzIZ4EG9FrQtJ3bROLrcx
        9f4fE9GrEdAlQsYNWoQCL6zt+5eb26/5sZKIztl5Z51On8LA1E3Ze63YEh70+5Pil3wg9E/i0+L
        Drysb4dV5gyrep6c1j3/vcDF+lPZo20fuJeiJiUNU1I0EYHacjvFjw7rLJ6P1k36e0Q7iA6OUoU
        LF
X-Received: by 2002:a50:ff16:: with SMTP id a22mr6567836edu.143.1622837910301;
        Fri, 04 Jun 2021 13:18:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCx0UwSGeTDQBAxTrW9bb/PWjt5dWgr8p5xE9YiOELsB4eVir6D7JeJmh50FPnZNFBhqg0Gw==
X-Received: by 2002:a50:ff16:: with SMTP id a22mr6567816edu.143.1622837910074;
        Fri, 04 Jun 2021 13:18:30 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q26sm3182397ejc.3.2021.06.04.13.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 13:18:29 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] platform/surface: aggregator: Extend user-space
 interface for events
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210604134755.535590-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bcbd0067-2df3-998e-0a28-23e599966ec1@redhat.com>
Date:   Fri, 4 Jun 2021 22:18:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604134755.535590-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/4/21 3:47 PM, Maximilian Luz wrote:
> Extend the user-space debug interface so that it can be used to receive
> SSAM events in user-space.
> 
> Version 1 and rationale:
>   https://lore.kernel.org/platform-driver-x86/20210603234526.2503590-1-luzmaximilian@gmail.com/
> 
> Changes in version 2:
>  - PATCH 2/7: Avoid code duplication, remove unused variable
>  - PATCH 4/7: Add missing mutex_destroy() calls
> 
> Maximilian Luz (7):
>   platform/surface: aggregator: Allow registering notifiers without
>     enabling events
>   platform/surface: aggregator: Allow enabling of events without
>     notifiers
>   platform/surface: aggregator: Update copyright
>   platform/surface: aggregator_cdev: Add support for forwarding events
>     to user-space
>   platform/surface: aggregator_cdev: Allow enabling of events from
>     user-space
>   platform/surface: aggregator_cdev: Add lockdep support
>   docs: driver-api: Update Surface Aggregator user-space interface
>     documentation

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I've done one small fixup to patch 2/7, see my reply to that patch.

Once the builders have had some time to test this branch the patches there
will be added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
>  .../surface_aggregator/clients/cdev.rst       | 127 ++++-
>  .../userspace-api/ioctl/ioctl-number.rst      |   2 +-
>  drivers/platform/surface/aggregator/Kconfig   |   2 +-
>  drivers/platform/surface/aggregator/Makefile  |   2 +-
>  drivers/platform/surface/aggregator/bus.c     |   2 +-
>  drivers/platform/surface/aggregator/bus.h     |   2 +-
>  .../platform/surface/aggregator/controller.c  | 332 +++++++++--
>  .../platform/surface/aggregator/controller.h  |   2 +-
>  drivers/platform/surface/aggregator/core.c    |   2 +-
>  .../platform/surface/aggregator/ssh_msgb.h    |   2 +-
>  .../surface/aggregator/ssh_packet_layer.c     |   2 +-
>  .../surface/aggregator/ssh_packet_layer.h     |   2 +-
>  .../platform/surface/aggregator/ssh_parser.c  |   2 +-
>  .../platform/surface/aggregator/ssh_parser.h  |   2 +-
>  .../surface/aggregator/ssh_request_layer.c    |   2 +-
>  .../surface/aggregator/ssh_request_layer.h    |   2 +-
>  drivers/platform/surface/aggregator/trace.h   |   2 +-
>  .../surface/surface_aggregator_cdev.c         | 534 +++++++++++++++++-
>  include/linux/surface_aggregator/controller.h |  27 +-
>  include/linux/surface_aggregator/device.h     |   2 +-
>  include/linux/surface_aggregator/serial_hub.h |   2 +-
>  include/uapi/linux/surface_aggregator/cdev.h  |  73 ++-
>  22 files changed, 1018 insertions(+), 109 deletions(-)
> 

