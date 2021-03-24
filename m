Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0F434731B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhCXH71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhCXH7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:59:11 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F265C061763;
        Wed, 24 Mar 2021 00:59:10 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id q9so11836296qvm.6;
        Wed, 24 Mar 2021 00:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2oLFU6kBXtBoiJ99rRAKUcC4swMk8Mzo4U07drU7Y6o=;
        b=OU4/IbizPTEafdf8uxb7yWWxPLSj01VpjpWS75K989gfYSeFGIuerRPAb8jh/dYwZL
         T5xRDPiNKcsfOUZCxA2g+qAq0gt/wnx8IeS1tb9RDy2Ql61s9pDM6ZCsHevz0UUGfdeV
         2Wm6O4VAhUv/avPMMMZ4rMZQ6iYr6dAmUwUSu8HNYTjpWFAArIruD3upRy+3AF4Y20Vq
         TqykUl0zKmRw5HIKTR8QzXARhtcHTHQCh8SEKf5hT5g6xVBBAQ8Pt1rX0gzjnWO83eGE
         r53Af+0sBc9E47Drrk0jXaptfFW70IsAfSY5VQgNQDca1j2sNpKoZlG5P1KmpQ9zUM/Y
         r8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2oLFU6kBXtBoiJ99rRAKUcC4swMk8Mzo4U07drU7Y6o=;
        b=P1x0EEMofgqqjdLkFM5puF5iboANEDynZBYzQGwnb1/wHkvT0fFqvi/PYKaJvQ74kE
         Gi5SeSjaPrvkPWf/Xc5f82X/+VQ8AgYXawYBO07FdMtfr5RxlfJ4HJUBD0KvmwuIKLfu
         GNXVw2sFSzfKeafyaxkwg+aB/o8lVjvTlV2XTXcKi4QVRmdymHAkEKovUSdYZ2gCjkdF
         Kshv70W7GF4XZzc+IRQ/Y/gSwGJrWo50HsQ9hlNU/5+Dn1gct7AAWBySo/eiXj6fIp4d
         y0jyoFGIeoOQlgaib8Jr6t4luLcLW02EutvQ6j0ZUA78wbtChYHkkQMXIrq06QK7zl8R
         3Ufg==
X-Gm-Message-State: AOAM531PXHxdB+ANH56umgW1lsx7f5SkLfsk+yj4zb3AvyS4F3LH4mUZ
        GJYjmoK6WUikAPh1lR40Gjc=
X-Google-Smtp-Source: ABdhPJznOSMK9G1E7ai3er0zItGQW6bGviQAad+yyppUypFVjw9UcpB3PydlSFdmUbXkS+TFf1ZbHQ==
X-Received: by 2002:a05:6214:1484:: with SMTP id bn4mr1751584qvb.8.1616572749950;
        Wed, 24 Mar 2021 00:59:09 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.37.194])
        by smtp.gmail.com with ESMTPSA id m3sm1137709qkk.15.2021.03.24.00.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 00:59:09 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, walken@google.com, unixbhaskar@gmail.com,
        grandmaster@al2klimov.de, willy@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] docs: rbtree.rst: Fix a typo
Date:   Wed, 24 Mar 2021 13:30:46 +0530
Message-Id: <20210324080046.20709-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/maintanence/maintenance/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/core-api/rbtree.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/rbtree.rst b/Documentation/core-api/rbtree.rst
index 6b88837fbf82..ed1a9fbc779e 100644
--- a/Documentation/core-api/rbtree.rst
+++ b/Documentation/core-api/rbtree.rst
@@ -201,7 +201,7 @@ search trees, such as for traversals or users relying on a the particular
 order for their own logic. To this end, users can use 'struct rb_root_cached'
 to optimize O(logN) rb_first() calls to a simple pointer fetch avoiding
 potentially expensive tree iterations. This is done at negligible runtime
-overhead for maintanence; albeit larger memory footprint.
+overhead for maintenance; albeit larger memory footprint.

 Similar to the rb_root structure, cached rbtrees are initialized to be
 empty via::
--
2.30.1

