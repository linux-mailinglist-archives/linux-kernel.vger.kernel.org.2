Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6ED3D6AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 02:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhGZXdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 19:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbhGZXdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 19:33:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DA1C061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:13:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mt6so15319906pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y1ObdeHfUvaGE6OdEsaKDeYTqGoMK1JQpRZjmzTf8+Q=;
        b=EiNoQ8au0i56j/OiC+h66C4LOENB6lLHoY6Tm8yue/H/qoswbC6dKNJ77idpBeV8iQ
         35xrZltDlaMstieVOVl8wLThjrBrbc2Odmgi7+wJSA/26s+/Chgn5b1i8HvCFPWjQom4
         CtvR/92QaJVL4NvG1g3u4u81wCcomKzu+TeUgAeUk14X9V8zerbio60aojUPcwbKKUni
         jjvdqGD92cW9Y+aNlCOpuHc9zkpwIQN1NufpJufg8mTi6zGXvE1uPnaVYyU84nOS7u3L
         hSGqzI+Ikts6bLugoEfHGjibClLib7ukJY9abVKDIWruv6TpNNRvk8e2qyAPF5T2EXEg
         1Llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y1ObdeHfUvaGE6OdEsaKDeYTqGoMK1JQpRZjmzTf8+Q=;
        b=geSf8vkK38Om7RD+W5pDm9Zq7Az9Vsp0wdHMs9Dbd05w4N9tggA3N9imc8NhcGsHlt
         hgqkr5480HkZVsL8WLU27PqCVI0b5DkFpyu8U2+SBMrq5jc3l66Lpm2PKqccKBe93MLq
         JlXRAFzJV2DJtvQLJX9bQK1fz364NBqn9bYFsp57aW2sko4XQXIwXxm74Yx1gQJxVwjO
         snKCFU5j9Xs/wqrwMF2ef9Yq0lmE24Ho9wLEohZcM9OasdfK5i1im0K2x2RnfOAHcYlQ
         YJa/vSlOKOulVjruVGQdbKCzwuM20kd7zaFKw0mebRyoEAMQDSce20jrvr2+Cs/guLeQ
         FptA==
X-Gm-Message-State: AOAM533M3CPAeaEKu33HNhhNKpHivZFeh7h8gGntYSXgJd5DJcB231mZ
        xJFXxWBTYQP831WcDxLcNnj0Qw==
X-Google-Smtp-Source: ABdhPJwOj7fy0Q+JX+8pFaI6/DxyXuSVyM0/beMbaLW4FHceDUnotQA8TT4Py/PMs8u7ivXD+bojPg==
X-Received: by 2002:a63:da0a:: with SMTP id c10mr20686628pgh.255.1627344827333;
        Mon, 26 Jul 2021 17:13:47 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id k1sm1079452pga.70.2021.07.26.17.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:13:46 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     netdev@vger.kernel.org
Cc:     cong.wang@bytedance.com, duanxiongchun@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 0/5] sockmap: add sockmap support for unix stream socket
Date:   Tue, 27 Jul 2021 00:12:47 +0000
Message-Id: <20210727001252.1287673-1-jiang.wang@bytedance.com>
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
 net/core/sock_map.c                           |  8 +-
 net/unix/af_unix.c                            | 89 ++++++++++++++++--
 net/unix/unix_bpf.c                           | 93 ++++++++++++++-----
 .../selftests/bpf/prog_tests/sockmap_listen.c | 48 ++++++----
 5 files changed, 194 insertions(+), 52 deletions(-)

-- 
2.20.1

