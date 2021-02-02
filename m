Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B264130C5C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhBBQaS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Feb 2021 11:30:18 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43662 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbhBBQ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:27:41 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdd8.dip0.t-ipconnect.de [79.239.205.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 19E24CECDE;
        Tue,  2 Feb 2021 17:34:23 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Fix memory leak in
 btusb_mtk_wmt_recv
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210202013913.15324-1-zjp734690220@163.com>
Date:   Tue, 2 Feb 2021 17:26:55 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Markus.Elfring@web.de, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jupeng Zhong <zhongjupeng@yulong.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <0C7BC6BB-9FC7-4857-8DDF-DA1FC56E15B7@holtmann.org>
References: <20210202013913.15324-1-zjp734690220@163.com>
To:     Jupeng Zhong <zjp734690220@163.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jupeng,

> In btusb_mtk_wmt_recv if skb_clone fails, the alocated skb should be
> released.
> 
> Omit the labels “err_out” and “err_free_skb” in this function
> implementation so that the desired exception handling code
> would be directly specified in the affected if branches.
> 
> Fixes: a1c49c434e15 ("btusb: Add protocol support for MediaTek MT7668U USB devices")
> Signed-off-by: Jupeng Zhong <zhongjupeng@yulong.com>
> ---
> drivers/bluetooth/btusb.c | 20 ++++++++++----------
> 1 file changed, 10 insertions(+), 10 deletions(-)

patch does not apply cleanly to bluetooth-next tree. Please rebase.

Regards

Marcel

