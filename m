Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AACD38238F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 06:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhEQEz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 00:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhEQEzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 00:55:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913AEC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 21:54:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t21so2453591plo.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 21:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HFS9vi1/rIdUkJiPvcjFMYok731ANFwoJROhku0cv+k=;
        b=J48ehh1zUunK+sqGHML91d0z8Z6c2ns7P2fLOZlR0TvO1n+k2+NhUNEYIxYo7ThWgb
         DNQXV21+IJ7x5O4HiQra2sp4ReuMBM/trRh3yp+UHGdPCkOPZdHoQLtTDSjdr2/5YW/r
         PlgWxedTBoSptJaxpR5FcK1GPeojf2yD+Y3ma3mwu+kG+jjbGviykmkYLDN767vGACSt
         Q4A1n6WPc4o04+tJ6mre9mMZOPV+dteBg31GY0qitIHq4VmICUugTLli0UFfmOVEf9U0
         vcZevTyz/+OsSnDykJIoTyZgFi86sX1cH26B646OZN9sRfBS4asdb81OicHGRz7pTaFC
         IQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HFS9vi1/rIdUkJiPvcjFMYok731ANFwoJROhku0cv+k=;
        b=ettncRTyJLqfRbfHSjdzcq8hcFiFURP+2BWoJL8PdE5ZlBM3DNnx42hBKJcSxgPjy6
         4V+ZrCfpdu1vdolKVwOi41dkC6zWOcfwOI0ZH5j2fqnpYvJ/7eeER9As8RsVZn+ivsCB
         9yZJp4tnLClz1vSRGYnAfo5Wn3OiSMy75+e7j+a/zRfOvhE3+spXWrroWjWLY/PbY62L
         wHQCOo+UwxcXdbZssfE9ipjXuOaXbsxFGQz0bKVVwXZ8SObzbaeL0Wufa1aqCrIhsrpz
         /NGgEMv/FUy1Di4SSr/ybknu99DQlkLKkcji3HZQBcOkoGiBh9I+QBm8WV2nN4IIjwXY
         iA4Q==
X-Gm-Message-State: AOAM533GILE3UwC7NUfUJSXhxT2Tpq+ByK7Ntgm5FgOeSoPNfDcxZ8S0
        CzQLfRj20uUQxwQI6Qe8qA==
X-Google-Smtp-Source: ABdhPJy5VEH9HAvQVJKfWv5s3dsy19b3fG0F2+2OCHu5Iwv9SSzsofe5yUHKzXWynl60URlvncVVsQ==
X-Received: by 2002:a17:90b:23ca:: with SMTP id md10mr4796177pjb.122.1621227248023;
        Sun, 16 May 2021 21:54:08 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id j29sm9439038pgl.30.2021.05.16.21.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 21:54:07 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] hwpoison: fix race with compound page allocation
Date:   Mon, 17 May 2021 13:53:59 +0900
Message-Id: <20210517045401.2506032-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I updated the patchset based on previous discussion [1],
I fixed wrong patch separation, remaining race issue, and build failure.

If you still find some issue in this series, please let me know.

Thanks,
Naoya Horiguchi

[1] https://lore.kernel.org/linux-mm/20210511151016.2310627-1-nao.horiguchi@gmail.com/T/#u
---
Summary:

Naoya Horiguchi (2):
      mm,hwpoison: fix race with compound page allocation
      mm,hwpoison: make get_hwpoison_page call get_any_page()

 mm/memory-failure.c | 122 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 50 deletions(-)
