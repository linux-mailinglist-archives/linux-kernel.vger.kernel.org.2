Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559154067D7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhIJHka convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Sep 2021 03:40:30 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60054 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhIJHk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:40:27 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0A876CED3D;
        Fri, 10 Sep 2021 09:39:15 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: hci: fix GPF in h5_recv
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210902202756.25378-1-paskripkin@gmail.com>
Date:   Fri, 10 Sep 2021 09:39:14 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        apusaka@chromium.org, abhishekpandit@chromium.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <EF01F61D-7765-49C1-A813-55EB130FCCE1@holtmann.org>
References: <20210902202756.25378-1-paskripkin@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> Syzbot hit general protection fault in h5_recv(). The problem was in
> missing NULL check.
> 
> hu->serdev can be NULL and we cannot blindly pass &serdev->dev
> somewhere, since it can cause GPF.
> 
> Fixes: d9dd833cf6d2 ("Bluetooth: hci_h5: Add runtime suspend")
> Reported-and-tested-by: syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
> drivers/bluetooth/hci_h5.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

