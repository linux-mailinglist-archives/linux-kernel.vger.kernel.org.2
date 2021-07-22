Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936193D2582
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhGVNgk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jul 2021 09:36:40 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45273 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhGVNgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:36:39 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id CD78ACECDD;
        Thu, 22 Jul 2021 16:17:12 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] Bluetooth: btusb: Fix a unspported condition to set
 available debug features
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210709134625.1235015-1-jun.miao@windriver.com>
Date:   Thu, 22 Jul 2021 16:17:12 +0200
Cc:     matthias.bgg@gmail.com, Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3A8EB08F-C6D1-4B92-B72B-265C49DC5940@holtmann.org>
References: <20210709134625.1235015-1-jun.miao@windriver.com>
To:     Jun Miao <jun.miao@windriver.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

> When reading the support debug features failed, there are not available
> features init. Continue to set the debug features is illogical, we should
> skip btintel_set_debug_features(), even if check it by "if (!features)".
> 
> Fixes: c453b10c2b28 ("Bluetooth: btusb: Configure Intel debug feature based on
> available support")
> Signed-off-by: Jun Miao <jun.miao@windriver.com>
> ---
> drivers/bluetooth/btusb.c | 18 ++++++++++--------
> 1 file changed, 10 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

