Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F3F4241BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbhJFPtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhJFPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:49:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468D7C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 08:47:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r7so10143161wrc.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyZGzeUkgMuIfCkYqfWElOZXd5GPAg5/iCAXdLNu3h4=;
        b=qsbyOtC6naFjiQp4Md5fkItqPQ4BtQDos3d1sNNKCgNiQfpxIDthOZNmxrJgeGzIK/
         eLrnIBXjxrUJtZvJ69/ZXw4NDJLnvcEFDEBD6gRV9JSGCFKHXleBQnlvxHRpTUzb/ddU
         Fx9dGpy64ltQG+tL8AQNQjN44hAK6+Nt25wDziviuGrYDdyH2jdv3UWIJqBuWzD7HxoF
         aWlH3uMSyfmC+WdOlITEWoCDPpCxJ8jgslVgQrudD76xEYhWYz7GPLX1+42dyVUAQ3Li
         unJnoLHmf1oQT+9zY0zv8L5tgFeZqf471tCk/GXgquwblj7IgWvH2jfhjGhi+HB/cNH7
         G4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyZGzeUkgMuIfCkYqfWElOZXd5GPAg5/iCAXdLNu3h4=;
        b=LeDQ8vIowqNZOPUrMfaQhb1w+fnkBBdBGpbxYEsU8GVXYngOiuQDv5+F/bBBKdvCyd
         /Oe4ef3pEiyqnCrIkjCvj4tbF6S3p6uMnXoQVsJOcFOYRZEJe7WLsj706RzRnnUfO7W3
         vSdErrnGFA7d+XSQLasE9Anu+OEWJfnWwHKDQ59PZVg7n2JjOPs+Dux/aCLSrphMj96W
         SpglIqsya+OBtLJuCIbjWeh31qiFQB9M+uRNo/L0afPkGA2qnQi9LVaGu7Sy9l6iq+AF
         pzrFlX3k5T9PFxOVFf7ciZMGjX/GU/hqzuM8svTn2Z/+5CA+fW0q+FM3Do+sigf4fKl1
         3mOQ==
X-Gm-Message-State: AOAM533JuE8ZSs+h+XsJJhTueBbPOcIodnNZhVZ5XyT0QUmYJsN7EUfC
        y9pg3JeGLEvfUgFRfqDVjUMgxRvpi8eyvw==
X-Google-Smtp-Source: ABdhPJwYCe+Zj1ADbpS0vlqmQDu/f4kg7XmL0xmqY0OETQL/ctNz9HE1VbeFAFqAxStrhLOiuhLL2g==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr29997879wri.323.1633535242885;
        Wed, 06 Oct 2021 08:47:22 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id o3sm21221048wra.52.2021.10.06.08.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 08:47:22 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in sysfs-devices-platform-ACPI-TAD
Date:   Wed,  6 Oct 2021 17:47:19 +0200
Message-Id: <20211006154720.135010-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated word: "the the status"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD b/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
index f7b360a61b21..bc44bc903bc8 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
+++ b/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
@@ -74,7 +74,7 @@ Description:

 		Reads also cause the AC alarm timer status to be reset.

-		Another way to reset the the status of the AC alarm timer is to
+		Another way to reset the status of the AC alarm timer is to
 		write (the number) 0 to this file.

 		If the status return value indicates that the timer has expired,
--
2.25.1

