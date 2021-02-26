Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6D32665A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBZRbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhBZRbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:31:47 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E31C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:31:06 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d3so14926791lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=nfhYhhUoR2pCqMTHUNPNgO8uvmAp2Cp7XBHNPpmJIgY=;
        b=CpMReeMFAGYUdY6aUaXf/OBDSikVA9jivmwzk6s9e8UWM1OWv2Z5kLaU/GEydMmbVH
         dEtcjRwwK7WLJXGO29RTjo+BpNOjLTtTH469cNdQzciDgEJ3Xkepuny5RJPUr4CWbD8Q
         cduLaSlxPao2/y8qm3KZJCFe3mjvzkLTzV5EDVCYpxHxPnhJ4yu8io5zkGpeT8ny8B2/
         zoZlG9mbpXwHHq1MzxbSiuMy8Um6MURmKyp5n8hwKJVTsrW9ojoZKLxep3um0a7BgldZ
         LxvqEA18FUxBYPuksGbeownY3EDJ7/GF4t+lEejPkmLAn2gTYaqsHcsNBD1Scz2Xf0Zm
         5DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=nfhYhhUoR2pCqMTHUNPNgO8uvmAp2Cp7XBHNPpmJIgY=;
        b=q65wfZDE7Ii82Slg/F0DYjrSe/kNGctHrWobv5I1Pa12i1/DUNCoD3I1w1dik9G2s8
         J47KNzSp3NvIzIwG13rxu7hjmZN+mtPmMrTfbsYwm6PHawKdJSHmDlkogOedhkuWrbbs
         hgKPYQETgSqGkW/9Llw8+SrQQ5yu7kGTz2F/b1kMuJeMk0LW8YOhusmH6YJCgMW4zPiE
         P0HLd9N1MQgpbP1tWT9HxSMHnI/GfszU4oLod+XEpoiU7Gplgf5LYgXu5s1McCR+Xjcd
         S1kZz0B/MA/EdhM/Xi70+TKcD3Pjacezy54lCJ7Se9yaXraTOO+cVobpQYeaWSR8zAzE
         jqDg==
X-Gm-Message-State: AOAM532IKUeMdptW5958aDWQj9S+2KBPbI0waqkJC9HaK8chKeC+c/5i
        wQ9ZOYMXoF6M9sReZLnu9cDbUb3WiBxSMJLAzt4=
X-Google-Smtp-Source: ABdhPJyLsGATep/I8MzxgxzT1qRXXsfXGbv2yvI/J+fRCHpyH39Y/Gp5YK+gKFmCQumWMmC6dN09UM7/BAqXFqBuddA=
X-Received: by 2002:a19:7409:: with SMTP id v9mr2418601lfe.507.1614360665145;
 Fri, 26 Feb 2021 09:31:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a19:5516:0:0:0:0:0 with HTTP; Fri, 26 Feb 2021 09:31:04
 -0800 (PST)
In-Reply-To: <CA+ESkMegOqpbLkM7TzAP6KdayEXeSJMDngn6EGumupei6xrU0g@mail.gmail.com>
References: <CA+ESkMegOqpbLkM7TzAP6KdayEXeSJMDngn6EGumupei6xrU0g@mail.gmail.com>
From:   willson mutanda <ncvbz0291@gmail.com>
Date:   Fri, 26 Feb 2021 09:31:04 -0800
Message-ID: <CA+ESkMdPVAM0bo1yO4sBWN6SpfKf4JXyFPn8bx3Thsw2mhx9HA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello my friend

I have sent several emails, have you received my previous complaints?

Willson J. Mutanda

Email:   willsonmutanda.j@gmail.com
