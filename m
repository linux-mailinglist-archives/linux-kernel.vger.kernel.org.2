Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965E53B824C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhF3Moc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhF3Mob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:44:31 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD9AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:42:02 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u25so3061101ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j2HDnCM5DYugUKh5NCiC3rgN76ij9TqOT5vqAWEIccA=;
        b=MC+FBlY/C8sZZj54lHz8K9fVVhLkvQTU2ysaG5WpxKRFNcktaefcsswogCbSqIC1MR
         +pvDx05pb5orgrJFUEVep458eOr15YU5Yvt5yhUO271J9nsprX9pAUzpEGwsRPzE3/gC
         U3w6oSuLOES+nHxpOiUfrgKa0gI492xPCx8k4Wp1POGOUGXTvc0tTXzuxI5ftBvoQamz
         IR/vepSuyiFIB3e4rBEwvVMIbFQlwya02YOz3UFPjWcauGoWVu6jRYUfT+R2tqOt5qtx
         6C7n52C/6OYCpT7bbjOy+EU8cq3gooWELiXC8AlFjGOYOdsyC/gpjjkZ+5tvtsNtbXAj
         /28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j2HDnCM5DYugUKh5NCiC3rgN76ij9TqOT5vqAWEIccA=;
        b=UxepeEdRRCKekfIomtLExZENOUiLYStLqx4BMv4ztP8GwSgbs4E+4tAC92os2rIUXv
         GDnI26Xnpuv70z4XeRP/H9WSW+L+zdJXNJgB6dBCEetnR3k8gbultacvB/Ie1z4MHbEy
         j8YJHVO4kZwnvtutFCLC6ZTFtefzk9OlppduWqx9XaYXsjWOqYFhnWDcLcjaNpiK2GjL
         JXOADK59jpkGfCGPRkOUIWDEovfrU0NdQgrTA3v5c2LQBGTo3v9YzkDWT2PtEnLSaKFY
         NiZubj8O9LAfWDO5v6US6m9uEwaheW2asuy7Ot+IZeQLFHCpFUqPn0vuO9HfJbZ2QpdS
         OSGw==
X-Gm-Message-State: AOAM533vGCmnrU2o8YeziSF7So0KdtJfsHEXGwhoH/bSqWNwetIrzCpE
        7/Sq3M/nQuEO4v3UjByMOSBLEoPmahyoLFbg
X-Google-Smtp-Source: ABdhPJz+Izz7NDMkJKm58GJreqHSm7hsN6Hdvt+kKUXXnv/NYoN8QYQ5aF2j+LjknUZ9J4pe77ReNQ==
X-Received: by 2002:a05:651c:b0c:: with SMTP id b12mr7709068ljr.190.1625056920364;
        Wed, 30 Jun 2021 05:42:00 -0700 (PDT)
Received: from alyaptyap.localnet (broadband-77-37-213-85.ip.moscow.rt.ru. [77.37.213.85])
        by smtp.gmail.com with ESMTPSA id q21sm1927714lfp.233.2021.06.30.05.41.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:41:59 -0700 (PDT)
From:   Peter Shkenev <santurysim@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [Issue] linux-staging and linux-5.13 fail to build
Date:   Wed, 30 Jun 2021 15:41:58 +0300
Message-ID: <2344468.8uhTOPbOhj@alyaptyap>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

linux-5.13 and linux-staging (main and staging-testing branches) are failing to build.

Error message: http://ix.io/3ryn. My config: http://ix.io/3ryo. Compiler is GCC 11.1.0. I made no modifications to kernel sources.

Best regards,
Peter


