Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D443347312
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbhCXH5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:57:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34035 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbhCXH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:57:10 -0400
Received: from marcel-macbook.holtmann.net (p4fefce19.dip0.t-ipconnect.de [79.239.206.25])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8A1B1CECF8;
        Wed, 24 Mar 2021 09:04:47 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] Bluetooth: SCO - Remove trailing semicolon in macros
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1616551405-41488-1-git-send-email-yumeng18@huawei.com>
Date:   Wed, 24 Mar 2021 08:57:08 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E7993DF8-F69C-45DA-8AF6-5E7017441A9F@holtmann.org>
References: <1616551405-41488-1-git-send-email-yumeng18@huawei.com>
To:     Meng Yu <yumeng18@huawei.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Meng,

> Macros should not use a trailing semicolon.
> 
> Signed-off-by: Meng Yu <yumeng18@huawei.com>
> ---
> 
> Changes in v2
> -Modify comments 
> 
> net/bluetooth/sco.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

