Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60CA3FD2FF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbhIAFjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:39:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52250 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbhIAFjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:39:22 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2C1BFCECED;
        Wed,  1 Sep 2021 07:38:25 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 1/2] Bluetooth: btusb: Support public address
 configuration for MediaTek Chip.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210901033226.20693-1-mark-yw.chen@mediatek.com>
Date:   Wed, 1 Sep 2021 07:38:24 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, chris.lu@mediatek.com,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Michael Sun <michaelfsun@google.com>, mcchou@chromium.org
Content-Transfer-Encoding: 7bit
Message-Id: <3878646A-57BA-47A3-B7C8-884B5AE3DF34@holtmann.org>
References: <20210901033226.20693-1-mark-yw.chen@mediatek.com>
To:     =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> The MediaTek chip support vendor specific HCI command(0xfc1a) to
> change the public address. Add hdev->set_bdaddr handler for MediaTek
> Chip. After doing a power cycle or MediaTek Bluetooth reset, BD_ADDR
> will bring back the original one.
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

