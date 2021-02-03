Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B43230DB72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhBCNhq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Feb 2021 08:37:46 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47044 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhBCNhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:37:01 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdd8.dip0.t-ipconnect.de [79.239.205.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 01E61CECFC;
        Wed,  3 Feb 2021 14:43:38 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v3] Bluetooth: btusb: Fix typo and correct the log print
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210203080612.36904-1-zjp734690220@163.com>
Date:   Wed, 3 Feb 2021 14:36:11 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Jupeng Zhong <zhongjupeng@yulong.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <28DBD65D-7252-48FF-8A40-276883BA7ED8@holtmann.org>
References: <20210203080612.36904-1-zjp734690220@163.com>
To:     zjp734690220@163.com
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
> v3: update bluetooth-next tree and regenerate the patch
> v2: correct the log print and update the patch From: and Signed-off-by:
> ---
> drivers/bluetooth/btusb.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

this must have been caught up again in between other patches, but it does not apply cleanly anymore. Please rebase again.

Regards

Marcel

