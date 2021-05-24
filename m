Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEAA38F185
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhEXQ33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233159AbhEXQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621873679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RCwD0QS5qYMZ3I485ga0mBzEclvb9mUVoGt+KyuaoxM=;
        b=BCvu5nDE7KgwG6YUJMSgstsNOzvNBVSrL0+h10MFEIa6uCJohu+7y+AWhJkQAoCca3PDAp
        xF/i/zU7seRIBFNfSOD4WU10/ITIVNFeUwBfgwFJhi25dQ99lFjfGhC9w3JsGwmNif0lUo
        ZBv8WuG7CUuYXhYK44JLePzdpprvjOE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-9x7APbGUNHGGdV4SyWWUVA-1; Mon, 24 May 2021 12:27:57 -0400
X-MC-Unique: 9x7APbGUNHGGdV4SyWWUVA-1
Received: by mail-ot1-f70.google.com with SMTP id h28-20020a056830035cb02902a5ea00385cso20121077ote.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCwD0QS5qYMZ3I485ga0mBzEclvb9mUVoGt+KyuaoxM=;
        b=MDf9G94XhJAfmddC6cokA7VktKvqtDs6J4Fvxb802CjoCHxZ71wlvkv6lN4x/py3q4
         urbYbjkG2BpIFuP36LlWAruE5jYsGkWFdXnVrGg8wWMexnDp/VwJl2Y/3MxVo3ZakY+R
         IpsyfdYptUYaZZqHZHZU+0HwIyAxch6I1hCXAwW2pvKkxWLMjX5HYF6JTdbLwXxGofLy
         w92/d3h62HFN9+IB339/zjorzLO+86ObZN+Cg4qZq100ctFhk7QcVWtmBToHNppY9orV
         VfQVhFnGxjBPVLPhlhe/qkobhG9NvuixX3nBU0kjDG+l4LTtIT+3QR4DvG0ElJiVRwwY
         aZlA==
X-Gm-Message-State: AOAM532b43JEj5k7QpeWtBp5pZKeyIz/N/pjpVtY6NSULLF/c9ONfUNq
        bQdGEUrAhJTuqB4HDcmetYaphyrvD0pLUQyaE9FGilhLOuIgM6mY6BineWGtQP8tlptUAaSoozH
        6vEqIisXg5YCyY8JFeQu0B7o0
X-Received: by 2002:a9d:30d2:: with SMTP id r18mr19068282otg.170.1621873676814;
        Mon, 24 May 2021 09:27:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/564NPCS6FnJ0OsaTxrZRw/CMSHj4jKE03KU5Oj1QWU8VWZQ5luePcELtSv05gQ3tHlVZ0w==
X-Received: by 2002:a9d:30d2:: with SMTP id r18mr19068270otg.170.1621873676671;
        Mon, 24 May 2021 09:27:56 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b8sm3145797ots.6.2021.05.24.09.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:27:56 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v3 2/6] fpga: add FPGA_MGR_REIMAGE flag
Date:   Mon, 24 May 2021 09:27:52 -0700
Message-Id: <20210524162752.2221245-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

If this flag is set the reimage ops will be used otherwise the
reconfig ops will be used to write the image

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/fpga/fpga-mgr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 50a9fea3c47ef..bb11b18527326 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -67,12 +67,15 @@ enum fpga_mgr_states {
  * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
  *
  * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+ *
+ * %FPGA_MGR_REIMAGE: Reimage the whole card, fpga bs and other device fw
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
 #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
 #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
 #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
+#define FPGA_MGR_REIMAGE                BIT(5)
 
 /**
  * struct fpga_image_info - information specific to a FPGA image
-- 
2.26.3

