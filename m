Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E290C310F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhBEQMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbhBEQIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:08:34 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EB6C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:50:16 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id j13so3830940qvu.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YE/YQGTHwZ7gbs66msaBXwH+40vFYJVzTcKrkbmzw0I=;
        b=IVvwgK3FTWbjgP5nm2j9BXlUlBzZ1hTRtXk/4fib3jzaTm1sVv7WdBvZvfPD2jKDUa
         khdknLUh6qENaXt8+w9ONS1Gu3Mm3HlFqtPsNS11qBVaQI/GtdJnxSCYwe3+1nHILCej
         0BRSBSa3l5/AgXY1OxiHgJsINK+yfsx4V6yMLTh8CQndgAhldR0OKcFwtH1X2Z2MkHh3
         6y9mkW3fa6UldKMrsp0IbaRUP+9vFdq/WRDG1KDLDncCT+2z6GzAZmCVzFxBdhcW5aRp
         Llr5FFaJEbG/2Z/I2K0Dxv6rB5qT3Fx8r6CY+SuqmO0W8Ta9j3DakS+/MsLgCRSzuBvZ
         Kp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YE/YQGTHwZ7gbs66msaBXwH+40vFYJVzTcKrkbmzw0I=;
        b=Z+CBSph+Yi/eKW45gmtCW+dqB6hszM6APESbvPr2YRU+bEog2c9gpNHvF2rYJ8OL0r
         XxKOOGJSozbU91zw8ye8xsRo5Cml/qSt8QgrGDeiVIBAPO7EgGipxfPuFh8k3SPQNniX
         /yJuA8hnxXEgNJwn2Gj96wFqB10AA8nVRDlPI0xMSlmbEJNxVZ1AgNHd/LW2J56VuvUp
         RU4nGXIO3egEuS1zqiKeUOwCtvRXzWoyjeaGwq2WQ38JG3Cw8R8CfG+3H5OipCoN1QpK
         ZMHMUwpeE6KF5eKh8JhBYMYiFZEnkRxWZ/dyd+YPv0/JAmT2sCdLIlhCnpaIgSssh/iq
         CraQ==
X-Gm-Message-State: AOAM5310nAnfsd0wxxmj/LnpRYD+LWjmpfb/fEK0g/a3PZ+Wy3hYFSix
        Vd4hXlObosC9gXHDTjTkv8SiIQ==
X-Google-Smtp-Source: ABdhPJwpLT2XDEM2BHa1u0r4wr8mb4qNEO20aAMdaZgJk+O5jPLsJ6mVjFrgKTOBGo1myjVSET2obg==
X-Received: by 2002:a0c:b912:: with SMTP id u18mr5365334qvf.2.1612547415282;
        Fri, 05 Feb 2021 09:50:15 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 2sm9864869qkf.97.2021.02.05.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 09:50:14 -0800 (PST)
Date:   Fri, 5 Feb 2021 12:50:13 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/7] mm: memcontrol: fix cpuhotplug statistics flushing
Message-ID: <YB2FVc7tNL2RUNm0@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-2-hannes@cmpxchg.org>
 <20210202230747.GA1812008@carbon.dhcp.thefacebook.com>
 <20210203022853.GG1812008@carbon.dhcp.thefacebook.com>
 <YBxLNZJ/83P7H8+H@cmpxchg.org>
 <20210204193446.GA2053875@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204193446.GA2053875@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:34:46AM -0800, Roman Gushchin wrote:
> On Thu, Feb 04, 2021 at 02:29:57PM -0500, Johannes Weiner wrote:
> > It even passes with a reduced margin in the patched kernel, since the
> > percpu drift - which this test already tried to account for - is now
> > only on the page_counter side (whereas memory.stat is always precise).
> > 
> > I'm going to include that data in the v2 changelog, as well as a patch
> > to update test_kmem.c to the more stringent error tolerances.
> 
> Hm, I'm not sure it's a good idea to  unconditionally lower the error tolerance:
> it's convenient to be able to run the same test on older kernels.

Well, an older version of the kernel will have an older version of the
test that is tailored towards that kernel's specific behavior. That's
sort of the point of tracking code and tests in the same git tree: to
have meaningful, effective and precise tests of an ever-changing
implementation. Trying to be backward compatible will lower the test
signal and miss regressions, when a backward compatible version is at
most one git checkout away.
