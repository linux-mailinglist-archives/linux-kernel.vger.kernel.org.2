Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2339377693
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 14:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhEIMUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 08:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhEIMUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 08:20:04 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CC8C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 05:19:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a10-20020a05600c068ab029014dcda1971aso7489365wmn.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqSSl0qicw8S1ed4pNsXBhSgZaQS6HCAXzNACgXQNog=;
        b=TOV4S5s0G6u9v9R1FK1rsk1u891PtTqDM59/a0ROMpk+jtnLetiGRleDAxrAKPaqCS
         HtMzWlcyiMjkWQAcrv+TTxsjPQUY9pe9OplQqo3r2iTQqz3tXsaAWmWBdYLvb8FcuaJR
         dh4IZ9xTqQbsdEQPgEzlgjlt763h+MYGCWanDIIRF4QKBGgEI/Ky5xifsNYmFYxzxuoM
         T0PDkjLnYeak3U7DPXZH36DEtxaxPx1KGpJqPfBrXKA3q9ifCROLgiIrzmwfljLFOP5V
         msDzs0ObROqD9Dj/oCb0FQ9nTPrDFpBFZBzNbHgl8r6YVNX4iPnkAUNUmKngwjXLY8oa
         N0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqSSl0qicw8S1ed4pNsXBhSgZaQS6HCAXzNACgXQNog=;
        b=ovzAF1s2TPx9QinBUSi5OL/XU5fNXbhlzYxpl+uAzn9PbCunxqXU7Oc77fjbwwGdOn
         kG1tQmU/yXwrCpvjk48sx5/BwH9X7bersri+yyCcNojZAZgvaKYlge7ElzpLb1N0xs75
         kU6XYPdm25+SAvpUfEzD3ZvTono1jjxqnuN52A3ewIhYsPN9EP9jEdIclpAY2dGpY8wR
         T39darRg+ZrfjVE75wfkLxcri09c8e6oL7Owmo6TNdmqkZJT/0dmRF7dVYdgwpwsoroX
         MJ2N0S0YE6/oKEIsfhrSh7h8Iq+vYT48CkVis+MphmIgvebc4Gnxuk2fLZch83jqBR3K
         KsnA==
X-Gm-Message-State: AOAM530Xd3PG/p1qIy4aRTsxMy7dGHTOK5Bqz5SOs0K2pcEODPdvckEm
        aCE2SAfDpahY9RoZ5p4XKWPsMg==
X-Google-Smtp-Source: ABdhPJzqyERM42xv3k0v3/mJEy4FwHnNStDcZqDn8swknsVhbFkb4DErcx5RuxDGmuA82atG+raK/w==
X-Received: by 2002:a1c:7fd0:: with SMTP id a199mr20861840wmd.161.1620562740099;
        Sun, 09 May 2021 05:19:00 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id p10sm19158223wre.84.2021.05.09.05.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 05:18:59 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     davem@davemloft.net
Cc:     kuba@kernel.org, yhs@fb.com, ast@kernel.org,
        johannes.berg@intel.com, rdunlap@infradead.org,
        0x7f454c46@gmail.com, yangyingliang@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netlink: netlink_sendmsg: memset unused tail bytes in skb
Date:   Sun,  9 May 2021 13:18:58 +0100
Message-Id: <20210509121858.1232583-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating the skb within netlink_sendmsg, with certain supplied
len arguments, extra bytes are allocated at the end of the data buffer,
due to SKB_DATA_ALIGN giving a larger size within __alloc_skb for
alignment reasons. This means that after using skb_put with the same
len value and then copying data into the skb, the skb tail area is
non-zero in size and contains uninitialised bytes. Wiping this area
(if it exists) fixes a KMSAN-found uninit-value bug reported by syzbot at:
https://syzkaller.appspot.com/bug?id=3e63bcec536b7136b54c72e06adeb87dc6519f69

Reported-by: syzbot+a73d24a22eeeebe5f244@syzkaller.appspotmail.com
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 net/netlink/af_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 3a62f97acf39..e54321b63f98 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1914,6 +1914,9 @@ static int netlink_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out;
 	}
 
+	if (skb->end - skb->tail)
+		memset(skb_tail_pointer(skb), 0, skb->end - skb->tail);
+
 	err = security_netlink_send(sk, skb);
 	if (err) {
 		kfree_skb(skb);
-- 
2.30.2

