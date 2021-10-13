Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE3D42C670
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhJMQeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:34:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52955 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJMQeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:34:36 -0400
Received: from smtpclient.apple (p4ff9f2d2.dip0.t-ipconnect.de [79.249.242.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id C9108CECFA;
        Wed, 13 Oct 2021 18:32:30 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: btusb: fix memory leak in
 btusb_mtk_submit_wmt_recv_urb()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211013162204.13919-1-mark-yw.chen@mediatek.com>
Date:   Wed, 13 Oct 2021 18:32:30 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, will-cy.lee@mediatek.com,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <75730B1E-4A50-4DC5-8D1A-84CE58C04E72@holtmann.org>
References: <20211013162204.13919-1-mark-yw.chen@mediatek.com>
To:     mark-yw.chen@mediatek.com
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> Driver should free `usb->setup_packet` to avoid the leak.
> 
> $ cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffffffa564a58080 (size 128):
>    backtrace:
>        [<000000007eb8dd70>] kmem_cache_alloc_trace+0x22c/0x384
>        [<000000008a44191d>] btusb_mtk_hci_wmt_sync+0x1ec/0x994
>    [btusb]
>        [<00000000ca7189a3>] btusb_mtk_setup+0x6b8/0x13cc
>    [btusb]
>        [<00000000c6105069>] hci_dev_do_open+0x290/0x974
>    [bluetooth]
>        [<00000000a583f8b8>] hci_power_on+0xdc/0x3cc [bluetooth]
>        [<000000005d80e687>] process_one_work+0x514/0xc80
>        [<00000000f4d57637>] worker_thread+0x818/0xd0c
>        [<00000000dc7bdb55>] kthread+0x2f8/0x3b8
>        [<00000000f9999513>] ret_from_fork+0x10/0x30
> 
> Signed-off-by: Mark-YW.Chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

