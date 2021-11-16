Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C0745357D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbhKPPUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:20:08 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56664 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbhKPPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:20:01 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 799E9CECD8;
        Tue, 16 Nov 2021 16:17:01 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] Bluetooth: btusb: enable Mediatek to support AOSP
 extension
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211104182605.30433-1-mark-yw.chen@mediatek.com>
Date:   Tue, 16 Nov 2021 16:17:00 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, josephsih@google.com,
        will-cy.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9C2ED95F-2515-444E-911A-6FD49EBF4B2A@holtmann.org>
References: <20211104182605.30433-1-mark-yw.chen@mediatek.com>
To:     mark-yw.chen@mediatek.com
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> This patch enables AOSP extension for Mediatek Chip (MT7921 & MT7922).
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

