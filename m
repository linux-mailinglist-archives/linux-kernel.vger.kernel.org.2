Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC92632AA6D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581939AbhCBT3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbhCBRM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:12:59 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161B6C0611BE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 09:11:59 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v3so15310557qtw.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 09:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=bxKMYYmUvUpBtKuJHbGhKlz3ZJSqS7vX/aC19oIQvPw=;
        b=si3ITMPtQRkoBlzL+4KThrMP994M3IzGtesqhkqNcxThBZJwOREcSxlMp04/Cww+r3
         Obz43ki1h7cCnPDdCLCK8gw3XovI55ebDceEeq58r+NObwrr+QUwuL1ZnNEqGdYWaT8y
         AwcEfH/xiwKSrZtjgr1aO6Ri5lcSrPHp7vQ0jK+dR4xtfs6tyURqgZ1Gn2x0Aqa0To4F
         sTZdYem6ieB2wY0JmOnWzBppa/x04C8BbnNNgW+Pc2+IVU0+ENurGWmWAIu3Dkl8wVoj
         QduVNDAYkxvJQlfJAMFW/Lmgo3bLirnSyowzawZ9QJyPF+VH3yZOe5sdwhwpy21ZY6H2
         D5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=bxKMYYmUvUpBtKuJHbGhKlz3ZJSqS7vX/aC19oIQvPw=;
        b=nztoZg07hOFJI/DfMK5JVfNEps6JMZOIWITsLTXJUit2ROwi+saeSJiL7K9/OFVVEu
         /VgpNWLfuhLeNN93Ih+7kg+dhizfPnlUGV/yDkxSWPK3UJWYhROXHcnJ3XOUpW7Okw7t
         Tvqe9UMUgI1a8Cwlm0U2Aj7PtLA8AwQ5uFKg4GPV1xH7aRAb6NhrJ9AibNJEvG1GAL+v
         PIyGe44EUOMyqO8Ptc3LFktc2IyTgKdJUXqo7XAwlOpw2wm0y0jOk+IAnFAqKD4M9cmY
         AnrVwG6w1B/ubh5h50I4PXclyzQxmrSgM9jX7jt/fqgNZYVJedTd8AddrmBIOl2RpbjH
         Xipg==
X-Gm-Message-State: AOAM532LqZOBUEOwGA9qXextU7PxFfRM9Pu4hvTkyjkh2Le/sz4BMpsc
        8Xa7/aSuWTBeN7toPuuvMK8=
X-Google-Smtp-Source: ABdhPJw9V6kkS/emUbxYISBExChLv07873aQwoji1U1eg2uYXZih8c3DxDfErsZW3V+C3PzFScQ7eA==
X-Received: by 2002:ac8:3937:: with SMTP id s52mr19494167qtb.90.1614705118127;
        Tue, 02 Mar 2021 09:11:58 -0800 (PST)
Received: from [172.16.141.208] ([187.68.192.108])
        by smtp.gmail.com with ESMTPSA id j24sm3020714qka.67.2021.03.02.09.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 09:11:57 -0800 (PST)
Date:   Tue, 02 Mar 2021 14:11:10 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJ9a7Vg5H-UUr9B3iOG4FqtgF=f3-2p8-VVqCCoegbrLn_GMjA@mail.gmail.com>
References: <20210224164835.3497311-1-mathieu.poirier@linaro.org> <YD41GUtuq8fVa4Q6@kernel.org> <CAJ9a7ViKLg8vjBnuA1eWh8b5-PN7RryefyOV1qoX9Zu362Eq8Q@mail.gmail.com> <YD5mu7Df3fXiWZuk@kernel.org> <20210302164254.GA3789438@xps15> <CAJ9a7Vg5H-UUr9B3iOG4FqtgF=f3-2p8-VVqCCoegbrLn_GMjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] coresight: Patches for v5.12 (perf tools)
To:     Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Message-ID: <F5C1A802-C5B5-45D6-96CC-2D13FCB23BAE@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 2, 2021 2:02:17 PM GMT-03:00, Mike Leach <mike=2Eleach@linaro=2Eo=
rg> wrote:
>On Tue, 2 Mar 2021 at 16:42, Mathieu Poirier
><mathieu=2Epoirier@linaro=2Eorg> wrote:
>>
>> On Tue, Mar 02, 2021 at 01:24:27PM -0300, Arnaldo Carvalho de Melo
>wrote:


>> > Can you please try one more time, these are the last csets on this
>> > branch:
>> >
>> >   $ git log --oneline acme/tmp=2Eperf/core -10
>> >   8e1488a46dcf73b1 (HEAD -> perf/core, five/perf/core,
>acme/tmp=2Eperf/core, acme=2Ekorg/tmp=2Eperf/core) perf cs-etm: Detect pi=
d in
>VMID for kernel running at EL2
>> >   47f0d94c203751dd perf cs-etm: Add helper cs_etm__get_pid_fmt()
>> >   30cb76aabfb4deab perf cs-etm: Support PID tracing in config
>> >   8c559e8d68630d64 perf cs-etm: Fix bitmap for option
>> >   2bb4ccbd95d7fbf5 tools headers UAPI: Update tools' copy of
>linux/coresight-pmu=2Eh
>> >   42b2b570b34afb5f perf cs-etm: Update ETM metadata format
>> >   83bf6fb8b076c72f perf vendor events power9: Remove unsupported
>metrics
>> >   34968b9327c83589 perf buildid-cache: Add test for PE executable
>> >   9bb8b74bdb186bd3 perf docs: Add man pages to see also
>> >   d9fd5a718977702f perf tools: Generate mips syscalls_n64=2Ec syscall
>table
>> >   $
>>
>> As far as I can tell you have all 6 patches=2E
>>
>
>Agreed - [1] I was trying is in fact:
>42b2b570b34afb5f perf cs-etm: Update ETM metadata format
>in the above list=2E

Ok, I misunderstood, good that's all already in, thanks for checking!

- Arnaldo
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
