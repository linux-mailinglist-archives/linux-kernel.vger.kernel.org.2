Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E3D41F85A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 01:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhJAXvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 19:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhJAXvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 19:51:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05674C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 16:49:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m22so12390091wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YIEsVF9+Cz+d1jK4k/hfEQTb1VC/M0tqWGPuXQp3AVc=;
        b=iarDf0OEMpwYPvVDTlxz/p+lSsjGK9ZgI+M9EBRhABW+xI0bwqg3TZU1CrBTIdnKMG
         JRdnUADnNQfn2SV5TNt8yd5oDV02pFmyr1bh+OHydCgCJSwU0iYwoyHaKEfVxn8I03SL
         +1eBonOku2f2AxOEB00KpZeSP7DoiDH7AcVw/qS4dze+9CbhXsYYHIDwgGuPSMAxAuep
         QnCQH05A63mzo5H7rRuIKu5vfQgz2accT4r9BtDSHlwCPBjBSaLjQHruNXmCQn1BFZ2A
         Dv3k5Gd8QDiV5ZK6q5F4TvQ2R0MrHb9wK155Q0l2ixA2/LcF9OohmPE4StjgMKLABa/H
         19/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YIEsVF9+Cz+d1jK4k/hfEQTb1VC/M0tqWGPuXQp3AVc=;
        b=bNUaphkyQONW6B+0nAkma+prwaSOWV7x9OatDX5gTcw/4Xjqt3imbrZehi43jwpm8I
         at9DO+Bm3iVmALAmq5AHbtFRQHAjxNR6qrRrDfdKDaujfj5I7JJZ/sHSWTsngeDWLWhy
         lzXlSVfQxiYsb7uc/h9e8o4NHlUS4Fhtv53sSFunRRWG/BCwTO90lzHbB3f5vPcITcCJ
         qiiSw1yveu24SGgbg34zuvysnDJG6gUTwaM/uiIm7v4DkKd+ZrD1rKpVDvS0cmPyLbuh
         MNsCiT81YtrHvnIENsy3jzxx7ZgxlEsh2+I7LvbGBIRMlNGdO65tkhQsFjG7opAA839W
         nxlQ==
X-Gm-Message-State: AOAM533f8Jo+oFqcMnDOEeTiqAhQiddiLM9wIw8CUrSaBzPMxjtajd9W
        hmjld9NU6YU2BwcxUJ9dXpS1j3dXzezTeic=
X-Google-Smtp-Source: ABdhPJy9reDOzOL4LfHVl1QUKbSnSEvXX3F7401/QaRhkT/w1HY++FVvLEVmnDAVEglkQhWLEJuq1w==
X-Received: by 2002:a05:6000:144d:: with SMTP id v13mr616891wrx.303.1633132187432;
        Fri, 01 Oct 2021 16:49:47 -0700 (PDT)
Received: from localhost.localdomain (88-108-171-137.dynamic.dsl.as9105.com. [88.108.171.137])
        by smtp.gmail.com with ESMTPSA id c4sm6943738wrt.23.2021.10.01.16.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 16:49:47 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Cong Wang <cong.wang@bytedance.com>,
        Eric Dumazet <edumazet@google.com>,
        Rao Shoaib <Rao.Shoaib@oracle.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Subject: [PATCH] af_unix: add missing annotation at bpf_iter_unix_seq_stop()
Date:   Sat,  2 Oct 2021 00:49:37 +0100
Message-Id: <20211001234938.14806-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at bpf_iter_unix_seq_stop()
The root cause is a missing annotation at bpf_iter_unix_seq_stop()

Add the missing __releases(unix_table_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 net/unix/af_unix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index efac5989edb5..9838d4d855e0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3291,6 +3291,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
 }
 
 static void bpf_iter_unix_seq_stop(struct seq_file *seq, void *v)
+	__releases(unix_table_lock)
 {
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
-- 
2.32.0

