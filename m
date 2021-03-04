Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E73B32CF3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhCDJD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbhCDJC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:02:59 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE430C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 01:02:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jt13so47933940ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7KgXY0PwJEcnJjBThvLtaDq7rpiFy8Hyxipx+DFayM=;
        b=DyaGq26iniFxs2MsnavbQc/3NXQ3VhEGKZfPrzTUKrSZbMu0CG3hDpMI4tO0OINzfa
         Rb5CZEsE/Khj321tcRmbScEa2UytOXvmqADOTJLQx6X3x4gS6oHxRJ+7sGvx/mD4d9kG
         8ixe0agM/RDFBUqbIbW9Beu5Tr0VfmDui4Ea0E8KeuG5pifiyplseRojaGeX1/39KrI2
         o+Zymy4zEm0LJlEvtylxXXnSLujjUSrvTid/YJ03vQiD8jABQkCsWHv2v9JGsHeOjFt3
         2MUw3ILN1fQKtH/ohbxAsrDbYljpbE4JHyDqYGXUZTfJHQefwM/DDtywPqC4Yj2qEr3j
         kydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7KgXY0PwJEcnJjBThvLtaDq7rpiFy8Hyxipx+DFayM=;
        b=Ad2vDJDOsXShyI5PNew9YwLKubUKil3C/42OrHIsCcLgUxPTpW3hkcJhW6U1QVQ834
         FlfZdXuvDXVJBqyj6ge7DCXKtqPMId45ejwNTaX3PNslIc/07lZwDwpa5uUz0yXkCXTG
         oEG9Y04VPnSIwtmYnshCL6cQA6sQhf70QRsv07zAmXZHZhCeb9noD1OUrn4PYnH0VaEq
         haUnteOhQD1TTHCh4GGHEsYseatIzZN3RVa2gWG6dZpgZotSLDvnvrSklhRvvo40kjMz
         rCf6XXT69SfbI1ZFBLKPm6OkSevNa0oRQzqFdd7Rz40i+MWrA6F7ikViuFzHFXReZI5T
         TiuA==
X-Gm-Message-State: AOAM533WAweBBSQsY6S7v1+XAM4Pwq2t/8WyUGHJqhQB/QsDHPJQhsWK
        7wMQZEMsBYTY3eiayZkiMGAWoT43Kbkd5w==
X-Google-Smtp-Source: ABdhPJxcQG4XwLHFAYb6jfnoSDDX0dsEBSniTC8R768L88yWYFTkGKpWAVBydsYdt1OatI65J81vyA==
X-Received: by 2002:a17:907:9870:: with SMTP id ko16mr3122111ejc.227.1614848537316;
        Thu, 04 Mar 2021 01:02:17 -0800 (PST)
Received: from localhost.localdomain ([95.87.199.88])
        by smtp.gmail.com with ESMTPSA id f22sm23123552eje.34.2021.03.04.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 01:02:16 -0800 (PST)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [RFC PATCH 0/5] Add "func_no_repete" tracing option
Date:   Thu,  4 Mar 2021 11:01:36 +0200
Message-Id: <20210304090141.207309-1-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new option for function tracing aims to save space on the ring
buffer and to make it more readable in the case when a single function
is called number of times consecutively:

	while (cond)
		do_func();

Instead of having an identical records for each call of the function
we will record only the first call, followed by an event showing the
number of repeats.

Yordan Karadzhov (VMware) (5):
  tracing: Define new ftrace event "func_repeats"
  tracing: Add "last_func_repeats" to struct trace_array
  tracing: Add method for recording "func_repeats" events
  tracing: Unify the logic for function tracing options
  tracing: Add "func_no_repeats" option for function tracing

 kernel/trace/trace.c           |  22 ++++
 kernel/trace/trace.h           |  24 ++++
 kernel/trace/trace_entries.h   |  16 +++
 kernel/trace/trace_functions.c | 219 +++++++++++++++++++++++++++++----
 kernel/trace/trace_output.c    |  44 +++++++
 5 files changed, 298 insertions(+), 27 deletions(-)

-- 
2.25.1

