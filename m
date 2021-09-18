Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAAE41075C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbhIRPcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 11:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhIRPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 11:32:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1C8C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 08:31:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id s24so9588317wmh.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 08:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2BhFmnpO/DswZ6lwsZOApEaVJnwjYMNKPSOmrPr5COM=;
        b=So40fcbmGuBlLAus4DtqiHHQ5vdTKmDkFLnV5gYvJ0YFE8Pntybwv4RQ3E1Gl03VL4
         G39wP7LYCkufDLbq0BjQ28snHJVpdTgWnjbqVdYcKXsRN0IU+5dQMrxBhtlSsbzY1JfF
         gSK4ePF67yv7sAMcRapHCmQ/TfYTMgCWsSp+ssaEsKdhNNRpadQIrqtSEWlvg22XgLNK
         uQmvei/6eu9znX5tJvaVzn152p5Y+8Fd5efr3bu+G+dpkqkqmUPy9oP37B1O35X9j85n
         Hff+k6Rwfv9FvOp87T6tn/lR5iDGLR+wIeT3jwE14hH8vrT739MZ/nk1bbO3jCA9uwmx
         IRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2BhFmnpO/DswZ6lwsZOApEaVJnwjYMNKPSOmrPr5COM=;
        b=GaK2+dkjJKfPHoEhYul8W1TeIlKfmlgjKW2tpZ8SMjEXz+HaqhlicXf70H2ZgUfaj5
         D4QUElF3OMuvmvFdOQDsp4xfKgtcPtRqzb16BvUGMApOkEnby+a5kybywwaC/Rt2BoAR
         Dur7LcTjq9Q/uM5YoWSEXfYjm3+mM43gSwUXzIh6DYSbkHVOUZNKXMaeSNkUtbp38LE4
         RCXUJu3SZq2cedjp7hovEjBwJfly9CzcakiE5Z404XMdBq2RkErhjNfWt20mPyOnkl0A
         n6EsdvEorSs7Atqa076Z2IjhHvOskJCxu0cO6Vrt1Umvzv+rlTYcY4sysrTzTz0EiGJZ
         I0og==
X-Gm-Message-State: AOAM533WqLm+eumGj2GU1qVUhYLmlF4tMMYPXNWE1PWWlQ2/q3us+beT
        nF6fNLbYhc+fd5I4eh8LGwY=
X-Google-Smtp-Source: ABdhPJxJwDDmbxu03shHjj33UebKdjFwxRUwG8hHI9K3Nv+2hCQUAiC9hP3rWLXvmXNtiV6TY78cdw==
X-Received: by 2002:a1c:1fd3:: with SMTP id f202mr20800749wmf.44.1631979088611;
        Sat, 18 Sep 2021 08:31:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:8f8:1127:62fc:cf28:f9:da98:9620])
        by smtp.gmail.com with ESMTPSA id q201sm15548999wme.2.2021.09.18.08.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 08:31:27 -0700 (PDT)
From:   Carles Pey <carles.pey@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Carles Pey <carles.pey@gmail.com>
Subject: [PATCH v2 0/1] ftrace: add unit test for removing trace function
Date:   Sat, 18 Sep 2021 19:30:42 +0400
Message-Id: <20210918153043.318016-1-carles.pey@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds a basic startup self-test for removing a traced
function.

Being kallsyms_lookup_name made unexported there is no easy use of
ftrace_set_filter_ip from kernel modules, leaving with ftrace_set_filter
as the way to set trace functions. The ftrace_set_filter API is not
explicit on how to remove trace functions, and there is no such use case
either in the kernel source-tree for which I decided to add an example
of it use as a self-test.

Changes since v1:
 - Added changelog and sign-off line.

Carles Pey (1):
  ftrace: add unit test for removing trace function

 kernel/trace/trace_selftest.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
2.26.3

