Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4140F39CB70
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 00:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhFEWWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 18:22:35 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:53026 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhFEWWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 18:22:34 -0400
Received: by mail-wm1-f45.google.com with SMTP id f17so7503422wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 15:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZV6QHmLW2IhVe7aDucJtaOWmiQLmQd2BmiqxceC5f78=;
        b=VyI/WF1SWGYXXj559OCdqmaiASZwVXGaTW7u3es2oQqtrKIRyxbRQXShiISwNO9zlY
         YOxZT6J/S5vuF+6Ex1S3Xs4DtdqB2RQvVTHCw4paxbO8FYO6rcbbZcP8XjKcLs7bi4Bc
         D7VaN9+aOLGFEbTAcarG7p3ajFzwwAFEgQFExMwZbclhwshc8Uk9VPMhywJMV9q4KrSx
         ydh7gnkuHxSDgNy1510NSu7Y+mlCMjRkeswYX3acFaly85pew0NJOag3AWKSQsEbZdg+
         18v3McNgA3n2RperEh80vM51cgkNC13u+oNu6XFYMNU6NqZWBZ9/sZ+6PydBin/XPAi7
         +I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZV6QHmLW2IhVe7aDucJtaOWmiQLmQd2BmiqxceC5f78=;
        b=k/oLTx32HMeuefpKCDfIrv5/B0sv/U+R5TVsuz2tTBsRHOkaoWyK1fd5CHYpEPm+rn
         fJTFP+FLcGXfbjIVRQDQhPHXP+LI85xvbqWVLNTd+wmKlGCZzJRVw3/pDPSiA1HMfGnL
         VBP0z2TX23GNHiQte3445mODtnUJJk6bbyL/+x7YC3E9mNaII4VgkpxwPYX3Qa0Ou+0f
         W8/jgNeiUyQ/xYD3vmkMXSn4hUn3jmPsE5zeAnpdEKM69Q0e5COmHDxs1aEniKQVz8BW
         diPq3IbgdfJ6DE34RVysNvr0Ju8g9NWdm6XIyr2u/mOGnddTj+xAHd0UKGIY0oFhpifE
         +Y/w==
X-Gm-Message-State: AOAM532lDEX+hvqvJ3c6Juw6EDCfBHU7udfqY+4pjDOUlXQvwdmFBs62
        3vtmZwh4ky9KY/HkRIg+rIbrpZDFng==
X-Google-Smtp-Source: ABdhPJxXWGIx0aH27GJP/VxRnQpylLE2w2GWeENrz0lBN+zO3FeVp+SR3gOkdZ2pmZ/uSjvQCcpT+g==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr9832629wmf.7.1622931570644;
        Sat, 05 Jun 2021 15:19:30 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.132])
        by smtp.gmail.com with ESMTPSA id t4sm10889365wru.53.2021.06.05.15.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 15:19:30 -0700 (PDT)
Date:   Sun, 6 Jun 2021 01:19:28 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: memscan() fixlet
Message-ID: <YLv4cCf0t5UPdyK+@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic version doesn't trucate second argument to char.

Older brother memchr() does as do s390, sparc and i386 assembly
versions.

Fortunately, no code passes c >= 256.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib/string.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/string.c
+++ b/lib/string.c
@@ -977,7 +977,7 @@ void *memscan(void *addr, int c, size_t size)
 	unsigned char *p = addr;
 
 	while (size) {
-		if (*p == c)
+		if (*p == (unsigned char)c)
 			return (void *)p;
 		p++;
 		size--;
