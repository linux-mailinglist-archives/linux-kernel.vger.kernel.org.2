Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71844389AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhETBhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 21:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETBhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 21:37:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C0CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:35:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s4so6525355plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMxNESd1nnW1kTHWLNEtfCLTGQb9RWPJzewtiKfvmJY=;
        b=aravIQ2bTNwRMj7Fd4Q2v4zNOLC74wfZOaqO1UCgYraFYWp28ovaFC05Un3Wz1IsIC
         MneVBdd8LTg7Ff1W80TNa/G2YRvnC4u6fMMLANMSnHSYqwtdtRPGFqpeIZXcaUnNKFC2
         d8Wd9G16q3gcMfZWCKvDlb4gGOqeuMP60JekM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMxNESd1nnW1kTHWLNEtfCLTGQb9RWPJzewtiKfvmJY=;
        b=Xlhn9Y9MD53iIYIb76llb0vlvLIuwEvJtj2DuRDXO5Iw1cj4ehfqMYLIzQ6KkRmw00
         TCG4E5U7Xd0oh/q8ddyk+XS8MVWym/fvKQ7q+1lvxKxZjrHATABobhFZ7hAiIbGgXijk
         T09V8YWtBDkQFxqnZlcpnQhLyeF1sV8WSAY4zakfVrptPbRpqL2D+uwLEwN/h0ZyIULi
         cLZTsXD+2o68OS+ZpAuBUUp+XlY5USGq2EIQZFZSD6uyDfhD1O98oaIh3tt9C4ESKjWX
         zUuV0ntPLcXsr+1P37Ssw0rXOqajpz7D5I5lbVgZn8BJey9XcbXPk2CMwKFSyzyVEET5
         g6AA==
X-Gm-Message-State: AOAM5322/UoWwbbe5jzdqlelrmab2kwS0GMiEiLo5u/NgOUgoyBGqjPn
        rrd6wzqw6PIKjmteeA5AdTmQKA==
X-Google-Smtp-Source: ABdhPJzOsRUfmlmBKiIkg4MVA3VhqnS/L700ejRySsi7ZuxD87BVXOfYFiwcudoc5KtWpZjBbzn1Zw==
X-Received: by 2002:a17:902:7683:b029:ec:a434:1921 with SMTP id m3-20020a1709027683b02900eca4341921mr2845004pll.67.1621474541172;
        Wed, 19 May 2021 18:35:41 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:200b:db75:4e6c:8b96])
        by smtp.gmail.com with ESMTPSA id m20sm5097368pjq.40.2021.05.19.18.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 18:35:40 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: [PATCH 0/3] slub: Print non-hashed pointers in slub debugging
Date:   Wed, 19 May 2021 18:35:36 -0700
Message-Id: <20210520013539.3733631-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was doing some debugging recently and noticed that my pointers were
being hashed while slub_debug was on the kernel commandline. Let's make
the prints in here meaningful in that case by pushing %px throughout.

Alternatively, we could force on no_hash_pointers if slub_debug is on
the commandline. Maybe that would be better?

The final patch is just something else I noticed while looking at the
code. The message argument is never used so the debugging messages are
not as clear as they could be.

Stephen Boyd (3):
  lib/hexdump: Add a raw pointer printing format for slub debugging
  slub: Print raw pointer addresses when debugging
  slub: Actually use 'message' in restore_bytes()

 include/linux/printk.h |  1 +
 lib/hexdump.c          | 12 ++++++++++--
 mm/slub.c              | 24 ++++++++++++------------
 3 files changed, 23 insertions(+), 14 deletions(-)


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
https://chromeos.dev

