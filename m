Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021D939B81E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhFDLl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230008AbhFDLl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622806810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YNkqwoHmjCetvDz6q0O22+jHsUtoiak49yhC0uQMzAQ=;
        b=NVk35oSZ6Y/OtjnPuDeRLXyO0e41N6uGD+seVpzu8B1V3AZ7ID8J9MSltUo/C/If5uhaM7
        dvkvSv9zqahliDat9QxmCOTlGmCR7u4wA/6sHx9xI5GsbzSLbpnNnKTtTdR4K9KqSWrOEn
        dg6zv5B5n1ehXYnkc4/Wut6kfUzS1VQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-Qe_S5HXPMDuHMuzfsd10Iw-1; Fri, 04 Jun 2021 07:40:09 -0400
X-MC-Unique: Qe_S5HXPMDuHMuzfsd10Iw-1
Received: by mail-ed1-f69.google.com with SMTP id c24-20020aa7c7580000b029038fd7468047so4823123eds.20
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 04:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YNkqwoHmjCetvDz6q0O22+jHsUtoiak49yhC0uQMzAQ=;
        b=Nbod05ejHkvm6ZZkEVNyJfAGeh+SuK33MQpTBDPAJY8mJSXgcdxIKnRGnBkAUV4C1X
         IdmM5skFg7OtCnj83uevqK080Y/N8pUhhrthQLAuEaiIM4kb+H00P7IIl+kC0JXWBM7U
         nEhRYF8AjupDOWu6JmIT7TQJigpKTozIErtpd/O2K+f0Zmt6W83BQHuXp6H0go5CC9A1
         UA8fssgfYG7XKc1Lq56KwMGSGL81cdeF7gNv7CZChfFmBMGXtKNLLL8/50Y3a3cYvhHu
         xPrp63W5mlW7lGA6VYDImzDbypRmxTp6z1+TMTf9xOIwB8YGHhrFxNAY2IpPPMYas0Ba
         Zlhg==
X-Gm-Message-State: AOAM533blAlxnA8j8mpFyN02Fh3C6SS7Khs2SC+dZpP7N1/+cAXR4ktO
        9IYtL8VO3xoUO3UZRri7qne4duqcieCEO6qegrTdYO2S37priZP6Y3/RRSsSeJ8oElOlfO2En6E
        SKVjn392TOZjuEvXvYGHokQy6bqgwJ5XRZnwMLqjZ1ryhxVRPiVZf35ZAeafwvlUtG6KVYKSRRs
        eU
X-Received: by 2002:a17:906:2892:: with SMTP id o18mr3668873ejd.124.1622806807744;
        Fri, 04 Jun 2021 04:40:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEz9sb6DS0Q6mlqeeAcYXa4WfwbrCCbzzk0TTRJqfgzB90gXvxTCGq4flqZ7kMMHhlezFk6A==
X-Received: by 2002:a17:906:2892:: with SMTP id o18mr3668856ejd.124.1622806807529;
        Fri, 04 Jun 2021 04:40:07 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id oz25sm2664178ejb.48.2021.06.04.04.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 04:40:07 -0700 (PDT)
Subject: Re: [PATCH 0/7] platform/surface: aggregator: Extend user-space
 interface for events
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210603234526.2503590-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c86a976e-64cb-ea10-486e-fa5d4482ad5b@redhat.com>
Date:   Fri, 4 Jun 2021 13:40:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603234526.2503590-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 6/4/21 1:45 AM, Maximilian Luz wrote:
> Extend the user-space debug interface so that it can be used to receive
> SSAM events in user-space.
> 
> Currently, inspecting SSAM events requires writing a custom client
> device and corresponding driver. This is not particularly user-friendly
> for quick testing and comes with higher iteration times. Since we
> already have a user-space interface, we can extend this to forward
> events from SSAM via the controller device file to user-space. With this
> we can then essentially write user-space SSAM clients for testing and
> reverse-engineering, providing us with all the essential functionality
> that previously only a kernel driver would have access to. Note that
> this is still only intended to be an interface for debugging and
> reverse-engineering purposes.
> 
> To achieve this, we need to extend the core to decouple events from
> notifiers. Right now, enabling an event group requires registering a
> notifier for that group. This notifier provides a callback that is
> called when the event occurs. For user-space forwarding, we need to run
> all events through the same file. In the current implementation, this
> presents a problem as, when we don't know the exact events or can't
> filter for them, multiple notifiers for the same target category will
> lead to duplicate events to be sent through the file, one per notifier.
> 
> Decoupling notifier registration from event enable-/disablement (and the
> corresponding reference counting) allows us to avoid this issue. We can
> then register one notifier for a whole target category and enable or
> disable events independently of this notifier. Since events are strictly
> separated by their target category, this will not lead to duplicate
> events.
> 
> With this, we can then provide user-space with two new IOCTLs for
> registering notifiers for a specific target category of events they are
> interested in. This allows us to forward all events received by those
> notifiers to the internal buffer of the device file, from which they can
> be read by user-space. In other words, user-space can, via those two
> IOCTLs, select which event target categories they are interested in.
> 
> Furthermore, we add another two IOCTLs for enabling and disabling events
> via the controller. While events can already be enabled and disabled via
> generic requests, this does not respect the controller-internal
> reference counting mechanism. Due to that, this can lead to an event
> group being disabled even though a kernel-driver has requested it to be
> enabled. Or in other words: Without this, a user-space client cannot
> safely reset the state as it has only two options, keeping the event
> group enabled and not attempt cleanup at all, or disable the event group
> for all clients and potentially stop them from working properly.
> 
> Also update the copyright lines since we're already doing some work on
> the core.

Overall this series looks good to me. I've found one small issue with
PATCH 4/7 (see my reply to that patch) and as the kernel test robot
pointed out there is an used "struct ssam_nf_head *nf_head;" in
PATCH 2/7.

With these 2 small issues fixed you can add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

to v2 of the series.

Regards,

Hans



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
> 
>  .../surface_aggregator/clients/cdev.rst       | 127 ++++-
>  .../userspace-api/ioctl/ioctl-number.rst      |   2 +-
>  drivers/platform/surface/aggregator/Kconfig   |   2 +-
>  drivers/platform/surface/aggregator/Makefile  |   2 +-
>  drivers/platform/surface/aggregator/bus.c     |   2 +-
>  drivers/platform/surface/aggregator/bus.h     |   2 +-
>  .../platform/surface/aggregator/controller.c  | 206 ++++++-
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
>  .../surface/surface_aggregator_cdev.c         | 531 +++++++++++++++++-
>  include/linux/surface_aggregator/controller.h |  27 +-
>  include/linux/surface_aggregator/device.h     |   2 +-
>  include/linux/surface_aggregator/serial_hub.h |   2 +-
>  include/uapi/linux/surface_aggregator/cdev.h  |  73 ++-
>  22 files changed, 921 insertions(+), 77 deletions(-)
> 

