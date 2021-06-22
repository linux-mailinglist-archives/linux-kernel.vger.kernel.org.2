Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9CB3B00DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhFVKBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVKBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:01:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C5BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:59:30 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v7so16655722pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7b0kVKn9qmmJHGSzYKJ32lLjNTvo0Camp58c232R8EE=;
        b=pWYoHUDwJXmCdk687rBRZXva7Vsbs3zsw9IcTWf6iWjXhmdF1C8hV27Q3fl0Djx0CF
         ztyXtsUzUztj4ppigeAUZBv5xgKSIcmYEHmTeODLNPSN7fLfpF9u6aIdwhgj4kYcOewO
         +2//azhxayqBCLBnPg2ccitNPCYnuTcZ4R4PoLuIpu5OZ1BXy12jKvhwh0+ntM0CdNa3
         Xuh1of0FiYcgkYbq1y80pL6WN8SRWo57f3eAj0T21l0zp+4x1sX2X8F1hnMsVr6vKxxs
         SppPlLLfUO6xydkMU2ohJBhH8S7fVT68ftRJ68qVIwTFvNDt8IcH7M8Ca+RlYOisbwVd
         Ni3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7b0kVKn9qmmJHGSzYKJ32lLjNTvo0Camp58c232R8EE=;
        b=kluAl1Iw4I+/GzYRs3xSC7DjwB0mMyJwrOdhsTHWD0GBmKGWj7CCycH2hOpnVsvBsr
         nE0Usa0OWkVmndWBBRtVMuzNEmNz86VKwC33HvXgCRDo5dt2g5ng+CUvbVpbFc8nmrxS
         pqW1aWVxGDAluhNPpWobKhgKmUXZkSn+uSHyZUKhmWXC3KUsBCkDVoHll8MuACLG1r8x
         agtoWtLCW8vlaMA2cX85RGqb57XCOvrGSaqMAMi788/UecmRDtokviOs9ev4y+AKDRtp
         0iZExP5jXR98xAOBUb2vQ/Wbr6Jf+kCMdIUxs4ePs/dHrxq4dDDSWSLQ4rM28xA+jrKT
         KKsA==
X-Gm-Message-State: AOAM531CfA3rt5o20YUY60HeJHq+1WcY/BXCEfbiTQwO8blHUlzymLzw
        CVuxWCkiCjB+9WoG5Vn1Tac=
X-Google-Smtp-Source: ABdhPJzYlRfKRC+Uaf7vlpZ4PJ0Q5uUTUhXW+dzKqZmJkkrbOJwEu2zoXUbIkJgyOGJGtig+UAB3jQ==
X-Received: by 2002:a62:1ccf:0:b029:304:3c28:b96c with SMTP id c198-20020a621ccf0000b02903043c28b96cmr2909740pfc.52.1624355969719;
        Tue, 22 Jun 2021 02:59:29 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id y190sm18059585pfc.85.2021.06.22.02.59.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jun 2021 02:59:29 -0700 (PDT)
From:   gumingtao <gumingtao1225@gmail.com>
X-Google-Original-From: gumingtao <gumingtao@xiaomi.com>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, nathan@kernel.org,
        ndesaulniers@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        gumingtao <gumingtao@xiaomi.com>
Subject: [PATCH v3] slab: Use __func__ to trace function name
Date:   Tue, 22 Jun 2021 17:59:24 +0800
Message-Id: <cover.1624355507.git.gumingtao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3
 - edit comment and the subject

Changes in v2
 - use %s replace function name for the panic() call
 - use %s replace function name:kmem_cache_destroy

gumingtao (1):
  slab: Use __func__ to trace function name

 mm/slab_common.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.7.4

