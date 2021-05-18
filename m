Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6F83882FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhERXO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhERXO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:14:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3EAC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:13:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 22so8172591pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmux7zEIvTlZ3g8qBTFUSGjR1GHleMmeGKxZ7tsT3bE=;
        b=pwupZ+G81nZwIn0zo+G/TlYE6h/qDMi1EBng+geK5dYMIq4x5U2wa0nf0U344ZI1bF
         VFJXNJjfO6eOPVyIRyKEmDHmQ4fcc1Z2RzMDw1pX/n0SL+qCKZhUtMC59hfOrDxAnmHH
         yyKnvMVFDMshHrMNdIkImBN6a/9vW+lu/SNV70tiZdRwctCZzYD1YJszXAeweq2yqES5
         mEeJUHBKpYmOWuhzj7kQtimO5dTL+bYKVlqtoUaQ0Yv6hUAVnUrr4i+kvmk0+5kfJUhA
         cKANbfMwB+qQQroRwq+BO+WglfV6SSbUx8SNQPqzj6XkfNOimu6/1qVL5nj1i9luGKoI
         FKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmux7zEIvTlZ3g8qBTFUSGjR1GHleMmeGKxZ7tsT3bE=;
        b=BLvU0od1mDiJmfE/TNRyQpK9lA/+mXWyDz5wsFxE9rAtpPXexYoa5TSeEPf72iZtTL
         oLDvh3qBDN+Kjw6DYEOADzkJ8Y2zTRPqyEI+kdXNCkFSz+Jdd91dlZ2mGqbl0DI5KHNw
         11LxjVwLade9t2m6RFvEiaDFfb49mOLI6tfR96tiCOGhh2mAMJnKft6/O/ijaJPjivIV
         Sa6bBkWgqpsY8Q9OfLtwKTCLgltxIy7PwZxt2ONPwNW33Hot1HcGtGY4K96ZNXigo8wr
         YCHQrAwsOh1tEWuhHhZb2wmqT9Iz+MwZTvUwS0kVRDeOeBFozy9+quV9Xze5dDVjZZu0
         IIVQ==
X-Gm-Message-State: AOAM532fH0QINTYao/7QB12cwUoJ3C34mU010dB5OiwF4iwPyE2BSBt3
        dAfbRVoxO7L+fe0Qmzqeqg==
X-Google-Smtp-Source: ABdhPJxkOgiuEJV76QXhK82iKkj+e2gMzcVaqQFYfXdKpaze7uwFzqV6RuKF29hlxkgC6haD7fiHrw==
X-Received: by 2002:aa7:90d5:0:b029:28e:df57:47ff with SMTP id k21-20020aa790d50000b029028edf5747ffmr7546916pfk.74.1621379589702;
        Tue, 18 May 2021 16:13:09 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id f14sm14437473pjq.50.2021.05.18.16.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:13:09 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] hwpoison: fix race with hugetlb page allocation
Date:   Wed, 19 May 2021 08:12:57 +0900
Message-Id: <20210518231259.2553203-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I updated the patchset again based on discussion over v4 [1],
I rebased onto v5.13-rc2 with suggested fixes and code adjustment.

Thanks,
Naoya Horiguchi

[1] https://lore.kernel.org/linux-mm/20210517045401.2506032-1-nao.horiguchi@gmail.com/T/#u
---
Summary:

Naoya Horiguchi (2):
      mm,hwpoison: fix race with hugetlb page allocation
      mm,hwpoison: make get_hwpoison_page call get_any_page()

 include/linux/hugetlb.h |   6 +++
 mm/hugetlb.c            |  17 +++++++
 mm/memory-failure.c     | 118 +++++++++++++++++++++++++++---------------------
 3 files changed, 90 insertions(+), 51 deletions(-)
