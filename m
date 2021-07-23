Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D330E3D39FB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhGWLbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:31:35 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48089 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhGWLbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:31:33 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id 554B8CECFE;
        Fri, 23 Jul 2021 14:12:04 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3 1/3] Bluetooth: hci_h5: add WAKEUP_DISABLE flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210723193137.v3.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Date:   Fri, 23 Jul 2021 14:12:04 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C589DD51-B5E4-45AF-91C8-7389723EE35C@holtmann.org>
References: <20210723193137.v3.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Archie,

> Some RTL chips resets the FW on suspend, so wakeup is disabled on
> those chips. This patch introduces this WAKEUP_DISABLE flag so that
> chips that doesn't reset FW on suspend can leave the flag unset and
> is allowed to wake the host.
> 
> This patch also left RTL8822 WAKEUP_DISABLE flag unset, therefore
> allowing it to wake the host, and preventing reprobing on resume.
> 
> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Hilda Wu <hildawu@realtek.com>
> 
> ---
> 
> Changes in v3:
> * Rebasing
> 
> Changes in v2:
> * Remove unnecessary variable
> 
> drivers/bluetooth/hci_h5.c | 83 +++++++++++++++++++++++++++-----------
> 1 file changed, 59 insertions(+), 24 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

