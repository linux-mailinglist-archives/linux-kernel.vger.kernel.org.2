Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECD839F195
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFHJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhFHJE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:04:57 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5128C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 02:03:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s22so5599653ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 02:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0ds+l2wwmikGBIkarzC+RWkNxvJMelGG4IknEWp7ak=;
        b=QzWpE4d7Czo3Zzuvhv+Wm8SOjKM7edThMVzlJK8RuUE5nNdoUEl19aWE/sd7LJmDHJ
         VqKCUb0i6PoLbvwyCMdn1VDa7/12/HC0sX0CyTwfcQgofGUxwmOY6YgoMa4J8armXTDn
         Jemd4DUXYbGk5wjagB0xfxRN/IIdjw1HWDjwNwFFMNbSnCA+s/WWOwZ1C+XkH5sN4nlm
         Sx8R1byKEXnCGlAClEtDjrPJJiL9xxPGswV/Z8x/EGAGVU/Lijv5j4QTCUXfqJdPvQ/k
         A6MmbefYfSU/d7S32LbjloQfzUELzcIHsB+ty+To3ojyeGIM6fvi7luoHXiA8treZv9K
         xbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0ds+l2wwmikGBIkarzC+RWkNxvJMelGG4IknEWp7ak=;
        b=jWDoAhQYNcI62VIdF0E19ytCZO09NwD2MWa2woswpfnm3+SHjcUmr9Lz+lR7+Ob5jy
         qhIVwTuQNKaBuCGv+5gTm1wzbdk7ubVD6FBJUfZrlIcTVOSVktntLEi4vx5cxDEVMAXO
         wRjWaECK1CuzQ5rB5eIR3I82i/F7VRkt1tVfnCXXni3ir2PCR2DTzhmiIIwzV2mlTZIB
         rCoN/+OQzipJr2WeZINGG7nckR2Jxinv/+LgB8njyhDCduQI7A/1l2TKUsX61ajYBFA3
         qohns96H6ejs6aGLn1VFsES7VFMRDgMCKSE+cgRLLYoqhnUKiPsj8rMO6lQ2dNPJ2EQL
         wcuQ==
X-Gm-Message-State: AOAM531lybtN9+83zf+kUEWACJXVC40zb9NjxVFwVejLoysY+Gm29TW+
        9zjhlWemGdGgprmT2gieAIv6ew==
X-Google-Smtp-Source: ABdhPJwkH3G8ZdlvfKKYqYu8Q01goGfnSxTrJLfHwYUX4RxNytFLFgCXQO7z+MAGuPyDCnsi8X9ewg==
X-Received: by 2002:a2e:8817:: with SMTP id x23mr17928556ljh.17.1623142982721;
        Tue, 08 Jun 2021 02:03:02 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id n17sm1295197lfq.118.2021.06.08.02.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:03:01 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] PM: runtime: Update behaviour for no callbacks
Date:   Tue,  8 Jun 2021 11:02:47 +0200
Message-Id: <20210608090250.85256-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing a patch on the mmc-list, I ended up inspecting the behaviour of
how we deal with the no callback case for runtime PM.

A couple of observations:

*) When pm_runtime_no_callbacks() have been called, it allows the PM core to
takes a quicker path, but at the same time, consumer/supplier device links are
being skipped in rpm_resume|suspend().

**) Calling pm_runtime_no_callbacks() to avoid boiler plate code (assigning
empty functions to ->runtime_suspend|resume()), doesn't work if there could be
consumer/supplier device link being used or a platform dependent PM domain that
could get attached to the device.

Therefore, this series suggests to change the behaviour in the PM core, to
allow the ->runtime_suspend|resume() callbacks to be unassigned. This is already
supported for ->runtime_idle() callbacks, so it would also move things into a
more consistent behaviour.

I have looked at various error paths, in the kernel of callers of
pm_runtime_get_sync(). I couldn't find anyone that made sense, that looked for
the special error code, -ENOSYS, which is the error code getting returned when a
callback is missing. Whether that is sufficient proof that these changes are
100% safe, I can't guarantee, but I think it would be worth a try as the
benefits of avoiding boilerplate code and the corresponding additional code
paths are quite nice, if you ask me.

Kind regards
Ulf Hansson


Ulf Hansson (3):
  PM: runtime: Improve path in rpm_idle() when no callback
  PM: runtime: Allow unassigned ->runtime_suspend|resume callbacks
  PM: runtime: Clarify documentation when callbacks are unassigned

 Documentation/power/runtime_pm.rst |  8 ++++++++
 drivers/base/power/runtime.c       | 18 ++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.25.1

