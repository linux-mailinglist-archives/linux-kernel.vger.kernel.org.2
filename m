Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27D938AF55
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243515AbhETM43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243568AbhETMyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:54:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415B8C068D9B
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j14so15707745wrq.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B1jkx2yvDVF12RiPS0MW3Iq7nNOEfHW1KrHFbI8bw8s=;
        b=Tlbq9tSUzi6bnsaCGfu1kYVjf219Unow7LbVnXmJf+Z5C0ERVgHn9Gos/qBfcfTf2F
         +nsc9Ag3qI1uJNyxSIfwsdHI2YmpKZq7LzATHpQIm6/BSPq9aMN7sCzvqMzYuzC0AIY8
         xL59Gn6O0qvzPobL/uWQ16uLCsrWQ+RZKnss7Z8z4SDddCqvZfc/F81m3vd/xWqN1/Y4
         ZzMs35tlIOs7SdN/8Un0D/fAvE31TuUGU+Wil/TKYNYZMN4mOpZxnkTsWT1MlbX+TtuG
         nnUN62kZbu3/1GImOrfylLWbZV5hwnr6EaeGOJ3/vgrQ2ojQFHsdpzjQp2PyMvIZeSS+
         rqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1jkx2yvDVF12RiPS0MW3Iq7nNOEfHW1KrHFbI8bw8s=;
        b=LsBizgm0IyDfRVx0eq5KIIWeeVFU8jmfTpFqQ2JrQ3hW/sxbmlBcbSOVKpsmzqgKHT
         3MlzD5Y07Zcxq19Zeneho5cZwLsh3hd5u0kgz/ZiXSpx4rSduNJvupksl8QBpLTBk/UL
         +xVv5HiMcprK9e+KhdypXjZ/5AdT1sLeP/AVzDmFsN2ue7uYf1e5o+NYVn1kFrCKXjd3
         /XqveQxsKbDbAfDtURQYNqxFKz6AFvMzdS8vlJIscB+UxQ9uJq9J77M/h6lfukLKh3Ae
         gXN67by+qp8p//uNei3i8iGB9ia2oLROTWUDnzwX4ipEHkNj8aKIRysJ8Kkn+BRHpJ/e
         kSYA==
X-Gm-Message-State: AOAM531R2Dc2WquTCAcycy4VYwB8E4mwlOktApYogUI2An1bs9lQ7ArF
        MHt7fZr2M66bLSwjalpIShfchg==
X-Google-Smtp-Source: ABdhPJyBMbGKgjTBWX/J1Ck1A+l0FhW0S7v5NMKSerctTmUpgwgRGP596C2HKkfkdkHkOo+v52vY1g==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr4025033wrd.407.1621513157838;
        Thu, 20 May 2021 05:19:17 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paul Fulghum <paulkf@microgate.com>,
        Michael Callahan <callahan@maths.ox.ac.uk>,
        Al Longyear <longyear@netcom.com>,
        Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>
Subject: [PATCH 08/11] tty: n_hdlc: Fix a little doc-rot in n_hdlc_tty_read()
Date:   Thu, 20 May 2021 13:19:03 +0100
Message-Id: <20210520121906.3468725-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/n_hdlc.c:421: warning: Function parameter or member 'kbuf' not described in 'n_hdlc_tty_read'
 drivers/tty/n_hdlc.c:421: warning: Function parameter or member 'cookie' not described in 'n_hdlc_tty_read'
 drivers/tty/n_hdlc.c:421: warning: Function parameter or member 'offset' not described in 'n_hdlc_tty_read'
 drivers/tty/n_hdlc.c:421: warning: Excess function parameter 'buf' description in 'n_hdlc_tty_read'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Paul Fulghum <paulkf@microgate.com>
Cc: Michael Callahan <callahan@maths.ox.ac.uk>
Cc: Al Longyear <longyear@netcom.com>
Cc: Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/n_hdlc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index d899ee4e0116f..580a37b3fe1b9 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -411,8 +411,10 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
  * n_hdlc_tty_read - Called to retrieve one frame of data (if available)
  * @tty: pointer to tty instance data
  * @file: pointer to open file object
- * @buf: pointer to returned data buffer
+ * @kbuf: pointer to returned data buffer
  * @nr: size of returned data buffer
+ * @cookie: stored rbuf from previous run
+ * @offset: offset into the data buffer
  *
  * Returns the number of bytes returned or error code.
  */
-- 
2.31.1

