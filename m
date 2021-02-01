Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6841B30AA2C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhBAOrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhBAOoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:44:23 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF41C061573;
        Mon,  1 Feb 2021 06:43:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A25CA1F4462C
Subject: Re: [PATCH 0/6] usb: typec: and platform/chrome: Add PD revision
 numbers
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Benson Leung <bleung@chromium.org>,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@google.com
References: <20210129061406.2680146-1-bleung@chromium.org>
 <24ec5a79-b457-3025-eb37-623ab20314a6@collabora.com>
Message-ID: <f33a1dcc-40b7-ec14-4e7a-5de0f73e2847@collabora.com>
Date:   Mon, 1 Feb 2021 15:43:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <24ec5a79-b457-3025-eb37-623ab20314a6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 1/2/21 15:37, Enric Balletbo i Serra wrote:
> Hi all,
> 
> On 29/1/21 7:14, Benson Leung wrote:
>> USB Power Delivery has a 3 entity handshake (port, cable, partner), and as
>> of USB PD R3.0, each entity may independently support either Revision 2 or
>> Revision 3 signaling and protocol. In order for userspace and the kernel
>> to properly process the data objects received from a particular SOP*, we
>> must know to which revision of the spec each conforms.
>>
>> This series adds individual version numbers for the partner and the cable,
>> and exposes them in the appropriate sysfs in /sys/class/typec.
>>
>> I provide as a first implementation of this, platform/chrome's cros_ec_typec
>> driver, whose underlying status messages convey the SOP and SOP' revisions
>> already.
>>
>> Thanks,
>> Benson
>>
>> Benson Leung (6):
>>   usb: typec: Standardize PD Revision format with Type-C Revision
>>   usb: typec: Provide PD Specification Revision for cable and partner
>>   usb: typec: Add typec_partner_set_pd_revision
>>   platform/chrome: cros_ec_typec: Report SOP' PD revision from status
>>   platform/chrome: cros_ec_typec: Set Partner PD revision from status
>>   platform/chrome: cros_ec_typec: Set opmode to PD on SOP connected
>>
> 
> I acked the above chrome/platform patches in case Greg wants to pick up the full
> series through his usb tree, I think is what makes more sense. They look good to
> me from the chrome/platform side.
> 

Sorry, just noticed that the platform/chrome patches depends on some patches
that we have already queued for 5.12. So we will pick up these patches and take
care to not merge before the specific usb type-c bits. So forget about the above.

Thanks,
 Enric


> Thanks,
>   Enric
> 
>>  Documentation/ABI/testing/sysfs-class-typec | 20 ++++++-
>>  drivers/platform/chrome/cros_ec_typec.c     | 26 +++++++--
>>  drivers/usb/typec/class.c                   | 59 +++++++++++++++++++--
>>  include/linux/usb/typec.h                   | 11 ++++
>>  4 files changed, 108 insertions(+), 8 deletions(-)
>>
