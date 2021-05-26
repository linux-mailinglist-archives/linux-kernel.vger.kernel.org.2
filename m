Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4973921C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 23:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhEZVIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 17:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbhEZVIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 17:08:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5510DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 14:06:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q7so4655738lfr.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 14:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VLd5OXrScZXh8ykov1e7sSfF7Q/pna3Hb4gFF9BgLMI=;
        b=Ck/H3n00G9X+o5dBtK+xs1rR6RxEax0xZqqm54XZaB9I1sNZW6rXKA0m99GVrjlpfb
         t0KZXtwPUvQC2nJxL6i1J9AQGc0Ov7Y8iWCR/HuR2uDhqTZKg5Tj1VJH/3GlFv5J7QoE
         NlUFgRlZZmyuFTe2Bk5CRJTRBSgJc6tqIO2+dI/C770ZMunL88YasX7pxMvgWhJ+mKwx
         qG7PcZBrG/XTDzAksOGYWf6i3tu8OfVbNqvZMKsCygvClTDa5Uhd8RhG/jNX/6yuN9tn
         +nVobvsfsOFDdnYHJBfzdnP9KvjRTC/y9GnpiaxGmYf6RcJWBxImy7Xtn0+T/nnKauFF
         ZjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VLd5OXrScZXh8ykov1e7sSfF7Q/pna3Hb4gFF9BgLMI=;
        b=RPXqP3h9gwKmFchBIVwxSYzX76fzepNVSXcoHmIeU8R7j+7W/4Not2bGh2lmYLaLym
         qg3vhxoPlQgh5z1FX66bFaoXLX5t+liF8tMMYzmcYUTRmcoQUIc+2qTMFB+CS9ArD8ra
         PDIAiKkbtgepL8WZtMy5uk/OLz2ZFoPeOvPM52J8HYlfg6E7ZHg3k4NE+it+PsKRntzF
         WuX/DByJbAdg9P1UETjATPlignsALVTBm1sKO+xTSw6V0Q8YRb/mBT229NUk6ijnrJL5
         x/HU6T1JT8xoYrNR4Uuuee+++UixVaTiDDdei4MH7/nw5MtWKIqc/UQwPC+lbrnoZWYQ
         /7QQ==
X-Gm-Message-State: AOAM530h1/24vjw5Kks02CA7vUuRNz9aNLgDst09saN0HuVnnDJjSz8a
        i9p0JtRbvQvxuYl2i+X2h20=
X-Google-Smtp-Source: ABdhPJwavZWnuA1g9gUQdiZMg2Dj80xDEzIKwCNc+3hki0pbQVZpHTRqMuKOjkCv69ZX4E4ffKaRSg==
X-Received: by 2002:a05:6512:3196:: with SMTP id i22mr39784lfe.492.1622063200706;
        Wed, 26 May 2021 14:06:40 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id r10sm16900lfe.110.2021.05.26.14.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 14:06:40 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] dm table: Constify static struct blk_ksm_ll_ops
Date:   Wed, 26 May 2021 23:06:37 +0200
Message-Id: <20210526210637.21528-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of dm_ksm_ll_ops is to make a copy of it to the ksm_ll_ops
field in the blk_keyslot_manager struct. Make it const to allow the
compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/md/dm-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ee47a332b462..7e88e5e06922 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1244,7 +1244,7 @@ static int dm_keyslot_evict(struct blk_keyslot_manager *ksm,
 	return args.err;
 }
 
-static struct blk_ksm_ll_ops dm_ksm_ll_ops = {
+static const struct blk_ksm_ll_ops dm_ksm_ll_ops = {
 	.keyslot_evict = dm_keyslot_evict,
 };
 
-- 
2.31.1

