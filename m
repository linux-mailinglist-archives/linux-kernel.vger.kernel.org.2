Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9F63E84DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhHJU4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhHJU4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:56:47 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B055DC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 13:56:24 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z12-20020ac8710c0000b0290291f4eb83d3so141924qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 13:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JgzvWF4aPcZQw92AZWKQngRnopIXZApLRoonBBa4I1M=;
        b=LvzCirHkYp4g7MWXT0gRDp5Ly2smHI22qe4PcMIBnQpQI8Vgw3luX9nhHbs648Sh/G
         57Y2JB788YgZs9/A47npZew5VaMP9z8TJmJofMxlbZFB3c8kMS0BC+AUS24Bez+9HRlC
         3vG3zcHPgcadI2dlKfh4Ovpw+z4jrufwHmiJO6QIYESninr4xn3XfrC//hfzrRcC0CSt
         GpF7/2A/ATFc4eSJuCW/CwDB41Lo8XRNmIn1JoczJkfq/yqBfzcLM/QGmEbUzLC/tp5B
         QM2cGEy57HeNWs6CKr1vslY/PKMQhxJSCY2Sw3/PuUBXWTj7qHZhK4n5V15+pv7cZvdx
         uCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JgzvWF4aPcZQw92AZWKQngRnopIXZApLRoonBBa4I1M=;
        b=dR+lkV0HEiolO0rFO5y45TRL1oip4t9woHY6C8kchH7FTn4KRv6zeLPZc67pyCx4qF
         WDOBRPm8bxWP0p5EknyuSSIFPdhH5AX4gBw4x4P/7RIaystkrM8R4mOEdW3YNiF2PB+S
         dzvgWYe79kOMFqOgKcROvulLf2YCqohdpBqge7lD4rceREQsRqvZQtyh/psU1OyJBb8I
         bL2j6kJEQXest7twnHusDYYlJ436XNLBxKcoi9Nw3LdMRbxycxzL/SjMSMy9swkUq+Fx
         TIdHerWelszaKsnm1ommu4+CqIYxUiD7NKB2f7HIHl0GvkTIei/Dn+sWyKdFPrfExqYS
         ZoJg==
X-Gm-Message-State: AOAM533pldqxxBf2bD6JZc4GNYC86KHiPx+VFml0BEeLEjeUiulF1N9n
        Ad4NN9tvPz7/xUJ4GuiDOAsy3IURuM2RFXUecas=
X-Google-Smtp-Source: ABdhPJwEsRvv3QId5aCWpPxPDxadwagwmm7YPlgRns5g24vq3jgZT5tTysjBS8xzNjqmie83ObaYjThhvWuHDdCY5Fs=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f3a2:624c:cdb9:1ee9])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:4e50:: with SMTP id
 eb16mr17380946qvb.14.1628628980850; Tue, 10 Aug 2021 13:56:20 -0700 (PDT)
Date:   Tue, 10 Aug 2021 13:56:10 -0700
Message-Id: <20210810205611.4013424-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH] MAINTAINERS: add Nick to Kbuild reviewers
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees' post inspired me to get more involved. I still have a long way to
go in terms of mastery of GNU make, but at the least I can help with
more code review. It's also helpful for me to pick up on what's missing
from the LLVM ecosystem.

Link: https://security.googleblog.com/2021/08/linux-kernel-security-done-right.html
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efac6221afe1..9768e4a19662 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10091,6 +10091,7 @@ F:	fs/autofs/
 KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
 M:	Masahiro Yamada <masahiroy@kernel.org>
 M:	Michal Marek <michal.lkml@markovi.net>
+R:	Nick Desaulniers <ndesaulniers@google.com>
 L:	linux-kbuild@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
-- 
2.32.0.605.g8dce9f2422-goog

