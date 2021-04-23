Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78573692BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbhDWNKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbhDWNKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:10:01 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEA0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:09:23 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id s5so40702385qkj.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5djI1+HvAi/jye2T39my6fOjQXVXyZ1kxwVi3Zvr5I=;
        b=pUobykd4RadgZy01VJZJcNxmHV0x3zxJgw2bOLSL06m5hO8j5DvLFWZ98JR7JdZEL5
         O3/WXhrJM7KyC5rEJGu7RtuG5VurZVWNbYcn3jlO6FkLUZi48402ctjb+lWyy6m00aRm
         FpvGclEt4EvTrDTocZsFe88GcACeNELZe7XwaBHhg7i3NA2Do7sIP2yXon5fnqJZDmTy
         56rl6Deu1AZG713d/uyjtlECnehxPfp7AIYkLoKurTKioh8hntQNzcBcQS1a98jfNiXW
         DGfGShNyM8/A8FJYBCkY53gG2K4Z4eBt1YL0k+HaIc0Q6SSniafUez5wzCCqRNfBDDcP
         YiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5djI1+HvAi/jye2T39my6fOjQXVXyZ1kxwVi3Zvr5I=;
        b=iRaLL1L2DwKylziqqO7MhD6owzdMBN8lKYoZXKj/5YI53qn48CZq7+iLLML8AnYuse
         U2+6D72XLkfyLazUjAFVO2dzwnc34Lc3GtMx2dhQ4rBTLI7W4jkMseTg5TzaWfLQ1suZ
         XOhR0NAWcLRlSeM9p1JeAgkuL3mZN+hNWnPjccsmXxM/rS6cDEgEAGYQExOf6BMA6BUE
         gOKYJcpUGTTPJXd5lESnTzXhYovkTH4u6+SMGEOPdEPI4VgxzJ8z9KAoaQ+0ZF28WmIY
         LdL9HnNp+BNOB4/F0DuIQo9r5s/nMttTqONkh/9hFUbZ32nkmgfw0M3j1X3cYbyWBBO5
         /z/w==
X-Gm-Message-State: AOAM530XdizU1omoKg3vJjLIuaO9kwUU9rPCN9s+QEq4ZScGvMXfYToW
        2AwlbU0fV/FQ/3dVtTpyUj8=
X-Google-Smtp-Source: ABdhPJzKEAzdBJ1Yf5WXCUEJVOP/e2IpDne1l+ZizN5Up7KpqzSyQPHFOiGQec3fzy5gn+EAeR/eJQ==
X-Received: by 2002:a05:620a:7d4:: with SMTP id 20mr3933234qkb.58.1619183363240;
        Fri, 23 Apr 2021 06:09:23 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.69])
        by smtp.gmail.com with ESMTPSA id a4sm4142613qta.19.2021.04.23.06.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 06:09:22 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, nathan@kernel.org, linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 2/3] oprofiled version output line removed from the list
Date:   Fri, 23 Apr 2021 18:33:00 +0530
Message-Id: <8d1928ff2fea29d67143d235839a5e845e4402c9.1619181632.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619181632.git.unixbhaskar@gmail.com>
References: <cover.1619181632.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oprofiled version output line removed from the list.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/process/changes.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index dac17711dc11..d3a8557b66a1 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -48,7 +48,6 @@ quota-tools            3.09             quota -V
 PPP                    2.4.0            pppd --version
 nfs-utils              1.0.5            showmount --version
 procps                 3.2.0            ps --version
-oprofile               0.9              oprofiled --version
 udev                   081              udevd --version
 grub                   0.93             grub --version || grub-install --version
 mcelog                 0.6              mcelog --version
--
2.26.3

