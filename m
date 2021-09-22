Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA6A414B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhIVORG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:17:06 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44423 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhIVORF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:17:05 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5DA3ECED34;
        Wed, 22 Sep 2021 16:15:34 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: hci_ldisc: require CAP_NET_ADMIN to attach
 N_HCI ldisc
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210922115656.97723-1-cascardo@canonical.com>
Date:   Wed, 22 Sep 2021 16:15:32 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <5E587006-CB9D-4561-955D-F296DE70CD22@holtmann.org>
References: <20210922115656.97723-1-cascardo@canonical.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thadeu,

> Any unprivileged user can attach N_HCI ldisc and send packets coming from a
> virtual controller by using PTYs.
> 
> Require initial namespace CAP_NET_ADMIN to do that.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

