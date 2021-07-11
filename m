Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F783C3B23
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 10:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhGKIHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 04:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhGKIHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 04:07:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EA6C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 01:05:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c28so34118280lfp.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 01:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iIVbAzHyLw3y+zgC5Ouu6XInoF13uau9z3nNzj7BY8M=;
        b=Pddb3LvRqu/aGewKupBHpePNuLgcq3iM/6jKs1uq7TK3PbFPPZXj94jUSnL3XjLPek
         20Io+F51K2qXMkPu0XNuhaAt9AcgW+ehD/DPAqUNRi5WwXXKaJjOoZ1+9tIFW/bYfLQc
         suecyMPSGFRFrvUP1QSMP3fCIqUwBCSUpcjIkPO4o0cu+17vKvZuKwqbls/1JaRoHyxr
         99hXV4jHxhVSfyybT4gM7uV8s7Qg1GRVKbD6hH5wWwyhRGLR+QnzM7QHrYAIk63S5Iyh
         JOEzXa3r4sqHrnSLg1dRF1FJEzW5DSSrKV4tmTw5cbSyt3MPAYGyaL7Wm+j9yUZyz6YU
         e6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iIVbAzHyLw3y+zgC5Ouu6XInoF13uau9z3nNzj7BY8M=;
        b=T5UV4dvcPClZceUr+Lexu15JxvA8VH+EHEZQoE1DjuKDji+BaJso7VsByDp93JsdLb
         1SwULY2t85JeWQY1gwXgW0Ku2yzhLQyMtMxOEEu912wjtvmHV48yXp0ax+EQoBI1ykoq
         W1tA5UuZ4B9C3bklFfZ8ZcEu1qwtfdmSoqcyV2Zb672+v0IzpDaO2eK+wVE6WPE8ieEE
         NuGZPbLC/IIN5H3U5GDU2gaxwHC5c7gSdbcFOJKV5O1nVE3i2PR08++/yP5JtjfGMRhx
         XgEaf/gquoEdnLm7GKHtFBeJIdvQ9HnhwP056FjAGoTMBP4pi9xjKZM+6l9WtIiLM0So
         glzg==
X-Gm-Message-State: AOAM533UKWYeLzKKHX/nJKxKJfKfKIcB6sXklAbGE+3ARao14QSQp+CZ
        xCp2/uykhgENm699EW9hVQdKdo1Q/qW02ahFMFswaLjxtjZh1aA/V98=
X-Google-Smtp-Source: ABdhPJw3uye/CcpHc443i8PkG8dRiWRb+B9g/ZMT1hsBbvD2QinCwv1BYHuq0QOZLLYP3/nXU7OvCmeNtKLVh6Kaky4=
X-Received: by 2002:ac2:5dd5:: with SMTP id x21mr2702535lfq.31.1625990700384;
 Sun, 11 Jul 2021 01:05:00 -0700 (PDT)
MIME-Version: 1.0
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 11 Jul 2021 13:34:49 +0530
Message-ID: <CABJPP5Acum9xDpF9OpwKRoB9SaQy+VVz4WGrksH9kTctwifAWw@mail.gmail.com>
Subject: False positives for non octal permissions in the kernel
To:     Joe Perches <joe@perches.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
A recent checkpatch run on the kernel detected a total of 26
ERROR:NON_OCTAL_PERMISSIONS violations.

20 of them seem to be false positives which are all from
drivers/staging/iio.

Example:
ERROR: Use 4 digit octal (0777) not decimal permissions
#331: FILE: drivers/staging/iio/frequency/ad9834.c:331:
+static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL, ad9834_write, AD9834_PSEL);

ERROR: Use 4 digit octal (0777) not decimal permissions
#334: FILE: drivers/staging/iio/frequency/ad9834.c:334:
+static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
+       ad9834_write, AD9834_PIN_SW);

ERROR: Use 4 digit octal (0777) not decimal permissions
#336: FILE: drivers/staging/iio/frequency/ad9834.c:336:
+static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL, ad9834_write, AD9834_RESET);

and more such..

Thanks,
Dwaipayan.
