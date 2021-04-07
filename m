Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9320335749B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355442AbhDGSzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhDGSzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:55:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37294C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 11:55:02 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id b20so7902551qvf.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YY9eveig3pp5+PlL75Purc6wsBlhiQiCMLwdknhjln8=;
        b=dILJtwuAkWIR/5tK4jc75SBb1OplrD5Ird2I+N1RS+bwZMIaLoSsiP913UNfqX6Rpx
         rQUBLjNHeTm+9wRxG+ddnJWanWmw70KcnFqUt+gpqh4TPUbVXGSV76XJRz9SE0sYObNV
         cqKhsdCkQs+DaRO1a+P33Albydyk9udMD8dGV2dVLieLfhYIYj9DBQRHqEJBCMibL+So
         41+040iCoQ+xmkBccKpWghEO7Gpri4wez6TOSgY9SMrh62ierZ2cvwQHmcdv2tP2A4Jw
         jb9/Kp2ptNuo2gLeff87udnUBR4sr9raDeRMkVXCzh2JIUsqV6oNbXbSLYNajNhUsZdE
         ZEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YY9eveig3pp5+PlL75Purc6wsBlhiQiCMLwdknhjln8=;
        b=H4QoXpYRRzKEN+Z48lk3O76Er8fHvuoPWdJwRnWktlYSdN0H5YpOJh/zNTP0Vjirg/
         Y1ycASfW5PF14pymXYjVzCxIfVc5JRO6u8b0yUZvZfnxaqjFhb0hubhV7UbN1wvdJzTk
         +gXkv9ej4n3jCtCA/N790JQ4wUqEaCvKruFS9qUgSyU2zAbB1AQUAJrnrSTHLlGQAHC9
         eSV8IdK0kfIewAwMoN4Vdk1MSxWcJ3LcrY+B2rGvX5opgrwcw5vTq5Uytaw+h1U23ykA
         IRWFMARRaep8PU1N0UOj/I9W59237sMVRZfBPBkatx8XA5a4CwqxbIETA64+CW/lmB0E
         w3Jg==
X-Gm-Message-State: AOAM530hz7tnhV7SeoREBZsSAXzdvi42IgOQabThTb+QmAJ4V8nwRC15
        iQJlrGW5a7uObpN1FIR88FolFI9uJA3NI/qREDo=
X-Google-Smtp-Source: ABdhPJwtqZslJND39tL9iA377qCKI6AsoMhgk2v7RZBaRoTkWXhduMSQj6iMNqKK9NJDCC+5cRhkEtSrK/ZVQyhNVdI=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:c454:8587:ce1c:e900])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:f30a:: with SMTP id
 j10mr4958678qvl.20.1617821702090; Wed, 07 Apr 2021 11:55:02 -0700 (PDT)
Date:   Wed,  7 Apr 2021 11:54:54 -0700
Message-Id: <20210407185456.41943-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 0/2] gcov: re-fix clang-11 support
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Fangrui Song <maskray@google.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM changed the expected function signature for
llvm_gcda_emit_function() in the clang-11 release.  Users of clang-11 or
newer may have noticed their kernels producing invalid coverage
information:

$ llvm-cov gcov -a -c -u -f -b <input>.gcda -- gcno=<input>.gcno
1 <func>: checksum mismatch, \
  (<lineno chksum A>, <cfg chksum B>) != (<lineno chksum A>, <cfg chksum C>)
2 Invalid .gcda File!
...

Similar to the last series, the patch is broken in two. The first is
tagged for inclusion in stable in order to continue supporting newer
versions of clang (clang-11+) for that tree, then the second drops the
older implementations to keep one and only support clang-11+. This same
pattern was done recently in:
https://lore.kernel.org/lkml/20210312224132.3413602-1-ndesaulniers@google.com/

We've since added CI coverage of CONFIG_GCOV
https://github.com/ClangBuiltLinux/continuous-integration2/pull/107
but need to find a better way to test validating the coverage info in
userspace.

Nick Desaulniers (2):
  gcov: re-fix clang-11+ support
  gcov: re-drop support for clang-10

 kernel/gcov/clang.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

-- 
2.31.1.295.g9ea45b61b8-goog

