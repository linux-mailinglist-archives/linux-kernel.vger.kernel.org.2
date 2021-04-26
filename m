Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853D536B90C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhDZSgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhDZSgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:36:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0BAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:36:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gq23-20020a17090b1057b0290151869af68bso5700030pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=M4PRNZ6UFdUD7I69kTPP/tNKoFLbFxl7JYOSSrNLLac=;
        b=cllrLqVU64S/FsTBgLwcU1JLdQwCtKY7Qh16AcqsehO8DgSzgYAHiXQquAg+MrcBJ8
         VMXgswIGI8FDmSIKHG0umGXeHyUOYFxGWAm0fYsDM1fZlsYFlA2gL5whej9aKUNULf7J
         om6rn76qKF1nSoQt6I5GNFkn0yB5vHEMBMtsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=M4PRNZ6UFdUD7I69kTPP/tNKoFLbFxl7JYOSSrNLLac=;
        b=kGRbGJXIoIK4f0zxn1W9AmbZTETHvtMjuaEm3yZ5P6TA/hg47JsHbRLDLxhLorB2bj
         LbNENxyIxeiqoCKahzcV6isTUOIO9QITU4CHK/dtc88Rj9rmqEwQCXs1WhlYYocFz6Uz
         sYXwNTeV3Jmmpm5imQxGywcBtIuZg4I2X4DZtgzI2aslN/Nd5C+/mFhO4kuG9gtXtme9
         XfFYaIk0HwE+cWPPN/AoNY2+3chZq3L1mYAW6btfZlAOdYBkPohHKBmrT8rg+W4VDYxc
         lZbjuHR6YHZHNJOJVk0T/sldSTWv/pvAeAsjKxgxDY/m5NVi4Vp1BqwWi7umlpbVJceV
         cAvw==
X-Gm-Message-State: AOAM530TWke0p9iJYNjYaYsvDejUaPlvWaKdYKgZXtYqG2PATGOckIUa
        AXTNQhGzCBXh/kk7F1dU0A9RsQ==
X-Google-Smtp-Source: ABdhPJxmf87ZpWLgN7nsKfNmzRCaUfjAb0nydUZ5Ni71x796SRfDbBB8AJhlhSlsrLX4Eid84TAfQg==
X-Received: by 2002:a17:90a:1747:: with SMTP id 7mr22214011pjm.109.1619462164835;
        Mon, 26 Apr 2021 11:36:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b25sm383286pfd.7.2021.04.26.11.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 11:36:04 -0700 (PDT)
Date:   Mon, 26 Apr 2021 11:36:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>
Subject: [GIT PULL] overflow update for v5.13-rc1
Message-ID: <202104261134.C4C4063@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this overflow update for v5.13-rc1. I was expecting more
in this tree for this cycle, but the other work has not yet landed for
-next. As a result, only this single typo fix exists. Yay tiny pulls. :)

Thanks!

-Kees

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v5.13-rc1

for you to fetch changes up to 4578be130a6470d85ff05b13b75a00e6224eeeeb:

  overflow: Correct check_shl_overflow() comment (2021-04-01 14:07:41 -0700)

----------------------------------------------------------------
overflow update for v5.13-rc1

- Fix typo in check_shl_overflow() kern-dec (Keith Busch)

----------------------------------------------------------------
Keith Busch (1):
      overflow: Correct check_shl_overflow() comment

 include/linux/overflow.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Kees Cook
