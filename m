Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7D3334A17
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhCJVso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:48:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231584AbhCJVsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615412901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w4pSXifxbZf42GsDGG2W8WaHn1JUicAeXlApjOr9ArU=;
        b=NkC/NcU9knice259JYGYsA00m+aQpPrTMLViv8zp/sAnY8cS4Yc/R4xGNWF0XAw0kDEExa
        T2CZ5tGx3Ic4SVVC5CDkDQoW71GluNEUuMwRNehZJTH/dSxNIPhh+F3PoVpKyU94npvhjF
        312ZysIK2bkG2ihDeXeYjgLyeGGRU+k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-2MHJ4jqnP8m_QSQL0btWeQ-1; Wed, 10 Mar 2021 16:48:19 -0500
X-MC-Unique: 2MHJ4jqnP8m_QSQL0btWeQ-1
Received: by mail-ej1-f72.google.com with SMTP id si4so7861642ejb.23
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w4pSXifxbZf42GsDGG2W8WaHn1JUicAeXlApjOr9ArU=;
        b=ubSOG1x7Z5JhqW+kxmsbXI6+/btbk7PnJz5SlNsNPZawFFjI+RYHUdPXgcA264hdLL
         UtiMms4huE3DtlfImdyrneTAivqDZd4x8GyCSPuunikUpEYDkknx8hmA8kSHqibVAhal
         16CZccAK0pe7bQpIFkgIx9nZ0TMRzl6/rBhY5khVC0P506hijPS4wuWtwu9MkTAU1PV0
         ww4/YIBS4ky7L7gQfNCgoLAOtd2SkhsMCNseOLmGP7KEleOTJbBayyfle4+k+LY8e9hN
         Nt+ncgpCdp3U1Di1bYA/5LYzqZh1FNrYFqOGT0HRPPBhDok6bmC82skrOFCWMq/T5BfI
         94VQ==
X-Gm-Message-State: AOAM531S+obfYUAwgHOeIoXuXjXdy5Uc1TxWogRWMwRcqV6ZtpudOBAP
        97mGKnkAU+AEhQEq+x9kyEppYibKdaKhQN/+846yiHPKTFzfvkSSuN6cbkbU5OWXuzKuUZehAcq
        rdb0kMd/dsLgpjCQDhZ0DtpiWRMt+qTCkGqdmG8WGe5XPbcQX0dMeto5CLs6PbojtVtNwX13nSL
        fp
X-Received: by 2002:aa7:d296:: with SMTP id w22mr5706841edq.150.1615412897709;
        Wed, 10 Mar 2021 13:48:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLaF+fIankaxxtkX1j/NV5/TWSr4GybaX8Rqb5lL+7Ro9/5j8890v4U/X9CZq+86CuTrZ2Cw==
X-Received: by 2002:aa7:d296:: with SMTP id w22mr5706824edq.150.1615412897534;
        Wed, 10 Mar 2021 13:48:17 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s14sm334946ejf.47.2021.03.10.13.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 13:48:17 -0800 (PST)
Subject: Re: Logitech G602 wireless mouse kernel error messages in 5.10.11+
 kernels
To:     =?UTF-8?Q?Filipe_La=c3=adns?= <lains@archlinux.org>,
        markh@compro.net, Jiri Kosina <jkosina@suse.cz>, sashal@kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
References: <ac5dde9c-194f-ce40-5c13-2a6890fad6a9@compro.net>
 <bb840ecf8dc626a07b9f00af69b0d561fb60f75b.camel@archlinux.org>
 <8276a207-abe7-06cc-0c25-f4eebf1a9525@compro.net>
 <91cda49d4fda10781dc2add8174536cf6b91a527.camel@archlinux.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cb14d9fb-9928-4c62-a087-b1a54202d65a@redhat.com>
