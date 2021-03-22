Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05567344A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhCVQIB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Mar 2021 12:08:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43263 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhCVQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:06:28 -0400
Received: from marcel-macbook.holtmann.net (p4fefce19.dip0.t-ipconnect.de [79.239.206.25])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8EB90CECB0;
        Mon, 22 Mar 2021 17:14:04 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Bluetooth: Remove trailing semicolon in macros
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1616224773-41847-1-git-send-email-yumeng18@huawei.com>
Date:   Mon, 22 Mar 2021 17:06:25 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4A3E143A-6877-459D-9CB9-834DA298B472@holtmann.org>
References: <1616224773-41847-1-git-send-email-yumeng18@huawei.com>
To:     Meng Yu <yumeng18@huawei.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Meng,

> 1. remove trailing semicolon in macros;
> 2. fix some coding style.
> 
> Signed-off-by: Meng Yu <yumeng18@huawei.com>
> ---
> net/bluetooth/smp.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

the patch doesn’t apply to bluetooth-next, please re-base and send again.

Regards

Marcel

