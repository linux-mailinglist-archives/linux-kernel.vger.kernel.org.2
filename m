Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAE7429B95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 04:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhJLCoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 22:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231742AbhJLCoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 22:44:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED16860295;
        Tue, 12 Oct 2021 02:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634006526;
        bh=eDyrZDG1jUlDOn/b9aiQ8V81XA+O3akwZLY+saZGUko=;
        h=Date:From:To:Cc:Subject:From;
        b=kjtrClA06mEeMugwfVFxqxIb+lpmpL1K51FzZZ6Hf6/I7J0K/pZYM6OFwkt6YHFg9
         xr8qZUxIt8BkPsVmv21dEvXY2XgkfWbBe+8tIlOmwOUq4b98NBsGBrr9LJ24xMF+9m
         uw9CKk1f7bPsHsY+p0hImPm0X0piuRWoq/1WQ+NKPqmoZUq4292oDS7St9uctzwdtX
         LchJF4nH9sgnd8Vg98oQo0phMq35Lrh96jKmhA7o+TpyD/PKb1k3+aKe1RyJ2N8g4f
         UIFQCyFtc2UOFAbKVo1loT1vNMbFyWDlmT7uSecOuFYgahiDMVM1JBHyXyyH8tZJ2Q
         iUdHP9rqPzv9A==
Date:   Mon, 11 Oct 2021 21:46:24 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] staging: r8188eu: Use zeroing allocator in
 wpa_set_encryption()
Message-ID: <20211012024624.GA1062447@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use zeroing allocator rather than allocator followed by memset with 0.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index e8fadbfcb3a9..8a125c869c27 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -419,11 +419,10 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = kmalloc(wep_total_len, GFP_KERNEL);
+			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (!pwep)
 				goto exit;
 
-			memset(pwep, 0, wep_total_len);
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
 			if (wep_key_len == 13) {
-- 
2.27.0

