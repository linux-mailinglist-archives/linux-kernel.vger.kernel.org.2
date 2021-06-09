Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF443A119B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbhFIKyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:54:06 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:36791 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbhFIKxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:53:48 -0400
Received: by mail-pg1-f179.google.com with SMTP id 27so19128979pgy.3;
        Wed, 09 Jun 2021 03:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KEaFyO0J3q1vE6ElC6lKcHQeblQJLtnz+8yDeNcuW/E=;
        b=fyIfO17VfFhzcsDwfbpVqpJPypvqZOeDKBZHpp/VQ3fWAwO37dqzuD4xQymx8fNhfr
         zOnOeDB7j5lcPJXihCkS+38d/OSED1gde5a8HUNAvmO3r0b5pfuWXG/oWHRE3oEoH6HH
         RYSHeSFJC1JUGwt+KajRq7d+xBtKwAaUM/R1qdN83I/5QGsKhYQTwyHqdCjSzD0W8WKE
         5NV6erbc7/MgtodTDY41aCZFYuDX88VzLAQ8i8SQzHQWa6Yj227j88vBsXAZYdTdoVPh
         jPE9IXcoRr+tNRLdkp2FeyHvO0uxkOb30F6mJUdFTrN8p/RnQc6ROVLKEMUrqZmSR9WY
         ldww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KEaFyO0J3q1vE6ElC6lKcHQeblQJLtnz+8yDeNcuW/E=;
        b=SIUUhD7mCqZKQfGy46zwwytDZEsS3c3E8NZQtiOmMp6pejx00+288Va5Y01JPxsJwl
         Klguln4216jgciv/6/txd4kaJ8L/LIZvXqZ4oAVoJgvcEGa6BM9Tqul6beaaRAK3kPqV
         n+1hS0OB3W209rm4SWIMX75rMvURuyHdraeuXKgwuOr9Bj1c0+jtSfhnsJ0E44+g/8oj
         iXs3m7Z1VfavrCenzb/vCbXfUi+3llfLqPmQ1lwGpXPhy4mk0sGYNF8kILdgZFPyNnkR
         vAj6LbtrC3Qnbgrw7cvgJHcrX/5KnpjZbhiTiN4B2lv4BC2VPGm08mhDOuQzXWQEwquI
         C1SA==
X-Gm-Message-State: AOAM530SwL1lRtJnDkODeQ/XQDO+nH1xraPcMYELSugY4fmkTTfhtRNC
        U7ScyOq/l3E+RRb0sO9knfgDCqiwtV9Oyg==
X-Google-Smtp-Source: ABdhPJxwpVXt3HmXcb4pLsiVz5iGLahwilSDaZqnPxARlHbyYJ/0haWlmbhtEzmMF38sG4iwDUhZig==
X-Received: by 2002:aa7:9613:0:b029:2ec:9eea:cc4c with SMTP id q19-20020aa796130000b02902ec9eeacc4cmr4504307pfg.12.1623235841123;
        Wed, 09 Jun 2021 03:50:41 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id u24sm13877940pfm.156.2021.06.09.03.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:50:40 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org
Subject: [PATCH 0/5] kprobes: Bugfix and improvements
Date:   Wed,  9 Jun 2021 19:50:14 +0900
Message-Id: <20210609105019.3626677-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently while staring at kprobes code for an unrelated task, I
noticed some opportunities for improving the code.

The first patch fixes a long standing bug in kprobes debug
functionality. The remaining patches (marked RFC) refactor the code to
increase code sharing, improve readability and remove redundancy.

All feedback welcome.

Thanks,
Punit


Punit Agrawal (5):
  kprobes: Do not use local variable when creating debugfs file
  kprobes: Use helper to parse boolean input from userspace
  kprobe: Simplify prepare_kprobe() by dropping redundant version
  csky: ftrace: Drop duplicate implementation of
    arch_check_ftrace_location()
  kprobes: Make arch_check_ftrace_location static

 arch/csky/kernel/probes/ftrace.c |  7 ----
 include/linux/kprobes.h          |  7 ++--
 kernel/kprobes.c                 | 58 ++++++++++----------------------
 3 files changed, 23 insertions(+), 49 deletions(-)

-- 
2.30.2

