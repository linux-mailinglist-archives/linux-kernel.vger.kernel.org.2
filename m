Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CCA3AF93C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 01:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhFUXZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 19:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhFUXZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 19:25:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE2DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:23:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p13so14924177pfw.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nqw3RDJ+DTyT+o1frNSrU6yxZhY99eAuItIbguQEWVc=;
        b=GrhNXMS0SWzU6iw+vXo9GCtOePd1pNW+VTpDK0ncZ8i6wGmF9Gm1mIOHxZot9Ed0su
         hm3kwe7tpUymfqEo3zFiFnVHGDtwBQOJWOwXeEy4nYzAveRHsd/eAhpsHnOJEwSqGjH3
         SCGxqFrI1h3ZNdTp2aH25aLDTgE85/a6eKq+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nqw3RDJ+DTyT+o1frNSrU6yxZhY99eAuItIbguQEWVc=;
        b=qhf2FNBno9bL5otYE0jJAJwmv307dlQnZnKCCQIz6A9xGoJRuPPHlroJe+xHGKtLig
         EgQ0Ps5OvWTJDDQuq8WxiKnnBoBTumvwmGzziFU5Iqvsa1PcICruOFfmf2VkhZS+sVF2
         CdXys3C/MSSrATTuivjT98PXHpiAg1KgIh6YYx3OuSJ+lk9etx162/93yIRfdbpkPWKp
         9BmE61I7Ttb8hibHK7S7pAa06AYET5i3liYtzpr80jKd59DHsk+i+yTtx0LxOB0wyOwM
         F+hIHbnAJ6EhVbDD6VjcDokvv63JzgF4XqYHxk1ZE8gN0Bw1QRLORFMFn4aotDNWBkVq
         CKvA==
X-Gm-Message-State: AOAM531kIPMQk0LjFxUJAIWwBqIVQx/WYVLgk9bEnp7gyDGCBHY1uk6I
        e4mxp85M5JXbqUYJ+ooQi8Wn4w==
X-Google-Smtp-Source: ABdhPJzw3RkUA3AzHbb59oK1W8ShH20Pt5+AZqtVwv2ZzkiD4zsX6N5Q6sbE9jkDPg0nZ3S3LPnYAw==
X-Received: by 2002:a62:53c1:0:b029:2ef:25e8:d9e5 with SMTP id h184-20020a6253c10000b02902ef25e8d9e5mr614646pfb.74.1624317805166;
        Mon, 21 Jun 2021 16:23:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g29sm17578166pgm.11.2021.06.21.16.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:23:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-hardening@vger.kernel.org
Subject: [PATCH] jfs: Avoid field-overflowing memcpy()
Date:   Mon, 21 Jun 2021 16:23:22 -0700
Message-Id: <20210621232322.1871799-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=b11510bc7e50860adb5724ba145e9eb45c6c55f8; i=dF8ixb+THfuF0nlsv1dQ2ZPKzBL7OPmaRy5zMjzXzkQ=; m=dZhpAKqgH3qyGhCqzRZONrY9E1fP0G347jf3KEe/AJc=; p=ZB+jylUfBmb3AKcK6RN2EtlbnZH0790JymJLoekV5EE=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDRH2oACgkQiXL039xtwCY1Lg/+Lq6 Wzj3j9XEvWvRtm7sY906hIOMjW0Bmr8KDM0B8AZgdttldYYWkqZcCaIXx3cwmjdA0oPtvoAUiymjK DgRCTVH0l3FisDsQBCs/Cwgz03XI9D9F5CyrrjOZrqQC0N8BpdV8bFbmLcUKXqtXgLLOYjRx+iCd5 ksArwzkRr109ZIpdukzOxvEh1nbyvDW1s/4CunG/7DXlV2MGvdIjI7KyFn2DpGJCkwtQtwfq9lN3X LscLUySz82lDe/qpKoz/WsxInScnazXptKXn4baTVtvYM8OuLyoXbJjn1+DOGphofM3siWSI7LM5I b3ID4UXB8cNlxVwLdR/zuz21bwO7g/Lh6Ijai9fz0ktMkHUpWowjR99ymYmbfrqOCISUHziokRPfO cYlKzXUBeCLRMtKAfhRoEY9Hcg2rzlJw4xrzSWT3yoCvy/otfOw09IJje1S/wJS6ghQMqGuqI3wZn JcqrZIs6VQJu2blQzp7RL6hSuannlJXtDLoJiD0oMFvSrlQ2GyVsXkzMJ/6Y006Lzz/4WLkwjogaZ 3/ty5ylzn08K59xlixLsJ8CKP+LVrzcBp4QZYDYvWy+6w/ILkAILuW34QAHobrdGIigbRpKz61zAc YSxG567tej3H5UuFd08yAdDO2oGLAo01//x1fRmW9MbFxAJrYcsFS44tythT+i5k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field array bounds checking for memcpy(), memmove(), and memset(),
avoid intentionally writing across neighboring fields.

Introduce more unions to cover the full inline data section, so that the
entire 256 bytes can be addressed by memcpy() without thinking it is
crossing field boundaries. Additionally adjusts dir memcpy() to use
existing union names to get the same coverage.

diffoscope shows there are no binary differences before/after excepting
the name of the initcall, which is line number based:

