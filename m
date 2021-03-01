Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB955327EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhCANGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhCANG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:06:29 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A8DC061788;
        Mon,  1 Mar 2021 05:05:48 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id v9so7582352lfa.1;
        Mon, 01 Mar 2021 05:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nEbtpOKYE7+5hAy4ITICBI8TnPiKOrdU/xDpwnt+5wU=;
        b=qgedUhePHbOW87063BXIpA8rqjWv9j5JaX7GcEb/+fFWPFSrXA8Qv9lbCWu8OzxpfG
         z9ao/362YbjSLw9XhMqM00WyeXPOpnHNxDG0kbeFVG+o4SDWFcJzVyVSUxX67GcWRzF4
         xCb/XAwPqANVLhbO8pwjgvafReQ5gMyHBtT6dGvOYExiAOIvyCrkLQWf3zbJbNiE+hGD
         n9IXbBPQ6VYsSLIL8dmowWx5ZQ4d4B1No2wLn6nC4e1FDxAmUC+4aagKqybyY8K5I8y5
         T23JJiUGwYBaA4uZDud4UG9gnDgOfS7uZCt7EGGc4y1T4tnGTDwNaAtSlhxqj7DcFvpM
         pSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nEbtpOKYE7+5hAy4ITICBI8TnPiKOrdU/xDpwnt+5wU=;
        b=YIlLrcYGVDlhR4gKj/Xs/Q1sUih+eKq4XYS5qaCFLbStLQ4/SpbJT09T4F1FoG6izJ
         mbmkBXjJPVS2vtVGgFLCbiDrTVQDfQhcUdUEYS1/9F4ldZlk6KXyiiQHqGrRzkBvN3Ee
         l03oFMqMGlb9auAW5VR7iRMmDmnSJG3KKajig4VMCVvO7VUZy9Gw0214i3RPyhSYfNgc
         iaAv7IXLRzoqaFCvkjqiY0b+4SdsYBvfu8asw7MNUu6RUgZM6N4h089HR9KPp3rv9t+p
         0ZesNHeLS1fkQiX1Im/dfVTxcgyX8bIPYg+gJr2B/JFxvFmN0KzyCq4wy63ixXS41+Px
         luxQ==
X-Gm-Message-State: AOAM532W0JuVgN0VulR6iV72k+cbLuHyGQPf0P3kxv1bbfG90vRPjVTa
        YG2eJCfrSjd6gKFsM7kUEnZ4GQiieSyBu8IO
X-Google-Smtp-Source: ABdhPJwLzQIf0IhH3hMlGo72mZgLdmmspQwbzJBm9vWqBVRYE/yACiPFSvj3o7y27sEh8cI7DOMQ7A==
X-Received: by 2002:a05:6512:1053:: with SMTP id c19mr9185299lfb.518.1614603946889;
        Mon, 01 Mar 2021 05:05:46 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id c16sm2278812lfb.302.2021.03.01.05.05.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 05:05:45 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     gschmottlach@gmail.com, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] USB Audio Gadget part 2: Feedback endpoint, Volume/Mute support
Date:   Mon,  1 Mar 2021 15:05:35 +0200
Message-Id: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is extendend version of "UAC2 Feedback endpoint" patch set
I've sent back in 2020 [1]. It is extended with
bi-directional Volume/Mute controls support for both UAC1
and UAC2 gadgets.

It fixes issues with enumeration in various operation systems
because of Feedback endpoint implementation, yet also adds
new Volume/Mute support which allows developers to control
UAC1/2 Gadget's Volume/Mute from the Host and in the same way
UAC1/2 Gadget can control Volume/Mute of the Host making it
closer to a real USB Audio card.

This patch set should be applied on top of USB Audio Gadget
part 1 fixes/improvements that I've sent previously to the
mailing list [2]

============ UAC2 Feedback Endpoint support ============

Current UAC2 gadget implements capture/sync paths
as two USB ISO ASYNC endpoints (IN and OUT).

This violates USB spec which says that ISO ASYNC OUT endpoint
should have feedback companion endpoint.
See USB2.0 spec  "5.12.4.1 Synchronization Type": asynchronous
sink provides explicit feedback (isochronous pipe).
Interesting that for ISO ASYNC *IN* endpoint respective
feedback isn't required since source provides implicit
feedforward (data stream).

While it's not an issue if UAC2 Gadget is connected to
Linux host (Linux ignores missing feedback endpoint),
with other hosts like Windows or MacOS the UAC2 Gadget
isn't enumerated due to missing feedback endpoint.

