Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE3F35C4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240119AbhDLLVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbhDLLVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:21:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04255C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:21:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cu16so4464189pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=WxFymkv1ReyBJIeSaYrMs9DALjw4Mde+TrIX6jgLR/A=;
        b=mU02UGTjy8WnCsjIBrTuIdTn6VlqvZ+TcMx+l0IwFrOl68I2/iT2qnUK59+L+c18SG
         LOk3jHz2BHBojlwRkGyI+xuG8DytqRFsGORbGwB4Goq9WkKGj9N0CLoixBP57ynJ016j
         zR0+bqhD21knLMjMDtKYigqFhm8j1YS9RyxHjM6RtMc/kWsvJVL00x2uytee5b8HVPnm
         ABNXOajLAsefIgB+eLgyv0WkxyGBlApPQ2GXuJ/rW3aN2sjhjOdrUJyvzjbJfErJ+5rk
         lZSCXJFS0B4Kmav7Rejy0gysYbEmu7iLqbbPThVLIPO87Uh2HDznmjq/AgRxfHBlFw7F
         GVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WxFymkv1ReyBJIeSaYrMs9DALjw4Mde+TrIX6jgLR/A=;
        b=Q2r9XcrWyx1JlH8YM64bZfsG8fGqbomXxiXEGJrvwlu4jrzqJaK4BYM/06bY+yHE8+
         tfbcGUBahzMpd4OekNASRyE21xvHwOQPKEbV58kDBWZ1f9cfNBfr6b17yiuSF8xcznU1
         3/uUypUjd6xve5lfhksgDLEGkIyu5TT/yI5qvoDey6SyvglJ+MRrVDidU2XoIccykOo4
         eGOALRPLzLvLm0vwe36Nnrps7TWsJ1LaK8MxWYRYzW11DFb7KUbP0z3drR814sEV6IT9
         Zfu3d+DPF9CaUPS8e/9DAp3W6ZEYLsDLk3A6fkKoExe3KGyKUwpkAmYnUkAv8rh+DHKS
         f51g==
X-Gm-Message-State: AOAM531XW2I53qVgo2rk+N2X1x5YSSRq4tx2GQLB9OpWD5fkT1S59qUm
        gQ/xB94lGKmifSNl9Bv1ZWc8wf9J0Afvvg==
X-Google-Smtp-Source: ABdhPJzyMLeks7DbKTOd7eb7WQ/+Dtg+kzaWIqBjAyQyPkg/gUWgXCf69NKP97rYLTZoADhDeCfnzw==
X-Received: by 2002:a17:902:b70e:b029:e6:cef9:6486 with SMTP id d14-20020a170902b70eb02900e6cef96486mr26555304pls.18.1618226474418;
        Mon, 12 Apr 2021 04:21:14 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id d20sm9635615pfn.166.2021.04.12.04.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:21:13 -0700 (PDT)
Date:   Mon, 12 Apr 2021 16:51:06 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v4 0/3] staging: rtl8192e: cleanup patchset for style issues
Message-ID: <cover.1618224838.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v3:- Changed subject line to match prefix on the patches.
[PATCH v3 1/3]:- No changes.
[PATCH v3 2/3]:- No changes.
[PATCH V3 3/3]:- No changes.

Changes from v2:-
[PATCH v2 1/3]:- Modified subject description. Changes has been made in
v3.
[PATCH v2 2/3]:- No changes.
[PATCH v2 3/3]:- Rectified spelling mistake in subject description.
Changes has been made in v3.

Changes from v1:-
[PATCH 1/3]:- Removed unnecessary parentheses around boolean expression.
Changes has been made in v2.
[PATCH 2/3]:- No changes.
[PATCH 3/3]:- No changes.

Mitali Borkar (6):
  staging: rtl8192e: remove parentheses around boolean expression
  staging: rtl8192e: remove unnecessary ftrace-like logging
  staging: rtl8192e: remove unnecessary parentheses

 drivers/staging/rtl8192e/rtl819x_HTProc.c     |  18 ++-
 1 file changed, 7 insertions(+), 11 deletions(-)

-- 
2.30.2

