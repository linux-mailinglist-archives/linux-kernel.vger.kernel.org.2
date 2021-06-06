Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67ED39CE49
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 11:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhFFJHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 05:07:24 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:34799 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhFFJHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 05:07:19 -0400
Received: by mail-io1-f51.google.com with SMTP id 5so15121083ioe.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 02:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KrywYnC2rdFM9ZVZ8EVSAj5LagzRyNVopwBpL+tCBJc=;
        b=Kzh7idzGDa/5wfWv6MwJHqWLpU+6Pm9KFESTHuQj6xcgOPDX6veuKeuvbEPn4t5Vew
         oYsMBf0KtGil0GtNjeLYCgaeyC/kw/s5lCdR7OwNMY6OHqPeqREquR+b6dx1hsCfO/wK
         udDGlPEa9MxLIJnr2Cid14LHN1X1jLSDlEOqj6kjDDjjGulXbyjjt/07AKgjE9nYKzPJ
         GRYdqLyAQt1Qgdd0EG3twvfWCputraeB/O8UZS5xLBSPrcivndfmulcYb2s/EDozIwcg
         8lm9Qhb27b8qmORtAS+TXK4WhsGgDZowzh3aFxpMjiHXSTRR8FniaXxKkAds3sny7aIx
         Dq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KrywYnC2rdFM9ZVZ8EVSAj5LagzRyNVopwBpL+tCBJc=;
        b=AMjvnGec0Pe5feFr5tkm2rxNNIkNQ9LM5HSY38bgnxqHtSwymNVwsQE5JTQZQDJnzd
         FRwqMACZSM1IP43vg0VqFO4st/3t7UAS7iDxaSajd2hOiZModRcqsQls76g47Iv7RE7B
         dHtcrkMjw64H9MyWnmsXYHgF3bdb/KXvXKqe8pk3Vo3xx+JPoSwjs+D1CDu5X29a11tj
         98cDA3i5yfhFXsuHFKEvc/PDI7+ogxJ20E8mJfTEd9Q0LdxdEiCvrgkPOCk+l77kLDBg
         6aopFhwOUyDANLMDx833T4A3mVWB/lxMs3OsWaKZtahnGe68rnULflaBNHZja9DQBgXu
         Zatw==
X-Gm-Message-State: AOAM532v4Eh4BWWjQRCfLyy5+KiTKTSwKqM9FOCMCmzq10SA3VXqJg64
        mLVjRVR5+JTzU57U/Za+npwac1F6KKJKB/fW94nwwLj7Duo=
X-Google-Smtp-Source: ABdhPJzLtBzHCThHaNO8FKp+XH3uQqgGoTlg/qsvp41HLEqmX8knTomlvQ6eFJ28sHZiTDSQ67B8huhP5RhKBJ0MacQ=
X-Received: by 2002:a05:6638:343:: with SMTP id x3mr11346320jap.101.1622970252511;
 Sun, 06 Jun 2021 02:04:12 -0700 (PDT)
MIME-Version: 1.0
From:   Nour-eddine Taleb <1337.noureddine@gmail.com>
Date:   Sun, 6 Jun 2021 10:04:01 +0100
Message-ID: <CAJO4vZzKBRZNsas856q4K1UmvhGkcX=tVmuL7kPQ-8=-Fxcsmw@mail.gmail.com>
Subject: [PATCH] scripts: extract-ikconfig: add support for unzstd
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the script doesn't work on newer bzImages without unzstd decompression

Signed-off-by: Nour-eddine Taleb <1337.noureddine@gmail.com>
---
 scripts/extract-ikconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/extract-ikconfig b/scripts/extract-ikconfig
index 3b42f255e2ba..62b84d6d17e4 100755
--- a/scripts/extract-ikconfig
+++ b/scripts/extract-ikconfig
@@ -61,7 +61,8 @@ try_decompress '\3757zXZ\000' abcde unxz
 try_decompress 'BZh'          xy    bunzip2
 try_decompress '\135\0\0\0'   xxx   unlzma
 try_decompress '\211\114\132' xy    'lzop -d'
-try_decompress '\002\041\114\030' xyy 'lz4 -d -l'
+try_decompress '\002!L\030'   xxx   'lz4 -d'
+try_decompress '(\265/\375'   xxx   unzstd

 # Bail out:
 echo "$me: Cannot find kernel config." >&2
--
2.31.1
