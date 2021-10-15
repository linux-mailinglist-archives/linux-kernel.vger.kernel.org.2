Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3471642EC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhJOIaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhJOIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:30:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69A5C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:27:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so8833381pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/5FxejazhnXMnooWKraT7JB1zm9hSMGHFyjyensLdw=;
        b=WCg9kioXUyMcTKWNyOumeEJ68J1VsxmUGDllI/wZuApMzkFONOQbusWZlzpAhb/QNe
         +XaTPZ9xzvng0ug5B1VsItVRGctoQ6kwj8UgG7Lds3cNcEpHmvKdD3l2n8h07ROppn7i
         N9+dhnHk3LPt9+8M7E+tVX2m8zVqjo7mRllXQi8ADa7VwfkX0KLHKRY11go1dM+HDCt1
         e0JW9Ky/byAB1KoPz2ly0ykNXrqBncPKpAKdJxuPajwALyaxYmVyZ5h7irhxBhG9ftbd
         iGm1dBvXxro0otJEXhow5SG96BzmAhWzqQGtaIiV3gCqFS1u6qUffj7Fy2wRxWMgFYXe
         I+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/5FxejazhnXMnooWKraT7JB1zm9hSMGHFyjyensLdw=;
        b=IRQrnvkwuw3I1zUNCE439wZxmRovipn6O4tGlZVW/DKJIO399lgFbADG3WNCybg7SH
         OQeu5s8p8Y5EtOT62p+YmcN6HAlkl0VmmOOg0bM6MzYixXyfcjDAiyU6VOA3DTdyY1oQ
         Z2S3KwEPCJTIKjH/h2EKhxV6SoX3NLsQzdwG+jBmcd7VHLJTSdQlMNOpEQ+btEeeNuQH
         XF4wsFDSXMSwiNA/++l2Wh+wvSmIZTj+PsdFB/+76qCJZ7XcX9ZoW8AtvWzH2vVzO+f/
         rH2dgDmx5z1OgWbBZc8nXoGZAUNrdmNN6U0SWrUe7NkEeprelxPhWEiyCo3ieyWX1FqG
         2sNw==
X-Gm-Message-State: AOAM533PjUVzoal+fr99MwVitwOwaoCmfgziV14ACN8znxHs1kD31Rmx
        iFU1vA9vsfKC1XqmRRkcgkH8RQ==
X-Google-Smtp-Source: ABdhPJzQ2WPaLrwkjxvs+S4+574PD2NAisn9suWPCmKzxxMbZJM/c1AyN7B04oBWZBp+Y8ywdUnCIA==
X-Received: by 2002:a17:902:6b48:b0:13f:903c:bc2e with SMTP id g8-20020a1709026b4800b0013f903cbc2emr2436717plt.68.1634286475330;
        Fri, 15 Oct 2021 01:27:55 -0700 (PDT)
Received: from integral.. ([182.2.71.75])
        by smtp.gmail.com with ESMTPSA id d15sm4933832pfu.12.2021.10.15.01.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 01:27:54 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Cordes <peter@cordes.ca>,
        Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>
Subject: [PATCH 0/2] Fix clobber list and startup code bug 
Date:   Fri, 15 Oct 2021 15:25:05 +0700
Message-Id: <dRLArKzRMqajy1jA86k0vg-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013090339.622070-1-ammar.faizi@students.amikom.ac.id>
References: <20211013090339.622070-1-ammar.faizi@students.amikom.ac.id>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patchset, there are 2 patches in this series.
 
[PATCH 1/2] is a resend of the last patch I sent. Appended Acked-by tag
from Andy.

[PATCH 2/2] is based on [PATCH 1/2], it's a new patch to fix startup
code bug.

Detailed story in the commit message. Thanks to Peter who reported the
bug, fixed in [PATCH 2/2] by me.

Please review!

Ref: https://lore.kernel.org/lkml/20211011040344.437264-1-ammar.faizi@students.amikom.ac.id/
----------------------------------------------------------------
Ammar Faizi (2):
      tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the clobber list
      tools/nolibc: x86-64: Fix startup code bug

 tools/include/nolibc/nolibc.h | 94 +++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 28 deletions(-)

-- 
Ammar Faizi


