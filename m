Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6803BF483
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 06:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhGHEVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 00:21:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56176 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhGHEVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 00:21:22 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1m1LUm-0004aK-1N
        for linux-kernel@vger.kernel.org; Thu, 08 Jul 2021 04:18:40 +0000
Received: by mail-pj1-f72.google.com with SMTP id u12-20020a17090abb0cb029016ee12ec9a1so1733376pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 21:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4G9i8vQWT5nXUI2uXZLc2Au8KV/9r+vg878BWJ9X0yw=;
        b=LlYIA/NEfn8vNoHNQAtb050CAM2zfkmdQW4j9sxONMu5PBDUwu15y0plsZr5QDNN0R
         rqAkK8iOYIYoHV4h3iDUCxMC2t1GK0jfHU897IJXwFg18NXeVXqMZ1T3WbGlS3P1gh3A
         IUIs/KZou2auwz/Ox7cuN+9EXcUr4q1ZKpUb6mb8GFmbhsjWW3KcueC3PyqRRZnUhRRo
         ndcbKnOUu2kzzIkiKFD09+S7LY2SMNBzoNzOLwdy7IcuUKfQAJ435z5zzVqfP9c9RRbu
         UriGKNcxobWnvi6i6MdQkvR0Id3Z+MXeVi5U9+IBL53uypJt8MZaEoppaHsCJ+C77W24
         jgWw==
X-Gm-Message-State: AOAM532YkybX2RPMGf6FhSf/7BX+JDPPjY8tjZJv4jxBvJcouc1r+rEv
        BZh96TwSYycF8p1srdzq/A3DZyPcphlwiJdcebrf3Gpe8s8ngJoOWnnFYS1N2zgGllLzvIopsVx
        3yA4oP0q9Ye+dje5jwMjBGO8Di7Pb2NcpG7mR1RIGwMSW1+NkETPlUYg9
X-Received: by 2002:a65:6659:: with SMTP id z25mr29667136pgv.291.1625717918565;
        Wed, 07 Jul 2021 21:18:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy73Par1gV7DO9u9OB55lNW9eOWHyS+LnBRXdrclf95y+wZHPdXg7cl+6HhiGgE6qOgbxg95hFBfk9zlpCAcZY=
X-Received: by 2002:a65:6659:: with SMTP id z25mr29667086pgv.291.1625717918266;
 Wed, 07 Jul 2021 21:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210525113316.25416-1-po-hsu.lin@canonical.com> <87y2c1swnz.fsf@nvidia.com>
In-Reply-To: <87y2c1swnz.fsf@nvidia.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Thu, 8 Jul 2021 12:18:26 +0800
Message-ID: <CAMy_GT_4dqEuSfUGND9GTBxGORcwf480-a46Z=J736YHo2RkDA@mail.gmail.com>
Subject: Re: [PATCHv2] selftests: Use kselftest skip code for skipped tests
To:     linux-kselftest@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        ast@kernel.org, Petr Machata <petrm@nvidia.com>,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, hawk@kernel.org,
        nikolay@nvidia.com, gnault@redhat.com, vladimir.oltean@nxp.com,
        idosch@nvidia.com, baowen.zheng@corigine.com, danieller@nvidia.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 4:54 PM Petr Machata <petrm@nvidia.com> wrote:
>
>
> Po-Hsu Lin <po-hsu.lin@canonical.com> writes:
>
> > There are several test cases still using exit 0 when they need to be
> > skipped. Use kselftest framework skip code instead so it can help us
> > to distinguish the proper return status.
> >
> > Criterion to filter out what should be fixed in selftests directory:
> >   grep -r "exit 0" -B1 | grep -i skip
> >
> > This change might cause some false-positives if people are running
> > these test scripts directly and only checking their return codes,
> > which will change from 0 to 4. However I think the impact should be
> > small as most of our scripts here are already using this skip code.
> > And there will be no such issue if running them with the kselftest
> > framework.
> >
> > V2: router_mpath_nh.sh and outer_mpath_nh_res.sh sources lib.sh,
> > there is no need to assign ksft_skip value in these two.
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>
> I want to note that defining ksft_skip=4 in every test separately is the
> current practice. I agree with Willem (in a parallel thread) that this
> stuff should live in a library of its own, but there is none currently.
> When there is, it looks like the conversion would be mechanical.
>
> Which is to say, IMHO this patch makes sense on its own as an
> incremental improvement.
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Hello folks,
any other comment on this patch? Or if I should break this down to
smaller patches for different suites in kselftests?
Thanks!
PHLin
