Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148D834EE45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhC3QpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhC3QpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E639C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c8so16871280wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hX4c3dvNt7mKQZ9EtHrANR7zKvje+/DsUArCAOpPAxo=;
        b=ufGMgP0fPhF499cbS5L2s0ZuuzUnSTD1T1zhTd15zIAY5KK1NQ7qWD1lYbNwb/GuYq
         RRxpdaI/ZMXXvKsTM1zrRba1+C87ha6A6Oy8CsQj8k3DvuHf1avsotQuXFOO+J8O1pGC
         Io6uvu8WiuL62KBwKNzXaQYitFzs/op9NvIOd2GGHTUb2y/HMQDsa56NtwdYGqvOgL4F
         sJXwBZ1CSXqXwIa0g7ktzQoV2tIlW0+ucez7PYs25stWD8AgHOsWmToyoSDwYsD2a/LH
         m5ML9Sr5euTrnAUKnFyHL5S9Dm7y4YKVPegnLRS70EMlxO97Zw1B0KFjDV5tSePLIZo1
         uk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hX4c3dvNt7mKQZ9EtHrANR7zKvje+/DsUArCAOpPAxo=;
        b=kQJGJkTeaPFda8H4mXaw8bcaxXGc5Cx/Xv3DLlrYSK+aW95GAFWfVbJcuTbc+Bh746
         k7n+mgyn/kWp4Mk5ruOIM+AXsxkAVdMQG8f0gesA/YJ97jf/tGMrLWCOLcaiBPINsBCt
         qmTZN3YqkLTiquAm/KzSrbSqVq6pyBfvnmK24RiPGUfC7d77tdCvb/Pf+AYINhuFf4S0
         OozIUjph5Nn0U5D0Y3qBrfP+aOGgHrSaWzW1lV/1DRFJqQgMHW1F6HG3GpFSZncXxV31
         nezF4e0r6ljxeqelqjTTBtFhR1XR2q6rM/o/csJb74i/TiP4UMqpHKYd+ccj/dtoCfez
         CckA==
X-Gm-Message-State: AOAM5327YdCL2a9jVbOR/q7crqLz/d+TdUFmrewNnfEbPOqhRTNl0okZ
        +tjlY+mR+/jMFe35kNHuPaw/tQ==
X-Google-Smtp-Source: ABdhPJzpMXQko2D3UFs8+f/kYkyaRHzL86/nAvCPzzz9zaLjxOxavCcpnSysA8SNm+ag9Lxgj29vng==
X-Received: by 2002:a5d:591a:: with SMTP id v26mr34589876wrd.172.1617122703371;
        Tue, 30 Mar 2021 09:45:03 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 02/31] fs: gfs2: xattr: Help out some kernel-doc header demote non-conformant ones
Date:   Tue, 30 Mar 2021 17:44:29 +0100
Message-Id: <20210330164458.1625478-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/xattr.c:41: warning: Function parameter or member 'sdp' not described in 'ea_calc_size'
 fs/gfs2/xattr.c:41: warning: Function parameter or member 'nsize' not described in 'ea_calc_size'
 fs/gfs2/xattr.c:41: warning: Function parameter or member 'dsize' not described in 'ea_calc_size'
 fs/gfs2/xattr.c:240: warning: Function parameter or member 'ip' not described in 'ea_dealloc_unstuffed'
 fs/gfs2/xattr.c:240: warning: Function parameter or member 'bh' not described in 'ea_dealloc_unstuffed'
 fs/gfs2/xattr.c:240: warning: Function parameter or member 'ea' not described in 'ea_dealloc_unstuffed'
 fs/gfs2/xattr.c:240: warning: Function parameter or member 'prev' not described in 'ea_dealloc_unstuffed'
 fs/gfs2/xattr.c:463: warning: expecting prototype for ea_iter_unstuffed(). Prototype was for gfs2_iter_unstuffed() instead
 fs/gfs2/xattr.c:587: warning: expecting prototype for gfs2_xattr_get(). Prototype was for __gfs2_xattr_get() instead
 fs/gfs2/xattr.c:814: warning: Function parameter or member 'ip' not described in 'ea_init'
 fs/gfs2/xattr.c:814: warning: Function parameter or member 'type' not described in 'ea_init'
 fs/gfs2/xattr.c:814: warning: Function parameter or member 'name' not described in 'ea_init'
 fs/gfs2/xattr.c:814: warning: Function parameter or member 'data' not described in 'ea_init'
 fs/gfs2/xattr.c:814: warning: Function parameter or member 'size' not described in 'ea_init'
 fs/gfs2/xattr.c:814: warning: Excess function parameter 'er' description in 'ea_init'
 fs/gfs2/xattr.c:1181: warning: Function parameter or member 'inode' not described in '__gfs2_xattr_set'
 fs/gfs2/xattr.c:1181: warning: Excess function parameter 'ip' description in '__gfs2_xattr_set'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/xattr.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 124b3d5a72665..fe2109789f75b 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -26,12 +26,9 @@
 #include "trans.h"
 #include "util.h"
 
-/**
+/*
  * ea_calc_size - returns the acutal number of bytes the request will take up
  *                (not counting any unstuffed data blocks)
- * @sdp:
- * @er:
- * @size:
  *
  * Returns: 1 if the EA should be stuffed
  */
@@ -219,13 +216,8 @@ static int gfs2_ea_find(struct gfs2_inode *ip, int type, const char *name,
 	return error;
 }
 
-/**
+/*
  * ea_dealloc_unstuffed -
- * @ip:
- * @bh:
- * @ea:
- * @prev:
- * @private:
  *
  * Take advantage of the fact that all unstuffed blocks are
  * allocated from the same RG.  But watch, this may not always
@@ -448,8 +440,8 @@ ssize_t gfs2_listxattr(struct dentry *dentry, char *buffer, size_t size)
 }
 
 /**
- * ea_iter_unstuffed - copies the unstuffed xattr data to/from the
- *                     request buffer
+ * gfs2_iter_unstuffed - copies the unstuffed xattr data to/from the
+ *                       request buffer
  * @ip: The GFS2 inode
  * @ea: The extended attribute header structure
  * @din: The data to be copied in
@@ -573,7 +565,7 @@ int gfs2_xattr_acl_get(struct gfs2_inode *ip, const char *name, char **ppdata)
 }
 
 /**
- * gfs2_xattr_get - Get a GFS2 extended attribute
+ * __gfs2_xattr_get - Get a GFS2 extended attribute
  * @inode: The inode
  * @name: The name of the extended attribute
  * @buffer: The buffer to write the result into
@@ -801,14 +793,11 @@ static int ea_init_i(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 	return error;
 }
 
-/**
+/*
  * ea_init - initializes a new eattr block
- * @ip:
- * @er:
  *
  * Returns: errno
  */
-
 static int ea_init(struct gfs2_inode *ip, int type, const char *name,
 		   const void *data, size_t size)
 {
@@ -1164,7 +1153,7 @@ static int gfs2_xattr_remove(struct gfs2_inode *ip, int type, const char *name)
 
 /**
  * __gfs2_xattr_set - Set (or remove) a GFS2 extended attribute
- * @ip: The inode
+ * @inode: The inode
  * @name: The name of the extended attribute
  * @value: The value of the extended attribute (NULL for remove)
  * @size: The size of the @value argument
-- 
2.27.0

