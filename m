Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C848737919E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbhEJO4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbhEJOzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:55:23 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB4BC051773
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:14:39 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id j19so11977831qtp.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=MADdJGzbzN/JTZLtOu89tCfxqIkdNRIgyDoqgwASVG8NzNJvDBx4Q26QufqDFOwdpm
         KCEUNEnzUq3rYYwXQ4xCmPRnlusEVyvRR7WoD20dHdbTR0MI0gD83a99bJAkBhBkWF8W
         gsNNh+F6s2+5ycUYEQA+SgiSW5qYvwDJVVVgHGqYjSLVGneDZYqNH5cxzab5UyqUXmZk
         u2Cb3HCd+8Fkii1WY2HtTmUbncJVxn7mwPt/kQi7T9zsm8RgcIVd1BM6qtRiynmA0aGi
         a8aKcmhXCI3evwYSfRBdyt9c9uyWq6PHCh/TbEnzK+w5lijCoaQLRXdi3bP00YB8n1GH
         Czfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=m180hX4SfblNOlTYImjU+AJKOZyPz1xRCm+nCiFZDHajLmYDhAFSlBbGcbiQbR4XPX
         GBidfLmGiSwS6VkAwLhmTk6lLu01oGkN/A8lOpGfaorERMtBr9Exlc6Q2S9gVqtWr7hN
         rYUDg2RKGdNV5Qs1K86542IavioOOnneXE52l33ZXPaG57/2FoyRjiz1Z5oD8A5Tm9G1
         Wc2NbWDMfJx6JKHhDxHp1kRUFIHM0IOLWkP/25CDZg/FinDd5N5T2lxUEC7T0V6TTrlZ
         N263rpNwe4vJkJGuX9uYSX5LySbhCtWFAIFsc00jMR2Q4AvDPzY4HimjqjzI+NFW7oLd
         sJVA==
X-Gm-Message-State: AOAM5308Fe5piiYcmHnUSIigJUebya6Pnt2pf7mwlwWu8ZRP6qjcljDv
        UE42gM6p3klJeJFBI7cq1G+/+WePj6JwB0CC6F25PHUkof3Jyg==
X-Google-Smtp-Source: ABdhPJzeObEY0sHkc5/E2sYTiNgmN0vpxxuK6JetGvBmO9HA6rnbZiyyebB31B0NTov88Lhtd6bQjQgU6aLUlwH0LoQ=
X-Received: by 2002:ac8:5d10:: with SMTP id f16mr22167635qtx.123.1620656078310;
 Mon, 10 May 2021 07:14:38 -0700 (PDT)
MIME-Version: 1.0
From:   Rafael Reinoldes <rafareino@gmail.com>
Date:   Mon, 10 May 2021 11:12:37 -0300
Message-ID: <CAOZB5GHn6MQzudVPObEo0_hAVn3=QUcUHVA+H69hZKjM8A6t0g@mail.gmail.com>
Subject: 
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe linux-kernel
