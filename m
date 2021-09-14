Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A7B40B031
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhINOEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:04:10 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55511 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233572AbhINOEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:04:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B1E6B5C01C0;
        Tue, 14 Sep 2021 10:02:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 14 Sep 2021 10:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=9FXyPXkwkycT7
        FpDBprBIlpPCJk+3RJgiVL3MbYdviE=; b=bKMd6ghzLgrKYQk8XadO3FM8GCSCw
        eRWRkjAM21IQ+Z2WCJVDDh0FFyNelPRfeewZnfWsCD6ea2zye+59QAlZMjt6rYk4
        5R75UfmuFsYmqz776a+qVyQUXstIqIlvnNGMLCav6cyHsPsxxpaiBoTpKUxwZf8T
        y+9vkAc0UkkH4h0r2rm0VGbHa76U1MQJwEAN8zYUvaL8Mb7RHc/ahnW6Le/SN9gQ
        HyQOOcfAdmQ9Nkg35lZcQrOXO7bVm29nqthLFLs7ADhUMD0CU3L3zNr7txqo0wKW
        QkPhmDGiiY6wvBz56yfuPjRefRViYjAtvZWf2PTD259bwrmXnO9LBLVXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=9FXyPXkwkycT7FpDBprBIlpPCJk+3RJgiVL3MbYdviE=; b=EUe6hKO5
        m6M6Ib2Pc29ULZbERVZyQpfN40C0lbci26ar3b0XUoP/OOvpPyqXwTJ7wxPn0UK3
        KSS22yTHHiGhwFCZKJ40PH0Kf/uPhSI6UY3/p6HiMdY9YBLyPXVh1MfTKdwMeHdG
        x2kjFDmdLtdNvTuCWjC8ra5UPKAO1UpUf5+eji7eGVsmzTnztN1+LTTBrUxR452U
        ZkO7jHDC2gShD1Zk3lrr68aX8+q/02FyhMRsmEPTkqd8X2NHyfEYhe02l0ItFWAb
        nNWbH9Bo80JdtpI7z/DZVcWnwcfo1yMTMFpZ4Ki2nyZ1+TYOmL9ywHCr5aNOFvjH
        2u38RUczPsNJWQ==
X-ME-Sender: <xms:iKtAYYwvl165O3NRQsA8kD_vNirHzbXbbtamcMy9bcZ3RVpM5HeF2g>
    <xme:iKtAYcQiHaB2_fDiNuranB-_ZJtoLl70chHfJdfs0pZt3iTVYSSelZfmfivW0Hn2h
    SzcK8OtxRXL9UPHaMY>
X-ME-Received: <xmr:iKtAYaU9tFXSpfYbUFUXf_Ul1jh0DP2XfWhftfanzbFC6xS46WOWP6z8nfJX4d9t5Y_Rz7r5VGqAcvAlLHdWO5u5y3Dzb9mHQEWCmybrme7rTXp_vM7gvDT2S_1V4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:iKtAYWjpH5znDmDKWT7iY6wzYNLHVXC5SvD43dx64rV8z_vqWHX5VA>
    <xmx:iKtAYaCVbb1UDV9pmZVSZN56fj1_aKmU7T06nfRRChZYcxNAqwNjlA>
    <xmx:iKtAYXIRfUzowpesl4_K48gGSw3D6ryYlJSfSX2Vwax47tqPVzYdGA>
    <xmx:iKtAYVNzF8PjeYXF_uErkbckSBnEsX29O3upWbsB6Y9XkI5nYcGGFw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 10:02:47 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Peter <sven@svenpeter.dev>
Subject: [PATCH v2 3/3] usb: typec: tipd: Remove WARN_ON in tps6598x_block_read
Date:   Tue, 14 Sep 2021 16:02:35 +0200
Message-Id: <20210914140235.65955-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210914140235.65955-1-sven@svenpeter.dev>
References: <20210914140235.65955-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling tps6598x_block_read with a higher than allowed len can be
handled by just returning an error. There's no need to crash systems
with panic-on-warn enabled.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v1 -> v2:
 - added this patch to also remove the WARN_ON in tps6598x_block_read
   as suggested by greg k-h

 drivers/usb/typec/tipd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 8c79ba17a157..93e56291f0cf 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -117,7 +117,7 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
 	u8 data[TPS_MAX_LEN + 1];
 	int ret;
 
-	if (WARN_ON(len + 1 > sizeof(data)))
+	if (len + 1 > sizeof(data))
 		return -EINVAL;
 
 	if (!tps->i2c_protocol)
-- 
2.25.1

