Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36FE33A811
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhCNUvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCNUvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:51:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1155C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 13:51:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g8so6967056wmd.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 13:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bHXV2ZUqTx5Nt10y02Zw9tHIUu1VlICSaYSpig1owRE=;
        b=btRvUb/OjDiJpu+e38bHZ3fIXjfdZY0+HxihrX1o1ugL2EeQzjpP6CO8P2OI+AwJm5
         JHATODwIxi/wkIVt4ZQhuJZUy1/xFR2wNTN855crfAnRfaJ3Bwz345TpomBeV51joTt8
         52Y3CS+8HoBCy6KeARgA3VEudVpOOgesuDo4y3Lf/tu27V2mQHROsVhN0SdH5SPp8wcW
         Od6eLM8SKmrEJDqpgI1scqjy1JGm8GxbclgZd9TNLzsyyoEMF7mg6ER+6YrYPM2jmU3+
         eHhn9lwXREMOXdbmnuycPeFKpSQD5dbpdl4IH0e/QNtdvERWh7h89AJ98Fo+Vhzw5mAS
         hulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bHXV2ZUqTx5Nt10y02Zw9tHIUu1VlICSaYSpig1owRE=;
        b=HBuyX4JdjW+Vv1ne7D9Q+zcsTUa0gksWqZEkauR3trugFAWk+ln/BKKKFjW66JyCqJ
         7U39G701O16p3wIKWRU8TVzRbKeyCjwl5DzYA6/wGV7+aFhbeqPH6MswqwHQykH43e5A
         JLK5EBGAuhbfV5MgId7MN9ahT2LtMpetg+OyDXbu/tL1AZv8fswXZBkDd83WEdflypF9
         6i/JxDg2+Yv6HSg2SBnEb2RQeHmPNlyiO2lfgzjoiZ5ecJZmbX5m94LJz/AQuijPjFN1
         Adry4tHKV0McwqHOocu4JYagbLlgCEVWe/0gdcVV4VBh+929cjoGUjvKW7vzErEw+ain
         21ig==
X-Gm-Message-State: AOAM5334NrFmHk654Nma27i5dvNlGxlUkpTnvAkEO6WX596ChX38QAWj
        VGFJTnPbp29kLiVIHDfFeeLWW52lJA==
X-Google-Smtp-Source: ABdhPJxWW3Hmy5rUeOytQWFZ+4mqExjO5dtGIdX1CAttjUn4HxuNDccd2p+Qge9SFXAhTUR74k4wVg==
X-Received: by 2002:a05:600c:4fcb:: with SMTP id o11mr13243188wmq.117.1615755076320;
        Sun, 14 Mar 2021 13:51:16 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.83])
        by smtp.gmail.com with ESMTPSA id t20sm2796866wmi.15.2021.03.14.13.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 13:51:15 -0700 (PDT)
Date:   Sun, 14 Mar 2021 23:51:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, gorcunov@openvz.org,
        security@kernel.org
Subject: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack leak
Message-ID: <YE53QiJuxsCUeoiu@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	prctl(PR_SET_MM, PR_SET_MM_AUXV, addr, 1);

will copy 1 byte from userspace to (quite big) on-stack array
and then stash everything to mm->saved_auxv.
AT_NULL terminator will be inserted at the very end.

/proc/*/auxv handler will find that AT_NULL terminator
and copy original stack contents to userspace.

This devious scheme requires CAP_SYS_RESOURCE.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	apply to >=3.5

 kernel/sys.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2079,7 +2079,7 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
 	 * up to the caller to provide sane values here, otherwise userspace
 	 * tools which use this vector might be unhappy.
 	 */
-	unsigned long user_auxv[AT_VECTOR_SIZE];
+	unsigned long user_auxv[AT_VECTOR_SIZE] = {};
 
 	if (len > sizeof(user_auxv))
 		return -EINVAL;
