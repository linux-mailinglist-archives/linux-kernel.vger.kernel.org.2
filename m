Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B6B3F4EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhHWRBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhHWRBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:01:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7419BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:00:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h9so38432906ejs.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKZs89fuLtkQSgv1rIGCp+G5BzMsQVDBKa5KYJGPMQo=;
        b=K9CflRAQPex0Z7F1fAvEEA2mdF8YNHHmNQQYm29NT45BWXaHVee+6I4k+JHaeFJnCF
         fOsw2vwSUW6G8KaIRtsNKklVkmnz9yvqAWOcyWK1PC87F72KKwE/8H+Q4f3coCCyNwI1
         8jMgukxYManP5YW7qO19MEeVYgsD3WoT/T1SK4q39kH7uck3n8Cpt5yPvM53rl2oz8VV
         OKbrCFSG92e/16eglZRKzh4/uzkrPdTkRBHGnDJ1iU7PplBuJNwS2fCjxo4TCN2FXBfR
         T/g6AXZ8xkozSvJStYIMb+OQE81eX/829yYB5kN0J9w1RXWdiF6vhID1Nl5hEejTkVgh
         lFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKZs89fuLtkQSgv1rIGCp+G5BzMsQVDBKa5KYJGPMQo=;
        b=B3y/HF7Ld9iErfCVScFBOeQuurdzYwx3fPHjU3s2vH+2CnoZwMdog/raYA0FwnntGM
         ezro+2zDlV8MJJV3uPw0c3QroPsT6+FVnJm7sIeeGyv+uuL7QahMjkuFy2ioGM91FvMc
         6/nDO/k6i7Qmlud8LE1F13Llyu0QilwCbTlQ9gIjmIqpGYiA/MXkuM1EekkwJEiNCWyE
         K+t1e25GqqjxQ4GpJzCCAMGb4K2ttORuRx1hzuUuGuhSEESp013j+Yd/QmC3mYsbiPbS
         cNpbPDYz82wOzrs3HRYlqiQdS9SsXP8ZyJ4rbDVexNyL1W3MDSaRQBj9lR9QgKVTY0qB
         LvQg==
X-Gm-Message-State: AOAM533NBA4DCECAlsZXU5scF36MZUqnTl9A5C2S/Qq++sA8aYo5xU7O
        FndNJQUtwLzaCX6BnfaykjxNE0B0yeQ=
X-Google-Smtp-Source: ABdhPJxCgMILpou0Z6NZmL/OByXrMkntRIc3Eqde5F/pUwWMJ1KIf9eBp6Vhk28N5ztcwUrBtwSZAg==
X-Received: by 2002:a17:906:5408:: with SMTP id q8mr37220563ejo.54.1629738058019;
        Mon, 23 Aug 2021 10:00:58 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id b18sm1633188ejl.90.2021.08.23.10.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 10:00:57 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] staging: r8188eu: incorrect type in assignment
Date:   Mon, 23 Aug 2021 22:30:30 +0530
Message-Id: <876b83dad76a6f561879da0db1fbb25b251374d4.1629563318.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629563318.git.aakashhemadri123@gmail.com>
References: <cover.1629563318.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
> rtw_br_ext.c:516:57: warning: incorrect type in assignment
    (different base types)
> rtw_br_ext.c:516:57:    expected unsigned short
> rtw_br_ext.c:516:57:    got restricted __be16 [usertype]

*pMagic holds __be16 change it's type to __be16

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---

Incorrectly removed htons() to satisfy sparse warning. Instead make
pMagic use the appropriate bid endian type

 drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 83a4594a4214..14cf13516d34 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -474,7 +474,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		/*                Handle PPPoE frame                 */
 		/*---------------------------------------------------*/
 		struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
-		unsigned short *pMagic;
+		__be16 *pMagic;
 
 		switch (method) {
 		case NAT25_CHECK:
@@ -512,7 +512,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						tag->tag_len = htons(MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN+old_tag_len);
 
 						/*  insert the magic_code+client mac in relay tag */
-						pMagic = (unsigned short *)tag->tag_data;
+						pMagic = (__be16 *)tag->tag_data;
 						*pMagic = htons(MAGIC_CODE);
 						memcpy(tag->tag_data+MAGIC_CODE_LEN, skb->data+ETH_ALEN, ETH_ALEN);
 
-- 
2.32.0

