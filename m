Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF47438652
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 04:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhJXCPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 22:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhJXCPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 22:15:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB1CC061764
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 19:13:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so8629199pji.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 19:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X589BqCXKNPB70WA3h+uA/HSHzhkvFxOpxaltJvaxRY=;
        b=Tfz6w1A1rjrKQIkjtu8DsXYMMo0Oqf0kOZaUqRkWXYwuc9+1a1qMu6SK20IrLami16
         OzngtF+jBde/EBdUDCB5dKkmPPWaHnHfiM3vyyIec67H6o8zer5b+WmUQRmb4zcV53Cv
         J9FhPLtakNuaj93NRmHsrZWbXssF8dbpAZ7uv0TPzR4aIfb0sbuupF5h/14iLIe5Kxj+
         XdDNWqhJIVySr/eQOtSoOsoa3XsMv4lOBBFvOG4jt8Afkugq/WDDpFD0CxSNzPBXObmR
         A9vSjXbpHEaQfUH11ISKl+H1FhgFvGWkisPBj3ZENOvNCxcTV/UI3MQvLPp6cmORIHAK
         eDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X589BqCXKNPB70WA3h+uA/HSHzhkvFxOpxaltJvaxRY=;
        b=pz2HzWGOtO5FkQScp51MT9fEJVrEqatgBn4K/0CHF+wspq+WtQJeTAoowBBpXG9wQo
         pYbd9rNpWbfvrV5llv4QaYY0Pi4j0be0qPBfVwFxj7JqBUk+qSIEI9vyBdmahzUUUFaC
         V2SWLDF2AOxJIsFcv4zyASO2UwxG+MZXcnbM14VrgUSRySEUzbspLORLjS0XUo8TmBFi
         H+dxrfNhDpoqMWNbDqvuClFZvxjTAqRZFPzf9CZxYQ756hvo2Pt266Q4lhZhTTDUB4JK
         Ep0+gExamez1iufUpSUbery7f82TTMSXLcnIIYsCaclS4f66XnQBZ6043qmpC3CKimXs
         x2jw==
X-Gm-Message-State: AOAM531YWuTAGYkqbwGhF8g2/oT5yFFLPOSp6Yd+snl6GSDiUVAjrX75
        D/gGzNkGnXPwgP0ysS3RKkslEg==
X-Google-Smtp-Source: ABdhPJxSiAzgCMdtIEVJ2ib+eiQzTskYXJ2BOHAFqSwrhR3ytjn4szslRIByBN/rM84ZNVoUR1Pe+g==
X-Received: by 2002:a17:90a:514f:: with SMTP id k15mr1999887pjm.71.1635041598362;
        Sat, 23 Oct 2021 19:13:18 -0700 (PDT)
Received: from integral.. ([182.2.37.49])
        by smtp.gmail.com with ESMTPSA id d15sm16293137pfu.12.2021.10.23.19.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 19:13:17 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86-ml <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Cordes <peter@cordes.ca>,
        Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>
Subject: Re: [PATCHSET v2 0/2] tools/nolibc: Fix startup code bug and small improvement
Date:   Sun, 24 Oct 2021 09:11:30 +0700
Message-Id: <20211024020616.395038-1-ammarfaizi2@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211023134323.GA5881@1wt.eu>
References: <20211023134323.GA5881@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,
This is a patchset v2, there are 2 patches in this series.

[PATCH 1/2] is a bug fix. Thanks to Peter who reported the bug, fixed
in [PATCH 1/2] by me.

[PATCH 2/2] is just a small improvement to minimize code size, no
functional changes.

Detailed explanation in the commit message.
Please review!

Link v1: https://lore.kernel.org/lkml/dRLArKzRMqajy1jA86k0vg-ammarfaizi2@gnuweeb.org/
----------------------------------------------------------------
Ammar Faizi (2):
      tools/nolibc: x86-64: Fix startup code bug
      tools/nolibc: x86-64: Use `mov $60,%eax` instead of `mov $60,%rax`

 tools/include/nolibc/nolibc.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Thanks!
-- 
Ammar Faizi


