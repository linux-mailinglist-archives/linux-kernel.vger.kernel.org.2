Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4573633D782
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbhCPPcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbhCPPbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:31:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFC5C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:31:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d15so10690721wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SocEqlvAbRT6Sm4b5Grbre+Ttg/sIXmmWrhwzkaP3Lo=;
        b=a1BxUYnuuD++WR1EXS5rpHMg0T0HK0bqd5q5v35hVmZPDMgEKbPRlSea9BR0thc6KW
         uPmyNyrJ4QucwwoeVtJGCCR+RPBNmDjXzeOcPvbHI+wkM4q1hbYVefnFEDKEwmebTLpt
         9iV5oN5ofcV9z27DfxiakrgZLQvEZ17xVxhIkkb5ediIqE/HgFqYR7rCy6ffd6Vd1AZx
         V2bJjtilE47a6AcD0yBVaQNfUgJi8RvYUwJUUzPuPgOXhCeS7dSGPxevjrrbJBeO+/jp
         SeZ9oHzlJrVrA2aESBmsDsaaZJeYkXu3C5fHScUgx5bk2EaylyAsJfowoNJlQGCQdXTz
         8+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SocEqlvAbRT6Sm4b5Grbre+Ttg/sIXmmWrhwzkaP3Lo=;
        b=R5Lp7ow0WI3Ctx0wCCwaVlLOJzknUp7/PW+Dbq920nNxIA6jSJCrDn+WclcrXPqPRa
         ndw+2wZNF2TE0Fs2xA0wMQjQ5kL60lEfDfKPpOa0G22KTSRcy+rDlaoQNQ+UpQXZAoyU
         KwPijdxjmVAqj92sevdPFselvO2a1OXE1zELGhomdpQjZjxwO08DDPkxDsmQOE4XdkTT
         tIEeX0ZltLeYY5gSnpyFk/NJJCPi7IhVW84wwVUKpSKeZwXBG/9vXYIUDva4InvUIlHx
         ltiRs6crklmjISlAIjfL/qnWtIK4nGQJq0R00OSgfh0BC+VT+3UDAAmgCwa6EuAUj3zy
         7d1Q==
X-Gm-Message-State: AOAM531upVPI4dUTW1hTD89y0mQXJv23WA1hiueK4CG706xNKn9u/hVr
        R3rlOleHbswKz7vGqDIUI0+NBdXUpVQ=
X-Google-Smtp-Source: ABdhPJziwiWFVahoTUxAqu+NNIDNn7QgtFMnwZB1suLQGExASHmxv6zIrlvpBqHMkalo0/xSJ09BWQ==
X-Received: by 2002:a5d:42cb:: with SMTP id t11mr5521719wrr.280.1615908705212;
        Tue, 16 Mar 2021 08:31:45 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id z1sm22259865wru.95.2021.03.16.08.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:31:44 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:31:42 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_LAYER2_ROAMING_ACTIVE
Message-ID: <db002fc802d266f09a1e990a7717a2cacf0ed7a1.1615907632.git.fabioaiuto83@gmail.com>
References: <cover.1615907632.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615907632.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_LAYER2_ROAMING_ACTIVE

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index a9e5c27a42f7..149093c710ae 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -67,9 +67,6 @@ int	rtw_init_mlme_priv(struct adapter *padapter)
 	pmlmepriv->roam_flags = 0
 		| RTW_ROAM_ON_EXPIRED
 		| RTW_ROAM_ON_RESUME
-		#ifdef CONFIG_LAYER2_ROAMING_ACTIVE /* FIXME */
-		| RTW_ROAM_ACTIVE
-		#endif
 		;
 
 	pmlmepriv->roam_scanr_exp_ms = RTW_ROAM_SCAN_RESULT_EXP_MS;
-- 
2.20.1

