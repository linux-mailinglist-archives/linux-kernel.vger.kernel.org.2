Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EC93DA288
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbhG2LyT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jul 2021 07:54:19 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58842 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhG2LyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 07:54:18 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id EE60DCED16;
        Thu, 29 Jul 2021 13:54:13 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_h5: add WAKEUP_DISABLE flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJQfnxFikFjkGn6_+n=ycH4byzTMWY51C=+VJOycg_ZXmg=qqA@mail.gmail.com>
Date:   Thu, 29 Jul 2021 13:54:13 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F610BDE8-CC34-4665-91D8-C32EDFD73F75@holtmann.org>
References: <20210715225146.v2.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
 <57AE120A-78AE-4990-8D7F-BA8D8077B610@holtmann.org>
 <CAJQfnxFzj9m43wntnb2gvXkJS6B5+aQGsu7v6hc4H4ktAopk7g@mail.gmail.com>
 <A2D33DB0-40DD-4F14-BFB9-9FB34DB003A8@holtmann.org>
 <CAJQfnxFikFjkGn6_+n=ycH4byzTMWY51C=+VJOycg_ZXmg=qqA@mail.gmail.com>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Archie,

>>>>> Some RTL chips resets the FW on suspend, so wakeup is disabled on
>>>>> those chips. This patch introduces this WAKEUP_DISABLE flag so that
>>>>> chips that doesn't reset FW on suspend can leave the flag unset and
>>>>> is allowed to wake the host.
>>>>> 
>>>>> This patch also left RTL8822 WAKEUP_DISABLE flag unset, therefore
>>>>> allowing it to wake the host, and preventing reprobing on resume.
>>>>> 
>>>>> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
>>>>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>>>>> Reviewed-by: Hilda Wu <hildawu@realtek.com>
>>>>> 
>>>>> ---
>>>>> 
>>>>> Changes in v2:
>>>>> * Remove unnecessary variable
>>>>> 
>>>>> drivers/bluetooth/hci_h5.c | 83 +++++++++++++++++++++++++++-----------
>>>>> 1 file changed, 59 insertions(+), 24 deletions(-)
>>>> 
>>>> so the set does not apply cleanly to bluetooth-next
>>>> 
>>>> Applying: Bluetooth: hci_h5: Add runtime suspend
>>>> error: patch failed: drivers/bluetooth/hci_h5.c:11
>>>> error: drivers/bluetooth/hci_h5.c: patch does not apply
>>> 
>>> Hmm, it applies cleanly for me. Not sure what's going on.
>>> Anyway I rebased and made a little change as v3, please take a look!
>> 
>> the v3 applied cleanly.
>> 
>>>> 
>>>> 
>>>> And I am really close to not accepting any patches for hci_h5.c anymore. This thing turns into crazy hacking and nobody is taking my hint to redo this as clean H:5 3-Wire serdev standalone driver.
>>> 
>>> Pardon my unfamiliarity, but could you share more about your vision of
>>> a clean h5 driver? Should the RTL component be moved out to btrtl?
>>> Do we have something as a reference?
>> 
>> so a while back I send a bt3wire.c sample driver around. That would be a good starting point.
>> 
>> Anyhow, the problem is that hci_uart.ko is inherent a line discipline driver from 2.4.x kernel days and it has been stacked and hacked on top of it. It has become a burden, especially in the light that you can have clean serdev based drivers now (like btmtkuart.c).
>> 
>> And yes, it would be following the 3-Wire H:5 spec and then deal with vendor specific details like btusb.c for example. And my hope would be that especially in the Realtek and Broadcom (RPi3 etc.) cases this can move into vendor specific blocks and shared between USB and UART transports.
>> 
>> I also send around a btuart.c sample driver that is solely serdev based and should replace all the cases where we have H:4 as transport.
>> 
> 
> Thanks for the pointers!
> 
> The files you mentioned are rather hard to find, so below I paste the
> URL where I found them in case anyone else is also interested.
> 
> [RFC v2] Bluetooth: Add new serdev based driver for UART attached controllers
> https://www.spinics.net/lists/linux-bluetooth/msg74918.html
> 
> [RFC] Bluetooth: Add new serdev based driver for 3-Wire attached controllers
> https://www.spinics.net/lists/linux-bluetooth/msg74839.html

exactly these. I posted my initial work so that it can be continued by people with easier access to hardware.

Regards

Marcel

