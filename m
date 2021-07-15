Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C761C3C959C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 03:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhGOBgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 21:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhGOBgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:36:48 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D2CC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:33:54 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id e19-20020ad442b30000b02902dc988b8675so2987861qvr.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8vnGhtmp+njtNtIuKwFZim7rfIp3lR+vOjiRHXUJKyQ=;
        b=FtVARWUY3U8/9Tw4oLPAphMR3pXqBM60v7dYlimahcB70OGTYW8bslo/9wNAXlFI46
         y22CdMWEZVZaw/xZpduxvuTcA9WTxKSwMCBvw6xh7vscbm3aZNrVpBOI6yk4DJqPMTSq
         8FsPf9s36iTloS5gBmOUBHtek2X1XFCx/mvCmGlpGeA6pcOnzeY03cU20vakLfX/FfYF
         iATRuajUrB2xiDkEo0OF7eDMjB9+Yh10SFXV87f/Yi02TkB8gWMU4AjV7siy7YcI7Js3
         +OdGfKfe4jC6GvJZ2GJREsSfVFXgNPNVm25oqdgLkyDYNBu3K93Ydza8w4f7IhYQga85
         ZyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8vnGhtmp+njtNtIuKwFZim7rfIp3lR+vOjiRHXUJKyQ=;
        b=Vh7V5YjLqZJXfGz8oc/FejLiQFA2+5yX/hSfS6Ziyx6L00cRy4vBzuKD5chidLue2/
         KytIs6M1xyuEUACU0xhtw6uClDifMbIi6uIRk1YhSUsR74walYBBqK72uksHKL95AJtE
         Y17NAYGY1vk76ZlAatHHndgE1djNlHwLeYjWAkeuKGWDNnYfi8Z2CHUazM+EMyf+joaR
         aMh4QwI8faG64yNKmLKQc1v4wBAuRLaaFl0V45S47C44uXP8sr6OXsi/6TolTvNzDAB3
         QGnJKvU0c8Kxt5jD978NwMN31FnlTlakTU/KgACxfYTgcuCn0UihCBQDmigFvCiKku00
         yLnA==
X-Gm-Message-State: AOAM530XgXa8SvaIkCgewd9bZJwjkJtyFHjOLGU+NRK1dcg8miU25gY+
        jxTZGdYywtVbrFawJjMj9EsT1bLpoMhz
X-Google-Smtp-Source: ABdhPJxUUNr0W3XsmB5xISQcI8yr8AX+7mp+8KI4DxlCKSI8oq0R1FwhPnhrhA7lYo2TKDZ0wgkv/2OtvDyO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a05:6214:13c8:: with SMTP id
 cg8mr1210074qvb.23.1626312833833; Wed, 14 Jul 2021 18:33:53 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:36 -0700
Message-Id: <20210715013343.2286699-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 0/7] Tidy perf Documentation build
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf's Documenation Makefile is based off git's, but some parts of it
were never completed. 'make info' also fails. These patches fix 'make
info' and do some related tidy up. Two missing files are added from git.

Ian Rogers (7):
  perf doc: Fix perfman.info build
  perf doc: Fix doc.dep
  perf doc: Remove references to user-manual
  perf doc: Add info pages to all target.
  perf doc: Remove cmd-list.perl references
  perf doc: Remove howto-index.sh related references.
  perf doc: Reorganize ARTICLES variables.

 tools/perf/Documentation/Makefile          | 74 +++-------------------
 tools/perf/Documentation/build-docdep.perl | 46 ++++++++++++++
 tools/perf/Documentation/cat-texi.perl     | 46 ++++++++++++++
 3 files changed, 100 insertions(+), 66 deletions(-)
 create mode 100755 tools/perf/Documentation/build-docdep.perl
 create mode 100755 tools/perf/Documentation/cat-texi.perl

-- 
2.32.0.402.g57bb445576-goog

