Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FFA3909BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 21:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhEYTjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhEYTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:39:11 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBD2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 12:37:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c12so12820759pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLsPMiv6DSA05GpG5maGyOqgxR569YwofFs48pyjZL8=;
        b=Cs8F7R1X5/sVmLfG7Pf3uoTDTzPTnDvQ0z4JNoxqo9NzCXTOa9qEp34QdOu1uZWzXH
         Vv/RjvlYGlZdKNUiMDYrsir9u7cUtJ82FnJU/yJGgTqdloQZqgLckh9ps6f78E7uvWBs
         ZYZrhdOllyAJ3iWqbAqlGPAbbJnqFDuwaIy4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLsPMiv6DSA05GpG5maGyOqgxR569YwofFs48pyjZL8=;
        b=pwZGXcSVhoNfDH5mY0x8lQ/mJX2I7OZGewolhQveuKsuj4xUQTUc/0R5iinQkJQnKf
         T8rz+n0C2u9XtTOg3LCEedUcMnkF+gbtky0U8sASK21ouMzHwg4L/U2Ao+dwbW5rvbgC
         nXbk1JHuQ+z6wlj4jgEynlX/sWkqav1vd8+sjPucXLGes6jo85ZfW6OYTSJv8itWSxmg
         CVqEpAoUxtKz3vOEs34sItGkjtDK/y5ipa0xXU+HAooInh5QZQGiET0ztlGfJWIdpC4t
         k29IlRYNec38kjrIEsQmCF5JfIMyFOfHP7KYPWBEdrYQ/6tD2XuwnmJpTu5ZDw9ZEz6E
         VUhQ==
X-Gm-Message-State: AOAM532AXAOEW36yTi07HPzZwe5Qa5JJio96A2unbyLG03LQ0hXBhcxY
        V/fLQfwUnWPA16JslZ7Sh/agglsUcUPyVg==
X-Google-Smtp-Source: ABdhPJw/qnct6G4Ym4gdjE6zXogTwpfmil++jLx2wKdZBrcdrGzTWQRDBKmSHcS6JnGVmmV83xhrhg==
X-Received: by 2002:a63:4b42:: with SMTP id k2mr20617120pgl.33.1621971460619;
        Tue, 25 May 2021 12:37:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x1sm13020631pjk.37.2021.05.25.12.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 12:37:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Oleg Nesterov <oleg@redhat.com>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH] proc: Check /proc/$pid/attr/ writes against file opener
Date:   Tue, 25 May 2021 12:37:35 -0700
Message-Id: <20210525193735.2716374-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=46e69e9d2d0af436a48018a857f2937985444d4d; i=zfYc9o7Xh4krRd7nGczFjvo5TEUhULZpwg1kF4EzE0A=; m=6TKTT+5qh3rPWLpItrWkKb3XMLMhdTLrBJauXglpkfg=; p=YZ4WBn7xWQf3J+lMAhtySTu19dR5D/lP+w3F8nCulTo=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCtUf4ACgkQiXL039xtwCakZxAAkCY SlPRMzII3/u1V5ffaqI51Tx/91rGPMTs7n9YT4IEAacrXfN9zPSLIWG/LKxyOhxnOOyJTaoCAyz8Z X/sCZ88juYRcxa7785rtY4SJjcC9A3cmYhae7I2cflrJv5yk/9Y+29IMzCSPdqYKS9KNLn7NsVWj6 iqtSdt3D47nHsQV4iQfF/tYnDfdplVphH0PZX20cPyuxjKWHLYOUcky9teilofn0gSawjxpOmK3dr 0idAfeBD2f3Y8YCb4K1NnvfIX1jcjN2PSfR2nFz4XaxPb9L4H+kKlM1PMmeiCgW54aptdD1zGujg8 nIMGkRM/9bL3tvBHEvZK3B15R7soKDrjvNtWr2DrXW8d4nme20CvZ0QPcLIUn1gVuYhLU377w5dx0 BCkNep2f0RNNTZ4Vxu2XBZYTBR4Lc0ITC6NvWisgyC2pjzZJqBDb+H5MOhKaykPukIIwFlG/iD+GW /cIChpgwLyOF4z1E1H+PAy5u0qMqyLMeTvOiAhRrMECzXqYrO8ZH10g8szmvFghSO9q6DigOCSFlV FXb1bagvuAjICq3G9WFKmCpxjFfVT6fe9OlV4RFCC/2YVYTrn+5r4HE+yrm+rpJ6Wig0nJxvCkecI xxtPLl0WCLqtrQk1ZJ4TyxsK9CHligb+SXg1OA3IoLfh0uXQv7ND3/gyH3ksnwR0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix another "confused deputy" weakness[1]. Writes to /proc/$pid/attr/
files need to check the opener credentials, since these fds do not
transition state across execve(). Without this, it is possible to
trick another process (which may have different credentials) to write
to its own /proc/$pid/attr/ files, leading to unexpected and possibly
exploitable behaviors.

[1] https://www.kernel.org/doc/html/latest/security/credentials.html?highlight=confused#open-file-credentials

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/proc/base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 3851bfcdba56..58bbf334265b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2703,6 +2703,10 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	void *page;
 	int rv;
 
+	/* A task may only write when it was the opener. */
+	if (file->f_cred != current_real_cred())
+		return -EPERM;
+
 	rcu_read_lock();
 	task = pid_task(proc_pid(inode), PIDTYPE_PID);
 	if (!task) {
-- 
2.25.1

