Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525EF333318
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhCJCW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:22:56 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:39697 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCJCWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:22:33 -0500
Received: by mail-il1-f176.google.com with SMTP id d5so14117255iln.6;
        Tue, 09 Mar 2021 18:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=voc/X78q1Cd5mXSfJ2m05folBsGa52Gk3s2/x35kFuk=;
        b=ZeJySklH10WnYLNScs23EE0Q3N6F2Jfj2JUs6XJbkmE4VSxoC3Ghma3Lzj6oRC+mu6
         FyE3/tEKRIJV9ti4wuAoFLVYBWAgW6Ch3jAOIgTHCuYiKSOI2QhGl99dvz4vlQws8JeV
         9vD4MK1Ph/WDeb1sGuVCGyJd05ehiIqN7UdMhO8oof+Rj5unI91ciEAhk2BZnEZO/O92
         zI/ZqMmzCUzqCMVITI+4vmexuC7Zcqk1Saea3MR1EKfs+dh+8oSZvXYvOY7jFt/sBoxZ
         2LJrRLWsX4+lZijegr2JLClNgCmp/GrfA5wDwrEf4bfq1mMUC3Zd4qE7g242MPyrAXOT
         4/cQ==
X-Gm-Message-State: AOAM530/mQlk4kGVyyTNzBpOpwpJxzIVT3dPD5NtNo3+JhMfRuftupZH
        2GY1hGVaVm4a/r5uyICO9w==
X-Google-Smtp-Source: ABdhPJzumPxjm3c/tKAxEqoTsUNFSmAT4HjT32krev6w0RJbztOm5m+HYFNgk9poe0kBJTLCYH19Qw==
X-Received: by 2002:a92:d80f:: with SMTP id y15mr1000656ilm.96.1615342952755;
        Tue, 09 Mar 2021 18:22:32 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k4sm8500015ion.29.2021.03.09.18.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 18:22:32 -0800 (PST)
Received: (nullmailer pid 1604756 invoked by uid 1000);
        Wed, 10 Mar 2021 02:22:28 -0000
Date:   Tue, 9 Mar 2021 19:22:28 -0700
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        anmar.oueja@linaro.org, Bill Mills <bill.mills@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V10 4/5] of: unittest: Create overlay_common.dtsi and
 testcases_common.dtsi
Message-ID: <20210310022228.GA1603543@robh.at.kernel.org>
References: <cover.1615199908.git.viresh.kumar@linaro.org>
 <46c3ec10db6e7bab87fd1a98236a3fdba6a02ec9.1615199908.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c3ec10db6e7bab87fd1a98236a3fdba6a02ec9.1615199908.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 04:15:09PM +0530, Viresh Kumar wrote:
> In order to build-test the same unit-test files using fdtoverlay tool,
> move the device nodes from the existing overlay_base.dts and
> testcases_common.dts files to .dtsi counterparts. The .dts files now
> include the new .dtsi files, resulting in exactly the same behavior as
> earlier.
> 
> The .dtsi files can now be reused for compile time tests using
> fdtoverlay (will be done by a later commit).
> 
> This is required because the base files passed to fdtoverlay tool
> shouldn't be overlays themselves (i.e. shouldn't have the /plugin/;
> tag).
> 
> Note that this commit also moves "testcase-device2" node to
> testcases.dts from tests-interrupts.dtsi, as this node has a deliberate
> error in it and is only relevant for runtime testing done with
> unittest.c.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/of/unittest-data/overlay_base.dts     | 90 +-----------------
>  drivers/of/unittest-data/overlay_common.dtsi  | 91 +++++++++++++++++++
>  drivers/of/unittest-data/testcases.dts        | 23 ++---
>  .../of/unittest-data/testcases_common.dtsi    | 19 ++++
>  .../of/unittest-data/tests-interrupts.dtsi    | 11 +--
>  5 files changed, 128 insertions(+), 106 deletions(-)
>  create mode 100644 drivers/of/unittest-data/overlay_common.dtsi
>  create mode 100644 drivers/of/unittest-data/testcases_common.dtsi

checkpatch complains about spaces instead of tabs.

Rob
