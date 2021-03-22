Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A64D343774
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 04:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhCVDat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhCVDaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:30:15 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD94C061762;
        Sun, 21 Mar 2021 20:30:15 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v70so9264015qkb.8;
        Sun, 21 Mar 2021 20:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JHAdv31lJiyavDMsRd7gTkVNlAx0wcbfCil7edmgyZA=;
        b=ZP7rc55HJWuS+079akH1GgH4KYySrznjsd3hlpLQ6KE7vC2in2J0nacX7ECspeG73S
         QAbvEwfsrUJMPQsRBwAKS0ymBU3vAoApIM5a1+ISNOz8u6rNF5zff1K4o2/RHbFeYL5r
         IQ6a9lDtjfJZVFQs2FHrtEGb4QXu3G7FED3qltFKaF6IqwcC94ku3wiMzHuzLa+rnw+q
         Hy3zTLpqC8K6jpkpMR4usKZJuMW+3eORghOLjB/eYvspJIwxxBHUFaVa1l/Pr4TMAdf/
         hZ13Ogx9EExntRDFTkeTZQEkWBuCNCd2ZPsytZg3S4JBsXZbM4Up+wKY1jb/4CRVOlkk
         huWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JHAdv31lJiyavDMsRd7gTkVNlAx0wcbfCil7edmgyZA=;
        b=TOwnkkoePum03K/fE92BZHHzNEG63d2QQpKEAmGH6NLDNX/IlSGfrHxI39WtIQk/i3
         Yze+NjVvXX4Y1ZLtihw71lbOhXQT5syx+PYCaqQ04HdLqmxz1py+ObGo6f14ESTZdSWO
         qjENzGvP+zKt+cFRA89FmMWN2qhGj0yfjdB2yZ2HGTdESKqmFQh5x8OMUeJkHFP5Vteu
         0eNAJQt+Npamn1DxFhqPyoh5j3h82RnBf41aa0cS046ej1/2KR4KlxrzdT1VbjyYxehb
         q3dvTpzqHKp/C190D6HEaByJuanvijJMSxmmxoBMcdovMH48CWuXsSqf8CeP1rkZEy0E
         sSrA==
X-Gm-Message-State: AOAM533hfPajoAQqe602Q1t1iYz9UtGaIsUKMoJDn/hQBD9bNoKvP2Iv
        Zy3jJpqoaWSQoFIdehXcl3VwxWy021RSVYNM
X-Google-Smtp-Source: ABdhPJzBDQCduCDKGfR8NxS15hrkiy4tLKQEf4P0xT9beBZvnQvy4uxEGsumDCMMC4iWNEoXRdFaXQ==
X-Received: by 2002:a05:620a:31a:: with SMTP id s26mr9031145qkm.355.1616383814576;
        Sun, 21 Mar 2021 20:30:14 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.190])
        by smtp.gmail.com with ESMTPSA id y19sm10082402qky.111.2021.03.21.20.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 20:30:14 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, unixbhaskar@gmail.com, sir@cmpwn.com,
        gregkh@linuxfoundation.org, lee.jones@linaro.org, bp@alien8.de,
        huawei@kernel.org, krzk@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] docs: submitting-patches Fix a typo
Date:   Mon, 22 Mar 2021 09:00:00 +0530
Message-Id: <20210322033000.2523887-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/mesages/messages/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/process/submitting-patches.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 91de63b201c1..8b2676527b7e 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -679,7 +679,7 @@ generates appropriate diffstats by default.)
 See more details on the proper patch format in the following
 references.

-Backtraces in commit mesages
+Backtraces in commit messages
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 Backtraces help document the call chain leading to a problem. However,
--
2.31.0

