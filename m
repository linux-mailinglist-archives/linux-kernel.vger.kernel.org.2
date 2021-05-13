Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4374D37FA56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhEMPOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:14:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39880 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEMPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:14:03 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4883BCED28;
        Thu, 13 May 2021 17:20:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH] Bluetooth: btusb: Add support USB ALT 3 for WBS
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210513101806.5666-1-hildawu@realtek.com>
Date:   Thu, 13 May 2021 17:12:51 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, max.chou@realtek.com,
        alex_lu@realsil.com.cn, kidman@realtek.com
Content-Transfer-Encoding: 7bit
Message-Id: <846A7897-6645-4FA0-8B3A-C0AB01965365@holtmann.org>
References: <20210513101806.5666-1-hildawu@realtek.com>
To:     Hilda Wu <hildawu@realtek.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hilda,

> Because mSBC frames do not need to be aligned to the SCO packet
> boundary. Using USB ALT 3 let HCI payload >= 60 bytes, let mSBC
> data satisfy 60 Bytes avoid payload unaligned situation and fixed
> some headset no voise issue.
> 
> USB Alt 3 supported also need HFP support transparent MTU in 72 Bytes.
> 
> Signed-off-by: hildawu <hildawu@realtek.com>

please use real name here.

> ---
> drivers/bluetooth/btusb.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 6f253378e893..872034e7a232 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1752,6 +1752,13 @@ static void btusb_work(struct work_struct *work)
> 			 * which work with WBS at all.
> 			 */
> 			new_alts = btusb_find_altsetting(data, 6) ? 6 : 1;
> +			/* Because mSBC frames do not need to be aligned to the
> +			 * SCO packet boundary. If support the Alt 3, use the
> +			 * Alt 3 for HCI payload >= 60 Bytes let air packet
> +			 * data satisfy 60 bytes.
> +			 */
> +			if ((new_alts == 1) && (btusb_find_altsetting(data, 3)))
> +				new_alts = 3;

	if (new_alts == 1 && btusb_find_altsetting(..))
		..

Regards

Marcel

