Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B55410D95
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 00:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhISWIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 18:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhISWIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 18:08:05 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89DDC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:39 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 72so24470644qkk.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjkKpbsOxtTLRzIMIRjss6tASIT031WBS0F4FaC661o=;
        b=XAeOLV6BqNjq9EWbsR0tUxpnuA2trCD6twKtXiP6b+wl5coPS29WULQcpwcxCVTvPK
         ebBE4TcKwer/1lhoni/vME6bsNX9QVYzqV/TU+9mqmJqApuUj5fzDCuLBx52AjXiS26I
         bCvSgZ0BoijMDw9OsUbb6TtMqaldXR4v9dPdihNcYKol/J3grtDmz3viohVSBSMiXeNL
         5j4coQufHZo7sjO/ZV1HzUWFqVWtHDqhbaDiSuhVC5cqy6fUUfP2TL4QlTZZMQyjT2vy
         4GvgJ0xOr6m8YPjNw08MoP5Vtw7CoP/zpqgdWnPIqnpdHCYJ4fO+N3R9RrUpDHXIuSHp
         HiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjkKpbsOxtTLRzIMIRjss6tASIT031WBS0F4FaC661o=;
        b=Krwxe184Y4+vinaLqg5fBC6JDotKTne0kCQRn7vKbVwVjcvnvxuwR6YgEh1WO4IBGj
         gcgUYlOWZ9lTX//I7ZJLJg5WrJJc5EzFk5ke5T0umd2YPvQ7iuPrNqKvgdHLkQTLi/L4
         DBQLl+5r8Z46dl6PEIJzsDW9myYNy1IoFBz9+nJw9BWt7KfYACp2UPZo4fkgBXOQkG2s
         ZnQFOo23tQNucFY51kv0Lu6D35GAqlWo1IjHVkK0pOnJBRWKJiN7MJqMkOmUzIaBBZJW
         mYvDYEAnz/bBzjVqgnYuHcoUsZzZQVLq42u9+MoDAZdP+kc4VIRFPDQ+E5s7wabUmDUi
         rYXQ==
X-Gm-Message-State: AOAM531mCCM+U717BoWU7L5604qkIX3cIji3YSHl0UUEQA0q2zYIGEXG
        NfVQhxz2BULzdIzAXRf9I7Q=
X-Google-Smtp-Source: ABdhPJz1CWgnIroJXybinJQzMbOF2B23vgwlHdCljMO+VE+W8hT0mUE2aP6wnNPYMAnp/J3/Q3kmpA==
X-Received: by 2002:a05:620a:191e:: with SMTP id bj30mr20635687qkb.319.1632089199017;
        Sun, 19 Sep 2021 15:06:39 -0700 (PDT)
Received: from localhost.localdomain ([191.84.236.195])
        by smtp.gmail.com with ESMTPSA id t23sm246313qkj.31.2021.09.19.15.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 15:06:38 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 6/7] staging: vchiq_arm: remove extra blank line
Date:   Sun, 19 Sep 2021 18:59:13 -0300
Message-Id: <20210919215914.539805-7-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919215914.539805-1-gascoar@gmail.com>
References: <20210919215914.539805-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank line.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index e8e39a154c74..8f5182df17b6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -151,7 +151,6 @@ vchiq_dump_service_use_state(struct vchiq_state *state);
 extern struct vchiq_arm_state*
 vchiq_platform_get_arm_state(struct vchiq_state *state);
 
-
 extern enum vchiq_status
 vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 		   enum USE_TYPE_E use_type);
-- 
2.33.0

