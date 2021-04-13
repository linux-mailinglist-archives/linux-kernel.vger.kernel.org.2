Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A99D35E687
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347940AbhDMSf1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Apr 2021 14:35:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48454 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347929AbhDMSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:35:24 -0400
Received: from marcel-macbook.holtmann.net (p5b3d235a.dip0.t-ipconnect.de [91.61.35.90])
        by mail.holtmann.org (Postfix) with ESMTPSA id 84989CECCC;
        Tue, 13 Apr 2021 20:42:47 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Bluetooth: btusb: fix memory leak
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210413175208.GA560049@LEGION>
Date:   Tue, 13 Apr 2021 20:35:02 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "mark-yw.chen" <mark-yw.chen@mediatek.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, dan.carpenter@oracle.com,
        colin.king@canonical.com
Content-Transfer-Encoding: 8BIT
Message-Id: <E4C40E0D-4D06-4E3C-BEA3-079FACEE1A06@holtmann.org>
References: <20210413175208.GA560049@LEGION>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muhammad,

> If btusb_mtk_submit_wmt_recv_urb returns error, wc should be freed and
> then error should be returned to prevent memory leak.
> 
> Addresses-Coverity: ("Prevent memory leak")
> Fixes: 4cbb375e997d ("Bluetooth: btusb: Fixed too many in-token issue for Mediatek Chip.")
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

