Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88F3EDD93
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhHPTEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhHPTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:04:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B772C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:03:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so386940pjz.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQIDgHDinK9G6OVBaqwTHfY5KB000CBp6CpTZGMvcek=;
        b=WY6mR6quoN2NpyDT0Cs4sZaNedYyZyWYZn7jL4roycAQ1Qc1jPq0YAcYZDJH/ybJld
         QiUXHBTlLxAXmoJkMctv9/5GoophqAfiAUybaAGW8TcsfRUT2dzVp2Z5xFSQ2PRHzL2G
         8H4MbrQOkNpPxPLcTRf69OPJcjLMcByxMlYsWOEStHoJ+NK6XPBxYvtAIn2C7CIn0DM0
         eyLQjg9qBfZywYs19F19KCGSvZq8K0rB/FpWfwVXEdpQ6rupZ0ea9OGIfn1qd86zBQZM
         IWDl+StJFsIe4ByBgiCZ4tqLVMX0RaltUDab7tEnyME18S8BDQ2GXg6Rzbk6z6OyvNOa
         X0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQIDgHDinK9G6OVBaqwTHfY5KB000CBp6CpTZGMvcek=;
        b=mhlk4YdB0v3ib/S9TLO1yRwBB58zXlQI+y0cnXR30dNx99q4Cf/2/7pBW5Nib5K6UO
         h36DGTXFFhgt34Zhk1jN6bOZfFXNAhivnAAKn6c+29d4ECXxZ50IJgtFcETeEzamvSYt
         EhAkgT60brstN72A7/kZd6bMtosMXuxfRVaNBjAHWWVMiWJGPhx1QJ5w4JlP9FUEocUP
         ShtBnG5ofqVnMRZIyTr/3Jd7eI1NnMa1osR+NMGHA5EJwJN8MgSIRrRlmRZERFFBhaPF
         tXo9Djg3+uPyqh80Q2NJZ9wjwNYBmHQKsQLp0bBlOL02aEVH4a1B/4PPAMGZTTCR4ZyR
         m0kw==
X-Gm-Message-State: AOAM53398+LYd3ksc21wCjrKatB2gBoM+ixSkD2z8dzCh4PpOrV7/RLB
        BYB5A+jNUxYq8hQuuH+nOoX9ag==
X-Google-Smtp-Source: ABdhPJzpUs4hGAe1udl/DE9Ky+AbUywHhNGuWdpShcgWqkdr1vSLVsikHzErghPFMfVjwOXtjwgzXw==
X-Received: by 2002:a17:902:9a02:b029:118:307e:a9dd with SMTP id v2-20020a1709029a02b0290118307ea9ddmr223456plp.47.1629140615950;
        Mon, 16 Aug 2021 12:03:35 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id t30sm175845pgl.47.2021.08.16.12.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 12:03:35 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     netdev@vger.kernel.org
Cc:     cong.wang@bytedance.com, duanxiongchun@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Rao Shoaib <rao.shoaib@oracle.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v7 0/5] sockmap: add sockmap support for unix stream socket
Date:   Mon, 16 Aug 2021 19:03:19 +0000
Message-Id: <20210816190327.2739291-1-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for unix stream type
for sockmap. Sockmap already supports TCP, UDP,
unix dgram types. The unix stream support is similar
to unix dgram.

Also add selftests for unix stream type in sockmap tests.


Jiang Wang (5):
  af_unix: add read_sock for stream socket types
  af_unix: add unix_stream_proto for sockmap
  selftest/bpf: add tests for sockmap with unix stream type.
  selftest/bpf: change udp to inet in some function names
  selftest/bpf: add new tests in sockmap for unix stream to tcp.

 include/net/af_unix.h                         |  8 +-
 net/core/sock_map.c                           |  1 +
 net/unix/af_unix.c                            | 95 ++++++++++++++++---
 net/unix/unix_bpf.c                           | 93 +++++++++++++-----
 .../selftests/bpf/prog_tests/sockmap_listen.c | 48 ++++++----
 5 files changed, 191 insertions(+), 54 deletions(-)

v1 -> v2 :
 - Call unhash in shutdown.
 - Clean up unix_create1 a bit.
 - Return -ENOTCONN if socket is not connected.

v2 -> v3 :
 - check for stream type in update_proto
 - remove intermediate variable in __unix_stream_recvmsg
 - fix compile warning in unix_stream_recvmsg

v3 -> v4 :
 - remove sk_is_unix_stream, just check TCP_ESTABLISHED for UNIX sockets.
 - add READ_ONCE in unix_dgram_recvmsg
 - remove type check in unix_stream_bpf_update_proto

v4 -> v5 :
 - add two missing READ_ONCE for sk_prot.

v5 -> v6 :
 - fix READ_ONCE by reading to a local variable first.

v6 -> v7 :
 - fix the following compiler error when CONFIG_UNIX is m.
   modpost: "sock_map_unhash" [net/unix/unix.ko] undefined!

For the series:

Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
-- 
2.20.1

