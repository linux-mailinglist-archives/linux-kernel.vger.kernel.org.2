Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1943E03AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbhHDOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:49:06 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46440 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhHDOtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:49:04 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 80392CECD6;
        Wed,  4 Aug 2021 16:48:50 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v5 1/2] Bluetooth: btusb: Record debug log for Mediatek
 Chip.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210804090316.12080-1-mark-yw.chen@mediatek.com>
Date:   Wed, 4 Aug 2021 16:48:50 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, chris.lu@mediatek.com,
        will-cy.lee@mediatek.com, Sean Wang <sean.wang@mediatek.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Michael Sun <michaelfsun@google.com>, shawnku@google.com,
        jemele@google.com, apusaka@google.com, mcchou@chromium.org
Content-Transfer-Encoding: 7bit
Message-Id: <8988B918-95FD-42DE-95FA-3BAC4A144165@holtmann.org>
References: <20210804090316.12080-1-mark-yw.chen@mediatek.com>
To:     =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> Mediatek Bluetooth controller sends the FW log and FW dump via EP2.
> This patch creates an MTK specified callback(btusb_recv_acl_mtk) to
> replace the original one (hci_recv_frame) when an MTK controller is
> detected. The new callback will separate the firmware dump traffics
> from the ACL data to have them process separately.
> 
> 1. Add a new field (recv_acl) to the btusb_data struct to store
> vendor-specific ACL callback handler.
> 2. Add the MTK-specific ACL callback handler (btusb_recv_acl_mtk) to
> process ACL data, debug log, and firmware dump.
> 3. The debug log traces LMP/LL events and connection quality reports.
> 4. The upper layer can use hci_channel_monitor to receive these
> packets.
> 
> Example btmon: firmware debug log.
> 1. Enable firmware debug log.
> < HCI Command: Vendor (0x3f|0x005d) plen 4
>        00 00 02 02                                      ....
>> HCI Event: Command Complete (0x0e) plen 8
>      Vendor (0x3f|0x005d) ncmd 1
>        Status: Success (0x00)
>        00 00 02 02                                      ....
> 2. Diagnostic packet from controller
> = Vendor Diagnostic (len 500)
>          ff 05 f0 01 fd ff 02 0e 08 01 5d fc 00 00 00 02
>          02 aa aa aa cb e3 f0 15 b0 0c 5f 01 00 d1 0f 33
>          01 7f 00 08 57 61 0c 00 00 00 00 00 23 37 17 00
>          fd ff 00 00 29 60 ff ff b1 56 e8 00 57 40 0a 40
>          39 95 f2 00 47 40 43 00 fc f0 16 00 57 61 0c 00
>          00 00 00 00 23 37 17 00 fd ff 00 00 29 60 ff ff
>          65 95 f2 00 57 40 0a 40 ec d3 fc 00 47 40 3b 00
>          2c f1 17 00 57 61 0c 00 00 00 00 00 23 37 17 00
>          fd ff 00 00 29 60 ff ff 19 d4 fc 00 57 40 76 1c
>          b2 61 01 01 47 40 b3 04 0b 63 18 00 fe ff 02 01
>          04 05 33 8b 9e 08 00 aa aa aa aa aa 27 38 01 02
>          01 00 00 00 02 e0 10 00 20 00 20 00 2a 08 40 00
>          20 00 20 08 2a 08 02 00 40 00 00 01 2e 08 40 00
>          01 67 b0 c2 2e 08 3e 07 ff ff ff ff 40 08 01 00
>          02 00 00 00 34 08 a3 00 00 00 00 00 34 08 a3 00
>          00 00 00 00 35 08 45 01 00 00 00 00 2e 08 40 00
>          01 67 b0 c2 30 35 01 02 00 00 00 00 2c 31 01 00
>          02 00 00 40 2d 19 03 00 00 40 00 00 fd ff 02 0f
>          04 00 01 01 04 aa aa aa aa aa aa aa 57 61 0c 00
>          00 00 00 00 23 46 32 00 01 00 00 00 2f 35 00 02
>          00 00 00 00 29 35 ff 02 00 22 00 00 2d 31 a6 02
>          02 00 00 00 31 6c 40 00 14 63 18 1b 31 6c 40 00
>          14 63 18 23 51 08 53 00 12 63 18 00 2c 35 12 01
>          fe 00 00 00 2b 35 fe 02 02 00 00 00 2f 31 21 00
>          00 00 02 00 75 61 01 00 4c 1b 93 00 79 61 01 00
>          00 00 00 00 12 e3 63 18 20 31 86 01 74 61 68 03
>          00 00 04 00 a1 73 ff 00 b9 01 00 00 a1 73 04 00
>          00 00 00 00 a1 73 00 00 00 00 00 00 a1 73 00 00
>          02 00 00 00 31 6c 40 00 16 63 18 0c 31 6c 40 00
>          16 63 18 1c 77 61 40 00 48 33 40 00 14 e3 63 18
>          40 31 86 01 00 d1 02 c5 07 23 a1 34 73 61 37 02
>          02 00 00 a1
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> Reviewed-by: Michael Sun <michaelfsun@google.com>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> ---
> drivers/bluetooth/btusb.c | 25 ++++++++++++++++++++++++-
> 1 file changed, 24 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

