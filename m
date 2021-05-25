Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3B38FF78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhEYKp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:45:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47418 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhEYKpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:45:23 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1llUXQ-0003Ew-9A
        for linux-kernel@vger.kernel.org; Tue, 25 May 2021 10:43:52 +0000
Received: by mail-pl1-f199.google.com with SMTP id x15-20020a170902e04fb02900f5295925dbso8999894plx.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7p+WdCrLEBx/FiI7skBf0U0P+IdeMCYAYyt9GXvbf4=;
        b=XWlQpZAEJdJVpLEB64ZZuHyfoXw4jUVPSLK2hf6f+CiQOZMVh+OaROFHutsoc45THu
         FNapr0ujIKBo45tQMosqXkA3paL2Uc0xwRxCDY6o/ntnfJKao2SWUnpFdZ+rDmZy5crB
         N/AmDoLkBG8uz2jnOf7a1aDjZtGTqhcYCPntcrPQlCik1M7pq1AWHtmiAn0vAigQETLy
         O5Tc48hVTmqfP98vyPYNTxz7lcnlArNtesRJ4oT63xk04uGuuOnSuauJ2MyZPDEIn5BM
         Pklh5wLA29B8lA+CJPnbvpx+0z4rGe65ueP4v242wQPAWfqdCsBtUZeDY37p0m5mEQQs
         jI6w==
X-Gm-Message-State: AOAM532+NoRT7B4OKaHzYDL2zJCXPOD+fxMF7p+YOMI4W5y4vW6NvXZV
        Qwib0UTGwzUfDt2jbpr/vL8BPffMBifsNLpGykTIV1MVeG4B+Nzj1lrbfputqYe4yteuK5A893G
        Gy9E/HV+VeZFDF49XAzaV9OWAaTQyavF/A6dY0I5Zha56SsSnxUy9I790
X-Received: by 2002:a17:90a:a395:: with SMTP id x21mr29859625pjp.63.1621939430968;
        Tue, 25 May 2021 03:43:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywHhaYkcm8fw4QivOp+4ibSJhb7az85BNgj13lNR58+4o7jczroKXrakihNHnjiG4KWZaVv+EJkjCk6vgwBtM=
X-Received: by 2002:a17:90a:a395:: with SMTP id x21mr29859587pjp.63.1621939430616;
 Tue, 25 May 2021 03:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210525061724.13526-1-po-hsu.lin@canonical.com> <87lf83cdyj.fsf@nvidia.com>
In-Reply-To: <87lf83cdyj.fsf@nvidia.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Tue, 25 May 2021 18:43:39 +0800
Message-ID: <CAMy_GT9iCU+BJLp_mVALkyBwnzV8fCJQawRJqk_pFvKV=7TU1A@mail.gmail.com>
Subject: Re: [PATCH] selftests: Use kselftest skip code for skipped tests
To:     Petr Machata <petrm@nvidia.com>
Cc:     linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, hawk@kernel.org,
        nikolay@nvidia.com, gnault@redhat.com, vladimir.oltean@nxp.com,
        idosch@nvidia.com, baowen.zheng@corigine.com, danieller@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 6:20 PM Petr Machata <petrm@nvidia.com> wrote:
>
>
> Po-Hsu Lin <po-hsu.lin@canonical.com> writes:
>
> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > index 42e28c9..eed9f08 100644
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -4,6 +4,9 @@
> >  ##############################################################################
> >  # Defines
> >
> > +# Kselftest framework requirement - SKIP code is 4.
> > +ksft_skip=4
> > +
> >  # Can be overridden by the configuration file.
> >  PING=${PING:=ping}
> >  PING6=${PING6:=ping6}
> > @@ -121,7 +124,7 @@ check_ethtool_lanes_support()
> >
> >  if [[ "$(id -u)" -ne 0 ]]; then
> >       echo "SKIP: need root privileges"
> > -     exit 0
> > +     exit $ksft_skip
> >  fi
> >
> >  if [[ "$CHECK_TC" = "yes" ]]; then
> > diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
> > index 76efb1f..bb7dc6d 100755
> > --- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
> > +++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
> > @@ -1,6 +1,9 @@
> >  #!/bin/bash
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > +# Kselftest framework requirement - SKIP code is 4.
> > +ksft_skip=4
> > +
> >  ALL_TESTS="
> >       ping_ipv4
> >       ping_ipv6
> > @@ -411,7 +414,7 @@ ping_ipv6()
> >  ip nexthop ls >/dev/null 2>&1
> >  if [ $? -ne 0 ]; then
> >       echo "Nexthop objects not supported; skipping tests"
> > -     exit 0
> > +     exit $ksft_skip
> >  fi
> >
> >  trap cleanup EXIT
>
> router_mpath_nh.sh sources lib.sh, which you changed above. This hunk
> should not be necessary.

Hello Petr,
Nice catch, I will remove the following lines in those script that
sources lib.sh:
 +# Kselftest framework requirement - SKIP code is 4.
 +ksft_skip=4
 +

Will prepare V2 later, thanks!

>
> > diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
> > index 4898dd4..e7bb976 100755
> > --- a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
> > +++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
> > @@ -1,6 +1,9 @@
> >  #!/bin/bash
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > +# Kselftest framework requirement - SKIP code is 4.
> > +ksft_skip=4
> > +
> >  ALL_TESTS="
> >       ping_ipv4
> >       ping_ipv6
> > @@ -386,7 +389,7 @@ ping_ipv6()
> >  ip nexthop ls >/dev/null 2>&1
> >  if [ $? -ne 0 ]; then
> >       echo "Nexthop objects not supported; skipping tests"
> > -     exit 0
> > +     exit $ksft_skip
> >  fi
> >
> >  trap cleanup EXIT
>
> Likewise.
>
> Unless I'm missing some indirect dependency, no other selftests in your
> patch have this problem.
