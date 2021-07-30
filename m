Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08A73DB05B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 02:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhG3Aiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 20:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhG3Aip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 20:38:45 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEFEC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 17:38:41 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 68-20020a9d0f4a0000b02904b1f1d7c5f4so7723358ott.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 17:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LQLHGvx8YzeIRk/lHZsyHMerPZm/rTK4XW2X0TgOuaE=;
        b=LPLGvRJCSV7j3Q9FR+FA9zgfT+9lrriHwbs/cjHWEn7PNSCOJC8M/5yP9Ncbh5KxEt
         QSUqB8zQ0S0yGHR9wDAIXSXBIZa+xox8iHQx/Y3frHpuOx06fvlfDS+fBBwTfrafC/hE
         fMc1BZvuCWQnHsRJcXZeF51yiYA7H/OH1QZq5Sp9+3B17mp4Us9X6Kh2KhS4JE+LXwOl
         pE9ayQBEQz/LLVbTIohmoOJQuFYAmLSKePGA3ymvJTV8lxTxAPmrGYskPmQrdWPrvAi4
         6rrUxe4dpWSDobZ3hNM3szAUt8T7DyUlGc3ORjorOeoJT3dPwjMecK2sQdXkwNggFOqG
         1p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LQLHGvx8YzeIRk/lHZsyHMerPZm/rTK4XW2X0TgOuaE=;
        b=CgIzDhkiYF+QjJ9eLj/iU8hSLwgOuWX9x+Ru28pYS1wrQdRHJTZy0XVt0F0RwjHJcK
         hyj78fc5Vye8+aZZCrezbcrH3CzzbC6FKUqL9J+Fc04/zSSXq0BSzBwYtCpAhThe6d7z
         XTgn16u/KoMovhbHxiEjp0QzGOPcWGsiVRrkKZwTUIaean+C576nLCPJry4WEhPEScUY
         iHHIcKiQNvazVgTVcCXQ1mywHn/oWayIWPen+omv3udZt1bO5I+VwLIv38VtxgH6n6hz
         T/J3FMfi3bw3HeO37nH1LmvEy+GnvwIasijRxuD3gHW2dYJsvlCQJz9VbkupAMsYE0UF
         iJug==
X-Gm-Message-State: AOAM532WBpDDxmtZVRWq0VXmRVsNPnGUw9raObp1il9+MyGqKPU1dlt4
        SiRMRaf6EI+qBrUXvVpbr4ASGA+GThM=
X-Google-Smtp-Source: ABdhPJyGo0BXwTDleEqjxV3kPtvQHWnEUvyPVlOv3kTnjob55wtZMRRfSUU4/7mASzbnPYSbGokgkA==
X-Received: by 2002:a9d:7dcf:: with SMTP id k15mr68348otn.201.1627605520907;
        Thu, 29 Jul 2021 17:38:40 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100f.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100f.res6.spectrum.com. [2603:8090:2005:39b3::100f])
        by smtp.gmail.com with ESMTPSA id a21sm15205otf.36.2021.07.29.17.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 17:38:40 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] staging: r8188eu: Fix sleeping function called from invalid context
Date:   Thu, 29 Jul 2021 19:38:22 -0500
Message-Id: <20210730003822.12471-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can call rtw_addbareq_cmd() from an interrupt routine. resulting
in the following splat:

