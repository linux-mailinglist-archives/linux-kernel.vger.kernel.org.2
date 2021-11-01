Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BCD441CE5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhKAO43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:56:29 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58762
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhKAO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:56:27 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0FEB13F1AB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 14:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635778432;
        bh=rmAXyW8JKxDq9r0r+1Hiw1y/OwyI9OGQCKHICCyfzlQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=k517EJmtWC2QNtixCLe84eqeLQgT6gpjIi13UuC1e/j4ks8G1fXVnu2ldBEsQRbwY
         HBVI4f5SfbN/RDaQGHaiK04ETOvgTKttA0eqRKjv8YqAn5MwCKoeV0tmiWfzDmYqQm
         81zOFIo7yMiQq+ScEyMMD30ut4y/+mj7ONSaVMmyl5W5JX7DqHgUzjHItr5nCNyTSK
         tl6F2IO9mKEK5jLef8+NsPUyw4cXI/weL3sW0OXZCNmqtgxV8QKNopO5fQKEPweTYh
         XiWHcETPS7jQ667FfK+yyU54iLQF7rS2JPlhPsMYkDGfsdMp4+gigO628CpD9m22lF
         kpm9+Aoh3noEw==
Received: by mail-wm1-f70.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso45752wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 07:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmAXyW8JKxDq9r0r+1Hiw1y/OwyI9OGQCKHICCyfzlQ=;
        b=VELpVvoy1Xw7+dXQqbxvRPdFdosbYP5L3irbHzkAwvFw5HgM3zAHOlFlNz5YGrB57N
         nHsATGSBd55ys2CDW5pNNsXdeniDfqxaxsSEPd1oJ1SIMYaHIkrY7X/C80IafpeI8d9A
         jKhKs3FXYLrVsAwTsgjdKghonLRcGB/s698j6BK32CBdzT1G4HD2N62DcnAkLGVkPywz
         BXM0JivEnRiHHL4r3aY04zFAYL7ZxbghQ/MnmaYvn5FlJdscq0uAg6C2grlJVkilgFUp
         bt8iLcxBYH0KLROWcamfZ7DfCGijSHEFfRarpGBA27LgslAFUfDvjI5oF6vnobRRrhoR
         QuSg==
X-Gm-Message-State: AOAM530dFeTshlwg0/QjuHGKoecreY4Ymkk6m7DENXkF2KIj+I9Bf5Vf
        91ZYJl5tk6xTp2ctERNfISABgO3jbX0frqBSDxLWA01Nwg2Fb9jCJl22F4Wgc8vhyFK0/X6QCxz
        o9pcCXKq6CWoAvdGDAb5QRNOA/iOaTYHJ8lGd5tcz0g==
X-Received: by 2002:a1c:29c6:: with SMTP id p189mr10765638wmp.129.1635778431803;
        Mon, 01 Nov 2021 07:53:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGiGBfWozkCP/mfa2+E7javYRR+SMfA/sCvASq0mdQDoSV2wdr7K7fwnlORgW5vU0HOn1y6g==
X-Received: by 2002:a1c:29c6:: with SMTP id p189mr10765618wmp.129.1635778431616;
        Mon, 01 Nov 2021 07:53:51 -0700 (PDT)
Received: from localhost.localdomain (p579d859a.dip0.t-ipconnect.de. [87.157.133.154])
        by smtp.gmail.com with ESMTPSA id x13sm10461694wrr.47.2021.11.01.07.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:53:51 -0700 (PDT)
From:   Kleber Sacilotto de Souza <kleber.souza@canonical.com>
To:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] selftests: net: reuseport_bpf_numa: skip nodes not available
Date:   Mon,  1 Nov 2021 15:53:17 +0100
Message-Id: <20211101145317.286118-1-kleber.souza@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some platforms the numa node numbers are not necessarily consecutive,
meaning that not all nodes from 0 to the value returned by
numa_max_node() are available on the system. Using node numbers which
are not available results on errors from libnuma such as:

---- IPv4 UDP ----
send node 0, receive socket 0
libnuma: Warning: Cannot read node cpumask from sysfs
./reuseport_bpf_numa: failed to pin to node: No such file or directory

Fix it by checking if the node number bit is set on numa_nodes_ptr,
which is defined on libnuma as "Set with all nodes the kernel has
exposed to userspace".

Signed-off-by: Kleber Sacilotto de Souza <kleber.souza@canonical.com>
---
 tools/testing/selftests/net/reuseport_bpf_numa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/testing/selftests/net/reuseport_bpf_numa.c
index c9f478b40996..b2eebf669b8c 100644
--- a/tools/testing/selftests/net/reuseport_bpf_numa.c
+++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
@@ -211,12 +211,16 @@ static void test(int *rcv_fd, int len, int family, int proto)
 
 	/* Forward iterate */
 	for (node = 0; node < len; ++node) {
+		if (!numa_bitmask_isbitset(numa_nodes_ptr, node))
+			continue;
 		send_from_node(node, family, proto);
 		receive_on_node(rcv_fd, len, epfd, node, proto);
 	}
 
 	/* Reverse iterate */
 	for (node = len - 1; node >= 0; --node) {
+		if (!numa_bitmask_isbitset(numa_nodes_ptr, node))
+			continue;
 		send_from_node(node, family, proto);
 		receive_on_node(rcv_fd, len, epfd, node, proto);
 	}
-- 
2.30.2

