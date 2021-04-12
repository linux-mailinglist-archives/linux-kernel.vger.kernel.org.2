Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C3535CFE6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244089AbhDLR7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239949AbhDLR7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:59:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C40C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:59:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h10so16116593edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/wwcGG3rNXNsZQgkGk7QbLfEu6ULkdlrYbUXwHoD98=;
        b=kHnoF8nNrf8iq5HdVKMzM6b8YJRKVAxeWL8MlhUNzfwMdNjyfM7Y3PIDrGZCFh5n6V
         DZbSRNWF0jfw3Zoa9SsLWtYsTMI8m5/eP0usAF7P7Edv6LRPahDNLgTdVfZhPqg7DKOo
         adNPHS1OvMS5ShLem6OUVzK7BVf8soeRc6HXeekSJEbPTA0Mn82Huo92OyCaOuF9+kTM
         oHeqt0CUmj19qdQMvrqY8K8cA2kInXmE1nyZo8uPpcby9ebsLzgrGpxLuViHra7/MtSv
         dOgMVlomqvf14hrxLqYc9jJIQHx3MUcmQH7xU9X6xKdZILuAfNrD/4ya964yV+piI2YZ
         vZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/wwcGG3rNXNsZQgkGk7QbLfEu6ULkdlrYbUXwHoD98=;
        b=SVCL1mAybYuE2BTJWW//r+J4c1D8qy5wjHJmBbzNLUaPkneE1336tpyH1s+G+WYzX2
         uebYxbgAfMy1eHIY/j0Zvzx3gCiuM/HKP+S+dz0VtxjQ7PmPjmW+nR9K4AZqJ1cHSLNh
         zFAerN6ithJesTtJf7POk/XMSXPXP0Gf6fN+ibsYxmcCeM9ni0t5dRJTV4zKAXDRVs63
         i5ZG+SVc6RytC+BrazsRAbV+fgc+CB6tZrBGwEOihq+tmhxFF1a4nxrlZVMW/xhgNvGy
         qalDbjGnFT7uy81qcYaPKqX6aSvmFn2DQWJfiCrGRDv9WGjgzdx3djTDfycHIjgpF5GJ
         jBCQ==
X-Gm-Message-State: AOAM531BhXVt9PxG0z+Q/tfXlhQkYKrm8qyWFkFUjuxMjC1KOtsuiRXO
        2f48RMBA8uJJBkijWQlPekY=
X-Google-Smtp-Source: ABdhPJxCJ9iMV8FrvfO4lMKc6BT20x0Fb6U0Bynd/YCdqCBulg8m2X3/kbdnTX84qd1TJezlVRYspQ==
X-Received: by 2002:a05:6402:2054:: with SMTP id bc20mr17256693edb.334.1618250348558;
        Mon, 12 Apr 2021 10:59:08 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id gz20sm6300534ejc.25.2021.04.12.10.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:59:08 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH 0/2] Remove spaces and blank lines  
Date:   Mon, 12 Apr 2021 19:59:01 +0200
Message-Id: <20210412175903.17819-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed spaces before tabs and multiple blank lines from Hal8723BReg.h
for readability improvement. Issues detected by checkpatch.pl.

Fabio M. De Francesco (2):
  staging: rtl8723bs: hal Remove spaces before tabs
  staging: rtl8723bs: hal: Remove multiple blank lines

 drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 43 +++++++++------------
 1 file changed, 18 insertions(+), 25 deletions(-)

-- 
2.31.1

