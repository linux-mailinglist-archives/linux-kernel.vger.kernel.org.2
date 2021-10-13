Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9158742CD51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhJMWJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhJMWJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:09:48 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2F2C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:07:45 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n7so1525483iod.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FixibM0EEPoAynkNmu46dZSmfyD3Z0bGdEJyGhIGZxo=;
        b=qCf5ckP6wW+mOGVuj38SogKUPhKLfL5YdlCecagOR1NTwY8nKAva9Ai8PDayYuF3gn
         M/V30ebmpm3XPnfbYQJtR7EFsyZjwS4Nr8t5Ev5LNyBu63DtNMLNWnNf9XpPsRVy6din
         k3EKZwkEHTEHoOuQPwOsuvd7XUItPDNA94CekMw5dUTQy/6auTXdEv02mepL08lGIDcT
         WVBDiri/NWzmMxKmMz07GKwe4tiV/he42rkhgiKsg+k9EBvPm+eNhX9ass4jn4Pm8nsi
         ua6rMnTpH3fan1URQUdleNzJNxkpTZ48rpY9gAPsc7M3EHTgBkfCLzYkDPLVFMfXaiTO
         OPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FixibM0EEPoAynkNmu46dZSmfyD3Z0bGdEJyGhIGZxo=;
        b=ho7313mw1TjrX4WeH/074gM0JQ2hqZcftajcE0ZGfvDiODOgb79PkwcHj0wf9CD2MC
         J+D6QtMYnsuOP9g5XiJD9rEMRqs5ekJYF8Bw/jRYDOd6TSmIy5TkS2M5e17I5Gb6+fqX
         cq+qFdnS+9GFqNTOcW0IIhUc5rl306ADogoJHWIAg/xT8ttf+VNDtbYIZym/rolYzXbX
         tkwuenwidIbwpiXlkPNyAS//O+r44/PqgkVstDGdThfRtZDJZ6kHAJh4gh2LlhLzggHv
         UJ+Y2RwTd2eFot9N7RyrCI1nhhisuBgZzFZhqMfDPlWBdVYYrfCIWbWR/VAOcl1mes8F
         SDpw==
X-Gm-Message-State: AOAM530GzIVS3Lsv/W3NPN1Mgrhcmy6jbCMi9Ai+JOuX73vA93yCiZlq
        dpGggCLYhb+6Ss1p1H+0dq4JTUOaMJ4=
X-Google-Smtp-Source: ABdhPJzaX5voOpoEXZacVg2YSDR33n744Tx6q/zn2APTW78nLiFz8+FW+6AuqtTgFvegOTFOL1npAA==
X-Received: by 2002:a6b:148:: with SMTP id 69mr1422403iob.54.1634162856259;
        Wed, 13 Oct 2021 15:07:36 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id i15sm324633ilb.30.2021.10.13.15.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:07:35 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/3] dyndbg: fix spurious log-level change
Date:   Wed, 13 Oct 2021 16:07:24 -0600
Message-Id: <20211013220726.1280565-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013220726.1280565-1-jim.cromie@gmail.com>
References: <20211013220726.1280565-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HEAD~recent inadvertently altered a message's verbosity from 1 to 2, restore it.

Signed-off-By: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dfe1e6a857bc..9dd8efb5a756 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -529,7 +529,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (!query || !*query || *query == '#')
 			continue;
 
-		v2pr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
+		vpr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
 
 		rc = ddebug_exec_query(query, modname);
 		if (rc < 0) {
-- 
2.31.1

