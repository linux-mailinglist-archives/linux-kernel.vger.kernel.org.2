Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40089408A78
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbhIMLo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhIMLo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:44:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9910C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:43:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso6327200pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=23tp3sw4Yu8JL/z9J4XVGLF+5gHKtiniS8RyPPdamkI=;
        b=ITwFDee00rrBZFs9a65pWvPZZlC08Ypflwv1DwXElV5rn3fQQVPDmbRoFPNOHFV2iq
         GOpqCZXT/4UxETGvpk2L+hIsGXy6vtUVBstcJsRYvi0CQqnXlzfLzf7CpgJnCUyoQM1b
         +cFwNSc4qSdhXhd48hXFUaIpSsVcXRQnyFWYTLrQpUspMxbeAv2QmSN6Ax5BQ5FfLdw5
         Bn13hRztFSnFLRwiFw22HJd+6LseQedq4NK7r56NmIpqq9Q5MoyTAwiA3lfVfhFUrbTt
         5wo3u+KVPY51fBarIrlvKQS9tvp0obqKDsfWv8xS/og06famA9NYBPL/ull/prxV1F3d
         gVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=23tp3sw4Yu8JL/z9J4XVGLF+5gHKtiniS8RyPPdamkI=;
        b=6Iz7kqkeepvmIw6Zp54xALL7+AT0F8/YAt4Pu0wWEl6ejzE4W/sDWRogS96fxkXQyk
         giRD0+tldrpoq7UQ3+XOzu4bWgou4cHkCtJrh3GqhKiYvR0NPVv1pNWByT7jUjGOpJ1w
         TmJnJBd4ZmnyxdruCuVxFTrFCiNN4fqaPWiv61MRQsM4AO4NiF2IZWLv/BVR3e936fRY
         jIQsh9EaAxKLweSsNn4pZ8yxUSz1p8fug45SKes+c41v966MAmgCpGGKaql4YlsekrCP
         Ms0cnwKFSamlYNHZkHwQLw2Mr9AfIlsUcFTq9W7bsfdS1oWs4fVWUuPiIbLWhBox8GFP
         IVSg==
X-Gm-Message-State: AOAM532nwohoIx92mFOOO3Pj1RpAaXS285m+ZgW3F8BhjR9TXjdnUbH+
        w0/T6aO4Goxd2nFqdQLfSoM=
X-Google-Smtp-Source: ABdhPJz9sKFxeKCOmo1ridvQ1gj5YqFaKeN4lM6+QsAxLDsy43Mv8RYH4VwWMqASN7vXGxRoJepMwA==
X-Received: by 2002:a17:90a:4498:: with SMTP id t24mr12292627pjg.235.1631533422299;
        Mon, 13 Sep 2021 04:43:42 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b3sm3543981pfo.23.2021.09.13.04.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:43:41 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     hare@suse.de
Cc:     axboe@kernel.dk, jack@suse.cz, tj@kernel.org,
        viro@zeniv.linux.org.uk, xu.xin16@zte.com.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        zhang yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH linux-next] init/do_mounts: fix potential memory out of bounds access
Date:   Mon, 13 Sep 2021 11:43:36 +0000
Message-Id: <20210913114336.83684-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Initially the pointer "p" points to the start of "pages".
In the loop "while(*p++) {...}", it ends when "*p" equals
to zero. Just after that, the pointer "p" moves forward
with "p++", so "p" may points ouf of "pages".

furthermore, it is no use to set *p = '\0', so we remove it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Acked-by: zhang yunkai<zhang.yunkai@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 init/do_mounts.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 2ed30ff6c906..ee1172599249 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -348,7 +348,6 @@ static int __init split_fs_names(char *page, char *names)
 		if (p[-1] == ',')
 			p[-1] = '\0';
 	}
-	*p = '\0';
 
 	for (p = page; *p; p += strlen(p)+1)
 		count++;
-- 
2.25.1

