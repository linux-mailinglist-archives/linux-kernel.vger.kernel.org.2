Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA7338BDBE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 07:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbhEUFKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 01:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbhEUFKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 01:10:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10BDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 22:09:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id z4so8139818plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 22:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sIJ+ck9inauVoMXTHlkoSKGLlKdMtcnMhxWkHbhJf5k=;
        b=T4y/y9pdazVNkasOKow36SKrzJur/5Kbx0MU55uxDrU8It+jbuiOn7qq1BAgRPZxbS
         B9042o5JKlqKTHj93EqMNDEQpbY5IZHTMwCtMVMALEIF52nfygBs4y5qhjoumyp1G7K+
         H/pw+s1yyplHwk4EyMII440SddaguwhsKqqKd2T9luSYw66mtciQvaLPlGdUBX4UjC4y
         O/Yvl5cvgTikJ7C+8gCeRj0K19hcbelvvGJ8RCJ1KxDfrHlAJI0prkxlN4c53a1ZBb7v
         odDU5fpR103xMQOm2Ldh6VJ6XUJGs6E00N/A8uYaQSy1cNsj4TCRvpMYkv3dq/YOOvYI
         iaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sIJ+ck9inauVoMXTHlkoSKGLlKdMtcnMhxWkHbhJf5k=;
        b=AAI6KSHBHE/imIKMaXHXxVKp5SmFXyjTHMFnJbvlX8S3pBgKfF6f5zeFcPtIVGNB98
         Zt4PvKFaoCOI65zL/VdiyGuRrDbEjdJbw541QRU03hzyQ2n6Zbb3jD5CzX7pP/KYYMSr
         5WrsZEu7xy4cjjBvo5wjdXtd9qqtb2dS+Q6ugq9FEn/36CjvQGfynAkncEp7uq2HstLK
         yQX46JBvuHQ3390FVAavaJxkyLF54DqN2AmEo37W3LJPmDul2Lyrc6sbqXZKB7EZj6po
         XuWiXGpHspvKrNqTczjR/wUqV+Oh50tB5rz1Ifgby8vVZp3c1SdQa5FvPWHHgfWAac0o
         7clg==
X-Gm-Message-State: AOAM533FRfqdNkNRkunXjUS5b2MVKD09GdLBga09uFTIaqDmSxCaQo2n
        sJSlv7gdwDxDdn77ZVZSEEAXitRdnZShWQolLzgfjnd6pv/TSg==
X-Google-Smtp-Source: ABdhPJz6upwGfuPR0FFGQ1Qa4CKLlL6/YoNCTF4IXpZl1taWZKGwEhnY7YHQU7jRW+i+0tRUQa0JiLpYN1H3WM9DTC0=
X-Received: by 2002:a17:902:7407:b029:ef:a78c:a385 with SMTP id
 g7-20020a1709027407b02900efa78ca385mr10042788pll.16.1621573763208; Thu, 20
 May 2021 22:09:23 -0700 (PDT)
MIME-Version: 1.0
From:   Yiyuan guo <yguoaz@gmail.com>
Date:   Fri, 21 May 2021 13:09:13 +0800
Message-ID: <CAM7=BFoktwgy=T0GK6Mpmp2gYToCUs=CrM29MRWw8O7TPypQ8w@mail.gmail.com>
Subject: A divide by zero bug in lib/math/rational.c (with triggering input)
To:     linux-kernel@vger.kernel.org
Cc:     andy@kernel.org, tpiepho@gmail.com, akpm@linux-foundation.org,
        oskar@scara.com, Yiyuan guo <yguoaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the file lib/math/rational.c, the function
rational_best_approximation has the following
code:

void rational_best_approximation(
    unsigned long given_numerator, unsigned long given_denominator,
    unsigned long max_numerator, unsigned long max_denominator,
    unsigned long *best_numerator, unsigned long *best_denominator) {
   ...
   if ((n2 > max_numerator) || (d2 > max_denominator)) {
            unsigned long t = min((max_numerator - n0) / n1,
                          (max_denominator - d0) / d1);
   ...
}

d1 may be equal to zero when performing the division, leading to a
divide by zero problem.

One input  to trigger the divide by zero bug is:
rational_best_approximation(31415, 100, (1 << 8) - 1, (1 << 5) - 1, &n, &d)
