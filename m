Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBCE3FC74B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhHaMcD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Aug 2021 08:32:03 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60540 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhHaMcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:32:02 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0EDE0CECDA;
        Tue, 31 Aug 2021 14:31:06 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/2] Bluetooth: btusb: Support public address
 configuration for MediaTek Chip.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <SL2PR03MB4457513693916CBA07BE450BB3CC9@SL2PR03MB4457.apcprd03.prod.outlook.com>
Date:   Tue, 31 Aug 2021 14:31:05 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michaelfsun@google.com" <michaelfsun@google.com>,
        "mcchou@chromium.org" <mcchou@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <51A4788D-DDFD-4700-9D50-84F37ADD4883@holtmann.org>
References: <20210824154430.27689-1-mark-yw.chen@mediatek.com>
 <CF258C9C-BB3C-4C10-88B0-F6F3A03303D5@holtmann.org>
 <SL2PR03MB4457513693916CBA07BE450BB3CC9@SL2PR03MB4457.apcprd03.prod.outlook.com>
To:     =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

>>> The MediaTek chip support vendor specific HCI command(0xfc1a) to
>>> change the public address. Add hdev->set_bdaddr handler for MediaTek
>>> Chip.
>>> 
>>> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 18 ++++++++++++++++++
>>> 1 file changed, 18 insertions(+)
>>> 
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 60d2fce59a71..41e7c9f28d82 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -2200,6 +2200,23 @@ struct btmtk_section_map {
>>> 	};
>>> } __packed;
>>> 
>>> +static int btusb_set_bdaddr_mtk(struct hci_dev *hdev, const bdaddr_t
>>> +*bdaddr) {
>>> +	struct sk_buff *skb;
>>> +	long ret;
>>> +
>>> +	skb = __hci_cmd_sync(hdev, 0xfc1a, sizeof(bdaddr), bdaddr,
>> HCI_INIT_TIMEOUT);
>>> +	if (IS_ERR(skb)) {
>>> +		ret = PTR_ERR(skb);
>>> +		bt_dev_err(hdev, "changing Mediatek device address failed
>> (%ld)",
>>> +			   ret);
>>> +		return ret;
>>> +	}
>>> +	kfree_skb(skb);
>>> +
>>> +	return 0;
>>> +}
>>> +
>> 
>> this is not a permanent change, correct? Meaning a power cycle will bring back
>> the original BD_ADDR?
>> 
> 
> Yes, it's not a permanent change.
> After doing a power cycle or Mediatek specific Bluetooth reset, Mediatek Chips will bring back the original  BD_ADDRESS.

ok, good. Then please re-submit against latest bluetooth-next tree. Unfortunately current patch doesn’t apply anymore.

Regards

Marcel

