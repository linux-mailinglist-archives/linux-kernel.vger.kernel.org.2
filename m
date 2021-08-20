Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0D3F2BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbhHTMUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240405AbhHTMUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:20:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDB1C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:17 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so847777pjx.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9anjfdG18mJqOXxjRUf3UdDKyUgAbv+ZuCsYxqBeGtQ=;
        b=twzZjDeOPrxYlngTzHxwcw9zo4yRpopoPAdoizt198sg0uckjWYy1S82fiWex+X9E1
         3t961j0RXCLrgQvaa9jrhjmmAgic61ALaPwtMYqgZVqh4/e6SZIMAC2tIfNi3+Uzjbkj
         AOh3rArvEZxOB8zbC0G2x1uqcbcuMz1aUrNSVl16xPsX80JvXTqf3DbTp1ssTSxn9HdU
         uZ4qnWIKbYHeEFtfOqFp5jfbcJsiRaaAlcZ7mhLBS+sSKg32skvpQnVuxSedtohbRad+
         1UkjLCmEPQGmByk0glsswdJuebn3SRN3MI/eG1IXuqeDjubsMW/fIJcv0zzcHy8rxr2D
         8BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9anjfdG18mJqOXxjRUf3UdDKyUgAbv+ZuCsYxqBeGtQ=;
        b=W9u63coa+lDyZnS27h1xM+zpx362f5bQEE9HKJRJRVxbPP1aMZSJChqhNEVqTkHJWs
         HptBP4WEbzx4xchynY91kF6QkUTMbpIjPwUHoSLwjpvpS97PcMkO2hfh0IOwWt0tJPAO
         2camLzq1yCNL4fkYBAjHAE8Or2R/usZyV8xZ6VjIyKjdU9FSp/vkQ84ibd75ycbMEdbC
         ZntdeSEqsKVGGIZZLBX7+rKlaeSIiHXo1SfF6C/6TnFosSc2JDgYMkvqQsoXo1cfVcOu
         r9HiRf8AkHB11tbv6gzlv+DbD5P5GtNYnMUEyXHR+iym5fGJOUJ3foc8FDSlP6WTV1Rh
         uVtg==
X-Gm-Message-State: AOAM533mRAha+Ng8rA/mk/bcxjss3oU1Mt0ln1Y7m+2TMsXRg8/c8hXe
        WbxtXLfTL8dp5c6BEFHIXsg=
X-Google-Smtp-Source: ABdhPJwTUWA5kGbJZ3W/dJttug/arfiryp40gvbIjo7JV3nOXmqUGDiiRJ/M7fdgF9S1X8WMRi1UyQ==
X-Received: by 2002:a17:902:b188:b029:11b:1549:da31 with SMTP id s8-20020a170902b188b029011b1549da31mr15938946plr.7.1629461957193;
        Fri, 20 Aug 2021 05:19:17 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t18sm6629554pfg.111.2021.08.20.05.19.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:19:16 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] tty: n_gsm: Delete gsm_disconnect when config requester
Date:   Fri, 20 Aug 2021 20:17:49 +0800
Message-Id: <1629461872-26965-5-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
References: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

When n_gsm config "initiator=0",when gsmld config ,as requester ,it
doesn't need to send CLD frame data or SABM frame.

Example,when tty dev receive "AT+CMUX=0",it will change ldisc
n_tty to n_gsm,during config requester,gsmld output "7e 01 ef c3 aa 7e",
initiator maybe not want to receive the frame data.

[  154.666457] c1 Q>  0) R: UIH(F)
[  154.669514] c1 C3
[  154.671519] c1 gsmld_output: 00000000: 7e 01 ef c3 aa 7e
[  155.014874] c1 Q>  0) R: UIH(F)
[  155.018000] c1 C3
[  155.020046] c1 gsmld_output: 00000000: 7e 01 ef c3 aa 7e
[  155.364425] c1 Q>  0) R: UIH(F)
[  155.367546] c1 C3
[  155.369597] c1 gsmld_output: 00000000: 7e 01 ef c3 aa 7e

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index e3e1be3..9ded99a 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2304,7 +2304,7 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	 * configuration
 	 */
 
-	if (need_close || need_restart) {
+	if (gsm->initiator && (need_close || need_restart)) {
 		int ret;
 
 		ret = gsm_disconnect(gsm);
-- 
1.9.1

