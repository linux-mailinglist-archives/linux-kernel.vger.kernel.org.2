Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3573EDA21
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhHPPqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:46:31 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49385 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbhHPPqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:46:22 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 95832CECC9;
        Mon, 16 Aug 2021 17:45:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Remove WAKEUP_DISABLE and add
 WAKEUP_AUTOSUSPEND for Realtek devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210810020147.14276-1-max.chou@realtek.com>
Date:   Mon, 16 Aug 2021 17:45:44 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        matthias.bgg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alex_lu@realsil.com.cn,
        hildawu@realtek.com, kidman@realtek.com, apusaka@chromium.org,
        abhishekpandit@chromium.org, josephsih@chromium.org
Content-Transfer-Encoding: 7bit
Message-Id: <08B718ED-F885-4870-BB80-AB547FEC52B1@holtmann.org>
References: <20210810020147.14276-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

> For the commit of 9e45524a011107a73bc2cdde8370c61e82e93a4d, wakeup is
> always disabled for Realtek devices. However, there's the capability
> for Realtek devices to apply USB wake-up.
> 
> In this commit, remove WAKEUP_DISABLE feature for Realtek devices.
> If users would switch wake-up, they should access
> "/sys/bus/usb/.../power/wakeup"
> 
> In this commit, it also adds the feature as WAKEUP_AUTOSUSPEND
> for Realtek devices because it should set do_remote_wakeup on autosuspend.
> 
> Signed-off-by: Max Chou <max.chou@realtek.com>
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> Changes in v2:
> -fix the compiling error due to the incorrect patch file submited
> ---
> drivers/bluetooth/btusb.c | 28 +++++++++-------------------
> 1 file changed, 9 insertions(+), 19 deletions(-)

this does not apply cleanly to bluetooth-next tree.

Regards

Marcel

