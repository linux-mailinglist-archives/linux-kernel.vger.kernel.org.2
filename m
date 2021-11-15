Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415554516DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 22:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351581AbhKOVuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 16:50:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241807AbhKOSZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:25:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 429A863426;
        Mon, 15 Nov 2021 17:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636998945;
        bh=Lzpjg7S6FjEu8dwAMJAWRcYBXpTjuugH3pGUWpKOyYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODS020sYr8SwKsv3EGOOJ8JlaM92B2IA1XbsnRMhzVMy7hS3U22WXlA055Riro1P/
         aFCcYNAlnIM8iSdJNyyd8AWmaCxXklkYv3nrq67M08vAnB7dKeM0vRK4sluwP4vQdK
         o8UVv+lzOKizWn4hf6hj7T522xmeVQbp2r5sV0uk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.14 120/849] ifb: Depend on netfilter alternatively to tc
Date:   Mon, 15 Nov 2021 17:53:23 +0100
Message-Id: <20211115165424.147300019@linuxfoundation.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115165419.961798833@linuxfoundation.org>
References: <20211115165419.961798833@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

commit 046178e726c2977d686ba5e07105d5a6685c830e upstream.

IFB originally depended on NET_CLS_ACT for traffic redirection.
But since v4.5, that may be achieved with NFT_FWD_NETDEV as well.

Fixes: 39e6dea28adc ("netfilter: nf_tables: add forward expression to the netdev family")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v4.5+: bcfabee1afd9: netfilter: nft_fwd_netdev: allow to redirect to ifb via ingress
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -150,7 +150,7 @@ config NET_FC
 
 config IFB
 	tristate "Intermediate Functional Block support"
-	depends on NET_CLS_ACT
+	depends on NET_ACT_MIRRED || NFT_FWD_NETDEV
 	select NET_REDIRECT
 	help
 	  This is an intermediate driver that allows sharing of


