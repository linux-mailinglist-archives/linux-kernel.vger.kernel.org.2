Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191FC3819B5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhEOPxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 11:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhEOPxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 11:53:10 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F33EC061573;
        Sat, 15 May 2021 08:51:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t193so1475334pgb.4;
        Sat, 15 May 2021 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jOvmf3JoFVpwNUWMjp8l9LOhDQkcr+mi2wWeST9IjuE=;
        b=cWPyJUPDEwRGoEw9tdG9cwKCLgDC3xFwJEpuKRTCQrmPQ+KHBiaWc/Hbl2lEsblUbC
         XmhyzGHyqxa8/yIDk83H4LEvl0DWh8NdeHK+g+OmPuwH9hF3UaKbYhHA9znr6352kANY
         zZCSD1ojOTN8AqPev9L7qTLpDxlky4sQHn5ytfFoF6BYKXkIuivqEg1MO3yIGCNiLWat
         cBEC+03tFNHf0M6pmWZQzyYJgCXgArnZp3xqdSkYGODMmeGnrgG7owaaA+rEI9aBR/iT
         NJahrUU/mnEzKsG1pgJ+LvgLq8bOhZ12MtIxfocE6E95Hq8Tp7Fh4HRIds82ia22oVrp
         ixGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jOvmf3JoFVpwNUWMjp8l9LOhDQkcr+mi2wWeST9IjuE=;
        b=XQ8M0vqhTXx9fzfhtv6T/kknPXyWu/+5aBQ/E95XaHgBvCF3BRTOAV5FXoVSWdRr81
         Pixn9GoXEXFmzAR+l/wOmfDIjDHvwaLAEdDt7jOEYNmu4FzahQc3a9aZjTGllqjr+WmI
         HCuceeY0O0ss6pHmjgca53a/PNyd1yfsC3PWL2pnd3sZZv+NpUx1hITyQ5LRn/nXoRj2
         ImzR2hizKQu7012J0a5e4MlkSVO8yJKRRjt1M3ZZXp05+8gyollVktIhAGrNyUaa4ezI
         LE6cZhMPEXWu+qOiEc/1WraW5Jh+GtBI+1BK0QfGbSwRi4A4xN75He++xR1ZM7attIyu
         sEdA==
X-Gm-Message-State: AOAM532zfghVmRFDMcdTn1mqgtdZiK3sXUlB/uwRxOtJ+gvVyUznvje+
        SuH6zemqzKPMuIj0IFfenw3rbLeHbeuM/3mz
X-Google-Smtp-Source: ABdhPJwfc5wRiIuvoxr5IL0MNy+qlgfJz9+NH5pElZQfCbs0JtnWcRw+mmcr17sGIM94zTVPWX/tpw==
X-Received: by 2002:a65:618c:: with SMTP id c12mr52544258pgv.296.1621093912693;
        Sat, 15 May 2021 08:51:52 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id q24sm6646648pgk.32.2021.05.15.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 08:51:52 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, federico.vaga@vaga.pv.it,
        corbet@lwn.net, alexs@kernel.org,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] docs: Use fallthrough pseudo-keyword
Date:   Sat, 15 May 2021 23:51:42 +0800
Message-Id: <20210515155142.2490-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace /* fall through */ comment with fallthrough, make
it align with original process/coding-style.rst

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 Documentation/translations/it_IT/process/coding-style.rst | 2 +-
 Documentation/translations/zh_CN/process/coding-style.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index 95f2e7c985e2..ecc74ba50d3e 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -62,7 +62,7 @@ i ``case``.  Un esempio.:
 	case 'K':
 	case 'k':
 		mem <<= 10;
-		/* fall through */
+		fallthrough;
 	default:
 		break;
 	}
diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/Documentation/translations/zh_CN/process/coding-style.rst
index 406d43a02c02..b8c484a84d10 100644
--- a/Documentation/translations/zh_CN/process/coding-style.rst
+++ b/Documentation/translations/zh_CN/process/coding-style.rst
@@ -61,7 +61,7 @@ Linux 内核代码风格
 	case 'K':
 	case 'k':
 		mem <<= 10;
-		/* fall through */
+		fallthrough;
 	default:
 		break;
 	}
-- 
2.25.1

