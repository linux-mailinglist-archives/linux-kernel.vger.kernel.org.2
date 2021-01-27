Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDAF305323
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhA0GVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 01:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbhA0F6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 00:58:46 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E25AC0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 21:56:56 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id lw17so2460926pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 21:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8HKDWEK8ExtdlsWay8OKrUEYUHkQ//vQexSJoiYU8YA=;
        b=TdPXHZ/2TpAVy+Zpq+FEn20zDnMqtnQqBjajkkFTID7dqzGPBe1HALdSl/quNqhSCV
         N0YCwRkxd4csKhF7xwn1nCcyysyPak9Y/+TeMtyjOjfYZ/Tax0u2q/dgc6EIMH344NmI
         UwQ8+pxzXZ/CT4WQiAiRRLI1HSeYG+xeQXVQL6su1SezSvgcMpu9l5cLF50wS/jBQ4cA
         sKVV3GqYGXBisP5FR7xgBj/EnNLqiqpQsy/Zkorq32exlBvcjSqCzCarJrxEx0/naYNT
         Mmy05Y+fQrlVjixWUsJjf978HFNMskWOJaHWscLBovB28rA6MTw2u7Sp4cfNQwqJyLmq
         U3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8HKDWEK8ExtdlsWay8OKrUEYUHkQ//vQexSJoiYU8YA=;
        b=fBD6gwi1Y0WGoBZDMHlmEPqpxTH5WzHV2iqKVeltsuPD/P9mdddhy2Jkj008pDXXi4
         H5AruBVD3iB9WkYgq7ojSOzfwccp3/uPt87SH1VYniLMR6XDoliHwONCmOGr5sj+sNNo
         g2GXLhzzbxnbKfgqVhVrMkJDrpDxPCxUDScbfe5+GV4u9US9Yvq9nakg4ViCQGgLRLOf
         FgUBh6RWh5Lb4rcpwv93fz6tvHvHJhgd0kPVZ9q3hRFzYyK2EN7Lfzia0bP6fcrG9dX7
         D5cKGTg1nJEfgWCjRAtKHRyXbYOVPsReput94WjSXw2zeplg7u5zb1Cm0qIzeSvdXa6G
         GSMg==
X-Gm-Message-State: AOAM532Huma519fHTbgvI8g+F4PK5fisPf1aEm6xVgMROmsPV0pnI/S4
        enTxP5FL5w7qZCLrUEZgPzUNFcUx08VOJQ==
X-Google-Smtp-Source: ABdhPJy8P4ltSydkIMUgoyE3IDr6/VeynofXBe1hmxUjJKVNEl1WYOljbwatwuTJt/Vrm+SuChvw6Q==
X-Received: by 2002:a17:902:e80c:b029:de:a20b:7a9c with SMTP id u12-20020a170902e80cb02900dea20b7a9cmr10005280plg.12.1611727016001;
        Tue, 26 Jan 2021 21:56:56 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id a25sm860040pgv.40.2021.01.26.21.56.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 21:56:54 -0800 (PST)
Date:   Wed, 27 Jan 2021 11:26:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH V6 5/6] of: unittest: Create overlay_common.dtsi and
 testcases_common.dtsi
Message-ID: <20210127055652.vmkx5sczef2mjwey@vireshk-i7>
References: <cover.1611312122.git.viresh.kumar@linaro.org>
 <94180731aa4a17e4834458a979de7de782dc73d4.1611312122.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94180731aa4a17e4834458a979de7de782dc73d4.1611312122.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-21, 16:20, Viresh Kumar wrote:
> In order to build-test the same unit-test files using fdtoverlay tool,
> move the device nodes from the existing overlay_base.dts and
> testcases_common.dts files to .dtsi files. The .dts files now include
> the new .dtsi files, resulting in exactly the same behavior as earlier.
> 
> The .dtsi files can now be reused for compile time tests using
> fdtoverlay (will be done in a later patch).
> 
> This is required because the base files passed to fdtoverlay tool
> shouldn't be overlays themselves (i.e. shouldn't have the /plugin/;
> tag).
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/of/unittest-data/overlay_base.dts     | 90 +-----------------
>  drivers/of/unittest-data/overlay_common.dtsi  | 91 +++++++++++++++++++
>  drivers/of/unittest-data/testcases.dts        | 17 +---
>  .../of/unittest-data/testcases_common.dtsi    | 18 ++++
>  4 files changed, 111 insertions(+), 105 deletions(-)
>  create mode 100644 drivers/of/unittest-data/overlay_common.dtsi
>  create mode 100644 drivers/of/unittest-data/testcases_common.dtsi

Frank,

As I mentioned in the cover-letter, I get a build warning right now:

drivers/of/unittest-data/tests-interrupts.dtsi:20.5-28: Warning (interrupts_property): /testcase-data/testcase-device2:#interrupt-cells: size is (4), expected multiple of 8

I think I need to add below diff to this patch to fix this warning, will that
be okay ?

diff --git a/drivers/of/unittest-data/testcases.dts b/drivers/of/unittest-data/testcases.dts
index 185125085784..04b9e7bb30d9 100644
--- a/drivers/of/unittest-data/testcases.dts
+++ b/drivers/of/unittest-data/testcases.dts
@@ -3,3 +3,14 @@
 /plugin/;
 
 #include "testcases_common.dtsi"
+
+/ {
+       testcase-data {
+               testcase-device2 {
+                       compatible = "testcase-device";
+                       interrupt-parent = <&test_intc2>;
+                       interrupts = <1>; /* invalid specifier - too short */
+               };
+       };
+
+};
diff --git a/drivers/of/unittest-data/tests-interrupts.dtsi b/drivers/of/unittest-data/tests-interrupts.dtsi
index ec175e800725..0e5914611107 100644
--- a/drivers/of/unittest-data/tests-interrupts.dtsi
+++ b/drivers/of/unittest-data/tests-interrupts.dtsi
@@ -61,12 +61,5 @@ testcase-device1 {
                        interrupt-parent = <&test_intc0>;
                        interrupts = <1>;
                };
-
-               testcase-device2 {
-                       compatible = "testcase-device";
-                       interrupt-parent = <&test_intc2>;
-                       interrupts = <1>; /* invalid specifier - too short */
-               };
        };
-
 };

-- 
viresh
