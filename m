Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67ED40C472
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbhIOLjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbhIOLjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:39:36 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B876C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 04:38:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f2so549850ljn.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cWe6oTyjLmK6VEOjd0bBPZtu4VeJ5Git5yX260+o1+4=;
        b=QDnrgzrAc4ux0j2WKEPJ0XQcs2m1Fwt/rSrzXsTSPthEIgpkHy+4qCh48/tVWzd8lF
         F7zTnRS6IRrazHGVgz3aDdUSPFdt6B7ov2NbewXB+vx1j/IzEnGQ6w8JyWZEjHHfIy3L
         38oAyZU4A2gpBj0td+kfYvTD7n2ZiS/gnpwkp54WAxJexsGz4Ss+z6rYUMdi7DcKYg+F
         k8FaiQjgA/pnvN8Alc0Ww2YkEOiqBZfPIoiNVrDanCsnARa6WyMWsVYJctyZ26sJB5/j
         sY6H0B6Xd4iayb+cNeU3j/F5qOG+GgnfG0mHk/AIdgNJf9Ag13z7AkTpyXh/P8pIPLq1
         Xwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cWe6oTyjLmK6VEOjd0bBPZtu4VeJ5Git5yX260+o1+4=;
        b=Fy8Agf3EP9c967wBTKW8bjY2Fw57YxbpPTc+lNKc9hyLCGrxSiK94LT21rZ6nkD7vQ
         rLG6EXq8XKiTD6i7f8gS32lzfmfP/6TLaqM22ZEbiNf8PvCKXnuiuwmFGWkmI9zeIIBX
         IsMQ2GkUSFm8jKSkAFwckaturfUBCqQHcdL7kj8y0Mr8Q/q28wgBtE/Vs7LB5IOtqChm
         UxgB0EObDpSKXuuGQ4+LZbWwYoBZ1L4qo72GtRpxgrWRME8Y0yZW9A27kkx3SHOTRBu7
         2ZODhgjQPC7He+xZKZorThr3ALMxvdaa+7Dhjo7c1NqLTh9wEXlRHfnbsnOGqwQ/cuH0
         HdIw==
X-Gm-Message-State: AOAM532Pm+vXPZtmhMlUsD7+8jTfDtblP/5Pjyj26b8By8FzTDyp0zb5
        Vd8khEApizHnxs7isTGFozFXeQ==
X-Google-Smtp-Source: ABdhPJwQiFagzIrGruSXaAYXLJqNhFncwn8ij/I4x29RKri2YfRi333HsvvJoyEVSMUaxj5egiq7Qw==
X-Received: by 2002:a2e:a316:: with SMTP id l22mr20891066lje.104.1631705895821;
        Wed, 15 Sep 2021 04:38:15 -0700 (PDT)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id v15sm1370271lfd.34.2021.09.15.04.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 04:38:15 -0700 (PDT)
Date:   Wed, 15 Sep 2021 13:38:13 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CGEL <cgel.zte@gmail.com>
Subject: [GIT PULL] OP-TEE fix for v5.15
Message-ID: <20210915113813.GA509196@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small OP-TEE driver fix for the shared memory pool
handler. The fix doesn't change the generated code, but it's still relevant
since the problem obviously triggers warnings with some tools.

Thanks,
Jens

The following changes since commit 7d2a07b769330c34b4deabeed939325c77a7ec2f:

  Linux 5.14 (2021-08-29 15:04:50 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-for-v5.15

for you to fetch changes up to 88a3856c0a8c03188db7913f4d49379432fe1f93:

  tee/optee/shm_pool: fix application of sizeof to pointer (2021-09-14 07:54:56 +0200)

----------------------------------------------------------------
Fix OP-TEE shm_pool lint warning

----------------------------------------------------------------
jing yangyang (1):
      tee/optee/shm_pool: fix application of sizeof to pointer

 drivers/tee/optee/shm_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
