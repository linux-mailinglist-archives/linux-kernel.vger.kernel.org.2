Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335A033B68E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhCON6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231468AbhCONyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:54:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EFF464F18;
        Mon, 15 Mar 2021 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615816469;
        bh=LtaBHPPjGw7SX7S201LXX2RssfLoU12kjn9AknrYuH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwJRQiJXm8OXyJ4uAEVu/q0Ynj8EmgQgQeJcmMrBHuL43HZoWPDqWGUrcmi6EOWcz
         qtyYpVd7xkwgM+Q7aygGuBFgAFmuPYhj76gbtVCFTHcsZk9GnRKyMM6CEksfkhLU/L
         gLXVTb6kxxwc8JljLiyXNt4ErxH84jTt0wF/+4+w=
From:   gregkh@linuxfoundation.org
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.9 58/78] staging: comedi: pcl711: Fix endian problem for AI command data
Date:   Mon, 15 Mar 2021 14:52:21 +0100
Message-Id: <20210315135213.979988000@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315135212.060847074@linuxfoundation.org>
References: <20210315135212.060847074@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Ian Abbott <abbotti@mev.co.uk>

commit a084303a645896e834883f2c5170d044410dfdb3 upstream.

The analog input subdevice supports Comedi asynchronous commands that
use Comedi's 16-bit sample format.  However, the call to
`comedi_buf_write_samples()` is passing the address of a 32-bit integer
variable.  On bigendian machines, this will copy 2 bytes from the wrong
end of the 32-bit value.  Fix it by changing the type of the variable
holding the sample value to `unsigned short`.

Fixes: 1f44c034de2e ("staging: comedi: pcl711: use comedi_buf_write_samples()")
Cc: <stable@vger.kernel.org> # 3.19+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20210223143055.257402-9-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/drivers/pcl711.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/comedi/drivers/pcl711.c
+++ b/drivers/staging/comedi/drivers/pcl711.c
@@ -193,7 +193,7 @@ static irqreturn_t pcl711_interrupt(int
 	struct comedi_device *dev = d;
 	struct comedi_subdevice *s = dev->read_subdev;
 	struct comedi_cmd *cmd = &s->async->cmd;
-	unsigned int data;
+	unsigned short data;
 
 	if (!dev->attached) {
 		dev_err(dev->class_dev, "spurious interrupt\n");


