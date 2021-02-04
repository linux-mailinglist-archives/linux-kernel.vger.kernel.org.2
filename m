Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB2430F38D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhBDM5c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 Feb 2021 07:57:32 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48590 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbhBDM53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:57:29 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdd8.dip0.t-ipconnect.de [79.239.205.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5204ECED16;
        Thu,  4 Feb 2021 14:04:13 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: btusb: remove set but not used variable in
 btusb_mtk_setup_firmware_79xx
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210204011856.3685334-1-yebin10@huawei.com>
Date:   Thu, 4 Feb 2021 13:56:45 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Hulk Robot <hulkci@huawei.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <CDB7E085-EE43-4AC7-838E-DA2BA56ED70C@holtmann.org>
References: <20210204011856.3685334-1-yebin10@huawei.com>
To:     Ye Bin <yebin10@huawei.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ye,

> Fix follow warning:
> drivers/bluetooth/btusb.c:3479:9: warning: variable ‘fw_size’ set but not used [-Wunused-but-set-variable]
>  size_t fw_size;
>         ^~~~~~~
> drivers/bluetooth/btusb.c:3473:29: warning: variable ‘patchhdr’ set but not used [-Wunused-but-set-variable]
>  struct btmtk_patch_header *patchhdr = NULL;
>                             ^~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
> drivers/bluetooth/btusb.c | 4 ----
> 1 file changed, 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

