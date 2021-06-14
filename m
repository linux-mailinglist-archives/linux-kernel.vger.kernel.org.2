Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8F83A5C58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 07:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhFNFJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 01:09:19 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:46941 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhFNFJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 01:09:17 -0400
Received: by mail-pl1-f178.google.com with SMTP id e1so5900695pld.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 22:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7emn/WrNvxvMGRavk2ZZTU/O8HzrawGqoRrQamBs2vA=;
        b=qmPKEk6nsUBRMtGUrK+YW0Y6lDW06gC2JDP/dJOSUGN5d342lCfmh+o3M/BfZEfIZ7
         UrWWPBqwOHjOS1MKQODSCKijNdC9JZ92OBn6nxj9W6bdPynpTSWQ3OtItph7SXAfIJT7
         HQGLMEn26hZi80/Yt4wgCTgGQPU5NujVvrFv0mtfvBo/qMXs3vVMBlI7qJv+sZzFfcS9
         2qzQjmiLeOhEPveuGIknOh/CTaIRn1dceppwLt9Vcb8OomnIOKDtAPYo6hpgCcqXfq+X
         TND5PXRfhgBChUUdpiBv7pZYLKpFhtd0nxI9ywJPuJTVNRIYiob76fP9q5bWf0edNWdq
         jVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7emn/WrNvxvMGRavk2ZZTU/O8HzrawGqoRrQamBs2vA=;
        b=dS/iild9v5srwmohXVKQdg+H1Atlb5mg/Rpi7Cci+rvzCDgNHy+YpqfaUFu4LvRya4
         JiYkacYa+NxbCPnDP6rs2UHPtw2oFr9HsgcK12AAvFZs+BsOq2YhIT+hpxtr0w5F3jh3
         hE1tlVzToeW6Phq6/XY3pE8GQb/3aJisrKISaR65UiDbD9SQGcxxcaCYfJoxf/maNDDe
         O9BZ31pDANLFuVlLN6dXIliIOXFYA8xq7GkBDitn+6KbmWgl1xo/I2LJkT4LAeL+LIHK
         JNeoVZq17a/IKpAmfb5l2muAc//Hud+5251kFSeFHWB8v995kFONZEM+2RHWmIXbU98B
         SPAA==
X-Gm-Message-State: AOAM531AIeycG+sdpczeurHVMN4BMCxAJkIM+tP7DhlzctBoTqXqZ8aM
        LMSgh/3xP0cOlerJdLr87EQ=
X-Google-Smtp-Source: ABdhPJxojE3pyUHguVc0JXxQWQkV3mdMX+hd3IyjHSemE7lgIVB5gm7wYYKQ+iXH8YsXHzE4WU90cQ==
X-Received: by 2002:a17:90a:8c14:: with SMTP id a20mr16797974pjo.167.1623647166158;
        Sun, 13 Jun 2021 22:06:06 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id q3sm10633391pfj.89.2021.06.13.22.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 22:06:05 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     anton@tuxera.com
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+213ac8bb98f7f4420840@syzkaller.appspotmail.com
Subject: [PATCH] ntfs: Fix validity check for file name attribute
Date:   Mon, 14 Jun 2021 13:05:40 +0800
Message-Id: <20210614050540.289494-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking the file name attribute, we want to ensure that it fits
within the bounds of ATTR_RECORD. To do this, we should check
that (attr record + file name offset + file name length) < (attr
record + attr record length).

However, the original check did not include the file name offset in
the calculation. This means that corrupted on-disk metadata might not
caught by the incorrect file name check, and lead to an invalid memory
access.

An example can be seen in the crash report of a memory corruption
error found by Syzbot:
https://syzkaller.appspot.com/bug?id=a1a1e379b225812688566745c3e2f7242bffc246

Adding the file name offset to the validity check fixes this error and
passes the Syzbot reproducer test.

Reported-by: syzbot+213ac8bb98f7f4420840@syzkaller.appspotmail.com
Tested-by: syzbot+213ac8bb98f7f4420840@syzkaller.appspotmail.com
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 fs/ntfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index f5c058b3192c..4474adb393ca 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -477,7 +477,7 @@ static int ntfs_is_extended_system_file(ntfs_attr_search_ctx *ctx)
 		}
 		file_name_attr = (FILE_NAME_ATTR*)((u8*)attr +
 				le16_to_cpu(attr->data.resident.value_offset));
-		p2 = (u8*)attr + le32_to_cpu(attr->data.resident.value_length);
+		p2 = (u8 *)file_name_attr + le32_to_cpu(attr->data.resident.value_length);
 		if (p2 < (u8*)attr || p2 > p)
 			goto err_corrupt_attr;
 		/* This attribute is ok, but is it in the $Extend directory? */
-- 
2.25.1

