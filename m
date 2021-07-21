Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DD13D06B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 04:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhGUBpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 21:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhGUBpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 21:45:01 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDF1C061574;
        Tue, 20 Jul 2021 19:25:37 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so735631otf.9;
        Tue, 20 Jul 2021 19:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQbKiPljTN+dTTqnrZPdPRJjVjeBdFaZnk4JQaGq1zQ=;
        b=JCEat75fKEzfQ7CKyaKAXEfCmZRdm+vRtxG+t54attinN4iAncmlEdjZxH7hVChZLC
         bZEWElIQgO57idUoj0rkD40KwvsD/4ttSfpA4GHWXkFwvndWUDyHrndclo+PvC633JIO
         JhDIh58J4Q6kKq44JXPPs2J4xVBiHXlDLpv+FSNC7dHEuGpjNgCnnCsLtGcDVI4rbwO8
         k1JJ9sCeOVx08zmjRYYiUWqT+g1JAX6gXsj/aYhAfmca2kC1NqSrvopqr6rhlXCGW6zd
         AqzzmdE9aOx1dpnYYOO6aM7PrH3ZsYyDun2P4VFg4UuPkKADpNvYH8v5JYtiAdbGc/Ho
         jLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQbKiPljTN+dTTqnrZPdPRJjVjeBdFaZnk4JQaGq1zQ=;
        b=B5r2aRcxGTS3IqOin49DjAN6SjUCh1OQTjohPeT84Utwp+OZHzlWI9JhYR0zdV33u8
         8GYCGxs+CoBG7dQUtAsv3UHlSUIOheW9lOcGC8Y665kGH0xK/+C0BkECwcLgyOxPZGoN
         Ga315v65a3mlSs0spFuTBCI4Jk1RQC1rPcFN4kzZlio/6lKO9Z0Uf8w6QDtEAkHx2pnq
         ig7p5OKrWCcRRDVABo+emyKbQOxmbNin1I8U9Jdp5idYevq69MKija9umc45TwgKTnQy
         AJttQNlDleFnG906gO2d1s+xILWTRhr7vEBvRkWcpXCk159S2Yuhz/A+/Ta55HB6cToQ
         tsrg==
X-Gm-Message-State: AOAM5338EgxzfbN7hUxRTWuKFIZyjvc+LjMY12U8u6yD4ToRVQ90Sn8q
        kufOyA7bgzwbCf9NeDTrOt4Hk/MwJAB9Gyms5WU=
X-Google-Smtp-Source: ABdhPJxqYqFY+81HyhGe4/n70beD2IZbljBQCgVjmf9vJoBbJHoEgfttiEsfCM246QFnUkO1YmP0TA==
X-Received: by 2002:a05:6830:2316:: with SMTP id u22mr24620555ote.90.1626834337093;
        Tue, 20 Jul 2021 19:25:37 -0700 (PDT)
Received: from localhost.localdomain (c-98-249-124-70.hsd1.nm.comcast.net. [98.249.124.70])
        by smtp.googlemail.com with ESMTPSA id v5sm2542722oor.33.2021.07.20.19.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 19:25:36 -0700 (PDT)
From:   Brett Holman <bholman.devel@gmail.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf mem: Standardize \'perf mem\' arg parsing
Date:   Tue, 20 Jul 2021 20:24:41 -0600
Message-Id: <20210721022442.159436-1-bholman.devel@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first time contributing here, please let me know if I
missed anything.

To compare the commands tested, use the following:

strace -f ./perf     record foo -pv bar 2>&1 | grep -a execve
strace -f ./perf mem record foo -pv bar 2>&1 | grep -a execve

Before this patch, note that '-pv' is stripped out of the command under
test for 'perf mem record', but not for 'perf record'. This patch makes
the behaviors match.


