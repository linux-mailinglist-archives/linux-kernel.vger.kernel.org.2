Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA4342735A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 23:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbhJHWBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhJHWBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 18:01:46 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C67C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 14:59:48 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k26so9284325pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 14:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37QohPvu5nxduVScyuuc1g40BjSdo1039ajksqcN9ds=;
        b=DHqd/Jjp5ezOy5swGeDNqrw79op/otO2UwW027Kxroza1uWcW5DIVbMHQAGojlQ5D6
         bVegpv70K42eP/J5lqXzwZ0Rivufe/kPgbyoePUE3p4CbxUj4RjdOQjVmvIOf7WK4Xd0
         +EUAKmYhUsQ7N9lFs/WzS3sI+nQ1ofmcgDmp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37QohPvu5nxduVScyuuc1g40BjSdo1039ajksqcN9ds=;
        b=Qf6uYFh1L6tncYQs40MGXSIVoMxHfL5At2515IsuFslW9LXy48tv3DfVRl/XwPK4Ak
         rjXG+GIU1S0E2xPTYgm4r7GR+I1xmQJLaFnIDfSl9UtwAM1qangfAaLGNwQ8pvkUuT8l
         c1wq1Ohdhz442TGCtwaOuPh3i1lzQ5+sWwjpw4ip1tcn1wtu8nL9dd3qbFMHMDhlbdA7
         JWkJsWE37Xq0QPjMz2lWIjbGMH9T0iQtb80x9bj0Z2yt7ATYnXEE/MF7cXlzZ8BEp5QG
         2aBG1E5x+Kz/EWDMWqByX8T2I0/HAfo9vjSDkgoURvPgj2TiBx5aVQsZFRvlCduBCMX+
         qu3w==
X-Gm-Message-State: AOAM533jl8CDa1TIxSmF3/s0L9MVWxZ8laY7cXpyUaOhO+9lFsDW0pJs
        y7RbV8wIAv1PX6OmZ4ZK3t0U3g==
X-Google-Smtp-Source: ABdhPJxhojz153cZhADfd21xUjR93mbEb0SjlWllpC1kbQ33IDVo1usYmUAthMH0YvAohG9l7myRrQ==
X-Received: by 2002:a63:7d42:: with SMTP id m2mr6708955pgn.349.1633730387828;
        Fri, 08 Oct 2021 14:59:47 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:60ee:fc0b:3092:ca2b])
        by smtp.gmail.com with ESMTPSA id y22sm12277335pjj.33.2021.10.08.14.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:59:47 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jiang Wang <jiang.wang@bytedance.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Cong Wang <cong.wang@bytedance.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] af_unix: Rename UNIX-DGRAM to UNIX to maintain backwards compatability
Date:   Fri,  8 Oct 2021 14:59:45 -0700
Message-Id: <20211008215946.3961353-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Then name of this protocol changed in commit 94531cfcbe79 ("af_unix: Add
unix_stream_proto for sockmap") because that commit added stream support
to the af_unix protocol. Renaming the existing protocol makes a ChromeOS
protocol test[1] fail now that the name has changed in
/proc/net/protocols from "UNIX" to "UNIX-DGRAM".

Let's put the name back to how it was while keeping the stream protocol
as "UNIX-STREAM" so that the procfs interface doesn't change. This fixes
the test and maintains backwards compatibility in proc.

Cc: Jiang Wang <jiang.wang@bytedance.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Cong Wang <cong.wang@bytedance.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Dmitry Osipenko <digetx@gmail.com>
Link: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/tast-tests/src/chromiumos/tast/local/bundles/cros/network/supported_protocols.go;l=50;drc=e8b1c3f94cb40a054f4aa1ef1aff61e75dc38f18 [1]
Fixes: 94531cfcbe79 ("af_unix: Add unix_stream_proto for sockmap")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index efac5989edb5..26f92325d94b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -828,7 +828,7 @@ static void unix_unhash(struct sock *sk)
 }
 
 struct proto unix_dgram_proto = {
-	.name			= "UNIX-DGRAM",
+	.name			= "UNIX",
 	.owner			= THIS_MODULE,
 	.obj_size		= sizeof(struct unix_sock),
 	.close			= unix_close,

base-commit: 9e1ff307c779ce1f0f810c7ecce3d95bbae40896
-- 
https://chromeos.dev

