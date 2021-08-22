Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148723F3E51
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 09:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhHVHmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 03:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhHVHmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 03:42:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8EBC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:41:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b7so20963365edu.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=asCsHBtUbI5ITQ2xcMkZ8DHrsYdlb3KLHjr5prFwuQs=;
        b=b8lKB1PFbvuV97/LRgUp0QUqLno35Zzu6Xg/4/pSl3ypPMVxbOwHNBRNfKW5TGLiIY
         t6KwJbe/zwgRfceo0zUAzx9l52XVQF0mFrGZMHSBlRI3OgY7fadn5BYINgmHIuUBxq+n
         Bhbsj6LnILijv2RVX4f5tSp2g8mUYTZMskK0yqq0F5rJTzFNbodRquxTUdZOsd1hv6V8
         VJIRFxn3kB8sVnnN/yMHqjeVi762dMjkZuLCYuIjvZGOvjgq2o91fZ5OWbhi5M7DRTRh
         laVYJ2Nt9MdBfAwCiaMSQmCvMrS3+SkTnhDCoFLvYvXQ8ifvRha+KU25BmdFmtQPOBmy
         y4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=asCsHBtUbI5ITQ2xcMkZ8DHrsYdlb3KLHjr5prFwuQs=;
        b=KwkNJy/mXCtQA/xBEVsTPr+srTkjaAUvn4eHKu+IQ1cVQ2SrKmkUGN/cPzzF+x08Z4
         xwXl6i8tsT8ggu0OFUwRDGqZ74A63JdCZWfmJ1sIIKGKwtt3DJJpPYIaCxXKrdwXZ3Qu
         IKYJe9nNXP8UtETf/kWOLPEVTB3k8D8j6ytX+26tGLrg7BmqjTmhkYQrNrMr4OYak5gN
         nXsZNG7E+FLw+0vmOJDlpwoHJPwb7O6MYtRHqaSDkgh/T3ezALPT+7RPqqhuw3rY+Wil
         CL2sOlP8ZhKvb18uANSKBlnTzpLy7PE6mgu2ZtkVrtoFat5PQiXWqSiKxzhHjXEebExk
         e9iQ==
X-Gm-Message-State: AOAM530OGhgWHbrhPS4tINAWAy5quvGgj+ak6ncKxkw27DY0tTpilPMz
        OvbzsktoKpu0hvjSP+B0+x9zb7dvY7g=
X-Google-Smtp-Source: ABdhPJwwZ9pCKbIjUPo/obWVRUQPRrUl6BiSxE9dfgTSpEhCjmHly8uy45hhvGl+hQWHHcL+9SbbXA==
X-Received: by 2002:aa7:c745:: with SMTP id c5mr5491617eds.297.1629618082942;
        Sun, 22 Aug 2021 00:41:22 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id u2sm5364012ejc.61.2021.08.22.00.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:41:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: TODO list for staging/r8188eu
Date:   Sun, 22 Aug 2021 09:41:20 +0200
Message-ID: <1897566.d8lQ4HMSh1@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Larry, Philip,

From what I understand how the development process works, drivers in staging 
should have a to-do list in the TODO file. Please read https://www.kernel.org/
doc/html/latest/process/2.Process.html?highlight=todo#staging-trees.

Could you (as the maintainers of the r8188eu driver) please compile and 
provide the above mentioned list?

Thanks,

Fabio



