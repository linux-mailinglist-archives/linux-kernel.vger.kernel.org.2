Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D703DC488
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhGaHoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 03:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGaHoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 03:44:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EB7C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 00:43:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l19so18562500pjz.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 00:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0bXc4+f8J7h+BNDmqSHrABgRPZcrLEP+EUPIPGuZBSg=;
        b=blBn1bdjx0Hf4LXvShmXzIy4bQIUJ9jycI0lDUNppPmirEO7h5mAx0gV7nO5jX346z
         U3p0hj/1qUcV1nsT28DFNsq30tBlCi0Bxl3frbMNVC93xafbGfTVKvpjWcFFOx3BU8yL
         HK0Dh0uDgP4GeRBYtKdLvNR4Fef0nQj28rgnH9lWLo6yNowde7McWWn4IEPghztHOHtk
         o+eultcLoEi8OK/uHZ3IACCj2nQPuOizNNvmwVZcJAR9nKX7cDu5I/UJ7ES6jQvluQHd
         kEaznNnOFuj+O35NscZ6/IjWWLbw0arQTM7WneF+T6T9KU2qHLhugSaUJkRfTbTW8pV1
         Bkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0bXc4+f8J7h+BNDmqSHrABgRPZcrLEP+EUPIPGuZBSg=;
        b=t5aYNHfCKfaIqPqna5/+FLxD9v5UcJwDMSATs+9zTzPWi9TfEoA+nnV3JEqJfqMCFI
         X53ukN3oYakrNxf91By5uV3etHff9T7Md/qBHh2DplDhbMkm06Pqwl4uSXJUZIT1OfjZ
         D1rEZ7eZLh7YBT+IPfFC353NPHsIe1QyMV2+ixOLvfCZrtrFaYwig0fURF0lh+7w6PGr
         EZZdxzPe9YF/OixTdV+gzzLXquctxKi+XC9iCq9KSXOTZSn6gJrc2gWMPIXXKG1o26sO
         kNqoRkY4CT9iIuHCg/12T6uuarqHDPZ3YnCNaUs3GYKqyFT9BTBlWKr2RfQ8hmkXhlEn
         GVEA==
X-Gm-Message-State: AOAM5310qDwMjbzqdx0z/EFH5WYo/hhUAzt0grez1YSEhhsR+c95fGC1
        3y8aWFLIvPhJW/xeUGW1pcvntw==
X-Google-Smtp-Source: ABdhPJwlRPY/8pm/IxhL59d2iJ856M16SNNYrqVK93bnXOKLeJqia0voU1lxF64lbFo8TO0S73or2w==
X-Received: by 2002:a17:902:8a98:b029:12c:3177:c3ef with SMTP id p24-20020a1709028a98b029012c3177c3efmr5902070plo.21.1627717435852;
        Sat, 31 Jul 2021 00:43:55 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.43])
        by smtp.gmail.com with ESMTPSA id j3sm4663125pfc.10.2021.07.31.00.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 00:43:55 -0700 (PDT)
Date:   Sat, 31 Jul 2021 15:43:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, al.grant@arm.com,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/6] perf cs-etm: Save TRCDEVARCH register
Message-ID: <20210731074343.GG7437@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-4-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721090706.21523-4-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 10:07:02AM +0100, James Clark wrote:
> Now that the metadata has a length field we can add extra registers
> without breaking any previous versions of perf.
> 
> Save the TRCDEVARCH register so that it can be used to configure the ETE
> decoder in the next commit. If the sysfs file doesn't exist then 0 will
> be saved which is an impossible register value and can also be used to
> signify that the file couldn't be read.

After reviewed the whole patch set, come back to highlight one thing:
seems to me ETE is only a feature introduced by new ETMv4 revisions; in
other words, if we support ETMv4.5 or any later revisions, it will
support ETE feature.

Here I think the right thing to do is to support newer revisions for
ETMv4, and then based on the revision it creates a decoder with
supporting ETE feature.  For a more neat solution, if the perf tool
passes the "correct" revision number to the OpenCSD decoder, it should
can decode trace data with ETE packets.  In this way, the ETE decoding
can be transparent for perf cs-etm code.

How about you think for this?  Sorry if I introduce noise due to my
lack knowledge (and platform) for ETE.

Thanks,
Leo
