Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A3C388808
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbhESHVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbhESHVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:21:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F580C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 00:19:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so3013201pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heLMK1eVMd9vz01zbjzMSRH/Wv+AZ6MgS42nN+leRL8=;
        b=XjbDchF23I2Bo56VloArkfZQPG+SkQmBadJ5nE5rEJ0YOcRju17csGqJmZ84opweJy
         c9T9sHYCTv78MMSMKQuquxH3ebgC0VhhUWb3n5z9yYBRRCaXHQslFleBbmmPDR5kfciD
         vNybNIgVuIbUptlBWJijwWURr6eiYaeQHd7kBK+l+4aRIjzlpMYbIVwSvlmS+2uTWspl
         R5iyYcvf0HXkJmMST9QjzeRnz2wKQjligSoeP1yQgzB8Gq++E6mWb8gxvJXMP+bGlQpH
         J0L+L2P3LBC69KwjRF9v2M2R8JfjpndY2JqrPIGTDt0tdgHMvMmdNycZKbL3N3jmNb+U
         zqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heLMK1eVMd9vz01zbjzMSRH/Wv+AZ6MgS42nN+leRL8=;
        b=es8DlrysjdCTkPkag1ImFXoRi/d0u3JV70GvKnHLcQqLIZWltoFAfr7+JjOU+61VqS
         hMVBGjw1yaU+waSP3yiDYAgXYoB0/o68WsAoqEYKjowQEo2Zek4MbSz7eoGiS/3EC2p9
         vsdCEQ83NuplkQD2DpamTefueQWWFguUQE5C0LdUinFBduxGFX9bfb/LCDEZvbk0axwn
         M+lf9ckjFRGdoANwOyABCx7yuovsudOb6FDflsD/2jfNb105s5RFYMfO+rm6rf/x8LUq
         DIRjJjCi4E1lckguPwMYwufn9kZCP4N2mBuFZCT6kbj+7nMVCswiEgE/Q/dZlfe8rTos
         sS8w==
X-Gm-Message-State: AOAM5303QyTrTYeF5YF6gHaoWE24SNSgdBoZvQugvLi+CxgZEX0qEcYJ
        11iHNgAAQ/ek6iMZ83c8gDS2GA==
X-Google-Smtp-Source: ABdhPJzsnkXIAqnGpb2P78SYG5OsZrFZjbzFBEaoM5bed8mXbJBTf7ascukMOrEQKyhdRY6fM+fsuw==
X-Received: by 2002:a17:902:a70f:b029:ea:d4a8:6a84 with SMTP id w15-20020a170902a70fb02900ead4a86a84mr9345467plq.42.1621408786017;
        Wed, 19 May 2021 00:19:46 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id q9sm3435974pjm.23.2021.05.19.00.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 00:19:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 0/5] perf arm-spe: Enable timestamp
Date:   Wed, 19 May 2021 15:19:34 +0800
Message-Id: <20210519071939.1598923-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to enable timestamp for Arm SPE trace.  It reads out
TSC parameters from the TIME_CONV event, the parameters are used for
conversion between timer counter and kernel time, the calculated
timestamps are assigned to Arm SPE samples.

This patch set can be clearly applied on perf/core branch with:

  commit 046b243a6afb ("perf x86 kvm-stat: Support to analyze kvm MSR")

The patches have been tested on Hisilicon D06 platform.

Changes from v4:
* Dropped the change "perf arm-spe: Remove unused enum value
  ARM_SPE_PER_CPU_MMAPS" for format compatibility (James).

Changes from v3:
* Let to be backwards-compatible for TIME_CONV event (Adrian).

Changes from v2:
* Changed to use TIME_CONV event for extracting clock parameters (Al).

Changes from v1:
* Rebased patch series on the latest perf/core branch;
* Fixed the patch for dumping TSC parameters to support both the
  older and new auxtrace info format.


Leo Yan (5):
  perf arm-spe: Save clock parameters from TIME_CONV event
  perf arm-spe: Convert event kernel time to counter value
  perf arm-spe: Assign kernel time to synthesized event
  perf arm-spe: Bail out if the trace is later than perf event
  perf arm-spe: Don't wait for PERF_RECORD_EXIT event

 tools/perf/util/arm-spe.c | 73 +++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 10 deletions(-)

-- 
2.25.1

