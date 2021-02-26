Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E223268BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhBZU22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:28:28 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45046 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhBZUTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:19:34 -0500
Received: from marcel-macbook.holtmann.net (p4ff9fb90.dip0.t-ipconnect.de [79.249.251.144])
        by mail.holtmann.org (Postfix) with ESMTPSA id 33845CECF0;
        Fri, 26 Feb 2021 21:26:08 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH 1/1] Bluetooth: btusb: Fix incorrect type in assignment
 and uninitialized symbol
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210223062740.12067-1-mark-yw.chen@mediatek.com>
Date:   Fri, 26 Feb 2021 21:18:35 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, Sean.Wang@mediatek.com,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        lkp@intel.com
Content-Transfer-Encoding: 7bit
Message-Id: <92470858-9C75-4F77-AC70-B56DEE423255@holtmann.org>
References: <20210223062740.12067-1-mark-yw.chen@mediatek.com>
To:     Mark Chen <Mark-YW.Chen@mediatek.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> Warnings: drivers/bluetooth/btusb.c:3775 btusb_mtk_setup() error:
> uninitialized symbol 'fw_version'.
> -> add initial value for fw_version.
> 
> Warnings: sparse: sparse: incorrect type in assignment (different base
> types)
> -> add le32_to_cpu to fix incorrect type in assignment.
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

