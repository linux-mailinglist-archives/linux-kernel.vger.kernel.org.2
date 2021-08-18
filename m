Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0943F0A98
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhHRRzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhHRRzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:55:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F04C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:55:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p38so6468652lfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2fnlNwiofJwFvUxJlW0rUAKllXf+VVuXYYhoztRaKrc=;
        b=WddZj7EJgefVxb9XuzeiiByxrQaIU1ZCn078ocCIbUNKeYAKTZMl9cUO+YdbgHEnoz
         06LQkdHHFctMrAG52vWwHps/gFewpi3V+2amfn7E0CrLCwJypvwZ07F7xk/9c7pKOIc9
         wVVERJlWS6c5K+hmeZfgZZ+99oVmw0VJD5obvog078WwAKDqNgbz6/HGzdPl84b96hN2
         Ej00VMayudP/1poXgwckqFLbp3QQgTATYXZRK4798uvoYMKz/vNoeFZ/A47KMbGR1AEG
         599cWUJtiuOUWUcbVXE/scN59fy69DEDU4KrIkpJKBhZnb2cDZFopYCYd5WTZHNVvvR7
         wz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2fnlNwiofJwFvUxJlW0rUAKllXf+VVuXYYhoztRaKrc=;
        b=gB2xuvwu3hp6ZQDGTVRTJQY5Rl0Icy+YDKGUcf7YA6Rfd9Eg7qjFXCbBr1tnJ8zvsu
         F31CQ1+2Nb5/RdrSBzvLSuTWj1TXvRO3MLbCTCBLpXw4rX2NfAt6mpCDmwmTm8Im18cU
         7RosBfL+0NTF/Tw3waEvGKyKjah1U7dEqRcColfq2al624lGPzoDxnatAuH5l8Ex+0MV
         pS7RlprsmjBHx1NxGcrghz+L7lE5fFkan8NadAz0ybAeHRi6qmJMUG8xmUXqtSjNDmy6
         fOKnVViHmhPg/XaevaSCbG/mxoEN7huUhiR9qV8kprSkmoBOjHZ20GiGc2xm70g7524T
         itcg==
X-Gm-Message-State: AOAM530VtF6TzUeyG51NnIBzT4BN+sH/zsNr4I/fH6rwDvgGdvjZWJAS
        zvPJ6B1LuuF/L3DtQYdbu3+lsQ==
X-Google-Smtp-Source: ABdhPJzi4vtgTooKvWILaZjtHgpR8vbROhR7aWUGuVSAwZ/NyTVd1HWcvqoEvUBvVwziQ8vKIed/sw==
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr7342984lfb.420.1629309302699;
        Wed, 18 Aug 2021 10:55:02 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id c5sm55820lji.67.2021.08.18.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:55:02 -0700 (PDT)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] drivers/net/virtio_net: Added RSS support.
Date:   Wed, 18 Aug 2021 20:54:37 +0300
Message-Id: <20210818175440.128691-1-andrew@daynix.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of RFC patches for comments and additional proposals.

Virtio-net supports "hardware" RSS with toeplitz key.
Also, it allows receiving calculated hash in vheader
that may be used with RPS.
Added ethtools callbacks to manipulate RSS.

Technically hash calculation may be set only for
SRC+DST and SRC+DST+PORTSRC+PORTDST hashflows.
The completely disabling hash calculation for TCP or UDP
would disable hash calculation for IP.

RSS/RXHASH is disabled by default.

Andrew Melnychenko (3):
  drivers/net/virtio_net: Fixed vheader to use v1.
  drivers/net/virtio_net: Added basic RSS support.
  drivers/net/virtio_net: Added RSS hash report.

 drivers/net/virtio_net.c | 402 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 385 insertions(+), 17 deletions(-)

-- 
2.31.1

