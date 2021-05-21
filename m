Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DBA38BCBF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 05:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbhEUDD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 23:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhEUDD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 23:03:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7BBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 20:02:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso6329674pjx.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 20:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDCqTxRCvKvq40fcsT0cEmcZyjzoY19iElps9bxazFU=;
        b=qFRo/g1wdeTiNOvWl41zLpPnlJGxEd0bOEtofJ9l9r2rpdrjAO/1NWvIbEaPe1dvrV
         JG0j85+OqBTOCMxtXwHbctWye+1eDlVBsO11Fx7qykYNzRw/RhGNbHX/dHTBql4A88HF
         ZEtKi+zi1zOg6XGTXBODzZQZ3NH/6NDwYVwkI2beEmcv0N5UsgKZKJS78DkuTCMMAqgo
         e3mozQJAnVnrC7bAKWVx/wPrGJmUmY071uz/XJzd0MikbPW2BHSsl+SoqilG1ci7LSzI
         Q7dkhAzCfyX7IERiLFnodX8CEzHW0mx+1Ze7GvRyBQ7OKFZnl8lFuBscL/V0FmvkfUzV
         7SGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDCqTxRCvKvq40fcsT0cEmcZyjzoY19iElps9bxazFU=;
        b=f/BaG136J+sEc2HoabiWM4/mAQu2tFO0e1He9XXEUHeh7q05ThiEqx5wT2O8/v/vjS
         6nehZ38hVkg0yo6FxL84rnEsf6SCMAF3pZzS7MDPRUtyyoKFUeZrbuHtVnm7kDXSaXTS
         K02ipdGWbi3r0fXVFjTmHYrRUNH77Q0SLdy8CykTGkkigW/dfLuXsL4+G94m02Tn86GD
         IGHg4r8uUnDfhK/JSZzMuchNJiunJULJyZCaPAKJ4oNpioWABy1BcyIa3IiTIGnubMcV
         RBlnhReuPhkxR3Se9VhUBIVvKZX0wBXGESAluzPa9EOAZnlpqFb3e2PMyDRlRRHeNrP3
         LNOg==
X-Gm-Message-State: AOAM532TbMT9db4cI4eR+1eOG2olw6JC8SVZy36yQrNmt+293pS0/adR
        jVWzNxQeHVDBMak45mxtdQ==
X-Google-Smtp-Source: ABdhPJxMvDDX75j1xA1E1unnWCRQaaxFQgeb+gKhDQ0f5nHjCfIUuFopGJxc2W4PIz9c7VUOT1lsuQ==
X-Received: by 2002:a17:902:b68c:b029:eb:6c82:60da with SMTP id c12-20020a170902b68cb02900eb6c8260damr9534824pls.25.1621566123765;
        Thu, 20 May 2021 20:02:03 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id 191sm2959677pfx.121.2021.05.20.20.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 20:02:03 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] mm,hwpoison: fix sending SIGBUS for Action Required MCE
Date:   Fri, 21 May 2021 12:01:53 +0900
Message-Id: <20210521030156.2612074-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I updated the series again with the following changes based on the discussion
over v4:

  - separated v4's 2/2 into two as done in the former version,
  - switched to "first found" approach in getting error virtual address,
    which could report wrong error address to applications but that's rare
    and not critical,
  - rebased onto v5.13-rc2.

v1: https://lore.kernel.org/linux-mm/20210412224320.1747638-1-nao.horiguchi@gmail.com/T
v2 (only 3/3 is posted): https://lore.kernel.org/linux-mm/20210419023658.GA1962954@u2004/
v3: https://lore.kernel.org/linux-mm/20210421005728.1994268-1-nao.horiguchi@gmail.com/T
v4: https://lore.kernel.org/linux-mm/20210427062953.2080293-1-nao.horiguchi@gmail.com/T

Thanks,
Naoya Horiguchi

--- quote from cover letter of v1 ---

I wrote this patchset to materialize what I think is the current
allowable solution mentioned by the previous discussion [1].
I simply borrowed Tony's mutex patch and Aili's return code patch,
then I queued another one to find error virtual address in the best
effort manner.  I know that this is not a perfect solution, but
should work for some typical case.

[1]: https://lore.kernel.org/linux-mm/20210331192540.2141052f@alex-virtual-machine/
---
Summary:

Aili Yao (1):
      mm,hwpoison: Return -EHWPOISON to denote that the page has already been poisoned

Naoya Horiguchi (1):
      mm,hwpoison: Send SIGBUS with error virutal address

Tony Luck (1):
      mm/memory-failure: Use a mutex to avoid memory_failure() races

 arch/x86/kernel/cpu/mce/core.c |  13 ++-
 include/linux/swapops.h        |   5 ++
 mm/memory-failure.c            | 188 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 190 insertions(+), 16 deletions(-)
