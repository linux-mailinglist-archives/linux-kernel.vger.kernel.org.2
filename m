Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE33F414B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhIVOSU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Sep 2021 10:18:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37935 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbhIVOSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:18:15 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 81392CED34;
        Wed, 22 Sep 2021 16:16:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: btmtkuart: fix a memleak in mtk_hci_wmt_sync
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210922134945.27503-1-dinghao.liu@zju.edu.cn>
Date:   Wed, 22 Sep 2021 16:16:44 +0200
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <88B71D9F-DA0D-46A7-AC42-C9A5E5B95C7B@holtmann.org>
References: <20210922134945.27503-1-dinghao.liu@zju.edu.cn>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinghao,

> bdev->evt_skb will get freed in the normal path and one error path
> of mtk_hci_wmt_sync, while the other error paths do not free it,
> which may cause a memleak. This bug is suggested by a static analysis
> tool, please advise.
> 
> Fixes: e0b67035a90b ("Bluetooth: mediatek: update the common setup between MT7622 and other devices")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> drivers/bluetooth/btmtkuart.c | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

