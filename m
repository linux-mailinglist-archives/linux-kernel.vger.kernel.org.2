Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2693714EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhECMCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233993AbhECMBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:01:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6F83611CB;
        Mon,  3 May 2021 12:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043254;
        bh=+GCanUseDL/QVpkhm+jfJ9pTIsTAY/+j1/aKY5VyeMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pr6fJ31eq5HKXXtdKzX+1r2eeqMIkpoc/UprY+r9OT8RTFZ1MSbrPvrPs/hnF+fXu
         7rx6v+vH3T0QCvclpqHOJdfdsjhTKJst14uqDCf9z7guS/FXMkyxR3zxOfwUvhuMfp
         1P9shHncmBLwk8vy8jI5Anpyf21+r1XBwekTRXEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alaa Emad <alaaemadhossney.ae@gmail.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 59/69] media: dvb: Add check on sp8870_readreg return
Date:   Mon,  3 May 2021 13:57:26 +0200
Message-Id: <20210503115736.2104747-60-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alaa Emad <alaaemadhossney.ae@gmail.com>

The function sp8870_readreg returns a negative value when i2c_transfer
fails so properly check for this and return the error if it happens.

Cc: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Alaa Emad <alaaemadhossney.ae@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/sp8870.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/sp8870.c b/drivers/media/dvb-frontends/sp8870.c
index ee893a2f2261..9767159aeb9b 100644
--- a/drivers/media/dvb-frontends/sp8870.c
+++ b/drivers/media/dvb-frontends/sp8870.c
@@ -280,7 +280,9 @@ static int sp8870_set_frontend_parameters(struct dvb_frontend *fe)
 	sp8870_writereg(state, 0xc05, reg0xc05);
 
 	// read status reg in order to clear pending irqs
-	sp8870_readreg(state, 0x200);
+	err = sp8870_readreg(state, 0x200);
+	if (err < 0)
+		return err;
 
 	// system controller start
 	sp8870_microcontroller_start(state);
-- 
2.31.1

