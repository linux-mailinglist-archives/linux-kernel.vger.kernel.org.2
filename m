Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DFA39349A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 19:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbhE0RQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 13:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbhE0RQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 13:16:27 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5305EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 10:14:54 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l70so441152pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OqveEGoL3ykfBq8zJtkXfVIXCQn6P1IwlpFVQTIOx+E=;
        b=G1b/bR4tJrhqaI4phTRsGC26D8zUwR63Ao0FWwJNaxwjal32hZaQITiukhEt4hMN3a
         OjXoYpVpJAMSXNf3PocHlP0t6ap9Vj0eX3TQJnKsJjvl0A8ievZWw10am6up++/NyDDT
         41fgH+HT5uXfRNjdyorUorZk4RF//D/NOWpdU9tpeV6EzUyIS3eLSCuL9oHHpO2Nsu9N
         G1dfImj+8p7Iq9RFbg7nXrZER3rvubm6sw1bnffJk68lO0l64oTNXxihCxtFbqsLoBr+
         3x6YuNgIMDBx657rjGLHaOQ3waakOFZKd/MijZE+FbP2m8HLqs1KtY7+CYwLkPADLPZS
         gG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OqveEGoL3ykfBq8zJtkXfVIXCQn6P1IwlpFVQTIOx+E=;
        b=kcp4CKwxR3J/99qIeRdnM1KDkbfao1UAC7hjqW9NyQ42hHWC/72US+grD170VJGHqE
         MchsgbBWk2kVS/FkBQ7CHU435zyRnYk7OsTZY8pnHnfaEYKuzMnNMh8UC6WTTCGvNdeg
         XB/H8QP3dHbjQQG/tyLNm2BALJgHuEa1PgqYzeVesHVcmJyyw1800aSUzm/Z2W1GNhch
         JpfXlg8kAKScczFYYoRJm/y2q/HWxkJKpRnaac40Fe4BXyB6a3oQFrLaqylUxBurh0Nu
         Eh/dGUw/ZLK4dhEn710cj7CROS29EMm69Jme3LL0lqmyJjzeSr4Z2EZW2ysk3FlSpe5D
         sitg==
X-Gm-Message-State: AOAM533Nn0bNoSCnlSHpZz4FRimflX36VmHUamcfknHY0cWAUk8xAe0D
        2XEnf1HaucCHplP0y1T/Mvg=
X-Google-Smtp-Source: ABdhPJzCPtzNSjt2WgzO0eFSPRCjTUwRUj6WvIizrkThQYuGvemIlzlHg/CAYIRvdDbn7G00zzEVwg==
X-Received: by 2002:aa7:9d86:0:b029:2dc:9acd:620d with SMTP id f6-20020aa79d860000b02902dc9acd620dmr4731720pfq.30.1622135693833;
        Thu, 27 May 2021 10:14:53 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id k13sm2378392pfg.31.2021.05.27.10.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 10:14:53 -0700 (PDT)
Date:   Fri, 28 May 2021 02:14:49 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Remove redundant variable ret
Message-ID: <20210527171449.GA145584@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable saves return value of event_hist_trigger_func,
but it's never read. So it's redundant.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 kernel/trace/trace_events_hist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c1abd63f1d6c..414f2727d7a7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5225,12 +5225,11 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	struct trace_event_file *file;
 	unsigned int i;
 	char *cmd;
-	int ret;
 
 	for (i = 0; i < hist_data->n_field_var_hists; i++) {
 		file = hist_data->field_var_hists[i]->hist_data->event_file;
 		cmd = hist_data->field_var_hists[i]->cmd;
-		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
+		event_hist_trigger_func(&trigger_hist_cmd, file,
 					      "!hist", "hist", cmd);
 	}
 }
-- 
2.25.1

