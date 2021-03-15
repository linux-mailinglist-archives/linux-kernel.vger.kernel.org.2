Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012F733AFD6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhCOKRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCOKR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:17:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0FFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:17:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so5380044wrd.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z19T33UGYuqCwizp47siFJ6FOeFaLx2TKUwNaoixEfE=;
        b=Cek31PW6fyYjviTHc+RBaMW/cNtZb0qD4w0YB/GJvJP+v7Ubg47lSNFrHe4krY+QMd
         b+jp4BHUWv7vqgNUjUeAoD62oZtYShPGpZigLfHamE5NZL/CztkrMhhrHPfCqYs1TLf5
         rWd3CtNUo9+cHsTzl1T/O8WVQRFzqXlfpatocSCBqW8td/OvJFH5kTiGs5FkgQQwPGZ+
         nNnxmkeZUsI4PNSHhQ0ZwaJ0SYwtUxFF0pYoHerQCJTJzzdb3ao0imkRFfYhiXd7kO/5
         dRvaQIJ2hDujZaTVmdIZekdKkCvoQAFU+aUhgz8e/GFM1yD8/Hx/0rKp0KcTLccktcx/
         4uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z19T33UGYuqCwizp47siFJ6FOeFaLx2TKUwNaoixEfE=;
        b=kqR89KV2fSvpW/vuimBjI8/4/Oej+wbC5tnnUxipTKvCzBWMtPFvkQiUQYkPm82qYZ
         8Yr9o62oM5vSCRdeBEL+A67P95Hzj5S1CURd+JgPzDgmmgzXIQVPLzBq0kucj1ArkB1D
         FQ+D3IP3IpfCbjBfC7riQfEtHwia1Rh3qEKYbYa04HkWBlJIXgXM9BZKcMzXfQcI9X3j
         YpbYhGS0JJrP985j1nwTraJIeg0IneEXKeRPEjq87PL0Kt/TKzw0GKavsZnpnQAIemvM
         0EW84cW2AVJ7iC6F37gKHX4dZ1sOyWS0oUTxemjpDAUqj11Lkk1DdwxugDBIlnJljHi6
         0onQ==
X-Gm-Message-State: AOAM5322KXsvPC7IIr2u7nyIMVI8FLLXc2z4We1lbadJ661r9HWjc2RE
        YLb47lu2eLVHKnwkckKsL+Q=
X-Google-Smtp-Source: ABdhPJxhzSX8668Wu02UfyDRW3tD2PKvJsjQ796FD6/hGR8GxSXUdNUnS19nuaoyR02zddh/YiXfRQ==
X-Received: by 2002:adf:e582:: with SMTP id l2mr26736002wrm.207.1615803445481;
        Mon, 15 Mar 2021 03:17:25 -0700 (PDT)
Received: from agape.jhs ([5.171.72.229])
        by smtp.gmail.com with ESMTPSA id q17sm13080993wrv.25.2021.03.15.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:17:25 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:17:22 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_C2H_PACKET_EN
Message-ID: <dfb524b34be556c499787b4f057d7c157b577a21.1615801722.git.fabioaiuto83@gmail.com>
References: <cover.1615801721.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615801721.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_C2H_PACKET_EN

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 0ea97e85e6a2..170a28f4b191 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -974,7 +974,6 @@ void sd_int_dpc(struct adapter *adapter)
 
 	if (hal->sdio_hisr & SDIO_HISR_TXBCNERR)
 		DBG_8192C("%s: SDIO_HISR_TXBCNERR\n", __func__);
-#ifndef CONFIG_C2H_PACKET_EN
 	if (hal->sdio_hisr & SDIO_HISR_C2HCMD) {
 		struct c2h_evt_hdr_88xx *c2h_evt;
 
@@ -997,7 +996,6 @@ void sd_int_dpc(struct adapter *adapter)
 			_set_workitem(&adapter->evtpriv.c2h_wk);
 		}
 	}
-#endif
 
 	if (hal->sdio_hisr & SDIO_HISR_RXFOVW)
 		DBG_8192C("%s: Rx Overflow\n", __func__);
-- 
2.20.1

