Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB1311080
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhBERPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:15:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233527AbhBEQCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:02:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6160650E4;
        Fri,  5 Feb 2021 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612538155;
        bh=cDXk9MQSqiJdERDqiVBVXUYsbbsTj7YvOt3iOUzRiq4=;
        h=From:To:Cc:Subject:Date:From;
        b=TSNjxZq8qgp+Xw0+YQTRd3EvO9QPNQOudgN7hQJXhSU3lmBSN3flcMT7ZN0SPI2jE
         3ZeMNQfUhg5xRhNjMkOe4R+zYEAe6tYUxYbQHeycVffFUMMGi2Qeuh4W9xdgwMHG19
         vCaVGjHh42hRCRgot4y9Qb3wAX8v22RLhNFtBAFSenKIVbWjwN5D3WxkGxW0jBr406
         rfQXcNhNGVmstHBJljXVUI6oltseIFg2GwSDMQVx3LrLqhS1PVmje0pyKf7MyYN39h
         8varxpkwA9BMPN9DiQbznCDXmrhpb3h0ZMDKBEFhihvksQ+0+Ghb/cW1tmG2l0LYyP
         SLe4XIWLgEc7w==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     sgx@eclists.intel.com
Cc:     dave.hansen@intel.com, Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: Add Dave Hansen as reviewer for INTEL SGX
Date:   Fri,  5 Feb 2021 17:15:44 +0200
Message-Id: <20210205151546.144810-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Dave as reviewer for INTEL SGX patches.

Cc: Borislav Petkov <bp@alien8.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b66de2097d6..41b78e20bd1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9227,6 +9227,7 @@ F:	include/linux/tboot.h
 
 INTEL SGX
 M:	Jarkko Sakkinen <jarkko@kernel.org>
+R:	Dave Hansen <dave.hansen@linux.intel.com>
 L:	linux-sgx@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/intel-sgx/list/
-- 
2.30.0