$ diffoscope --exclude-directory-metadata yes before/fs after/fs
--- before/fs
+++ after/fs
│   --- before/fs/jfs
├── +++ after/fs/jfs
│ │   --- before/fs/jfs/super.o
│ ├── +++ after/fs/jfs/super.o
│ │ ├── readelf --wide --symbols {}
│ │ │ @@ -2,15 +2,15 @@
│ │ │  Symbol table '.symtab' contains 158 entries:
│ │ │     Num:    Value          Size Type    Bind   Vis      Ndx Name
...
│ │ │ -     5: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT    6 __initcall__kmod_jfs__319_1049_ini
t_jfs_fs6
│ │ │ +     5: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT    6 __initcall__kmod_jfs__319_1050_ini
t_jfs_fs6
...

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/jfs/jfs_dinode.h | 14 ++++++++++----
 fs/jfs/jfs_imap.c   |  4 ++--
 fs/jfs/jfs_incore.h | 12 ++++++++++--
 fs/jfs/super.c      |  3 ++-
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/jfs/jfs_dinode.h b/fs/jfs/jfs_dinode.h
index d6af79e94263..6b231d0d0071 100644
--- a/fs/jfs/jfs_dinode.h
+++ b/fs/jfs/jfs_dinode.h
@@ -101,7 +101,6 @@ struct dinode {
 					u8 unused[16];	/* 16: */
 					dxd_t _dxd;	/* 16: */
 					union {
-						__le32 _rdev;	/* 4: */
 						/*
 						 * The fast symlink area
 						 * is expected to overflow
@@ -109,9 +108,15 @@ struct dinode {
 						 * needed (which will clear
 						 * INLINEEA).
 						 */
-						u8 _fastsymlink[128];
-					} _u;
-					u8 _inlineea[128];
+						struct {
+							union {
+								__le32 _rdev;	/* 4: */
+								u8 _fastsymlink[128];
+							} _u;
+							u8 _inlineea[128];
+						};
+						u8 _inline_all[256];
+					};
 				} _special;
 			} _u2;
 		} _file;
@@ -122,6 +127,7 @@ struct dinode {
 #define di_rdev		u._file._u2._special._u._rdev
 #define di_fastsymlink	u._file._u2._special._u._fastsymlink
 #define di_inlineea	u._file._u2._special._inlineea
+#define di_inline_all	u._file._u2._special._inline_all
 	} u;
 };
 
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 937ca07b58b1..4df3f222c35c 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -763,7 +763,7 @@ int diWrite(tid_t tid, struct inode *ip)
 		lv = & dilinelock->lv[dilinelock->index];
 		lv->offset = (dioffset + 2 * 128) >> L2INODESLOTSIZE;
 		lv->length = 2;
-		memcpy(&dp->di_fastsymlink, jfs_ip->i_inline, IDATASIZE);
+		memcpy(&dp->di_inline_all, jfs_ip->i_inline_all, IDATASIZE);
 		dilinelock->index++;
 	}
 	/*
@@ -3084,7 +3084,7 @@ static int copy_from_dinode(struct dinode * dip, struct inode *ip)
 	}
 
 	if (S_ISDIR(ip->i_mode)) {
-		memcpy(&jfs_ip->i_dirtable, &dip->di_dirtable, 384);
+		memcpy(&jfs_ip->u.dir, &dip->u._dir, 384);
 	} else if (S_ISREG(ip->i_mode) || S_ISLNK(ip->i_mode)) {
 		memcpy(&jfs_ip->i_xtroot, &dip->di_xtroot, 288);
 	} else
diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index a466ec41cfbb..721def69e732 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -77,11 +77,18 @@ struct jfs_inode_info {
 			unchar _unused[16];	/* 16: */
 			dxd_t _dxd;		/* 16: */
 			/* _inline may overflow into _inline_ea when needed */
-			unchar _inline[128];	/* 128: inline symlink */
 			/* _inline_ea may overlay the last part of
 			 * file._xtroot if maxentry = XTROOTINITSLOT
 			 */
-			unchar _inline_ea[128];	/* 128: inline extended attr */
+			union {
+				struct {
+					/* 128: inline symlink */
+					unchar _inline[128];
+					/* 128: inline extended attr */
+					unchar _inline_ea[128];
+				};
+				unchar _inline_all[256];
+			};
 		} link;
 	} u;
 #ifdef CONFIG_QUOTA
@@ -96,6 +103,7 @@ struct jfs_inode_info {
 #define i_dtroot u.dir._dtroot
 #define i_inline u.link._inline
 #define i_inline_ea u.link._inline_ea
+#define i_inline_all u.link._inline_all
 
 #define IREAD_LOCK(ip, subclass) \
 	down_read_nested(&JFS_IP(ip)->rdwrlock, subclass)
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 1f0ffabbde56..9030aeaf0f88 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -939,7 +939,8 @@ static int __init init_jfs_fs(void)
 	jfs_inode_cachep =
 	    kmem_cache_create_usercopy("jfs_ip", sizeof(struct jfs_inode_info),
 			0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_ACCOUNT,
-			offsetof(struct jfs_inode_info, i_inline), IDATASIZE,
+			offsetof(struct jfs_inode_info, i_inline_all),
+			sizeof_field(struct jfs_inode_info, i_inline_all),
 			init_once);
 	if (jfs_inode_cachep == NULL)
 		return -ENOMEM;
-- 
2.30.2

