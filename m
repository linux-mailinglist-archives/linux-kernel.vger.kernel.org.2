Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6ADF32AE0F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360458AbhCBWUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383541AbhCBVOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:14:53 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B66FC061226
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 13:05:35 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a17so25836972ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 13:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LqbcVwvcpYXsJFarepRzRWHsccyux23U00s52Ev1SrU=;
        b=FAsua1V2QV7c/d9t7V7N7NgidNhLd2p+omEdzz0Fst5ZUsIRrkO35AxLtqqpNEq4Gm
         pSrf8FLs/Ufa6zrtAnW8XbItNibn1CLOEBh41FkHvvbIb+f7xqbD4DE8GchlDFNm23yI
         2y1gsJQqy2iNZ8Bm8E4CzVgIKl3UJ0yokFNyJyV57Xx9vsWwZnDA5SuZaD5MdUOssawl
         Gw9HNfzu+YksZIPYLJ5Jt0HOW8sD/1UB3DaHVZDva95IDTqQghGX6eXyJGX8CiDGsk2Q
         /DBMHUOs+KTk4WkeFucImEJHBoTOVCRdOWUkYSOpK0XNnxwnpQQ5l/CLuTFfT2tDx8kG
         2E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LqbcVwvcpYXsJFarepRzRWHsccyux23U00s52Ev1SrU=;
        b=gwDGDfx0Ty1/GSnUlT+5eoiei25K/BCwpvbXLLmK2P1+Uc3sHiRzCPa1LpZfx4dNFQ
         cI/jV20A01SWP9I6gzXPugABQrseQocbf+owfTjXvIBl49XxX8O+OX0bYPSpPjrUnRXh
         zDv994kv5tGlwV5Dai+4Of4mJ+x+33gaCoPjGrqkhaJKy5uGBD1B6Sm9yO1z4A8tnhaz
         p4hlwTN7Typ6uQAGxTjpOyDMnth73bkX5m2wjaOJ4qJvlCIbtCHiRIBcXaZdkHa7OHTh
         htFH++F/zZmGWAW2lDAYY9Zf3obILgDC5uIBCUi/6wkias/rriKRNQKqnJU+7lGag5o0
         dxlQ==
X-Gm-Message-State: AOAM533tZGrRbIpovXxRT4rDhs7LJI7J5R8iaZQTfdin1x0gTdX6bbtf
        jXG2ueKR5e5nlcotuuYLcKs=
X-Google-Smtp-Source: ABdhPJzZzVG5Dlm7cAK1xr7dRB40t7fOl8J246aD1JjcAeJ3BVEdYmfB/lNLz0GNmpVykN6VxAtnBA==
X-Received: by 2002:a2e:a306:: with SMTP id l6mr12870607lje.251.1614719134204;
        Tue, 02 Mar 2021 13:05:34 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id k6sm1619796ljb.110.2021.03.02.13.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 13:05:33 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [RESEND PATCH 0/3] drivers/mfd: Constify static attribute_group structs
Date:   Tue,  2 Mar 2021 22:05:25 +0100
Message-Id: <20210302210528.70945-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems the first submission somehow didn't make it to LKML, here's a
resend.

The only usage of the structs is to pass their address to
sysfs_create_group() and sysfs_remove_group(), both which takes pointers
to const attribute_group structs. Make them const to allow the compiler
to put them in read-only memory.

Done with the help of coccinelle.

With these patches applied, all static attribute_group structs in
drivers/mfd are const.

Rikard Falkeborn (3):
  mfd: gateworks-gsc: Constify static struct attribute_group
  mfd: lm3533: Constify static struct attribute_group
  mfd: pcf50633: Constify static struct attribute_group

 drivers/mfd/gateworks-gsc.c | 2 +-
 drivers/mfd/lm3533-core.c   | 2 +-
 drivers/mfd/pcf50633-core.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.30.1

