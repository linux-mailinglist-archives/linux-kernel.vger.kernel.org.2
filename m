Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60D53D4608
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhGXHBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 03:01:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42741 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhGXHBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 03:01:31 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id D910ECED10;
        Sat, 24 Jul 2021 09:42:02 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] Bluetooth: btusb: Add valid le states quirk
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210723171729.1.I98b1da8cdd72c1f355366f623cb34ddfc0fe40ae@changeid>
Date:   Sat, 24 Jul 2021 09:42:02 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D45ACCA1-7C68-4D7F-8F45-12BED075D597@holtmann.org>
References: <20210723171729.1.I98b1da8cdd72c1f355366f623cb34ddfc0fe40ae@changeid>
To:     Michael Sun <michaelfsun@google.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> Add the valid le states quirk for WCN6855 and GarfieldPeak controller
> so the 'central-peripheral' role is exposed in userspace.
> 
> Signed-off-by: Michael Sun <michaelfsun@google.com>
> ---
> 
> drivers/bluetooth/btusb.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