[21760.582207] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:201
[21760.582219] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
[21760.582224] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G         C O      5.14.0-rc2-00135-g774ba5f0db67 #3
[21760.582228] Hardware name: TOSHIBA TECRA A50-A/TECRA A50-A, BIOS Version 4.50   09/29/2014
[21760.582230] Call Trace:
[21760.582232]  <IRQ>
[21760.582233]  dump_stack_lvl+0x34/0x44
[21760.582245]  ? rtw_addbareq_cmd+0x2a/0xba [r8188eu]
[21760.582306]  ___might_sleep.cold+0x88/0x95
[21760.582311]  kmem_cache_alloc_trace+0x25a/0x2d0
[21760.582315]  rtw_addbareq_cmd+0x2a/0xba [r8188eu]
[21760.582368]  rtw_issue_addbareq_cmd+0xda/0x17f [r8188eu]
[21760.582404]  rtw_dump_xframe+0xa6/0x266 [r8188eu]
[21760.582433]  xmitframe_direct+0x40/0x57 [r8188eu]
[21760.582459]  pre_xmitframe+0x72/0x110 [r8188eu]
[21760.582485]  rtl8188eu_hal_xmit+0xa/0xb [r8188eu]
[21760.582508]  rtw_hal_xmit+0x1b/0x1c [r8188eu]
[21760.582539]  rtw_xmit+0xd6/0x1cb [r8188eu]
[21760.582564]  rtw_xmit_entry+0xe4/0x1d2 [r8188eu]
[21760.582584]  xmit_one.constprop.0+0x98/0x170
[21760.582588]  dev_hard_start_xmit+0x40/0x90
[21760.582591]  sch_direct_xmit+0xfa/0x230
[21760.582596]  __dev_xmit_skb+0x27c/0x530
[21760.582598]  __dev_queue_xmit+0x327/0x4e0
[21760.582602]  ip_finish_output2+0x279/0x5c0
[21760.582605]  __ip_queue_xmit+0x167/0x3f0
[21760.582607]  __tcp_transmit_skb+0x4ff/0x9a0
[21760.582610]  tcp_rcv_established+0x5c1/0x6f0
[21760.582613]  tcp_v4_do_rcv+0x13e/0x240
[21760.582616]  tcp_v4_rcv+0xbad/0xc70
[21760.582618]  ? ip_rcv_finish_core.constprop.0+0x13c/0x2f0
[21760.582621]  ip_protocol_deliver_rcu+0x30/0x1f0
[21760.582623]  ip_local_deliver_finish+0x4b/0x60
[21760.582625]  __netif_receive_skb_one_core+0x63/0x90
[21760.582628]  process_backlog+0x8f/0x140
[21760.582631]  __napi_poll+0x2e/0x180
[21760.582634]  net_rx_action+0x11b/0x260
[21760.582637]  __do_softirq+0xcb/0x2f5
[21760.582640]  irq_exit_rcu+0x9e/0xc0
[21760.582643]  common_interrupt+0x83/0xa0
[21760.582647]  </IRQ>
[21760.582647]  asm_common_interrupt+0x1e/0x40
[21760.582650] RIP: 0010:cpuidle_enter_state+0xdf/0x5c0
[21760.582655] Code: 49 89 c6 0f 1f 44 00 00 31 ff e8 4c a1 98 ff 45 84 ff 74 12 9c 58 f6 c4 02 0f 85 10 03 00 00 31 ff e8 d5 73 9f ff fb 45 85 ed <0f> 88 59 01 00 00 4d 63 e5 49 83 fc 09 0f 87 05 04 00 00 4b 8d 04

Fix by changing kmalloc() flags argument from GFP_KERNEL to GFP_ATOMIC.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 0302aa101de6..159346d97110 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1240,13 +1240,13 @@ u8 rtw_addbareq_cmd(struct adapter *padapter, u8 tid, u8 *addr)
 	struct addBaReq_parm *paddbareq_parm;
 	u8	res = _SUCCESS;
 
-	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
 	if (ph2c == NULL) {
 		res = _FAIL;
 		goto exit;
 	}
 
-	paddbareq_parm = kzalloc(sizeof(struct addBaReq_parm), GFP_KERNEL);
+	paddbareq_parm = kzalloc(sizeof(struct addBaReq_parm), GFP_ATOMIC);
 	if (paddbareq_parm == NULL) {
 		kfree(ph2c);
 		res = _FAIL;
-- 
2.32.0

