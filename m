Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4E23BA2B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 17:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhGBPWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 11:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhGBPWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 11:22:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E0EC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 08:20:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w13so13815104edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=06Nd6TnCb3nAEOSv6yJcw8Ps4KFQ2U44qABFJzU7ha0=;
        b=Tb/6zZy4QHtUFQ/eS5cHy+sIGYIkdjTd200ybkGsGXbXYWCEALMoQDLxmcoiNdrIgI
         cfY5xLUYk705kgEv0XtIyadG7Cxb56eW5w9P04fb7WrYDhByCRSAOpJanGBrr38sDSRN
         i2mVFrn7X4L/Spm4WwxNuzxYnFfv4dOyXp18c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=06Nd6TnCb3nAEOSv6yJcw8Ps4KFQ2U44qABFJzU7ha0=;
        b=jWOpz26qNMzBRWwBNmNiitPPKZcwnlPzkWwiU+J1asDawM0sc5dHmEON9Clu+anbx8
         ofChX4DCDw+I4nvBtfys5bPa+9XrBkrPmZErBpzj0upna+lwr/KtVCsfkjzYLZdyXipf
         F7ksZ8S6cN1bUcucRv0zofVLTBdkAbmImJR8N6NFYfZz5k3nAQqrMzYjh1NQ3VrTJ3Kp
         1PAlsu4q1sUonmXAMm58cxTd3UiEF/h4v2Ye1SvS7rTXeFSQrmlSoA6OmRjmoiwbz3e6
         zu2Bb3TmYStZLWvXxoZ3AtcpDAqAiIbxFwchirALgypSQps4flMfdxm5EfyjNpQA2xkC
         8fgg==
X-Gm-Message-State: AOAM5315mjA5LfbTSmlN6iUomkI4jKqQjkNZTw0uajMkIVk908xuUuFc
        JESx9jSkV31fWAD0A5V8cDKrYw==
X-Google-Smtp-Source: ABdhPJy1u5wCKlcBTOsax8/gzE7py/1SbgaTWjGsn//HbIVqC6hXhZ/ySiT8Gf+pZZArQ4zCrVvkDA==
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr7348581edt.321.1625239204808;
        Fri, 02 Jul 2021 08:20:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:9880:57f0:ba7c:cdd5:fff7:623c])
        by smtp.gmail.com with ESMTPSA id c14sm1508402edr.27.2021.07.02.08.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 08:20:04 -0700 (PDT)
From:   Rodrigo Campos <rodrigo@kinvolk.io>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        containers@lists.linux.dev
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] Documentation: seccomp: Fix typo in user notification
Date:   Fri,  2 Jul 2021 17:19:27 +0200
Message-Id: <20210702151927.263402-1-rodrigo@kinvolk.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The close on exec flag is O_CLOEXEC, not O_EXEC. This patch just fixes
the typo.

Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Rodrigo Campos <rodrigo@kinvolk.io>
---
 Documentation/userspace-api/seccomp_filter.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index d61219889e49..539e9d4a4860 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -263,7 +263,7 @@ Userspace can also add file descriptors to the notifying process via
 ``ioctl(SECCOMP_IOCTL_NOTIF_ADDFD)``. The ``id`` member of
 ``struct seccomp_notif_addfd`` should be the same ``id`` as in
 ``struct seccomp_notif``. The ``newfd_flags`` flag may be used to set flags
-like O_EXEC on the file descriptor in the notifying process. If the supervisor
+like O_CLOEXEC on the file descriptor in the notifying process. If the supervisor
 wants to inject the file descriptor with a specific number, the
 ``SECCOMP_ADDFD_FLAG_SETFD`` flag can be used, and set the ``newfd`` member to
 the specific number to use. If that file descriptor is already open in the
-- 
2.30.2

