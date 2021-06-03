Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1109539AECE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhFCXrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCXro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:47:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C54BC06174A;
        Thu,  3 Jun 2021 16:45:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f20so123910wmg.0;
        Thu, 03 Jun 2021 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3CgvK6mP0QW9sFdMKMBwLGrltbNn3STDZujxPwSb3s0=;
        b=toQvauYIYaxK+64eW0m/teo1WO7qG+E6rvyBjOo2/RsBhhRaKvtVwcsl60yfYr+1+C
         Wv1hk3d8ezwhdH1VDu0egjpyUk/Is0EQwXmnN2xaceWcC5k8AJCKQkAa7JV3zD5dKoxd
         baeU6vjw+BL0zTr3vaobJ+G8IzibFoVc0iBsE1RslaE1r8K00LyFnHp846rEjwWJVDeZ
         jJ81ZKPYGmNQhF+B4GPsnDyq9ulxlaE9ibrNtVAY7fiAa3MNe7D3KV6Zh2KdqWeUU84T
         ultGwZGoclirp6nrL3Qh1p+zCuTOXU3JWvT7iG8zu8zXBMEvhTtgpr6jFOOBIPCRTSU9
         VXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3CgvK6mP0QW9sFdMKMBwLGrltbNn3STDZujxPwSb3s0=;
        b=YW9SxOR4W1mVJkGjc9OO/RI12yIrrM1bTmfw97ofKzf3yLV1WDlBrLxjWM8bjiFtI6
         o93kqK9KBh5OmRugPdZrswpFBMHY/ra2ZeOZyBnwyTfLpj9mFPwpiYeXaiM1oBv3rWjO
         ZV6S+ohN1jRB0bfXBpBjwzFi6UHrze+F7GKZxBUWgkAI/XHxNUWl+cISKa2vbf9mt2rY
         U+oFcb2KdLi5+65BMihBWNjjR2Q+roWgbp2SsAGjka6MikNM4LYujrvl57D2YayEUPzy
         ccLaijDfo7ayilJ5idnD4AnB+EowZjLRxWDfaCt/sDxjsEbxtgmQ+pFRkGfMz0oRngTO
         wHKg==
X-Gm-Message-State: AOAM533VHzlepbazBnboMrFb5FRG1/eZAVnNP1H7TU02lWr43zeK0R3U
        LFSBLwzJTZ8+jcTsQOvYodk=
X-Google-Smtp-Source: ABdhPJyfVdmAt9flIwqHJTXh5UV7De7hWH7rXeVmiO7dO7Dz0uJzG8X0y2hGWz8ChBS1YUTdW0fI/Q==
X-Received: by 2002:a1c:e915:: with SMTP id q21mr772896wmc.110.1622763942808;
        Thu, 03 Jun 2021 16:45:42 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id a11sm4743386wrr.48.2021.06.03.16.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 16:45:42 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] platform/surface: aggregator: Extend user-space interface for events
Date:   Fri,  4 Jun 2021 01:45:19 +0200
Message-Id: <20210603234526.2503590-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the user-space debug interface so that it can be used to receive
SSAM events in user-space.

Currently, inspecting SSAM events requires writing a custom client
device and corresponding driver. This is not particularly user-friendly
for quick testing and comes with higher iteration times. Since we
already have a user-space interface, we can extend this to forward
events from SSAM via the controller device file to user-space. With this
we can then essentially write user-space SSAM clients for testing and
reverse-engineering, providing us with all the essential functionality
that previously only a kernel driver would have access to. Note that
this is still only intended to be an interface for debugging and
reverse-engineering purposes.

To achieve this, we need to extend the core to decouple events from
notifiers. Right now, enabling an event group requires registering a
notifier for that group. This notifier provides a callback that is
called when the event occurs. For user-space forwarding, we need to run
all events through the same file. In the current implementation, this
presents a problem as, when we don't know the exact events or can't
filter for them, multiple notifiers for the same target category will
lead to duplicate events to be sent through the file, one per notifier.

Decoupling notifier registration from event enable-/disablement (and the
corresponding reference counting) allows us to avoid this issue. We can
then register one notifier for a whole target category and enable or
disable events independently of this notifier. Since events are strictly
separated by their target category, this will not lead to duplicate
events.

With this, we can then provide user-space with two new IOCTLs for
registering notifiers for a specific target category of events they are
interested in. This allows us to forward all events received by those
notifiers to the internal buffer of the device file, from which they can
be read by user-space. In other words, user-space can, via those two
IOCTLs, select which event target categories they are interested in.

Furthermore, we add another two IOCTLs for enabling and disabling events
via the controller. While events can already be enabled and disabled via
generic requests, this does not respect the controller-internal
reference counting mechanism. Due to that, this can lead to an event
group being disabled even though a kernel-driver has requested it to be
enabled. Or in other words: Without this, a user-space client cannot
safely reset the state as it has only two options, keeping the event
group enabled and not attempt cleanup at all, or disable the event group
for all clients and potentially stop them from working properly.

Also update the copyright lines since we're already doing some work on
the core.

Maximilian Luz (7):
  platform/surface: aggregator: Allow registering notifiers without
    enabling events
  platform/surface: aggregator: Allow enabling of events without
    notifiers
  platform/surface: aggregator: Update copyright
  platform/surface: aggregator_cdev: Add support for forwarding events
    to user-space
  platform/surface: aggregator_cdev: Allow enabling of events from
    user-space
  platform/surface: aggregator_cdev: Add lockdep support
  docs: driver-api: Update Surface Aggregator user-space interface
    documentation

 .../surface_aggregator/clients/cdev.rst       | 127 ++++-
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +-
 drivers/platform/surface/aggregator/Kconfig   |   2 +-
 drivers/platform/surface/aggregator/Makefile  |   2 +-
 drivers/platform/surface/aggregator/bus.c     |   2 +-
 drivers/platform/surface/aggregator/bus.h     |   2 +-
 .../platform/surface/aggregator/controller.c  | 206 ++++++-
 .../platform/surface/aggregator/controller.h  |   2 +-
 drivers/platform/surface/aggregator/core.c    |   2 +-
 .../platform/surface/aggregator/ssh_msgb.h    |   2 +-
 .../surface/aggregator/ssh_packet_layer.c     |   2 +-
 .../surface/aggregator/ssh_packet_layer.h     |   2 +-
 .../platform/surface/aggregator/ssh_parser.c  |   2 +-
 .../platform/surface/aggregator/ssh_parser.h  |   2 +-
 .../surface/aggregator/ssh_request_layer.c    |   2 +-
 .../surface/aggregator/ssh_request_layer.h    |   2 +-
 drivers/platform/surface/aggregator/trace.h   |   2 +-
 .../surface/surface_aggregator_cdev.c         | 531 +++++++++++++++++-
 include/linux/surface_aggregator/controller.h |  27 +-
 include/linux/surface_aggregator/device.h     |   2 +-
 include/linux/surface_aggregator/serial_hub.h |   2 +-
 include/uapi/linux/surface_aggregator/cdev.h  |  73 ++-
 22 files changed, 921 insertions(+), 77 deletions(-)

-- 
2.31.1

