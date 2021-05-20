Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827F038B322
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbhETP0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:26:02 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36588 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhETPZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:25:05 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 153D6CECEB;
        Thu, 20 May 2021 17:31:36 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support USB ALT 3 for WBS
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210514031901.2276-1-hildawu@realtek.com>
Date:   Thu, 20 May 2021 17:23:41 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>,
        Alex Lu <alex_lu@realsil.com.cn>, kidman@realtek.com
Content-Transfer-Encoding: 7bit
Message-Id: <E9F68188-F920-4CBA-95D4-4270472D63D6@holtmann.org>
References: <20210514031901.2276-1-hildawu@realtek.com>
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
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> Changes in v2:
> - Updated signed off name.
> - Adjusted coding style.
> ---
> ---
> drivers/bluetooth/btusb.c | 7 +++++++
> 1 file changed, 7 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