Date:   Wed, 10 Mar 2021 22:48:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <91cda49d4fda10781dc2add8174536cf6b91a527.camel@archlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/10/21 9:55 PM, Filipe Laíns wrote:
> On Wed, 2021-03-10 at 15:24 -0500, Mark Hounschell wrote:
>>
>> That is correct, I don't have any buttons bound to keyboard events. With 
>> the original patch the G4(forward) and G5(Backward) buttons work in a 
>> browser. I guess G7, G8, and G9 buttons are programmable to keyboard events?
>>
>> However this patch does not seem to fix the messages I get.
>>
>> Regards
>> Mark
> 
> Those events belong to the USB HID button usage page and are sent by the
> receiver in the HID device with the unnumbered report descriptor, so they are
> not affected.
> 
> Looking at the report descriptor for the other HID device, I see a report ID of
> 128 (0x80) used for a vendor application, I am not really sure what it is used
> for and can't seem to trigger my device to send it.
> 
> I am gonna guess this is the device reporting the pressed buttons via vendor
> reports or something like that. Speaking as the person who added support for
> this device in libratbag, this report is very likely not something that we don't
> need in our custom drivers and just likely something extra that Logitech built
> to achieve something custom in the Windows driver. FWIW, this device is a very
> weird one, it does not even follow Logitech's own spec :P
> 
> Seeing this report the driver chugs.
> 
> 	if (report > REPORT_TYPE_RFREPORT_LAST) {
> 		hid_err(hdev, "Unexpected input report number %d\n", report);
> 		return;
> 	}
> 
> Causing your
> 
> [   36.471326] logitech-djreceiver 0003:046D:C537.0002: Unexpected input report number 128
> [   36.565317] logitech-djreceiver 0003:046D:C537.0002: Unexpected input report number 128
> [   42.390321] logitech-djreceiver 0003:046D:C537.0002: Unexpected input report number 128
> 
> I feel like the correct fix for these cases is not to consume the report and not
> forward it to device node, but rather to forward it to the receiver node.
> 
> (looping in Hans)
> Hans, you introduced this code, do you remember why? Where did
> REPORT_TYPE_RFREPORT_LAST get its value from and what is the purpose of this
> check?
> Shouldn't we just keep forwarding unknown reports to the receiver node? Is there
> any technical limitation to do that? I am not too familiar with this part of the
> code.

The code used by the recvr_type_gaming_hidpp receivers is shared with all the
other non-unifying receivers. Even though these receivers are not unifying the
non gaming versions may still have multiple devices (typically a keyboard + a mouse)
paired with them.

The standard HID interfaces which these devices emulate are usually split in
at least 2 HID interfaces:

1. A keyboard following the requirements of the "boot keyboard" subclass of the
USB HID class, so that the keyboard works inside say the BIOS setup screen.
This uses a single unnumbered HID report

2. A mouse + media-keys interface, which delivers numbered reports, including the
special Logitech HID++ reports for things like battery monitoring, but also some
special keys, which have their own sub-addressing embedded inside the reports.

The driver asks the receiver for a list of paired devices and then builts a list
of devices, which are then instantiated as child-HID devices which are
handled by the drivers/hid/hid-logitech-hidpp.c driver.

Any input reports received by drivers/hid/hid-logitech-dj.c are then forwarded
to the instantiated child devices, where they are actually processed.

The problem is that there is not a 1:1 relation between the interfaces and
the instantiated child-devices, so the driver aggregates all input-reports
from both interfaces together and then dispatches / forwards them to the
child-devices using its own internal addressing.

This forwarding uses 2 different addressing schemes:

1. If the report received is a special HID++ report, then it is forwarded to
paired-dev child-dev matching the HID++ device-index which is embedded
inside these special reports.

2. If a normal (unnumbered or numbered) report is received then that report is
forwarded based on the report-number.  What happens here is that each paired-dev
which the hid-logitech-dj.c code instantiates has a bitmask associated with it
which indicates which kind of reports it consumes. So e.g. a normal mouse will
only consume mouse input-reports (STD_MOUSE, report-id 2) and a keyboard
will consume all of:

#define STD_KEYBOARD                            BIT(1)
#define MULTIMEDIA                              BIT(3)
#define POWER_KEYS                              BIT(4)
#define MEDIA_CENTER                            BIT(8)
#define KBD_LEDS                                BIT(14)

When forwarding these normal (unnumbered or numbered) reports, the list of
paired devices is searched and the report is forwarded to the first paired-dev
which reports_supported bitmask includes the report-nr:

	spin_lock_irqsave(&djrcv_dev->lock, flags);
        for (i = 0; i < (DJ_MAX_PAIRED_DEVICES + DJ_DEVICE_INDEX_MIN); i++) {
                dj_dev = djrcv_dev->paired_dj_devices[i];
                if (dj_dev && (dj_dev->reports_supported & BIT(report))) {
                        logi_dj_recv_forward_report(dj_dev, data, size);
                        spin_unlock_irqrestore(&djrcv_dev->lock, flags);
                        return;
                }
        }

The:

        if (report > REPORT_TYPE_RFREPORT_LAST) {
                hid_err(hdev, "Unexpected input report number %d\n", report);
                return;
        }

check happens before this to ensure that report can be represented
as a bitmask, IOW to ensure that BIT(report) does what we expect it to do,
without any wrapping BIT(128) cannot be represented in a 64 bit integer,
so then we end up with undefined behavior. The result will likely be either
0x00 or 0x01, but it certainly will not do what we want.

I hope that helps explain why the check is there.

As for what to do about the errors, I agree with you that the code which is
logging these errors should check for this new special input-reports with
a report-number of 128 and just silently discard these.

Regards,

Hans

