Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D867530EE24
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhBDIPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbhBDIPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:15:10 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C544CC0613ED
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 00:14:29 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y142so1641158pfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 00:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X41ZVpkm4N3FHW1l7EM/KlfjzpLXKJMjAogx1w2NMzw=;
        b=deuWGVTk8lcuam/3+G2HtN0HD8YFeWkivhhyZ86Dq/tn1C9LXgbar8ajvaPlpvCF04
         aLULln21el5/h1Wbd/G9i3NEqH8rH7iQ5VXTQ4Xmm7zcbQo/tpJKiZUCkwOJMgb3+y0X
         adZx7YViNQAfQvT+ZBlNeV5DRVZ5gHFLd59j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X41ZVpkm4N3FHW1l7EM/KlfjzpLXKJMjAogx1w2NMzw=;
        b=iYQgdR7AFyJIve0RPTZV2C5DuhwViONUJvT/SicY1lkMHnOvsLaSvQjK8474gAOZc3
         Z/pP/3mc5mAS6k6kFYSrkyXeFQXX6LsBgoTGu2uJefaBuHEcFTo8O84VNd8kAZwSfmsz
         ezNP9M07uLCt1YPyD0ad63rov2A6ghseAu1+OTOocGrh6FBOw470EXVDCMG5fp7qYEkK
         8WUf8XLdGFtOxfxMPXvp/577vV/ZIBBRWREVtHxwoUECN1/8Gda3u/GCfE2DsIMIvfUr
         7VNs2hHvgVwdRTHy9VM98RkUYWmKm7aJx0B0ccmMy8Vitrv+rmpeIKRf3JPBpSAsdlTk
         Spgw==
X-Gm-Message-State: AOAM533DcJoNUqKQQq0xVh3DymER997+mfy65klhH3fewo/jY7MR5dfB
        aezrGSf6FUs+XVWOc1eZsRmOmQ==
X-Google-Smtp-Source: ABdhPJx6HQaIlvGtLQ0Jj2RFHTgKw7dQej0JpeKIzqm53d6NckluV7ll0BiijAafN3TSR124+3bM2Q==
X-Received: by 2002:aa7:80c6:0:b029:1b6:92ae:a199 with SMTP id a6-20020aa780c60000b02901b692aea199mr6878721pfn.71.1612426469239;
        Thu, 04 Feb 2021 00:14:29 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ed70:6d43:9c6a:2e22])
        by smtp.gmail.com with ESMTPSA id e3sm5091258pgs.60.2021.02.04.00.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 00:14:28 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v6 0/3] Add required-opps support to devfreq passive gov
Date:   Thu,  4 Feb 2021 16:14:21 +0800
Message-Id: <20210204081424.2219311-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq passive governor scales the frequency of a "child" device based
on the current frequency of a "parent" device (not parent/child in the
sense of device hierarchy). As of today, the passive governor requires one
of the following to work correctly:
1. The parent and child device have the same number of frequencies
2. The child device driver passes a mapping function to translate from
   parent frequency to child frequency.

When (1) is not true, (2) is the only option right now. But often times,
all that is required is a simple mapping from parent's frequency to child's
frequency.

Since OPPs already support pointing to other "required-opps", add support
for using that to map from parent device frequency to child device
frequency. That way, every child device driver doesn't have to implement a
separate mapping function anytime (1) isn't true.

Some common (but not comprehensive) reason for needing a devfreq passive
governor to adjust the frequency of one device based on another are:

1. These were the combination of frequencies that were validated/screened
   during the manufacturing process.
2. These are the sensible performance combinations between two devices
   interacting with each other. So that when one runs fast the other
   doesn't become the bottleneck.
3. Hardware bugs requiring some kind of frequency ratio between devices.

For example, the following mapping can't be captured in DT as it stands
today because the parent and child device have different number of OPPs.
But with this patch series, this mapping can be captured cleanly.

In arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi you have something
like this with the following changes:

        bus_g2d_400: bus0 {
                compatible = "samsung,exynos-bus";
                clocks = <&cmu_top CLK_ACLK_G2D_400>;
                clock-names = "bus";
                operating-points-v2 = <&bus_g2d_400_opp_table>;
                status = "disabled";
        };

        bus_noc2: bus9 {
                compatible = "samsung,exynos-bus";
                clocks = <&cmu_mif CLK_ACLK_BUS2_400>;
                clock-names = "bus";
                operating-points-v2 = <&bus_noc2_opp_table>;
                status = "disabled";
        };

        bus_g2d_400_opp_table: opp_table2 {
                compatible = "operating-points-v2";
                opp-shared;

                opp-400000000 {
                        opp-hz = /bits/ 64 <400000000>;
                        opp-microvolt = <1075000>;
                        required-opps = <&noc2_400>;
                };
                opp-267000000 {
                        opp-hz = /bits/ 64 <267000000>;
                        opp-microvolt = <1000000>;
                        required-opps = <&noc2_200>;
                };
                opp-200000000 {
                        opp-hz = /bits/ 64 <200000000>;
                        opp-microvolt = <975000>;
                        required-opps = <&noc2_200>;
                };
                opp-160000000 {
                        opp-hz = /bits/ 64 <160000000>;
                        opp-microvolt = <962500>;
                        required-opps = <&noc2_134>;
                };
                opp-134000000 {
                        opp-hz = /bits/ 64 <134000000>;
                        opp-microvolt = <950000>;
                        required-opps = <&noc2_134>;
                };
                opp-100000000 {
                        opp-hz = /bits/ 64 <100000000>;
                        opp-microvolt = <937500>;
                        required-opps = <&noc2_100>;
                };
        };

        bus_noc2_opp_table: opp_table6 {
                compatible = "operating-points-v2";

                noc2_400: opp-400000000 {
                        opp-hz = /bits/ 64 <400000000>;
                };
                noc2_200: opp-200000000 {
                        opp-hz = /bits/ 64 <200000000>;
                };
                noc2_134: opp-134000000 {
                        opp-hz = /bits/ 64 <134000000>;
                };
                noc2_100: opp-100000000 {
                        opp-hz = /bits/ 64 <100000000>;
                };
        };

-Saravana

v5 -> v6:
- fix review comments

v4 -> v5:
- drop patch "OPP: Improve required-opps linking" and rebase to
  https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=opp/linux-next
- Compare pointers in dev_pm_opp_xlate_required_opp().

v3 -> v4:
- Fixed documentation comments
- Fixed order of functions in .h file
- Renamed the new xlate API
- Caused _set_required_opps() to fail if all required opps tables aren't
  linked.
v2 -> v3:
- Rebased onto linux-next.
- Added documentation comment for new fields.
- Added support for lazy required-opps linking.
- Updated Ack/Reviewed-bys.
v1 -> v2:
- Cached OPP table reference in devfreq to avoid looking up every time.
- Renamed variable in passive governor to be more intuitive.
- Updated cover letter with examples.

Saravana Kannan (3):
  OPP: Add function to look up required OPP's for a given OPP
  PM / devfreq: Cache OPP table reference in devfreq
  PM / devfreq: Add required OPPs support to passive governor

 drivers/devfreq/devfreq.c          |  6 +++
 drivers/devfreq/governor_passive.c | 25 +++++++++----
 drivers/opp/core.c                 | 59 ++++++++++++++++++++++++++++++
 include/linux/devfreq.h            |  2 +
 include/linux/pm_opp.h             |  7 ++++
 5 files changed, 92 insertions(+), 7 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

