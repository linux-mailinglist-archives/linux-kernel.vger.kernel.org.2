Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052113692BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbhDWNKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWNJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:09:55 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BEFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:09:17 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 66so9906851qkf.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fUQvT7RDTsjrM/n9IADdotEfLF+yNkafMvM3nvSGTXE=;
        b=fH/8M5lXV55CQpSnr5iBAhSWzGkESZuxCoSxJNMJGDWJM5DpVWrW9CM224/25m/JEl
         ievgI9Yy6P5OKcc/Pr8fr1G0uV72lNzuHL8Tsf9gyNoMN+KqasazVWO2ftVPjkx3Zz5A
         hAVyhfXfEKSVZ4VVlL+mrqRdlnzBL04kczJFSR0BepcvKXrfqRYpKyS3J9AziMEByDUj
         LIwADr4ep2lFdy2JbpM2VtTHxVxArNkFV5cHxdJmkR/IgPFAabXWiFa1MKS0FfbDYixD
         NpZQQUkeXrFpIIsfAWWJzLi5jvQolkrJui/gW0VhnetDbV1Yrz0KWAT0dWQJPT+8R5CX
         g47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fUQvT7RDTsjrM/n9IADdotEfLF+yNkafMvM3nvSGTXE=;
        b=IJU0rn/3j2XYqbpFJFfwo9QkjuEsnZk5l+NP9uhe7vPcgVx08fl1r52mdBUkIMUjwU
         0ooxXTDq4LFX1rUejt54zVqnEiUnUarqLA93mgSe41wiYYl2UzzeYs6+DGb5QZwUsPSl
         pTfPwEvayQqJmrqOyLIhtr6rhNhG0T63Z7aXeCsAKk0ocdyqjhstdyYJhfujih+GT/8R
         XEX5CEAw8fw3W0f1ZKjkjBXuOiJ89Cxz1uMsRbnkZKOowmheivUOD24TDJcjAaWa3zaC
         UQhqOpzJv+gunTmgFHmpl9QY9wn0atfOKJE+/CxQ0sBxEhLE5JaLyHVx3j4sBtJZonpc
         HrVw==
X-Gm-Message-State: AOAM530PVQg5zEXVrleXNaIheJpWaONEh+URaem12FvulHzT2vmWNmmy
        8buTJ7FV5eraG7hTJp4R1iYER5TN0F6Wrg==
X-Google-Smtp-Source: ABdhPJx0vUqlxlDaGN431NvwbVjva4x1ARdqQEMihew5wkzJFzSdNTgVzhtoY1btevmn5YFJx/iwyQ==
X-Received: by 2002:a37:aad8:: with SMTP id t207mr4044245qke.187.1619183356483;
        Fri, 23 Apr 2021 06:09:16 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.69])
        by smtp.gmail.com with ESMTPSA id a4sm4142613qta.19.2021.04.23.06.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 06:09:15 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, nathan@kernel.org, linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 0/3] Removed oprofile stale entries
Date:   Fri, 23 Apr 2021 18:32:58 +0530
Message-Id: <cover.1619181632.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series trying to clean out remaing debris of removed
functionality.Kindly see the commit : 24880bef417f(oprofile-removal)

Cc:viresh.kumar@linaro.org
Cc:torvalds@linux-foundation.org
Cc:viro@zeniv.linux.org.uk
Cc:hch@infradead.org
Cc:viro@zeniv.linux.org.uk
Cc:tglx@linutronix.de
Cc:gregkh@linuxfoundation.org
Cc:rdunlap@infradead.org
Cc:linux-doc@vger.kernel.org
Cc:akpm@linux-foundation.org

Bhaskar Chowdhury (3):
  Removed the oprofiled version option
  oprofiled version output line removed from the list
  Enlisted oprofile version line removed

 Documentation/process/changes.rst                    | 1 -
 Documentation/translations/it_IT/process/changes.rst | 1 -
 scripts/ver_linux                                    | 1 -
 3 files changed, 3 deletions(-)

--
2.26.3

