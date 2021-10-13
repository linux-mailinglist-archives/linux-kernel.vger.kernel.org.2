Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9670D42B781
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 08:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhJMGkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 02:40:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43968 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhJMGjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:39:54 -0400
Received: from smtpclient.apple (p4ff9f2d2.dip0.t-ipconnect.de [79.249.242.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 41311CECF1;
        Wed, 13 Oct 2021 08:37:50 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2] Fix application of sizeof to pointer
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <88c30c5f6238a096d1d431634f3ea93d97f66215.1634086268.git.davidcomponentone@gmail.com>
Date:   Wed, 13 Oct 2021 08:37:49 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
Content-Transfer-Encoding: 7bit
Message-Id: <2C1B50C4-02B7-4D80-B18E-66EDDE827209@holtmann.org>
References: <88c30c5f6238a096d1d431634f3ea93d97f66215.1634086268.git.davidcomponentone@gmail.com>
To:     davidcomponentone@gmail.com
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> The coccinelle check report:
> "./drivers/bluetooth/btusb.c:2239:36-42:
> ERROR: application of sizeof to pointer".
> Using the real size to fix it.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

