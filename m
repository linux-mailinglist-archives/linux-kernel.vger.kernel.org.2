Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD7137F812
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhEMMix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232660AbhEMMir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:38:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87A24613DA
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620909457;
        bh=qeKUmOFQwUuzccQ7OPyu+xzYII9VVza4a7QOpxn6M64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cmFTFjJ+7y/+1jcDyFTdQpHLWvR/xS6UhokysM12iTSV5KzZz9/TI4/vxRbJYgri3
         BWhgqdzrZAK9tnPjgZrmbjw/6XCXyk0rRS4c4tClbcDcXNs9w1aXixVnEXie43MxCj
         WzcyESId5GvCn2U9vHba7a25wUWzPLIsWOxhbbQFDdZ0rmFl9HSCye+tt469GJT21V
         fhrQ210q1+vyqHFdZO3i+42CiWiRQGH5/0sOUshxpCEXl160XX2ERvzQ5nt3rOdB5A
         KKgE641cvjtXr4ijN+d07AIum4mnAEfrxbp+t4VaMoDOdWjg/qoEpU2AMAk89/GjSo
         ZEdS7uoz5eEuA==
Received: by mail-ed1-f49.google.com with SMTP id r11so6753154edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:37:37 -0700 (PDT)
X-Gm-Message-State: AOAM532z1ZwTPtCWT7jA/RMemQhaQbjmZlUcVWS6V0ZfT7CpFIBEXI4n
        k2Hw8oH7OQMUaW1LKYxJhyGU1q1lc7QbhGqFBQ==
X-Google-Smtp-Source: ABdhPJziudrJ40RQ4MMCAOpgwbf56oardORl1c2Ld7FXnTjUwjnLiVgB51drEJ586sz3Hl42A7RumoGGhpAFRn0yAQw=
X-Received: by 2002:a05:6402:234b:: with SMTP id r11mr49991488eda.137.1620909456065;
 Thu, 13 May 2021 05:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210420031511.2348977-1-robh@kernel.org> <20210420031511.2348977-8-robh@kernel.org>
 <OSBPR01MB4600B56CA4CE59935DDCC8B7F7519@OSBPR01MB4600.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB4600B56CA4CE59935DDCC8B7F7519@OSBPR01MB4600.jpnprd01.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 13 May 2021 07:37:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKazmW6_2dQBz49zPkMDYreDBnCvKbHSqm5MucefmGZ5Q@mail.gmail.com>
Message-ID: <CAL_JsqKazmW6_2dQBz49zPkMDYreDBnCvKbHSqm5MucefmGZ5Q@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] perf: arm64: Add test for userspace counter access
 on heterogeneous systems
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "honnappa.nagarahalli@arm.com" <honnappa.nagarahalli@arm.com>,
        "Zachary.Leaf@arm.com" <Zachary.Leaf@arm.com>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 4:06 AM nakamura.shun@fujitsu.com
<nakamura.shun@fujitsu.com> wrote:
>
> Hi Rob
>
> > Userspace counter access only works on heterogeneous systems with some
> > restrictions. The userspace process must be pinned to a homogeneous
> > subset of CPUs and must open the corresponding PMU for those CPUs. This
> > commit adds a test implementing these requirements.
>
> Are you planning to change x86 tests (tools/perf/arch/x86/tests/rdpmc.c)
> to use libperf as well?

The test can be removed as the libperf unit tests have an equivalent
test. I had a patch doing this, but there were objections removing it
until 'perf test' can run the libperf tests.

Rob
