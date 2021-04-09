Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A04035A256
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhDIPw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhDIPwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:52:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CCF8610D0;
        Fri,  9 Apr 2021 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617983560;
        bh=1kp3+kVh4wgovHOtbQyFeBMBECiBSIk+VPjiYDcmYDk=;
        h=From:To:Cc:Subject:Date:From;
        b=WSFCTq9/s5kmYKknzg8BAU1lOKAhg3zmKQ5pT7CLnvOVZhWptIKGc58PvoaAEtwMR
         FbbpSd+YqmaD4cnuellicpbPM8UL+MCEecKEsgmRlVJJbNWs2/+PVBKBiaGutBA2eS
         1tg23Bca/JQACmrH75vw57Ta5MzIMxXgJrajAB5ILCpgi7QjSn7yjzRmdUHzmhklQ/
         NpHZ7jyusR1biEV+55efAEPYdVk9mPyIm1AY4tI0aDsbXEPctwjM5+KYULlJVg0YqO
         cXC75Wxe5N4ptzsJ8CtlrPO08jTicq4FzUd0SH917JmMD/I363bl7epgIlY3xL71Wu
         SVopxYfBuJilg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUtQz-0008Il-Q9; Fri, 09 Apr 2021 17:52:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pho Tran <photranvan0712@gmail.com>, Hung.Nguyen@silabs.com,
        Tung.Pham@silabs.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] USB: serial: cp210x: provide gpio valid mask
Date:   Fri,  9 Apr 2021 17:52:14 +0200
Message-Id: <20210409155216.31867-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new GPIO valid-mask feature to inform gpiolib which pins are
available for use instead of handling that in a request callback.
    
This also allows user space to figure out which pins are available
through the chardev interface without having to request each pin in
turn.

Johan


Johan Hovold (2):
  USB: serial: cp210x: provide gpio valid mask
  USB: serial: cp210x: add gpio-configuration debug printk

 drivers/usb/serial/cp210x.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

-- 
2.26.3

