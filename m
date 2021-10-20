Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD995434BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhJTNBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:01:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56900 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTNBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:01:35 -0400
Received: from smtpclient.apple (p54899aa7.dip0.t-ipconnect.de [84.137.154.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id E776FCED1B;
        Wed, 20 Oct 2021 14:59:19 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2] Bluetooth: virtio_bt: fix memory leak in
 virtbt_rx_handle()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211020081444.37324-1-soenke.huster@eknoes.de>
Date:   Wed, 20 Oct 2021 14:59:19 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1A203F5E-FB5E-430C-BEA3-86B191D69D58@holtmann.org>
References: <20211020081444.37324-1-soenke.huster@eknoes.de>
To:     Soenke Huster <soenke.huster@eknoes.de>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soenke,

> On the reception of packets with an invalid packet type, the memory of
> the allocated socket buffers is never freed. Add a default case that frees
> these to avoid a memory leak.
> 
> Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
> ---
> Changes in v2:
>  - Add break; to default case
> 
> drivers/bluetooth/virtio_bt.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