This patch series adds feedback endpoint support to
UAC2 function, new control to UAC2 mixer which can
be used by userspace tools (like alsaloop from alsa-utils)
for updating feedback frequency reported to the host.
This is useful for usecases when UAC2 Gadget's audio
samples are played to another codec or audio card
with its own internal freerunning clock so host can
be notified that more/less samples are required.

The alsaloop tool requires some (relatively small)
modifications in order to start support driving
feedback frequency through UAC2 mixer control.
That change have been sent as a separate patch
to ALSA community [3].

Also added ability to switch ISO ASYNC OUT endpoint into
adaptive endpoint which doesn't require feedback endpoint
(as per USB spec).

======== UAC1/2 Volume/Mute controls support ==========

Volume and Mute controls are traditionally presented in
USB Audio cards that are available on the market,
and Hosts usually expect they exist in the attached devices.

However, Linux UAC gadget previosly didn't have such
functinality which (depending on Host's operation system)
was causing different behaviour: Linux hosts (usually) in
this case can adjust volume by changing audio sample's
amplitude that are sent to the gadget. Other hosts may
stuck with maximum volume and can't adjust it for the
Linux UAC gadget device.

Volume/Mute controls support is quite useful feature.
If implemented according to UAC1/2 spec, it allows to
control volume in both directions: from the Host to Gadget
and from Gadget to the Host. To do it, it's required to add
new Feature Unit descriptor to existing UAC1/2 Gadget
topology and add new interrupt endpoint so Volume/Mute
changes can be reported to the Host.

This has been tested with Linux/MacOS/Windows(7,10) hosts,
by attaching alsamixer to the UAC1/2 ALSA card on Gadget
side, and using available Volume/Mute control applications
on the Hosts.

An user can adjust Volume/Mute on the Host and see respective
changes on the Gadget side. In the same way, an user can adjust
Volume/Mute on the Gadget side and observe respective changes
on the Host

There is a known issue with Win7 which for some reason doesn't
poll UAC1 interrupt endpoint causing Volume/Mute control not
working in Gadget->Host direction

========================================================

Both features have been tested on BeagleBone Black and
Raspberry PI 4 boards with Linux/MacOS/Windows(7,10) hosts.

While on BeagleBone Black it works fine, Raspberry PI 4 DWC2
controller is affected by the DMA issue for control trasfers
which I reported a while back in [4]. It is causing incorrect
data provided by DWC2 UDC to UAC1/2 gadgets screwing up
volume and mute control messages in the Host->Gadget direction.
The hack is available (see [4]) but it leads to traces/issues
with audio streaming.

Patches reviews and testing on your HW is welcome as usual!

[1] https://lore.kernel.org/linux-usb/1604794711-8661-1-git-send-email-ruslan.bilovol@gmail.com/
[2] https://lore.kernel.org/linux-usb/1614599375-8803-1-git-send-email-ruslan.bilovol@gmail.com/
[3] https://lore.kernel.org/linux-usb/1605220482-28487-1-git-send-email-ruslan.bilovol@gmail.com/
[4] https://lore.kernel.org/linux-usb/CAB=otbTVxa=nGWF4K1AYcYyPceYYRkC_1HYSb_Nhu6C9RMZEHA@mail.gmail.com/

Ruslan Bilovol (8):
  usb: gadget: u_audio: convert to strscpy
  usb: gadget: f_uac2/u_audio: add feedback endpoint support
  usb: gadget: f_uac2: add adaptive sync support for capture
  usb: gadget: u_audio: add real feedback implementation
  usb: audio-v2: add ability to define feature unit descriptor
  usb: gadget: u_audio: add bi-directional volume and mute support
  usb: gadget: f_uac2: add volume and mute support
  usb: gadget: f_uac1: add volume and mute support

 Documentation/ABI/testing/configfs-usb-gadget-uac1 |  10 +
 Documentation/ABI/testing/configfs-usb-gadget-uac2 |  11 +
 Documentation/usb/gadget-testing.rst               |  37 +-
 drivers/usb/gadget/function/f_uac1.c               | 674 +++++++++++++++++-
 drivers/usb/gadget/function/f_uac2.c               | 764 +++++++++++++++++++--
 drivers/usb/gadget/function/u_audio.c              | 582 +++++++++++++++-
 drivers/usb/gadget/function/u_audio.h              |  32 +
 drivers/usb/gadget/function/u_uac1.h               |  20 +
 drivers/usb/gadget/function/u_uac2.h               |  23 +
 include/linux/usb/audio-v2.h                       |  14 +
 10 files changed, 2069 insertions(+), 98 deletions(-)

-- 
1.9.1

