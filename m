Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82737AEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhEKSwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhEKSw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:28 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC95C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:22 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id t3so19127541iol.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dS6uHjz9CiOVRNfXnDoINC1MJqAgC4MzLCRQqOhkkl0=;
        b=TijEh3JEcPfbLKoUPT9uVq7Hr4n03fdW7UhfG0dTCxQaorpz+yRmuehSi3KjdJI3Y3
         cRVnsPnwGh1rHGnwTnXa/9kS7twWqnzJE+KWu95nphFw7dyc3W/1AN8wWWQ9SN+9lRLA
         KT7gefE3LFhehVbQJk+rrRgqHR3C9wD3+PeowYIByWL7sKrKBcgjaE8p7VObAyI1Py/M
         zHK+E43NdI6mLDJ4MiiR+q8XSWsYWXuxbrpE1OgDfmMRWiT8ujWKgGsRXr9zotn51O3O
         4I2gaSzI2p5I5nJOWzwXMojqGr31FUz20OxyfW7mIw+HuH8/ZFZ//EtKOa/OIxfvOm56
         A9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dS6uHjz9CiOVRNfXnDoINC1MJqAgC4MzLCRQqOhkkl0=;
        b=rIeGlR2FGa9Buv4+7iHAGXAKRh004k01gz9nCDJSYpkIIOE49GmvMUcpEydOSs5R8V
         m9jCOx1BvjOfDnqptGLFZxFX8hNYtngNkF3vJljp2hJfqvAhNhLBsGf9MuX8UKvAPPqw
         FlGxclXgysvKGi2SphgmokdCOM0UjnJwTU0Zp/vlK0aID76M4glVQ7EKwFhNN1TxcsXE
         Nge4LHStCkwSs4f/pl5SmQl2+Yt82QsMa2TEiwvqXa8tftG0UBjPktEO0UxPQUmVesf+
         YCCv/t/npe/nM9jcM2vr468Bgmqgqc1KVW2RI/fk/uJz1KpRWNeQS4DqMiUZ4o3Vpvfm
         WfSg==
X-Gm-Message-State: AOAM533vSm4CHFmwbqwxBD/kXbKmrjPXY9c85HNxc+tGUj280eVYotYP
        ny8GnR/O00YfGhB0+B6u/T8=
X-Google-Smtp-Source: ABdhPJxOm1qEuoS1k2upmIrWUWJGvoRYh2qw756gXTMjIJOxYp9oMZsSRyeI/qgyTjx+liffFgke3A==
X-Received: by 2002:a05:6638:2157:: with SMTP id z23mr27889930jaj.35.1620759081774;
        Tue, 11 May 2021 11:51:21 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:21 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 02/28] dyndbg: drop uninformative vpr_info
Date:   Tue, 11 May 2021 12:50:31 -0600
Message-Id: <20210511185057.3815777-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a vpr_info which I added in 2012, when I knew even less than now.
In 2020, a simpler pr_fmt stripped it of context, and any remaining value.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ede4a491ee87..3a7d1f9bcf4d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -920,7 +920,6 @@ static const struct seq_operations ddebug_proc_seqops = {
 
 static int ddebug_proc_open(struct inode *inode, struct file *file)
 {
-	vpr_info("called\n");
 	return seq_open_private(file, &ddebug_proc_seqops,
 				sizeof(struct ddebug_iter));
 }
-- 
2.31.1

