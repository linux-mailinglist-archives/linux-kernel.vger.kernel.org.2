Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4EE32FCE2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhCFTtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhCFTtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:49:17 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5B8C06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 11:49:16 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id a17so5321817oto.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 11:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3xWV5zAqKnrplLTO+ME8uiC/bDkyJw2IionsQTOWESU=;
        b=IhwYVa3ZyPSQ5ATyanUpL7cEHaIlUWYceq6glOHNc1VzUmBGPr0yWr5g1NAdnn2g+8
         3c18wNeeJWbrcGKP3XaBBDiclc+tJhp/kRaLcn8uGCSJ/gySvMjyef35k5RbDp3CQygf
         y6+vhEfTxMTrFBnac6PTJdpiKJ5Mx5d/ww5VWZs2wgrAiCC6Q7KzZGyyr2NGg3Tt7jx+
         I77BCnWUzYLc51Qa02/rcCCsrY4GbnU0swx/yNbTjNwr3J5YqovL8RfXsw6W1kbEWM/4
         H7YCPjoPDOjuOcdauI/JGoUo8mnHOxY7zeMQvr1Mb1xyASG03QFW4s0KfQnEu1H4y4l7
         zZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3xWV5zAqKnrplLTO+ME8uiC/bDkyJw2IionsQTOWESU=;
        b=GS9TxF/sUvekRER91SN7TgDxViarRXtBp8h/gGdPLBeYAs3ciIQXQlja0UOIE76SNz
         DrH2wp639HR+0blcex/9P1ZYtujoVMOY9lOp5DylwTpOQtPAXqFhfjLmLibjbPg9Cry2
         qCYS/lO0Ll+ormYSuV1AS2qgTRje/+LisgEWA1+JBHE4YuU5m11/XZeGKkhBGxNIQqaj
         glaK47ZkvTViIRGs1hGysKhZ1dHehKlbs5rkJ48qQNHWkBD//Vte+pzx7QaSY/F8YpgY
         reAmWJHBVfB9TpRhFbfMiLe2rwK1lfExO2p/xGBgbdajqloNI70Xj6wR1B6cyCNPMME6
         iCsw==
X-Gm-Message-State: AOAM532vYbkCRAHDIWJxEqNoowhDzOey1jys/jdma47he6LXCTngFaM/
        IHVbHvoN3h7+SPsBW+n2V4tEWQ==
X-Google-Smtp-Source: ABdhPJzNb4doqDJycZlkxwYjyWr7mBB/Di1OfL51GUaZI4vO7db4kJ4Uq96qKaS5mhUIYT7vY/om6A==
X-Received: by 2002:a9d:6381:: with SMTP id w1mr13282381otk.236.1615060155724;
        Sat, 06 Mar 2021 11:49:15 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n6sm1353898oop.48.2021.03.06.11.49.14
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 06 Mar 2021 11:49:15 -0800 (PST)
Date:   Sat, 6 Mar 2021 11:49:13 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Luca Coelho <luciano.coelho@intel.com>
cc:     Kalle Valo <kvalo@codeaurora.org>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iwlwifi: fix DVM boot regression in 5.12-rc
In-Reply-To: <alpine.LSU.2.11.2103061139200.1285@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2103061147270.1285@eggly.anvils>
References: <alpine.LSU.2.11.2103061139200.1285@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No time_point op has been provided for DVM: check for NULL before
calling, to fix the oops (blank screen booting non-modular kernel).

Fixes: d01293154c0a ("iwlwifi: dbg: add op_mode callback for collecting debug data.")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 5.12-rc2/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h	2021-02-28 16:58:55.058425551 -0800
+++ linux/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h	2021-03-05 20:59:14.156217412 -0800
@@ -205,7 +205,8 @@ static inline void iwl_op_mode_time_poin
 					  enum iwl_fw_ini_time_point tp_id,
 					  union iwl_dbg_tlv_tp_data *tp_data)
 {
-	op_mode->ops->time_point(op_mode, tp_id, tp_data);
+	if (op_mode->ops->time_point)
+		op_mode->ops->time_point(op_mode, tp_id, tp_data);
 }
 
 #endif /* __iwl_op_mode_h__ */
