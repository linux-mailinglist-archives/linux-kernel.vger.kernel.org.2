Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE598447F64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbhKHMS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:18:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239472AbhKHMSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636373769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYP45irqlvN4LwnhVHPJ2BU2KkkDGk/34c5IpHYqxRQ=;
        b=QEeNNUWYScwCmwORrmyu0VsY+UkJ6jx155UBs4PUktUPbFZ6UccZn3ULpj56G50fMJIdvW
        uKktApv2HfmDsflxcDSdSrfWCJXTsrHg9cNVtFlo3ZJoUXYDS9yBtbAsIRmZIQ0N3xWV/e
        qk7bznMdzGP5BKyCjiD9IoOzCbNRND0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-sMuaRRAmOXm8Q2JVvm2aQQ-1; Mon, 08 Nov 2021 07:16:08 -0500
X-MC-Unique: sMuaRRAmOXm8Q2JVvm2aQQ-1
Received: by mail-wr1-f70.google.com with SMTP id p3-20020a056000018300b00186b195d4ddso3966425wrx.15
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 04:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYP45irqlvN4LwnhVHPJ2BU2KkkDGk/34c5IpHYqxRQ=;
        b=GVAtFyqhgXqzhrceBvS2zFfsxLWkFywgkusmaOyG+udxd8RgjlL1YhIR7OoT6zLIUX
         FxJstdR5j0/9dJBKEOlLQO2vmjnBjAMYwDjl3jzl51eMWsPrJHmvLOpTwokFaO9tP1Yq
         k5oLLXYzj7isKGaJx3Al9xSYvp4W49B4XD3Ol1Ul4Bz0vER/kck54dArw/UqnAvdVt+5
         arvhkjdrqo1nM4x1Rds5QDX5WBgt03jQ2w8Uo73IkXqqb0eqom8aXKuh73ROqPcgmJQI
         14OToSqm3R+dRFz+LiE53q2gh9SKndRgt7q2OzOiVA5cd71o7Z2q/Y4ooCB5zmvhlQFU
         GG7A==
X-Gm-Message-State: AOAM532/aUKwNCR0EeB7YZ3WuN1Db1ELcaPjxB6fMxkPWRM9FnMV+miK
        N02IYFafzcl0uDcrj/md7SOCZabn955hK4VOQ27wj1/ccbYf4N3WzJf2+VHfL4XnFuK8Om0Ws43
        2ssCzTOkUld0vE3jWjSKtT4NRwriJgClSlnWN1vGfnYRcDK8n4kMJPfoRnr+06oizuO3d6YWXRb
        Q=
X-Received: by 2002:adf:d1e3:: with SMTP id g3mr40570922wrd.300.1636373767286;
        Mon, 08 Nov 2021 04:16:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqmdnv8hB/1I80V7WFAMCesKfVcjz59XA/P6anCiMb+qZGLTd+pMQzzm8ZY1WF+8dDjHy4qA==
X-Received: by 2002:adf:d1e3:: with SMTP id g3mr40570869wrd.300.1636373767009;
        Mon, 08 Nov 2021 04:16:07 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q4sm16866866wrs.56.2021.11.08.04.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 04:16:06 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 5/6] Documentation/admin-guide: Document nomodeset kernel parameter
Date:   Mon,  8 Nov 2021 13:15:43 +0100
Message-Id: <20211108121544.776590-6-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108121544.776590-1-javierm@redhat.com>
References: <20211108121544.776590-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nomodeset kernel command line parameter is not documented. Its name
is quite vague and is not intuitive what's the behaviour when it is set.

Document in kernel-parameters.txt what actually happens when nomodeset
is used. That way, users could know if they want to enable this option.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git Documentation/admin-guide/kernel-parameters.txt Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..ed9859fd0734 100644
--- Documentation/admin-guide/kernel-parameters.txt
+++ Documentation/admin-guide/kernel-parameters.txt
@@ -3521,6 +3521,10 @@
 			shutdown the other cpus.  Instead use the REBOOT_VECTOR
 			irq.
 
+	nomodeset	Disable kernel modesetting. DRM drivers will not be
+			loaded when this kernel boot parameter is used. The
+			simpledrm driver is the only DRM driver that loads.
+
 	nomodule	Disable module load
 
 	nopat		[X86] Disable PAT (page attribute table extension of
-- 
2.33.1

