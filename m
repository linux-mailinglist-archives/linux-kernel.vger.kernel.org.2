Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033C930DD32
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbhBCOs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:48:59 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:34228 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhBCOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:48:57 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdd8.dip0.t-ipconnect.de [79.239.205.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8E5B3CECFE;
        Wed,  3 Feb 2021 15:55:42 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v4] Bluetooth: btusb: Fix typo and correct the log print
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210203142846.39648-1-zjp734690220@163.com>
Date:   Wed, 3 Feb 2021 15:48:14 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Jupeng Zhong <zhongjupeng@yulong.com>
Content-Transfer-Encoding: 7bit
Message-Id: <90A308CB-BFF0-453B-BAEA-5CFDEC59412C@holtmann.org>
References: <20210203142846.39648-1-zjp734690220@163.com>
To:     Jupeng Zhong <zjp734690220@163.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jupeng,

> Change "deivice" to "device"
> 
> Correct "Unsupported support hardware variant (%08x)" to
> "Unsupported hardware variant (%08x)"
> 
> Signed-off-by: Jupeng Zhong <zhongjupeng@yulong.com>
> ---
> v4: update bluetooth-next tree and regenerate the patch again
> v3: update bluetooth-next tree and regenerate the patch
> v2: correct the log print and update the patch From: and Signed-off-by:
> ---
> drivers/bluetooth/btusb.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

