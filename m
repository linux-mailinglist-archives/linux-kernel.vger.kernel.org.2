Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15AC446DEA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 13:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhKFMiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 08:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhKFMiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 08:38:13 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43BDC061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 05:35:32 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id q13so22250642uaq.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=keith-pro.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=65D/qGsKqTv1LUK5gsBP+4elDJxC4IgpXO2lx/Bp7JY=;
        b=REfHWDOw8bTR2MGu+WKZXKDyiDHNmklzwhYulE5VirtIg0xS2KH+r+MYQI9Ro96PQp
         ZneU8uZULBasXrYR1lYFfjwI1ciAomUrXALZeBVyVWETyBmiIKncHdAyLjkDWoPPCyMz
         wA6KDd9g2WVuW7IWc+BCpOEpPOaIjj7Wd4Yu4XRjuX/YuAE14+yCn12prTqV3qm3O79R
         hCXgwjacHxjfp7tV7JlyeBnOgLv9o+n/Zvyx8n359U0QK1dcG1u80e72Acuq2B0yv0vd
         koTyyQTAyir8w1G7n57gZSCdLvPdrrW55/2uEDGceQMw4QcKKpmHAgDgVFn+JikzlrVN
         ARYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=65D/qGsKqTv1LUK5gsBP+4elDJxC4IgpXO2lx/Bp7JY=;
        b=jMcXttWMnXVbjfWYZ0J3J2HlP8fvz1ND0Xx7pTGN/8k5iqrb841XcWjg/Ntf3fL3mH
         s3MpiiDafU6a4p2l9PyOza5NX99/3ivpEFwDa4bq2rgWK634/+zRVKjYQ5WPFQvrW6NC
         u0iTP2SRwP7xI1BkjwrltcIX3GQ+fMiLUzDq6y093VLE+WYRLHQwultXJr6feXXhwnbT
         /YlE4qvKrm1kKHH+gRGRmQExQUCUhnGt2lSszP0kK4kEQChz+5l0+T8PTELoWpDcd+Az
         Au5d4SWaGkv1p2730mB8YA4Wcp6FSiOLvT3DogZlZ1Tf1aByRXN3gUhLn+OZhqmfD5OF
         CQxw==
X-Gm-Message-State: AOAM530ikqyFRFOtmwKifVEzfG7i7Rds9KPx3j8d1RYV6G67EL0GbXHz
        kPA3uwfkdmmrU1XGU/fwu/i7MGek6qyeD+JrVJZj59uHDR/LNA==
X-Google-Smtp-Source: ABdhPJxymEMAIKq62CYvSwDt0+B0o7zsmoKhtayjOPKVdaqm1KEFvANR+G13xXBNZkGxF+tgTQfrnZvuQcSbP5GzglI=
X-Received: by 2002:a67:26c7:: with SMTP id m190mr80572681vsm.50.1636202131911;
 Sat, 06 Nov 2021 05:35:31 -0700 (PDT)
MIME-Version: 1.0
From:   Keith Cancel <admin@keith.pro>
Date:   Sat, 6 Nov 2021 12:35:01 +0000
Message-ID: <CALGQo4a6kO7R-EOcX0kad7jmMRVTgm8-p+7LCZ7TjAaOpweNUQ@mail.gmail.com>
Subject: crypto/aegis128-neon-inner.c
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there a reason aegis128-neon-inner.c is not in the arch
sub-directory? It's clearly architecturally specific. It also is using
ifdef's to delineate between arm and arm64. It seems like it would
have made more sense to have split this up as 2 assembly files in
arch/arm/crypto and arch/arm64/crypto.

Thanks,
Keith Cancel
