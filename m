Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6B933CD97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhCPFsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbhCPFrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:47:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F3DC06174A;
        Mon, 15 Mar 2021 22:47:55 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id n9so20920256pgi.7;
        Mon, 15 Mar 2021 22:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtOfFrwlqkf2krV4UnTOaGgRKM0mS+2xLAv0ovtGplY=;
        b=PPdt/PL54CZoqen2mZAqOe5Kuhbj1ZXG+C9wFNdCLXl0xe2esL6DIMjUZCAlHGd/uw
         lVD2Gy/QbKGEqMJ8e5uYVN6IkEexHqFbbWTL5OqUJpxliTi6mNcqTJfS3WdETpTGvFaF
         /K/I/J0BsQWv+jwGXhagRyFZI70+MDCSHpq2Qx0fPKdeqgugI5Z1u8ig2hJmfdI0XOwW
         7Ca3F1z7m82fICyPSTLj9eulXE8JhcsRu7YQfJaB2dh3bR8EXdyK+k5catqPkvk3mDtq
         NNZg+76fEPmc3hK9MTxHwD6BBWyEVx2E3s12BdW/QFwI4xyjl7CdoBNl+m62j1L+ItKa
         ytdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtOfFrwlqkf2krV4UnTOaGgRKM0mS+2xLAv0ovtGplY=;
        b=rQgEC3lkvUNQDej8qEcWzm3Jrqk78A9hpX6uKtK+v5CADpLkvV3KKI+2djJgdwAOnO
         XxHO6x1qwzjOUf3Wfgg3xCp4k5Cdrcvl5RJWZ9HSEPbzM4dfpYQawhgX1VHMqV3p+XB3
         hDKIqsxbq++P+joa5c2QM9/ic7OYEtXX7euvjsSI0HHF2I2ZLFhJtX4uYLtuwyTFb09J
         WmoLvZGG3wUb5raEJHhtjYK/vCE0clxFfA84fUUq8rED+1L5upXKJjNAWnc7AxdI3FCL
         uejjZK2no+h2WL7+FL3R1aG6mQzSG2Acss/ygc1kflKN5EtR5tyrauG9fw7R2d6AWizd
         S5cA==
X-Gm-Message-State: AOAM533lbjgKoAcJkIkuWg0phIDodAm3iuMTy4LdXLMbrXOswzdJiNuR
        MDxWm5ogCRaNXqgGSSZdxt0=
X-Google-Smtp-Source: ABdhPJyalTxdFQkvCnGMm0X617kx8T7224ruISFRHRZcOXyy9aKBiaxCpQyNIlqx4uRX3Ux1WzwjFA==
X-Received: by 2002:a63:6206:: with SMTP id w6mr2364741pgb.363.1615873674798;
        Mon, 15 Mar 2021 22:47:54 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l22sm15096513pfd.145.2021.03.15.22.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:47:54 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 06/12] docs: path-lookup: Add macro name to symlink limit description
Date:   Tue, 16 Mar 2021 13:47:21 +0800
Message-Id: <20210316054727.25655-7-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316054727.25655-1-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro name MAXSYMLINKS to the symlink limit description, so
that it is consistent with path name length description above.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 66697db74955..af5c20fecfef 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -992,8 +992,8 @@ is 4096.  There are a number of reasons for this limit; not letting the
 kernel spend too much time on just one path is one of them.  With
 symbolic links you can effectively generate much longer paths so some
 sort of limit is needed for the same reason.  Linux imposes a limit of
-at most 40 symlinks in any one path lookup.  It previously imposed a
-further limit of eight on the maximum depth of recursion, but that was
+at most 40 (MAXSYMLINKS) symlinks in any one path lookup.  It previously imposed
+a further limit of eight on the maximum depth of recursion, but that was
 raised to 40 when a separate stack was implemented, so there is now
 just the one limit.
 
-- 
2.30.2

