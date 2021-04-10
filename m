Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F06F35A9F2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhDJBer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhDJBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:34:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD14C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:34:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q10so5171317pgj.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Wsw3laNKp4K1pOr1JmqRCZTS7mmbPQQcq1XguLZwJWk=;
        b=mPl5ou5UDi5gzboKS8ESlunB9Caylq8iYe9f7S8SqpJIPLD6c/nmaPw8xccBUo4m6N
         cC1+DwpUg+98fmJlDR0TwsDVU4AVJBw7KFPd5Aj5SJvplHRM5uQ8UmuZ/JJoQcDJGby1
         UCwdZE6snEEXhQc590gMigbKKc8hi6vvH/RqgEpYUa5QzggXv/ENL2PB9IAhF3+SB5/i
         0N49haiU3Dyrh5juc4xdgfM5HZL8U7gZUUsDuzjKEb+/R9mcT3HyL0COxDPEQAQ3KH4m
         bXwZvCN/g7cgRaaqigirMy4DZPQMPCadrDeQ3S9b0WM6+avpMJQsbtwRxq38OhAhRvXM
         AN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Wsw3laNKp4K1pOr1JmqRCZTS7mmbPQQcq1XguLZwJWk=;
        b=hGWyvn29z7OvV0b0WEJihLYaaAMKKjgIaaYhwHOWWWZgCXxqScfo1mxj6QNaeZddRe
         gkgZMGWQs5Y+sGRJqCxd2LfcrgQhKMvBCgekxFqWbuRP8Ecz+j+ATzgAoJVC7Hu18wDT
         UCAkbRaOw3y7ZFEo2vdBmY53SXrcCTnEa/MDgNsOF044bbnsE8DsPeDZ1ID0hklMnp6D
         r6l0vrSfq9c5F0KLXzoBT3n1zTUEOAH1VCatPyP11WHNT3SDMVNXsZhLCzV7VdeZMyYK
         g5BmR2VIKYilcYKxxz3kOriZpznZO4hwUyTQarHsZBT6wIJt+3RD/xJHPRLnvm3WEzDl
         6jNw==
X-Gm-Message-State: AOAM532bql0PSbndklJ2heqT86yn+fZiq1Z2s6RnHZ1l7SyJUc2UVzZU
        GcHmEj3MGWOUNxKOQ5Itx9Y=
X-Google-Smtp-Source: ABdhPJya27UWLDN4A0QZSK1DUEyyim8s0lL+liJM2Tz9w8TmAxTDVFCrPi/Ds2PSdNrOZXQiEJLJqw==
X-Received: by 2002:aa7:98c9:0:b029:242:18fc:562d with SMTP id e9-20020aa798c90000b029024218fc562dmr14420057pfm.39.1618018470710;
        Fri, 09 Apr 2021 18:34:30 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id u14sm3179714pji.15.2021.04.09.18.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:34:30 -0700 (PDT)
Date:   Sat, 10 Apr 2021 07:04:23 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH 0/6] staging: rtl8192e: cleanup patchset for style issues
Message-ID: <YHEAnyO11wgp5PNZ@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches fix the cleanup style issues.

Mitali Borkar (6):
  staging: rtl8192e: add spaces around binary operators
  staging: rtl8192e: remove unnecessary blank line before brace
  staging: rtl8192e: remove unncessary blank line after brace
  staging: rtl8192e: matched alignment with open parenthesis
  staging: rtl8192e: removed multiple blank lines
  staging: rtl8192e: align statements properly

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 43 +++++++++--------------
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 28 +++++++--------
 2 files changed, 29 insertions(+), 42 deletions(-)

-- 
2.30.2

