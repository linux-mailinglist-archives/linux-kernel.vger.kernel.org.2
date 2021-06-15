Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80D83A88C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhFOSr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:47:58 -0400
Received: from mx.ucr.edu ([169.235.156.38]:46809 "EHLO mx-lax3-3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhFOSr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1623782753; x=1655318753;
  h=mime-version:from:date:message-id:subject:to;
  bh=VwHEffF6WEd8HZtGBpsh6YDP+gKybrkud0rCfHHpekU=;
  b=cXrOVS6+0HDqq4AALlNuZjTBjvkYAC1/4FLYp6lwZVuupzdfZA88Bl78
   FLza+yNOkU692YpI9uMOlNvlJYOhiI9oUAa8jWIbzoUhOv6E9gdiYBh96
   a0J8BwQfHhk/VPMCNDUcDilotiI8pXFhqGFjtYVYKJlJqdK1rzg46WYet
   KlQ2MN7A7sfuEM0mT2gozqy41K5H7hWEEQRUWrg2viqHiXwmZAQcTQe50
   wYFK0XFkZaeW6aOfAxSTUQ7WuMTR+jAWQ+OihYHqSFqFcoVokxWQ3WH+V
   ScKwiWcGeB1+6WSr9a/G6lDD76PfZCAyDAdwljOlZy0hpQfccFH3SpSnT
   g==;
IronPort-SDR: jgxBQ1emycBFOis6CObs9cR/fIBVNaUlykQ/p3BzIa/OpmZjwbK0na7hLxJAiVOv2HUOqjvmx9
 ybW7r+xlLB9cJvscIpcx6IcoPOC0l++YA1qhJTr8aq8UHDFcu8sSFcAmlK6Ibp8a5ji3m/530W
 zbsDPAt6AiNod+WmhuyidHYLJnVl0unx3sLLOkrZhVmgTwWRcYk/Qir5l0LzyJb56xIyijf5Lb
 CTkKQGO2ZTy30KlOm9oMRbJbJq1oRw77kJmOnCfQjFw6tIdKAcj1c+vFyqGYmxnOFPZcqjBaDJ
 v60=
X-IPAS-Result: =?us-ascii?q?A2E5AgAG9chghsfXVdFagQmBV4N4bIRIlSgBmCWBfAIJA?=
 =?us-ascii?q?QEBD0EEAQGHOwIlNAkOAgQBAQEBAwIDAQEBAQUBAQYBAQEBAQEFBAEBAhABA?=
 =?us-ascii?q?QEBbIUvRoI4KQGEBREEeA8CJgIkEgEFASIBEiKCT4MInGWBBD2LMn8zgQGIJ?=
 =?us-ascii?q?wEJDYFiEn4qhwmCZ4QhgimBS4I3dIQLg1CCZASDGXsTg3YBAQGeM5xgAQYCg?=
 =?us-ascii?q?wMbnXgrlGqQewGVVKRNECOBMYIVMxolfwZngUtQGQ6OOI5VJC84AgYKAQEDC?=
 =?us-ascii?q?YcVgkcBAQ?=
IronPort-PHdr: A9a23:K/H8ABNnLsgl8PkoB4Ml6nZWChdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDvKQr1wWWFtqAo9t/yMPu+5j6XmIB5ZvT+FsjS7drEyE/tMMNggY7C9SEA0CoZNTjbig9A
 dgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1oLejpB4Lelcu62/229pHJbQhEmjiwbbxwI
 Ri4sA7cqtQYjYx+J6gr1xDHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S
 6dYDCk9PGAu+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC+85
 Kl3VhDnlCYHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6jAf90VWHBBU95eWCJBDI2yb
 JYBAfQdMutDs4nxu0EDoQeiCQWwBu7izCJDiH/s3a091uQsCQPJ3A0hHtIOrXTUq8j+O6QSU
 e+vzanD0DLObvNX2Df98ofIcwwtre2CUL9rbMre1VMvGxnbgVqNtIzoJjWY3fkCvGaH9eRvT
 /6vi3I5pAFrpDii3sYhh43Ui48LxF7K+zh0zZs1K9GmVUJ3f9qpHIZRui+VNYZ7Td0uTmB2t
 Cs+1rELt4K3cSoExpg6yRPSd/iKfoaO7xn+V+iROS91iGx5dL+7nRq/8kitxvfiWsWp0FtGt
 DdJn93Iu30Lyhfd8NKISuFn8UekwTuP0gfT5fxaLk0sjqrbLoIhwqY3lpoOrUTPBi/2l1vyj
 K+Rbkgk//Kn6+XjYrn/vp+cOJJ4hhjwMqgznsGyBf40MgcJX2ic9uS80KPs8VflT7VNi/06i
 qjZsJbEKsQHvqO1HRNZ34I55xu8DzqqysoUkWQHIV5fZR6Ki4zkN0nLIP/iDPe/h1qskC1sx
 /DDJrDgApTMLnjZn7fgYbpx90BRxREuzd9D/ZJYEK8OL+/uWkPprtzXEgc5MxCow+bgENh90
 oIeWWSSAq6WKa/SskGH5vgpI+aSYI8Yoyj9K/c76P70l3M5mkESfbOv3ZQJbHC0BPNmI1+WY
 SmkvtBUNG4XpA12Z+XwllSGUTkbTHa/X6s2rmU+A4KrDY7JboOgmrqM2GG8BJIAIihPCVmWE
 DHhdoGZQN8IaSSPMolglCAJUf6qTIplnT60uQCy6KBgJ+qR2iQCqZfq0pAh6PfemhIy3Th1C
 dmN3WaQSW19gmIPQXkxxq8p5QR/116Fze5xh/BVHPRc4vpIVkExMpuYh+h7Dc3iHwfMctaAY
 EipT8/gAjwrSN81hdgUbAI1H9SkkwCGxDajDL4TmJSPBYco6eTY3n7sN4BxxmiCnK0giUQ2B
 8hCL2urgoZh+AXJQY3EiUOUk+Ctb6tP8jTK8TKyzHiOoUYQYg55UO2RTGIfb0qO9Y/R+0jYC
 bKiFOJ0YUN61ceeJ/4SOZXShlJcSaKmYYyGC18=
IronPort-HdrOrdr: A9a23:A9lLZqiZYKjHZM2wKTad3NyTY3BQXtMji2hC6mlwRA09TyX4rb
 HIoB11726WtN98YhEdcLO7WZVoI0msl6KdiLN5VdyftWLdyQ6Vxe9ZnO/fKv7bdhEWNNQ26U
 6tScdD4RTLYTZHsfo=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="51733529"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2021 11:45:50 -0700
Received: by mail-pg1-f199.google.com with SMTP id x7-20020a63db470000b029022199758419so9367494pgi.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LSLEA8uny0SvK6BuP9EUGLzKH3cmbfNsLY8/jivrk4k=;
        b=IXhz4Vgn5YinUovcioNrSBmaJ/2PPohXG/cRRlKqLJ7XwcpjOuCbx5EyTPbKXF+Fry
         rRClr6ayQmUfPFZi8VgWa2oFdYACZqGUm2KDktJNBJ8k83GAPTNKH1SStCbYpG3bolzG
         VNZJzFkpkH7rI7M0Lw09r8LYa2Rq6E16m5nvHyg3f6o8+XQJ/QTO/hgQEXMwxhuAsFwe
         fvu+atLjGrAgfiw9U+sObUuRXE/7nNz9ogpDNU+QJ1d7JIp7mEu+QYXMBzjp81N/w/ix
         neeCHZRac7d/IN+UeSJr1Absz4eBFSPPdnWjgb7YGVGQgAeomDHdPLWL1wQ8Vv5EVKGP
         N1rw==
X-Gm-Message-State: AOAM530cP2bzjeTqJ+lE9FibrjPsWFG7G1YBcWP/CAMvGyZAZbCScmPi
        /dCQdJx2jmN2+MP6y9Zt1QqrTSxBTkHOUDpLRvB8RtRHibqQxTCX6JdxTJRHl4O9R/Nq4eMNW5f
        rborTfDvyNYziw7tNtY9fpKPTJ7+Xe9SnUI6Dq9QpCw==
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id p30-20020a056a000a1eb02902e289d85c87mr5849455pfh.73.1623782748929;
        Tue, 15 Jun 2021 11:45:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRMpzEEiW7csamoO9aph8EpArFwG28jZL6hWiXyGFAufQLqrWEPEkYySQa4vh+rPwD5JI28wk2KUtqd79gny0=
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id
 p30-20020a056a000a1eb02902e289d85c87mr5849431pfh.73.1623782748638; Tue, 15
 Jun 2021 11:45:48 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Tue, 15 Jun 2021 11:45:38 -0700
Message-ID: <CABvMjLRkmsrxXxHkX7PrkoRK5m=7_b3wpvyZK88V19b05CFx2w@mail.gmail.com>
Subject: [PATCH] media: atomisp: fix the uninitialized use
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        akari.ailus@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        juant.aldea@gmail.com, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function mt9m114_detect(), variable "retvalue" could
be uninitialized if mt9m114_read_reg() returns error, however, it
is used in the later if statement, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
index f5de81132177..8ddddb18ffbb 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
@@ -1534,12 +1534,15 @@ static int mt9m114_detect(struct
mt9m114_device *dev, struct i2c_client *client)
 {
        struct i2c_adapter *adapter = client->adapter;
        u32 retvalue;
+       int ret;

        if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
                dev_err(&client->dev, "%s: i2c error", __func__);
                return -ENODEV;
        }
-       mt9m114_read_reg(client, MISENSOR_16BIT, (u32)MT9M114_PID, &retvalue);
+       ret = mt9m114_read_reg(client, MISENSOR_16BIT,
(u32)MT9M114_PID, &retvalue);
+       if (ret)
+               return ret;
        dev->real_model_id = retvalue;

        if (retvalue != MT9M114_MOD_ID) {
-- 
2.17.1
