Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CDE348489
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbhCXWWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbhCXWWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:22:14 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86996C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:22:14 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id m7so15755065pgj.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=/48dhgHDHZre46tBf8aePXg6q2Dde6pSRdqmAz+ycAY=;
        b=A8DAbCnd0l9fDtqdYkr/Nn72/s9Zi3UynAvoqz+r5wGJd0U0yoyPQpc46VY93XuP6/
         Yk8tpcPM3i1S90vjj2cxGzOSbz+1I8ot51rAZWd9Cd7Pe9791Rb1rFdj1hzSFhC6f8eC
         76oDbhS/1H9i3cFwPQCM2gBARn0J/15uAS5Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=/48dhgHDHZre46tBf8aePXg6q2Dde6pSRdqmAz+ycAY=;
        b=F5CJH+xicDKAWfKaiQV9GP5S4/bONKM4zCKtR0xrjBjevTS4DjSeHqaiuE7H5yQHLB
         WMzRLGg2H9ES1AcekI1cUQxvIeowzO6H7khXWqeGgAeBYXqx3KcDYUdKmYmw40RpBaEM
         c4oCXF+3v2x5SoH0J5QMVEh2plVLpXrRawmOCWuZlv9FuuWIwrb/iZPcJDvxUMb4VKmm
         yaETWm/hUW5ZQOQgWE63gR8ZVN/CV4NrtXOjUpF0E7rp1m/bLjQmR0lDOUV/ZMGjCrCJ
         eA7vFCHSHHdb+qYqoPALO65updS2YCokfoJkhYJJ1cCvsB9+Np+AWi5R9swLXiWtdOLV
         dVMA==
X-Gm-Message-State: AOAM530YOqFXfV2DVWGph8DeYaGo6mrK8/H5Hz1oF/6co4bhbF5u/QX9
        uZzrBsZXaS96811sVAc1v9cWjg==
X-Google-Smtp-Source: ABdhPJyauwhSo+lJ2UsS32ctOdOvo0/1VQ3+mMErQ1WcyR2ND2cDzF0M5zIcTCj/RhYOGeGnOo+bNg==
X-Received: by 2002:a63:c807:: with SMTP id z7mr4706221pgg.363.1616624534052;
        Wed, 24 Mar 2021 15:22:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id f6sm3564775pfk.11.2021.03.24.15.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 15:22:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YFsiOe7RYjSDJ6A+@smile.fi.intel.com>
References: <20210324020443.1815557-1-swboyd@chromium.org> <20210324020443.1815557-8-swboyd@chromium.org> <YFsiOe7RYjSDJ6A+@smile.fi.intel.com>
Subject: Re: [PATCH v2 07/12] scripts/decode_stacktrace.sh: Support debuginfod
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sasha Levin <sashal@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Wed, 24 Mar 2021 15:22:11 -0700
Message-ID: <161662453186.3012082.16246196278552144536@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2021-03-24 04:27:53)
> On Tue, Mar 23, 2021 at 07:04:38PM -0700, Stephen Boyd wrote:
> > Now that stacktraces contain the build ID information we can update this
> > script to use debuginfod-find to locate the debuginfo for the vmlinux
> > and modules automatically. This can replace the existing code that
> > requires specifying a path to vmlinux or tries to find the vmlinux and
> > modules automatically by using the release number. Work it into the
> > script as a fallback option if the vmlinux isn't specified on the
> > commandline.
>=20
> One wish for the shell scripts: try to avoid bashisms as much as possible,
> please.
>=20

I wish too but the script has /bin/bash at the start and I was trying to
follow similar style to what was already in here. Feel free to send a
patch to remove the bashisms.
