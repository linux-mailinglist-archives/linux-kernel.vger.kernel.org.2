Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9426D30F95B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhBDRRC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 Feb 2021 12:17:02 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35244 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbhBDROR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:14:17 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdd8.dip0.t-ipconnect.de [79.239.205.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4161FCED18;
        Thu,  4 Feb 2021 18:20:47 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: btusb: fix excessive stack usage
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210204154716.1823454-1-arnd@kernel.org>
Date:   Thu, 4 Feb 2021 18:13:19 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Mark Chen <Mark-YW.Chen@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, Kiran K <kiran.k@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sathish Narasimman <nsathish41@gmail.com>,
        Rocky Liao <rjliao@codeaurora.org>,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        Hilda Wu <hildawu@realtek.com>,
        Trent Piepho <tpiepho@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <24876961-6740-4C52-9F10-3E8056237DD0@holtmann.org>
References: <20210204154716.1823454-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> Enlarging the size of 'struct btmtk_hci_wmt_cmd' makes it no longer
> fit on the kernel stack, as seen from this compiler warning:
> 
> drivers/bluetooth/btusb.c:3365:12: error: stack frame size of 1036 bytes in function 'btusb_mtk_hci_wmt_sync' [-Werror,-Wframe-larger-than=]
> 
> Change the function to dynamically allocate the buffer instead.
> As there are other sleeping functions called from the same location,
> using GFP_KERNEL should be fine here, and the runtime overhead should
> not matter as this is rarely called.
> 
> Unfortunately, I could not figure out why the message size is
> increased in the previous patch. Using dynamic allocation means
> any size is possible now, but there is still a range check that
> limits the total size (including the five-byte header) to 255
> bytes, so whatever was intended there is now undone.
> 
> Fixes: 48c13301e6ba ("Bluetooth: btusb: Fine-tune mt7663 mechanism.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> drivers/bluetooth/btusb.c | 24 +++++++++++++++---------
> 1 file changed, 15 insertions(+), 9 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

