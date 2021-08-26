Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203753F8B40
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhHZPkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242936AbhHZPkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:40:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46068C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:39:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so2689305pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=0x3JVYJjoPp3mCHZGSPU/br7LvYDmK0AvhxHSp9lei4=;
        b=BR2UH4Z+GTbgEsYwtzFTbhdGQ/ifkZOkcR9teV+AYwQ3uF+6UE2vX9k0M4WOgNrNWf
         raCkiFOMfrY6FzZdgajczRJJIDJCdW9kwHCG5G2CE9JrNoSypm+HxXGIIAQstL4hFcZ9
         m1iWfYepYFxbr1A5juP/ftBYb8BjyINYS3TVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=0x3JVYJjoPp3mCHZGSPU/br7LvYDmK0AvhxHSp9lei4=;
        b=gn57L9Ldn/tLf47E/YJ8vDOdnFsRRKAi2Abvqk2rrkulCACblFXB9PkfcW4/LwIep+
         flJ/qbi0MSaaeF0jBLHkrg11sGq6yZDEuKlxvTxK9ow77kcM5nKdbHnmCl8xOQSvILPv
         h7QbXcBsg6MMk9NHMA6tixFiZTvcR2KcnBwtBINcWmIDfzmNtsgum5PmlmuRIMSrgfwW
         YZUrK5A4VmMy83k8/L1MZLk9rpwB35sy4ikucGzhWGon6G0T5rtuya67dsPF+aahhYGP
         l3gjX4pZkCQaxT0wNXTyXp1IOWegc71WQJV9O74F2Eme4Ot2WoMhNeNJ3TcYLHFJKKPW
         8DcA==
X-Gm-Message-State: AOAM5332rN1wulnUI1d1vC9jfiMxRcf4EHVivcL+zyEGNhlOoYApvq72
        7A4J5Gb0BqmTfi3vi35Qyt51ng==
X-Google-Smtp-Source: ABdhPJyT1qPGkMrZWNyo9SQCMwAQb4rxdWH8bunPfFQd6Ss5tMxVMpPCzWceJSepz+bPci6A3ddt0g==
X-Received: by 2002:a17:90a:14e4:: with SMTP id k91mr17431519pja.3.1629992392852;
        Thu, 26 Aug 2021 08:39:52 -0700 (PDT)
Received: from ?IPv6:::1? ([2600:6c55:4b00:c768:1835:a5a0:2702:1052])
        by smtp.gmail.com with ESMTPSA id z131sm3466093pfc.159.2021.08.26.08.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 08:39:52 -0700 (PDT)
Date:   Thu, 26 Aug 2021 08:39:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
CC:     open list <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Luca Coelho <luciano.coelho@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        linux-crypto@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        linux-scsi@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        bpf@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/5] treewide: Replace open-coded flex arrays in unions
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMZ6RqJMWaRCB3sZa-it804Sv6aFyZ9J3aQyAStMY-1GAwR1Jg@mail.gmail.com>
References: <20210826050458.1540622-1-keescook@chromium.org> <20210826050458.1540622-3-keescook@chromium.org> <CAMZ6RqJMWaRCB3sZa-it804Sv6aFyZ9J3aQyAStMY-1GAwR1Jg@mail.gmail.com>
Message-ID: <AD5C7E3B-6984-49D9-8666-B3BE90588F1F@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 26, 2021 12:36:27 AM PDT, Vincent MAILHOL <mailhol=2Evincent@wan=
adoo=2Efr> wrote:
>On Thu=2E 26 Aug 2021 at 14:04, Kees Cook <keescook@chromium=2Eorg> wrote=
:
>> In support of enabling -Warray-bounds and -Wzero-length-bounds and
>> correctly handling run-time memcpy() bounds checking, replace all
>> open-coded flexible arrays (i=2Ee=2E 0-element arrays) in unions with t=
he
>> flex_array() helper macro=2E
>
>Nitpick: the commit description says flex_array() but the code is
>actually DECLARE_FLEX_ARRAY() or __DECLARE_FLEX_ARRAY()=2E

Ah yes, thanks! I had renamed the macro but missed these references=2E Now=
 fixed!

-Kees
