Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5326141E7A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 08:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352171AbhJAGgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 02:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhJAGgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 02:36:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3AAC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 23:34:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v127so6380092wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 23:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVXSClePRw23VTXz4l+/+e888Gbk2ilj3kNPqGf79zg=;
        b=MDRwr01PKBnlGhAI74nZeDDj4I9RjOtvQmDn2a3Y95SAQyJHltSclBMQ38Yyy6/P2q
         LbGp8sJ2Zswrmb1TYdF2WgVTHMcVOvmoZF5QbAQpRX+oa+2nvIHpcR7MmHcAbugLwGwm
         x5PDI2Tjy0vnf3DqqFNE9p13F6N8aXmYAx53dzTkWOso3uABiRbX/RNK5agbxyBZJ8sY
         lilDe9EUjkDHRG9tdBzxyDsYf6g1pEnKpM1WmQluZA2X/1yPPTA7LER9Dtl67QKXcuDm
         gNL8rfKUUtQx4cpnakb6glQ9frVrC+DsGbTl+MMr4tzDnWuN4cI6WsKUUVOTPmLrlQHe
         lVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVXSClePRw23VTXz4l+/+e888Gbk2ilj3kNPqGf79zg=;
        b=xuPkEO7EFyBueerv12scHmicfpjC+/k2Ny3mvuo4Wu3ewCziIsgrGxORctPif90IAq
         b9H5DQGN8yu6z5snOmPcjejMVSp4kfLAjQ3IKExSljq02sAj15AHejS/1dyp6vtVOa9E
         4a4rSEkcDeHL58e+8S9n95Q2qNGkqc4SFeEBvU2mNJOTdr8EUbMjQYA3oGVE6wtRn1Q/
         SZhhjTQg526xb8hk3KdITGDL0cwi2HXwW27/8/OpVSyIi6rLcOZefV3MCw7cQr2Ws4jn
         6m5W+wxwdNd2IP75XilZG08gPfanqR1JhPMgdWtpnRo9yFaWL3pX6gqeg2hcNXc3kQrr
         0ecw==
X-Gm-Message-State: AOAM53079Pwsjqh6goIhw++fxIrr461awForf8aTXyc2bRYY03lb8GJW
        qMtR39P8NtAp8DHDXCc/mtI=
X-Google-Smtp-Source: ABdhPJwIBNtxxWYUraabzlZULyiClnV/Z0SgsiR9OEFntO2XYi1c0esnzc07fTwqKM/G4m2QqdLfSg==
X-Received: by 2002:a1c:9a4f:: with SMTP id c76mr2760960wme.22.1633070091136;
        Thu, 30 Sep 2021 23:34:51 -0700 (PDT)
Received: from localhost.localdomain ([197.49.49.194])
        by smtp.googlemail.com with ESMTPSA id o17sm5002032wrs.25.2021.09.30.23.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 23:34:50 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/9p: fix warnings found by checkpatch.pl
Date:   Fri,  1 Oct 2021 08:34:44 +0200
Message-Id: <20211001063444.102330-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 fs/9p/v9fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 92124b235a6d..5dd031252236 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -135,8 +135,8 @@ static inline struct fscache_cookie *v9fs_inode_cookie(struct v9fs_inode *v9inod
 
 extern int v9fs_show_options(struct seq_file *m, struct dentry *root);
 
-struct p9_fid *v9fs_session_init(struct v9fs_session_info *, const char *,
-									char *);
+struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses, const char
+		*dev_name, char *data);
 extern void v9fs_session_close(struct v9fs_session_info *v9ses);
 extern void v9fs_session_cancel(struct v9fs_session_info *v9ses);
 extern void v9fs_session_begin_cancel(struct v9fs_session_info *v9ses);
@@ -167,7 +167,7 @@ extern struct inode *v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses,
 
 static inline struct v9fs_session_info *v9fs_inode2v9ses(struct inode *inode)
 {
-	return (inode->i_sb->s_fs_info);
+	return inode->i_sb->s_fs_info;
 }
 
 static inline struct v9fs_session_info *v9fs_dentry2v9ses(struct dentry *dentry)
-- 
2.25.1

