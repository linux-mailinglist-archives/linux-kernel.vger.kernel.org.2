Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A703767D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhEGPVO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 May 2021 11:21:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33138 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbhEGPVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:21:12 -0400
Received: from smtpclient.apple (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7732CCECE3;
        Fri,  7 May 2021 17:28:02 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH] bluetooth: fix potential gfp
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <YJU8iP+O9aSYwYp/@hovoldconsulting.com>
Date:   Fri, 7 May 2021 17:20:11 +0200
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CDE30B55-E91B-4513-80E4-2198F8A32217@holtmann.org>
References: <20210501150445.4055-1-paskripkin@gmail.com>
 <9A08CBDA-3501-48F6-9F7A-60958C5CF888@holtmann.org>
 <YJU8iP+O9aSYwYp/@hovoldconsulting.com>
To:     Johan Hovold <johan@kernel.org>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

>>> In qca_power_shutdown() qcadev local variable is
>>> initialized by hu->serdev.dev private data, but
>>> hu->serdev can be NULL and there is a check for it.
>>> 
>>> Since, qcadev is not used before
>>> 
>>> 	if (!hu->serdev)
>>> 		return;
>>> 
>>> we can move its initialization after this "if" to
>>> prevent gfp.
>>> 
>>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
>>> ---
>>> drivers/bluetooth/hci_qca.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> patch has been applied to bluetooth-next tree.
> 
> Why did you pick the v1 when it is clear from thread that a v2 has been
> posted?

because I only saw that email after I applied the patch and the v2 is nowhere in sight as it seems. If it shows up, I replace this one then.

Regards

Marcel

