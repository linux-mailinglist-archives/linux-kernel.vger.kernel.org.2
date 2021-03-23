Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B8C345596
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCWCkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCWCj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:39:56 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9804BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:39:56 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z10so12946617qkz.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RJHRUPAwhh/xnYBdvNJd3MhgX+gUVfP9zmCXt+qJW5k=;
        b=IU6USNd5jJZdYelYLbs5VurvSkMKF1sf6JSnzgQcnXINpDiKuZyE5BvjbyXWWQVUNX
         nc3HCFd5Vt46qFua8K63jseDVJpr/PgGHBPmugiN/8E2J4R/I7qFsu2qQMH3zhfEJS1l
         SeNsk6cuiE4/aHf1oTEaNhBx/PXp0EQp6YabAr9eivQGoko/odHV/OuOYKB9GsbSvlYt
         X5uWyHW9fCaa5vVxT16dvb6lsEQhWdSh2v6X0RmozDUTJxEkSm1ivfVU3mw1I/5izgGl
         tnBh81zjHRt5SbpVBhL2x9/EJUEm31IISGUyKUOxv9bX1k6Vb4iqMNzRQfgK8Mm5pghF
         KQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RJHRUPAwhh/xnYBdvNJd3MhgX+gUVfP9zmCXt+qJW5k=;
        b=t65h9866iWJ3KpNSFUf5kVg3XUgy8gOZcGJUKfYWdWydCEJjlE1H8chwKv9BW1Mxak
         fz/caH031cW0zExJvMDccUrMhUPGJ3Wgkvc4E98YiS/752rb3fdwW97wdqODWPTPpA0Z
         JNkfPX1IxwYNSgc/9UcigFYnD9XSNFv2DwbIuGlc6I4jt1CPy+Q9Z02+th4j9+t5ZRWD
         bQj4wSyGoet9giuxFOXTUWx5viTUs1tuGEm90GNhnZ1HFDkPQxBVFuRsTGqc9B0o6uAh
         0Ix2H3F1tLBEY89RpRBuTuEqRmQs5abcjUVauVtJ3eVJ74yxQjSD9rTkXcEvaj1V5uNx
         DvyA==
X-Gm-Message-State: AOAM533QHY3bIMXaguqcjPZY/8K1rI2JfRcjIh1TwSR4z3LQucMORf6Z
        pCQSL5nA+25CiMppNHaXxeKnsG2cO86Gtg==
X-Google-Smtp-Source: ABdhPJwcZfEJHB5mLUUYynOu8+q+XiQ175HfWlQiP/uuzXtGNbXAA9aoVYIaMvlFsDxO/q4BDCBZKQ==
X-Received: by 2002:a37:a70c:: with SMTP id q12mr3361943qke.141.1616467195808;
        Mon, 22 Mar 2021 19:39:55 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:5155:3abd:5705:9236])
        by smtp.gmail.com with ESMTPSA id r125sm12353934qkf.132.2021.03.22.19.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 19:39:55 -0700 (PDT)
Date:   Mon, 22 Mar 2021 23:40:37 -0300
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     rikard.falkeborn@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] w1: ds2438: adding support for calibration of current
 measurements
Message-ID: <20210323024037.qe6ooze4ncusnh7u@LuizSampaio-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches aim to make a user able to calibrate the current measurement of the ds2438. This chip uses a offset register in page1, which is added to the current register to give the user the current measurement. If this value is wrong, the user will get an offset current value, even if the current is zero, for instance. This patch gives support to read the page1 registers (including the offset register) and to write to the offset register. The ds2438 datasheet shows a calibration routine, and with this patch, the user can to this quickly by write the correct value to the offset register.
This patch was tested on real hardware using a power supply and an electronic load.
Please help to review this series of patches.

Best regards!
Sampaio

Luiz Sampaio (3):
  w1: ds2438: fixed a coding style issues
  w1: ds2438: fixed bug in get_page function
  w1: ds2438: adding support for accessing page1 registers

 drivers/w1/slaves/w1_ds2438.c | 120 +++++++++++++++++++++++++++++-----
 1 file changed, 104 insertions(+), 16 deletions(-)

-- 
2.30.1

