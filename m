Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC7434A3DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCZJMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhCZJMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBC5C0613B3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h10so5439287edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKzeLqRR981m8Q6V7H7TUSXK4XL8F6YSqoxMJOt3/UM=;
        b=c7aN3mnmKRReDVchVPRN5F3ZGlMuKOg65u0dZJ/cg3cO+3DRCgJZolt/1XPMivWwGo
         bLXwvQgL0EEvZJHDRLJtN0P6bmNLQSUbzHQ15UaRXosjuz10b30ghoRc//UHpITsg+p4
         Z5+oSiJMmEHU8/yywuOWviscj5XQOiO16SPUhnPeDR/h5wB4Ta7EcNOEtibAKfDaeLRv
         3DuXSTLpYRLhx0+VcIbrofIDONQILhLP4FAlrGtOCw7lSidmPgDtMrjzls06K8MN88og
         ylqJQJn1Je6+dwTe2nHy7b3KBgg/bPcRhVu+G7XwdZOVYi3RoFgbel1ePZP5IY7CxiXV
         /9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKzeLqRR981m8Q6V7H7TUSXK4XL8F6YSqoxMJOt3/UM=;
        b=MCXzZPaMV4DLwZzHsqUlpRA/5s3LykTeU/UvxQQXuEgM+UL+4t9liCCHZXb0QvicRt
         wkPcXZWxaOIOgIcvz4m1yVS6E31AYL5OCYZ9Fq0XhcIMe70IDqBz6aguIc6nF7m40qrF
         FafW34GMd5VyGmTn0RSIy0fqn2Ay3iR0QBib1xTMeq6sm8lXbKGEAt41vrXGdx6fiXqr
         6oTOpxYLB5RLCSXIMONutJhgewTl9/JC2CtBdZX/Omhjq+JudAB8lKZoVXcSgkNUC00Y
         f3Ow0QtzwH3xroua3SYGy4JRBu5dhdbURgfRvVccqbOW6o383E6GLM5HBP4hVNquZhsK
         P5fA==
X-Gm-Message-State: AOAM530iytgAZf50zpgmqJkZZxrFeOKJmuvwxbZ51zNpKGmT9BasmIv+
        dZNTBA/SUmaKP9cKC+rHGZvdjA==
X-Google-Smtp-Source: ABdhPJxDJ3TiBWwBuIIIUl2qWtWahIpl4fU1w+mZcTN0WLXPxFS1sjSsGKtEcZ6XeObhTS29nlfXiw==
X-Received: by 2002:a50:fb10:: with SMTP id d16mr13900790edq.73.1616749926918;
        Fri, 26 Mar 2021 02:12:06 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:12:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 13/18] fs: gfs2: quota: Fix incorrect param name in 'gfs2_quotad'
Date:   Fri, 26 Mar 2021 09:11:46 +0000
Message-Id: <20210326091151.311647-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/quota.c:1542: warning: Function parameter or member 'data' not described in 'gfs2_quotad'
 fs/gfs2/quota.c:1542: warning: Excess function parameter 'sdp' description in 'gfs2_quotad'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/quota.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 6e173ae378c44..33520eed467c2 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1534,7 +1534,7 @@ void gfs2_wake_up_statfs(struct gfs2_sbd *sdp) {
 
 /**
  * gfs2_quotad - Write cached quota changes into the quota file
- * @sdp: Pointer to GFS2 superblock
+ * @data: Pointer to GFS2 superblock
  *
  */
 
-- 
2.27.0

