Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D551339C1A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFDUx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:53:27 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:51122 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhFDUxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:53:23 -0400
Received: by mail-qt1-f201.google.com with SMTP id b20-20020ac87fd40000b02901e1370c5e12so5903631qtk.17
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CFNkGJMFknWFYDKUTL5q74oSIb8W2HSb6ukDUBFf34Q=;
        b=VQdOe4hyoP5UxypW7+lxtdhuTjdiGffnTahC5PiPI1Y0t0+E2De93ToxaFgulyk2v0
         RWs7YGPXq4Qn/5TM+WtfLbVQ4ps1B1SyYUKxqXcjHQrBdB+Mn/EmKjoc5YLS+OGZvziN
         PTDVHWjwCPQEwlQPK/1SmELVbm2qIHslTGnZ9hNxuxETIh+t5TDqbHOmticahF0sh+wd
         lbM5LNZcLllcA9OIejAaxxWlHbpUZtS5ft0htW5tgR5qMGXppeXZNremAM2atyA/xdz/
         z++WmCe/NDk3Uoh4+3D7ZI7lMjwTYmR3cAgVku5r3848nbBJbFq9m3Af0Az+3KEvf+OD
         gh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CFNkGJMFknWFYDKUTL5q74oSIb8W2HSb6ukDUBFf34Q=;
        b=um+hC8oZBLg023XiwBlew161dKk6z9NS+GcOmisXK3/YhnuZAt5XOW/YZWh33p/uNc
         7tTOZkO5tNvp+/Mp7p21q2hIyKMOe+X7T5udy82yszSSjOg5654CCj3bOE2uKsvxpTRW
         NYNJMwfbX911z/lcefsKtr2CUU6AJM2Gr9olt90hgMknwPC5iZ1mRtxHN/HQOIoUjT7z
         AN11XTJJarxAIx0SGSzx4sprb4pzblxDpjC4Xsg++MsZuTkUa0yx0hpEQJzgvDouMiyL
         AUOxWdjl2XxCX0V7MjRdKN1afrIFB8lTbX1b36NhPQZt5pFjotrA3kg2VfBqXopplaNS
         CkKg==
X-Gm-Message-State: AOAM530WN6MUok6Sx8yYloInCqdxL8nL6536h68CkjU1T0u9beIlV7Nc
        SsBS4G3q9Py8Go+zsmFv0Bqj1NKKhDC2EVM10rE=
X-Google-Smtp-Source: ABdhPJyeljV7nI5n7zL3gkvPNvq2ZeBkRbws8mZVcFn9/8rHM8amyvY670ZHVxHUur7P7oj5zJlclxcWsbBfTS3kNCo=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:c4c3:48b1:987e:8e6a])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:4e68:: with SMTP id
 ec8mr6687875qvb.62.1622839820623; Fri, 04 Jun 2021 13:50:20 -0700 (PDT)
Date:   Fri,  4 Jun 2021 13:50:18 -0700
In-Reply-To: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
Message-Id: <20210604205018.2238778-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     peterz@infradead.org
Cc:     jpoimboe@redhat.com, lma@semihalf.com, groeck@google.com,
        jgross@suse.com, lb@semihalf.com, linux-kernel@vger.kernel.org,
        mbenes@suse.com, rad@semihalf.com, upstream@semihalf.com,
        x86@kernel.org, clang-built-linux@googlegroups.com,
        nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Manually replying to https://lore.kernel.org/lkml/CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com/)

Hi Peter,
We're also tracking 2 recent regressions that look like they've come from this
patch.

https://github.com/ClangBuiltLinux/linux/issues/1384
https://github.com/ClangBuiltLinux/linux/issues/1388

(Both in linux-next at the moment).

The first, it looks like a boot failure. The second is a warning from the
linker on a kernel module; even readelf seems unhappy with the results of the
output from objtool.

I can more easily reproduce the latter, so I'm working on getting a smaller
reproducer. I'll let you know when I have it, but wanted to report it ASAP.
