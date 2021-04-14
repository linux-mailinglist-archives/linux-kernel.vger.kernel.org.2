Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C010A35EE49
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349646AbhDNHWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347513AbhDNHWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:22:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CB9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:22:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w8so7261558plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fOZOvYrVPIcZPO2R1dW7gEMhF5gXoGLf+TJd7DF8ljo=;
        b=HRQJdPkhGjqRsB6YI0Jwx0K/h2FghIaw9XUDYBGZiew7aqo8R0m2+CwOrjpTpGgFMC
         S/srO2NNCgixWWUO7YixYFcQlf8oiduiBGx4n8LkDFwuL3+T/gTK3l8tijP8zio6TU7Y
         5uw1v3/yBHIqq1kKWXQMPkJA7SNKMboqbJ3tmcI7HCqi0InZB2ogDCb+4zJbrkZJU87h
         fUpoUQS8oWRB3DGalomq71SCS1uuBPudoMBaF71LbnDOne8pTYA6w9D0D+jekRTwZWUp
         f5m4MGhcXrGMqrLdjZ61cCpOGB/T7eTn8NLa0YGNPpucf6sUPhh0AnPQS9R65OU7xlcJ
         sOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fOZOvYrVPIcZPO2R1dW7gEMhF5gXoGLf+TJd7DF8ljo=;
        b=KG8FH6IJjaoZmQCb+VW7PV6OjwrRA66NAtHkN1X/2Uv/1hM7F28lTUrZ3gRFVgKqEr
         6QoAzBwFqB7IFkzvv9u6jBJi/CwDAuCpZ3uKb+6x3uTPOFQ3H9BmV6nV5x4IEqqBpoQc
         yzS2HI7MK+ub23VaCUNnLKkjSWurEg9lMwZNVGoJqyC2QxxIEqtxkCUxwcolWqcTQL0f
         8HhC4JJKkfjAlfaFoIbRYWNv8aPZnNIgTJpsczobwhxKfBl7ujSAtfyNcO9hs7fn/JSJ
         +t+lD9qEV1LPQjYlcZ1zn+XzzWnnWdpwcROaNd3wrzeNqZsWHxrRYplj27owQIytmklu
         PCww==
X-Gm-Message-State: AOAM530praq6E0qIAw67E9hJMlt3mcRQocqAmb2J2T/Vq3c8DEyFO/ea
        OS28fOZUkgl0gpumdKnq+DeV7FQeWwuXjQ==
X-Google-Smtp-Source: ABdhPJwD9xA9TFfNPjtfquklFyJTiYrdUaPFWrmyRgn4DButJl6iWVYC5sH1H9fyuQ7hLtOoLnieyg==
X-Received: by 2002:a17:902:6bcc:b029:ea:f58f:274c with SMTP id m12-20020a1709026bccb02900eaf58f274cmr15518935plt.68.1618384921966;
        Wed, 14 Apr 2021 00:22:01 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id u1sm16135423pgg.11.2021.04.14.00.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 00:22:01 -0700 (PDT)
Date:   Wed, 14 Apr 2021 12:51:55 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v6 1/2] staging: rtl8192e: remove parentheses around boolean
 expression
Message-ID: <60483f646c16ffd3c19ca8f508a1f1c3a0a13db6.1618383684.git.mitaliborkar810@gmail.com>
References: <cover.1618383684.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618383684.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses around '!xyz' boolean expression as '!'
has higher precedance than '||'

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
Changes from v5:- No changes.
Changes from v4:- No changes.
Changes from v3:- No changes.
Changes from v2:- Modified subject description. Changes has been made in
v3.
Changes from v1:- Removed unnecessary parentheses around boolean
expression. Changes has been made in v2.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index b1fa8e9a4f28..431202927036 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -276,7 +276,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	struct rt_hi_throughput *pHT = ieee->pHTInfo;
 	struct ht_capab_ele *pCapELE = NULL;
 
-	if ((!posHTCap) || (!pHT)) {
+	if (!posHTCap || !pHT) {
 		netdev_warn(ieee->dev,
 			    "%s(): posHTCap and pHTInfo are null\n", __func__);
 		return;
-- 
2.30.2

