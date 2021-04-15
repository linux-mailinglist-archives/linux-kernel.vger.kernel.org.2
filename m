Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65943605FE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhDOJiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:38:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40255 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhDOJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:38:38 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWyRz-0005zg-3A
        for linux-kernel@vger.kernel.org; Thu, 15 Apr 2021 09:38:15 +0000
Received: by mail-ej1-f70.google.com with SMTP id d16-20020a1709066410b0290373cd3ce7e6so723791ejm.14
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aRJNj2Va0WuSj7bZqa+mg+YnYSMlodN/I41H1ztfK0=;
        b=ktKajLAQxCVsNzl8hI7exvjoO03/0O9rWdiid081DnMQlUvUc58wKV6M5GxBYSv0cS
         HAw5G11v5/58eq5AMHc82nyxmb7kufw+jH7TIX9ADjYRvUe+k7o95BnDqXSZ2RwJMkLR
         r5+W/OVmJXCSaSJwdJooxuYSz0E547zDoGReheSxVnvMUau+V6NYkn22Li5EaIs5G98l
         enM7mnkRiyvciCA1SFy9x/u++HoAP3SGYQO3k3MACHQeEmwM1wVYR+ZK4gajhMNFkyNq
         95RHQ6DG6q0lIJFlIQgBWDmhmzGLID0EUgMAV5w/KEDMo+6G7ej16r6zWy761qNftH/z
         Gqmw==
X-Gm-Message-State: AOAM531mvMU5DYhtkDDLF0k5PG+tWNlpU5Fx+NiEqxWs281rcfdKZIke
        06/ZhtL005CQeIR1+q7QZZ4oLjSH1wR7m1XCjsFF4Ei7kKjRPM8HOt6bemXxvF6r/NNo3GR7tM7
        LIMpF1CbIuncwRV78oUqSNMilC6X1njGovJyxfpGEQA==
X-Received: by 2002:a05:6402:12c3:: with SMTP id k3mr3104010edx.86.1618479494841;
        Thu, 15 Apr 2021 02:38:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8hCXucMNCy2MFa0IAxrCmDHgzWOO5+IZIekrpsC964e9WmaUDMs8NNfahxQW97g1nkmD62A==
X-Received: by 2002:a05:6402:12c3:: with SMTP id k3mr3103999edx.86.1618479494737;
        Thu, 15 Apr 2021 02:38:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id cq26sm1954088edb.60.2021.04.15.02.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:38:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [RFT 2/2] i2c: s3c2410: fix possible NULL pointer deref on read message after write
Date:   Thu, 15 Apr 2021 11:38:03 +0200
Message-Id: <20210415093803.162673-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415093803.162673-1-krzysztof.kozlowski@canonical.com>
References: <20210415093803.162673-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt handler processes multiple message write requests one after
another, till the driver message queue is drained.  However if driver
encounters a read message without preceding START, it stops the I2C
transfer as it is an invalid condition for the controller.  At least the
comment describes a requirement "the controller forces us to send a new
START when we change direction".  This stop results in clearing the
message queue (i2c->msg = NULL).

The code however immediately jumped back to label "retry_write" which
dereferenced the "i2c->msg" making it a possible NULL pointer
dereference.

The Coverity analysis:
1. Condition !is_msgend(i2c), taking false branch.
   if (!is_msgend(i2c)) {

2. Condition !is_lastmsg(i2c), taking true branch.
   } else if (!is_lastmsg(i2c)) {

3. Condition i2c->msg->flags & 1, taking true branch.
   if (i2c->msg->flags & I2C_M_RD) {

4. write_zero_model: Passing i2c to s3c24xx_i2c_stop, which sets i2c->msg to NULL.
   s3c24xx_i2c_stop(i2c, -EINVAL);

5. Jumping to label retry_write.
   goto retry_write;

All previous calls to s3c24xx_i2c_stop() in this interrupt service
routine are followed by jumping to end of function (acknowledging
the interrupt and returning).  This seems a reasonable choice also here
since message buffer was entirely emptied.

Addresses-Coverity: Explicit null dereferenced
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/i2c/busses/i2c-s3c2410.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index ab928613afba..4d82761e1585 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -480,7 +480,10 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 					 * forces us to send a new START
 					 * when we change direction
 					 */
+					dev_dbg(i2c->dev,
+						"missing START before write->read\n");
 					s3c24xx_i2c_stop(i2c, -EINVAL);
+					break;
 				}
 
 				goto retry_write;
-- 
2.25.1

