Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671333DC3F8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 08:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhGaGbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 02:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhGaGbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 02:31:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A96C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:31:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c16so13634211plh.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=qIjbr+bB3b2M/mjNyixbaPxC5u6C27XmhB1R4YVuR4A=;
        b=sMj5HuKPgFyPTo4c3LC5MzvgaL4cUri7Ek8+Fxf1TRLjqOt8nxke5Nv/FbO209pTX4
         jtnROqrwCSzaThBSaiyq3KOI/rRDJAmu8kKS7wJ46wO9nd1VsGWpwv6kFg1a8U24v2tJ
         J01c2c+oVkh6uwE8O3lIJswOh/lfbyipccBsFYXsOakHE8Ea6fJ+JKpwq9ZsfdCB+QYw
         NTAWfKCOq9Ve1IrMsHbGX6XUQAkvVMZGQWoq5KQ7+TLt1z9+WP7ljklA91Sn6uWAgKaA
         6CNVfrxE7LEpBfX13FPGU/0u2V7jS2xvB+OBNYWQtZoiRhm7nHdTcoBQun+NsgKCDFOU
         q/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=qIjbr+bB3b2M/mjNyixbaPxC5u6C27XmhB1R4YVuR4A=;
        b=eRdXgWkffqoFV9jEG/RWBYqFUlzz0QEnD+VLChHkqn31V8aafbVE6LsbXKlrxwmApD
         ztpIgWDXYuB/LFTtI+50pOvnVJXLy7aGuk+kDHPFZOMhYgPBbS5WzMKRiCcEGqX5f99v
         Tucwzc5aOLuCGKXdrilcB6qfMejT7pw2UVOoZobnJHrWvqVt4H3zyvTBx1NXI5Nka5Sh
         1qbMGuV84kxa+L8LNUj80syd+UzIluJwTtUX0t9b7zVZw8R9TMwsD7Zjk7a5wlavO8yz
         l8K/UP61nTsImv5zsdLZSdlAiukERrynf5OWGPCgIb86dBJ2XW3w2c0gccPJUiqpCvR0
         FpZQ==
X-Gm-Message-State: AOAM530pGHzYEhWYEvm4bO/mRFTYql27rxeOkBdt92t/P5Qr7Eb4NR8v
        0tVQ3OLEi8QZ7rDVWwkGjhI=
X-Google-Smtp-Source: ABdhPJwc2rieJ6CRVUVfh9qjZkUSX/FqySfbO7siHkND9wdIQtdcsqX52axifxcVqDVmRZQtTYwaVw==
X-Received: by 2002:a63:6c5:: with SMTP id 188mr2329643pgg.39.1627713064378;
        Fri, 30 Jul 2021 23:31:04 -0700 (PDT)
Received: from [10.106.0.50] ([45.135.186.29])
        by smtp.gmail.com with ESMTPSA id n17sm5263572pgj.93.2021.07.30.23.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 23:31:04 -0700 (PDT)
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com
From:   Li Tuo <islituo@gmail.com>
Subject: [BUG] jfs: possible uninitialized-variable access in xtSplitUp()
Message-ID: <6b3b3a56-b77c-aff7-c9f1-94a99d4929d2@gmail.com>
Date:   Sat, 31 Jul 2021 14:31:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Our static analysis tool finds a possible uninitialized-variable access 
in the jfs driver in Linux 5.14.0-rc3:

At the beginning of the function xtSplitUp(), the variable rbn is not 
initialized.
If sp->header.flag & BT_ROOT is true,
780:    rc = (sp->header.flag & BT_ROOT) ? xtSplitRoot(tid, ip, split, 
&rmp) : xtSplitPage(tid, ip, split, &rmp, &rbn);

the varialbe rbn will remain uninitialized.
However, it is accessed through:
814:    rcbn = rbn;

I am not quite sure whether this possible uninitialized-variable access 
is real and how to fix it if it is real.
Any feedback would be appreciated, thanks!

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

Best wishes,
Tuo Li
