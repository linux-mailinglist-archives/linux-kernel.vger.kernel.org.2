Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8AC3440E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCVM0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhCVMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:25:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F90C061574;
        Mon, 22 Mar 2021 05:25:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so11099247wmq.1;
        Mon, 22 Mar 2021 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LOMTMUV/x85LsCPs4gPFUtmz8oNiKQ4g1MCpJALdrNc=;
        b=h23X+iafnBgO3cnGvZfeiDg84UGZYLcGqxh1D7fZNVic8vdWLnIQPRMVK42ZPf8o9N
         +K26B+14EB/6s0m9osJUsNjYzpbDuRf/7piB9JM4/q/UzSPB/U96FdLPbGlTUpPGvzOw
         1hWUG56Xt4gBGdWCQOoAREVM2ewYnA0y6TVzNc+Q9mrB7CaQJrCObm8phOzqeAfJWR4p
         v2mbPrgNEOYDbzbt7Uw7F9RZUBTMzbr175Orz62+zqqqrEBfYgpc24vLlP1F8YafQ7A4
         DtnwAxRPtNvi9UitVE2DyIcFIDEGhwT9Qsh+ZsSjRXHvV38GxS1sMiiu/mHnCcrOVCyn
         tehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LOMTMUV/x85LsCPs4gPFUtmz8oNiKQ4g1MCpJALdrNc=;
        b=Z5NCMaj3kjNyGhB5ybGQoGXN1PMf/bTYwWE01ti4C21lUVBXxTKM9bpxBFX0/EhGZZ
         ta3EJrtqDFXOJqL/6nsf0zUh/iNXdlJ5N5rTZQU+uCffFj4NWowRGv8roNMWgXJ1xsVj
         mb36V5YhskDsAvoX8k6dINzWvxAkDYqYWqEXQ9UfbtA96x+u/9X3Lct28mq7auDpSSRa
         Zb5n+ANhYRbI9ZIeFI6Yp/CNE0fDyFaKqxdupXU2IeaxAAOrneQQ0MUgdrLJ3qJMCEbC
         aLt8sFKpOZxGtdimhS96MyMZa13S/RvmbtixpdUgIC1Nembx2tu00LFxVbcRXI0OJ4NA
         5kzQ==
X-Gm-Message-State: AOAM532A8DEgQENcb+pHK85C+pi+XIW7dsjesvkT9i281rQzvR4Gsdl6
        5Lwp8lkvMVNPI8LmtOZ67Es=
X-Google-Smtp-Source: ABdhPJzt258rnp+NSla7apvIQE3tvvBvTpjWmYXSMVgriDFOrOqXSTatqWQQ26RLdAxRvgCu6jDioQ==
X-Received: by 2002:a05:600c:290b:: with SMTP id i11mr16282819wmd.129.1616415950882;
        Mon, 22 Mar 2021 05:25:50 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d8a:8e00:5079:bba3:3b0:9023])
        by smtp.gmail.com with ESMTPSA id u17sm19088558wrw.51.2021.03.22.05.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:25:50 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/2] kernel-doc and MAINTAINERS clean-up
Date:   Mon, 22 Mar 2021 13:25:40 +0100
Message-Id: <20210322122542.15072-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roughly 900 warnings of about 21.000 kernel-doc warnings in the kernel tree
warn with 'cannot understand function prototype:', i.e., the kernel-doc parser
cannot parse the function's signature. The majority, about 600 cases of those,
are just struct definitions following the kernel-doc description. Further,
spot-check investigations suggest that the authors of the specific kernel-doc
descriptions simply were not aware that the general format for a kernel-doc
description for a structure requires to prefix the struct name with the keyword
'struct', as in 'struct struct_name - Brief description.'. Details on
kernel-doc are at the Link below.

Without the struct keyword, kernel-doc does not check if the kernel-doc
description fits to the actual struct definition in the source code.
Fortunately, in roughly a quarter of these cases, the kernel-doc description is
actually complete wrt. its corresponding struct definition. So, the trivial
change adding the struct keyword will allow us to keep the kernel-doc
descriptions more consistent for future changes, by checking for new kernel-doc
warnings.

Also, some of the files in ./include/ are not assigned to a specific
MAINTAINERS section and hence have no dedicated maintainer. So, if needed, the
files in ./include/ are also assigned to the fitting MAINTAINERS section, as I
need to identify whom to send the clean-up patch anyway.

Here is the change from this kernel-doc janitorial work in the ./include/
directory for MEMORY MANAGEMENT.

Andrew, please pick this clean-up patch series for mm.

Link: https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html


Lukas Bulwahn (2):
  MAINTAINERS: assign pagewalk.h to MEMORY MANAGEMENT
  pagewalk: prefix struct kernel-doc descriptions

 MAINTAINERS              | 1 +
 include/linux/pagewalk.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.17.1

