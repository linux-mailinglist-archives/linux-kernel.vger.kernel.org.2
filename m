Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095083DABAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 21:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhG2TM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 15:12:26 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35555 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhG2TMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 15:12:24 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 99120CED1C;
        Thu, 29 Jul 2021 21:12:19 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] Bluetooth: btusb: Enable MSFT extension for WCN6855
 controller
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210729101036.1.I20af1cbaba1aed4ea5978c97339df5e035f08625@changeid>
Date:   Thu, 29 Jul 2021 21:12:19 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C7813019-4DAE-4C18-9E2A-7F15EF87A762@holtmann.org>
References: <20210729101036.1.I20af1cbaba1aed4ea5978c97339df5e035f08625@changeid>
To:     Michael Sun <michaelfsun@google.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> The Qualcomm WCN6855 Bluetooth controller supports the Microsoft vendor
> extension, enable them by setting VsMsftOpCode to 0xFD70.
> 
> Verified on a WCN6855 device through bluetoothctl show
> 
> Signed-off-by: Michael Sun <michaelfsun@google.com>
> ---
> 
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

