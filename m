Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2924B3FB8B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbhH3PFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:05:43 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50766 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbhH3PFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:05:42 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 40665CEC82;
        Mon, 30 Aug 2021 17:04:47 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 2/2] Bluetooth: btusb: Add protocol for MediaTek bluetooth
 devices(MT7922)
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210824154430.27689-2-mark-yw.chen@mediatek.com>
Date:   Mon, 30 Aug 2021 17:04:47 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, sean.wang@mediatek.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        michaelfsun@google.com, mcchou@chromium.org
Content-Transfer-Encoding: 7bit
Message-Id: <3BC55188-B231-4F16-994F-BE0D6E1455B2@holtmann.org>
References: <20210824154430.27689-1-mark-yw.chen@mediatek.com>
 <20210824154430.27689-2-mark-yw.chen@mediatek.com>
To:     =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> The information in /sys/kernel/debug/usb/devices about the MT7922U
> Bluetooth device is listed as the below.
> 
> T: Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 18 Spd=480 MxCh= 0
> D: Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=0e8d ProdID=7922 Rev= 1.00
> S: Manufacturer=MediaTek Inc.
> S: Product=Wireless_Device
> S: SerialNumber=000000000
> C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
> A: FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=125us
> E: Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> I: If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=83(I) Atr=01(Isoc) MxPS= 63 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 63 Ivl=1ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=8a(I) Atr=03(Int.) MxPS= 64 Ivl=125us
> E: Ad=0a(O) Atr=03(Int.) MxPS= 64 Ivl=125us
> I: If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
> E: Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 41e7c9f28d82..fe52f7b9548e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2821,6 +2821,8 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
> 	case 0x7668:
> 		fwname = FIRMWARE_MT7668;
> 		break;
> +	case 0x7922:
> +		fallthrough;

The fallthrough is not needed. Multiple case labels in a row are fine.

Regards

Marcel

