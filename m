Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6B144AF28
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 15:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhKIOJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 09:09:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230283AbhKIOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 09:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636466831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6HrMco/R0NUD57OxTvVAWvFQ91tOHioQPvFqP/WswDk=;
        b=Gqx7G8v3CVl08FFdB/9DIMSmMKWW+pPsX3jBJxtu3Tq6WdYNDwar3iTbIlTje3xuTyM362
        pQKpVvvMNB6shqXL8cFiUONHbHMbu7AvVDg+M20mh8yFQw2sGrH4XfJwnrHFepIRvYAnHj
        ZmVWe9kqnAVyVmEqAnYZqNE0gOdBrY4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-tMxn7MTeMLyOo3LkXmgcrw-1; Tue, 09 Nov 2021 09:07:10 -0500
X-MC-Unique: tMxn7MTeMLyOo3LkXmgcrw-1
Received: by mail-wr1-f69.google.com with SMTP id p17-20020adff211000000b0017b902a7701so4822824wro.19
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 06:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6HrMco/R0NUD57OxTvVAWvFQ91tOHioQPvFqP/WswDk=;
        b=7ffTmR4SzcgAi9OuYs/LL2JzxBqdGI+O+7iTFLIe2V+M2c+PRI2CNxK4ZYSPPAgiMV
         ACoRUH/IH8rmd2sLxRdw8AvLmAUK264u9mafMY/n2vO0G8wXLzmTbBRkwz7nGrtXISbj
         gZmw8UG+xnAxzDOzNbAdiUOGrfmXCefscJbykNvVRJ0/OrfMf/1uDWEBnJdPIhQ5eR18
         gzn0WLs47NtlythcPDFiQV6uqR6A/epLGXlMsViKIyrnfTjIHT0XXFseMdHlSENy9MAS
         Abw4qh7I/ZtIskyUhboaVq3GIQxVOT1e0rnemZ10A8HptZaAykOIlEp/9Cl0qY1K1ytp
         DAGQ==
X-Gm-Message-State: AOAM53141noJnvTsUwX00vR4UbI615rZQPVJoDWhORnar0iSF7E+8E9V
        m/eOW69k4dM7v8Imb1HDPWQgVFCYZnUnEaMz54wLY+Mombr/Y4GULKrNX74NYJT/F4EAM8Si2w9
        P/yGwDFlPbdxr6Nkp0xEMLlRO
X-Received: by 2002:a5d:460d:: with SMTP id t13mr9562270wrq.44.1636466829311;
        Tue, 09 Nov 2021 06:07:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaP3JI+F3utXxRMEWygfnuHNjAmS3H+yQwa9Je6KMvLAT6PSUOSZqkXEDwKRAQziCXRmv2DA==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr9562242wrq.44.1636466829164;
        Tue, 09 Nov 2021 06:07:09 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t189sm2762136wma.8.2021.11.09.06.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 06:07:08 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 0/2] perf tools: Fix perf build with dynamic libbpf
Date:   Tue,  9 Nov 2021 15:07:05 +0100
Message-Id: <20211109140707.1689940-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending fixes for building perf with LIBBPF_DYNAMIC=1.

We hit the window where perf uses libbpf functions, that did not
make it to the official libbpf release yet and it's breaking perf
build with dynamicly linked libbpf. Fixing this with adding weak
stub functions for possibly missing libbpf function.

thanks,
jirka

---
Jiri Olsa (2):
      perf tools: Add more weak libbpf functions
      perf tools: Add weak variants for the deprecated libbpf functions

 tools/perf/util/bpf-event.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

