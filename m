Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5BB33BDC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbhCOOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232159AbhCOOBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:01:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADFC064EEF;
        Mon, 15 Mar 2021 14:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615816839;
        bh=Q7fOIOhYYEgWEapd03u/hAGSKrUrhyVrhseD34/Bq5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1+DgOmcgNu3g624Ae03vJqQwuNt5gnGkcsndgVcN8OH/uqVfWyd/IUkea4iJSdj9t
         4WczvCcmhWRzKDUp4eHPiUVbKRHYOOydVnvA/3dPDMzMKkAHGc4JjfK4q2PaCAARKD
         SROiCUHffL5Y478PFkGiy+BBvGP/DhO74l0nnt1w=
From:   gregkh@linuxfoundation.org
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.19 104/120] staging: comedi: pcl818: Fix endian problem for AI command data
Date:   Mon, 15 Mar 2021 14:57:35 +0100
Message-Id: <20210315135723.380838238@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315135720.002213995@linuxfoundation.org>
References: <20210315135720.002213995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Ian Abbott <abbotti@mev.co.uk>

commit 148e34fd33d53740642db523724226de14ee5281 upstream.

The analog input subdevice supports Comedi asynchronous commands that
use Comedi's 16-bit sample format.  However, the call to
`comedi_buf_write_samples()` is passing the address of a 32-bit integer
parameter.  On bigendian machines, this will copy 2 bytes from the wrong
end of the 32-bit value.  Fix it by changing the type of the parameter
holding the sample value to `unsigned short`.

[Note: the bug was introduced in commit edf4537bcbf5 ("staging: comedi:
pcl818: use comedi_buf_write_samples()") but the patch applies better to
commit d615416de615 ("staging: comedi: pcl818: introduce
pcl818_ai_write_sample()").]

Fixes: d615416de615 ("staging: comedi: pcl818: introduce pcl818_ai_write_sample()")
Cc: <stable@vger.kernel.org> # 4.0+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20210223143055.257402-10-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/drivers/pcl818.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/comedi/drivers/pcl818.c
+++ b/drivers/staging/comedi/drivers/pcl818.c
@@ -423,7 +423,7 @@ static int pcl818_ai_eoc(struct comedi_d
 
 static bool pcl818_ai_write_sample(struct comedi_device *dev,
 				   struct comedi_subdevice *s,
-				   unsigned int chan, unsigned int val)
+				   unsigned int chan, unsigned short val)
 {
 	struct pcl818_private *devpriv = dev->private;
 	struct comedi_cmd *cmd = &s->async->cmd;


