Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DA13DAC05
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 21:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhG2TrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 15:47:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34295 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhG2TrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 15:47:16 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 39516CED1E;
        Thu, 29 Jul 2021 21:47:12 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] Bluetooth: btusb: Enable MSFT extension for Intel next
 generation controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210729094319.1.Ib7a90fea41e56da34bab6811c2ecf6b255a14f51@changeid>
Date:   Thu, 29 Jul 2021 21:47:11 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0E5C12DF-2385-4B31-A396-FBDB9A2CFD0D@holtmann.org>
References: <20210729094319.1.Ib7a90fea41e56da34bab6811c2ecf6b255a14f51@changeid>
To:     Michael Sun <michaelfsun@google.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> The Intel TyphoonPeak, GarfieldPeak Bluetooth controllers
> support the Microsoft vendor extension and they are using
> 0xFC1E for VsMsftOpCode.
> 
> Verified on a GarfieldPeak device through bluetoothctl show
> 
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Michael Sun <michaelfsun@google.com>
> ---
> 
> drivers/bluetooth/btusb.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)

Patch has been applied to bluetooth-next tree.

Regards

Marcel

