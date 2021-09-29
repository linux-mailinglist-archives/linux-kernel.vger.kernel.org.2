Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF8241CC80
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346534AbhI2TTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245131AbhI2TTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:19:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCB3C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:17:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g41so15044892lfv.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=mTYrYfRcpOqB6R4Sxta/MBfuL5XFQNtVPBAzoCOcfGbEzqlYUyTJnnvTPMTaSJeVB4
         LYV96W9WGj4qWDtPa2f1aT6aAZalkhD1waluxD9MN0QUMrghOcrAQVCFbFD0fhDtTIcR
         6tsQCdowUzRk1NtDegmzPc00jEh9zaMBEPiCddplQo7bjYJXVAFETto4g3eD42VIRFyJ
         g7fRhRhZ38+YJqc7p0R7Z3Zs7wM4mA0VFxeboJgA8Nx3hzfGEOMki8jV69Px63esbgo6
         64scNDtvBiSoy4ku4g/HIScAo4VhO3FNOv8iccxWQR5PN63Q3wBfWbCN4nQXb2iRdKUQ
         6qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=gCA42L5byW6xBltsYG8Fx8oN7qSEJ3gi8yLSLFYbCwS4IQZa7f3jiU0qP0qB51DVq2
         VbmHAWpj53Gxf+G31vMcH5pRa1AvE7EhvD/Uv7l2FAD7+wti9/3sRIw6gvb+bHDmnDaN
         RWClWU4fTP/NxO4iiISL6c0Nh3bxq7ruV7w9kDNeMqb6nBFvS4ByFj4TEet3crW6cqF5
         wC0a1Q4KUScqctnkQMRUJ+crt6ZFCaA9fmMJBxJ6oOaya44aEZcSPe12iPTNbo+Ftakx
         2+BiR5yEDzxyMJxe4plOApaEkQI2XAftAyJOhuPi7AcfKUfE4VA+5o8vb1/49QMCZ+DH
         Mdlw==
X-Gm-Message-State: AOAM533wNjJRz0CqPKBVlE2vyDNNzHmNbDsL2+j/R1jSKSnl+6A+zt15
        p2hQLUt9jsmpMcWpJcmX8H2/66k6iS6mi5nJ3/k=
X-Google-Smtp-Source: ABdhPJzThssUxWj+qBh+4p9uZnVxCzmmbz0MUIe4TCF3jp51Cjqw5SDzfPAZKD77acJMwgT93RDkAMhEy3xVJv8QGf4=
X-Received: by 2002:a05:6512:3ee:: with SMTP id n14mr1336855lfq.589.1632943036799;
 Wed, 29 Sep 2021 12:17:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:651c:4d0:0:0:0:0 with HTTP; Wed, 29 Sep 2021 12:17:16
 -0700 (PDT)
Reply-To: georgebrownlevi@outlook.com
From:   Mr Brown Levi <amesata8@gmail.com>
Date:   Wed, 29 Sep 2021 19:17:16 +0000
Message-ID: <CAJR0EqOwtGCHgVnYqQYnwtEYaxCyPxR=ZND6xPnpjBKk0QSbSA@mail.gmail.com>
Subject: Do you received my previous email?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


