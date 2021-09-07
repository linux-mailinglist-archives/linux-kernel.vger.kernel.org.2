Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C3C40252F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242480AbhIGIfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239541AbhIGIfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:35:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9D2C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 01:34:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so18043573lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5jiyAdNFgY4dKiWyQrmXOrxD937CdW4dp/ur4Sj9c4=;
        b=BlQmzjVmTKLmSrVOnikqaOe0A/FKEnJM3rFhecCtOdgIKYpDjjEBh1zx+Jeq2jaHuy
         HEpndfDjUkP4Q/bwSlSuZfm6+jBjWWty1Aoa5/3PJ3DCTqxsShc5wmPWPdIsbLdUnXmT
         z5BbxjQkpk2CPbOwRH8N+FT6cSxCkvQr2jopktD4SXq+hwqmJUOqrzeI8DTngadcFAhR
         6LLGXeTPWB4cfp6bzbSX3ea+jFjLiwTjCU4SRbib2sdAJ9xYSl/yPQmWppe4wF8zcWvQ
         JSPtjw3PrJ4XZXg3bF8AFhJ+oGLXe91SRx4VeQXBxQLE4EYhAn0OHuoOeCmycHrGfWvU
         hAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5jiyAdNFgY4dKiWyQrmXOrxD937CdW4dp/ur4Sj9c4=;
        b=nQVNzAV5R9gRLioK9v/w9CDJdtDifQiv+Wi4BcAlHcQjwAQv+wSmRoPhKIIqAvfihX
         YGg3WK1fgZbyuIi7EOuS8s0BjptH2yzKp/71mrekVUSzT5XRulnTSJjVlNRZF+9Yv3k+
         9hn+U4lDkJJYBWetIOLI1fMzh5zH0jBMXFfZHP9kcvcNV69r6OX9K6DoVJedHxI+EBqg
         KoNYguv67OWGIEnFsz/FaxAl1h/nUstHjqs4O6yT9/o3KeoFpmPWAQUGx5kOR4r5qRa/
         2BTcgJ3DpymluRlJLXxTgoTtTIDOyYXeC4FspdfDj7UuHYURWo675kRi9hoiCA8Dgmev
         eaHw==
X-Gm-Message-State: AOAM531jvDPndQsbx02C9QqY79WIuD1ER8BVsmeNUnxq/3HEaqroFEbD
        q1Gz1nWBe6BeqBO7one7TzM=
X-Google-Smtp-Source: ABdhPJzrMwAvsjOXzbEsId4NE3ssWmqDEu6qRo7UrT83m2EbLwX96UaOC3dYuA4wNMOgQTpvo4Fy1Q==
X-Received: by 2002:a05:6512:3da2:: with SMTP id k34mr12272632lfv.260.1631003686539;
        Tue, 07 Sep 2021 01:34:46 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id q30sm944771lfb.155.2021.09.07.01.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 01:34:45 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v2 0/4] fs/ntfs3: Fix various styling issues
Date:   Tue,  7 Sep 2021 11:34:37 +0300
Message-Id: <20210907083441.3212-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix various checkpatch warnings. There will still be some but they
will be addressed in different patch sets.

v2:
	- Remove + sign completly in 1/4 (Thanks Joe)
	- I dropped one patch as it addressed else were [1]. (Thanks Joe)
	- Drop newline in 3/4

[1]: lore.kernel.org/ntfs3/20210902154050.5075-1-kari.argillander@gmail.com

Kari Argillander (4):
  fs/ntfs3: Remove '+' before constant in ni_insert_resident()
  fs/ntfs3: Place Comparisons constant right side of the test
  fs/ntfs3: Remove braces from single statment block
  fs/ntfs3: Remove tabs before spaces from comment

 fs/ntfs3/frecord.c | 7 +++----
 fs/ntfs3/lznt.c    | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)


base-commit: d3624466b56dd5b1886c1dff500525b544c19c83
-- 
2.25.1

