Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0D37FA80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbhEMPVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:21:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37795 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbhEMPVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:21:02 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5A5C5CED28;
        Thu, 13 May 2021 17:27:41 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH] Bluetooth: btbcm: Add entry for BCM43430B0 UART Bluetooth
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210509232838.2477651-1-mike.rudenko@gmail.com>
Date:   Thu, 13 May 2021 17:19:48 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E8A21908-1D48-4B89-8A88-7E82A71E0DA4@holtmann.org>
References: <20210509232838.2477651-1-mike.rudenko@gmail.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

> This patch adds the device ID for the BCM43430B0 module, found e.g. in
> certain revisions of AMPAK AP6212 chip. The required firmware file is
> named 'BCM43430B0.hcd'.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
> drivers/bluetooth/btbcm.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

