Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132533348E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhCJUba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:31:30 -0500
Received: from smtp70.ord1c.emailsrvr.com ([108.166.43.70]:38572 "EHLO
        smtp70.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229687AbhCJUbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:31:24 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2021 15:31:23 EST
X-Auth-ID: markh@compro.net
Received: by smtp17.relay.ord1c.emailsrvr.com (Authenticated sender: markh-AT-compro.net) with ESMTPSA id 2735E600FD;
        Wed, 10 Mar 2021 15:24:46 -0500 (EST)
Reply-To: markh@compro.net
Subject: Re: Logitech G602 wireless mouse kernel error messages in 5.10.11+
 kernels
To:     =?UTF-8?Q?Filipe_La=c3=adns?= <lains@archlinux.org>,
        Jiri Kosina <jkosina@suse.cz>, sashal@kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
References: <ac5dde9c-194f-ce40-5c13-2a6890fad6a9@compro.net>
 <bb840ecf8dc626a07b9f00af69b0d561fb60f75b.camel@archlinux.org>
From:   Mark Hounschell <markh@compro.net>
Organization: Compro Computer Svcs.
Message-ID: <8276a207-abe7-06cc-0c25-f4eebf1a9525@compro.net>
Date:   Wed, 10 Mar 2021 15:24:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <bb840ecf8dc626a07b9f00af69b0d561fb60f75b.camel@archlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Classification-ID: 494214d0-accd-474b-8f27-c6eec4513597-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 2:56 PM, Filipe Laíns wrote:
> On Wed, 2021-03-10 at 13:55 -0500, Mark Hounschell wrote:
>> I have been using a Logitech wireless G602 mouse since forever. As of
>> kernel 5.10.11 I get the following kernel messages;
>>
>>
>> $dmesg | grep -i logitech
> (snip)
>> .
>> .
>> .
>> Every mouse event seems to produce another "Unexpected input report
>> number 128" kernel message.
>>
>> The commit that started this is:
>>
>> commit 1e6fc9768ed2c3917e1fd7af26cb194dfe14f7da
>> Author: Filipe LaÃ­ns <lains@archlinux.org>
>> Date:   Mon Jan 4 20:47:17 2021 +0000
>>
>>       HID: logitech-dj: add the G602 receiver
>>
>>       [ Upstream commit e400071a805d6229223a98899e9da8c6233704a1 ]
>>
>>       Tested. The device gets correctly exported to userspace and I can see
>>       mouse and keyboard events.
>>
>>       Signed-off-by: Filipe LaÃ­ns <lains@archlinux.org>
>>       Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>>       Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> The actual patch:
>>
>> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
>> index 1ffcfc9a1e033..45e7e0bdd382b 100644
>> --- a/drivers/hid/hid-logitech-dj.c
>> +++ b/drivers/hid/hid-logitech-dj.c
>> @@ -1869,6 +1869,10 @@ static const struct hid_device_id
>> logi_dj_receivers[] = {
>>             HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>                   0xc531),
>>            .driver_data = recvr_type_gaming_hidpp},
>> +       { /* Logitech G602 receiver (0xc537) */
>> +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>> +               0xc537),
>> +        .driver_data = recvr_type_gaming_hidpp},
>>           { /* Logitech lightspeed receiver (0xc539) */
>>             HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>                   USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1),
>>
>>
>>
>> markh@harley:~> lsusb
>> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>> Bus 003 Device 003: ID 046d:c537 Logitech, Inc.
>> Bus 003 Device 002: ID 0424:2504 Standard Microsystems Corp. USB 2.0 Hub
>> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>>
>>
>>
>> With the patch reverted:
>>
>> $dmesg | grep -i logitech
> (snip)
>>
>> $lsusb
>> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>> Bus 003 Device 003: ID 046d:c537 Logitech, Inc.
>> Bus 003 Device 002: ID 0424:2504 Standard Microsystems Corp. USB 2.0 Hub
>> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>>
>> With or without the patch and error messages the mouse has always worked.
>>
>> Regards
>> Mark
> 
> Yes, sorry about that. The following patch should fix it, can you confirm?
> You probably didn't notice any breakage because you do not have any of your
> buttons bound to keyboard events.
> 
> 
> commit ef07c116d98772952807492bd32a61f5af172a94 (hid/for-5.11/upstream-fixes)
> Author: Filipe Laíns <lains@riseup.net>
> Date:   Fri Feb 5 14:34:44 2021 +0000
> 
>      HID: logitech-dj: add support for keyboard events in eQUAD step 4 Gaming
> 
>      In e400071a805d6229223a98899e9da8c6233704a1 I added support for the
>      receiver that comes with the G602 device, but unfortunately I screwed up
>      during testing and it seems the keyboard events were actually not being
>      sent to userspace.
>      This resulted in keyboard events being broken in userspace, please
>      backport the fix.
> 
>      The receiver uses the normal 0x01 Logitech keyboard report descriptor,
>      as expected, so it is just a matter of flagging it as supported.
> 
>      Reported in
>      https://github.com/libratbag/libratbag/issues/1124
> 
>      Fixes: e400071a805d6 ("HID: logitech-dj: add the G602 receiver")
>      Cc: <stable@vger.kernel.org>
>      Signed-off-by: Filipe Laíns <lains@riseup.net>
>      Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 45e7e0bdd382..fcdc922bc973 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -980,6 +980,7 @@ static void logi_hidpp_recv_queue_notif(struct hid_device
> *hdev,
>          case 0x07:
>                  device_type = "eQUAD step 4 Gaming";
>                  logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
> +               workitem.reports_supported |= STD_KEYBOARD;
>                  break;
>          case 0x08:
>                  device_type = "eQUAD step 4 for gamepads";
> 
> 

That is correct, I don't have any buttons bound to keyboard events. With 
the original patch the G4(forward) and G5(Backward) buttons work in a 
browser. I guess G7, G8, and G9 buttons are programmable to keyboard events?

However this patch does not seem to fix the messages I get.

Regards
Mark
