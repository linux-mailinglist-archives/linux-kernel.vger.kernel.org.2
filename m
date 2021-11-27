Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE2845FD2B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 07:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352162AbhK0G4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 01:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352564AbhK0Gyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 01:54:40 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED5C061757
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 22:51:18 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a18so23353359wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 22:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/QmESk+rRLywivE13is/0sNcAEpfuwDTaPH34HQyPo=;
        b=lnRy+2X/8mUbKW85ZdqVulrGv/6QaqHOBRhyu8SEeS9nqQKLfqgsjiTaONPJgVHD5O
         mQdu1eHAy6j4pBCbYT2sIXawgLcLRq+NvIorsNUovaZw4YBPpa+yaswjvRntYr1k5Sn6
         XOUeuzGau/YmbxXnrMRw/xNlTAPPl4A+/sHaXmDOaYlrLqUjXjnabc8vSMcM/IkcLYF9
         9xVA/hV5x4LXhuLnuMTjDPKYO0H2GyMBkLBZrZPPmQU0gflOG78a01Kn5591rPRGRCa6
         2MeFjTqADyRjaJLhZ1a1cttbmKyePKifzHIrPai3/7KGvq8AoWfklRYjMbWO5rmbsXT5
         UGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/QmESk+rRLywivE13is/0sNcAEpfuwDTaPH34HQyPo=;
        b=PLL/xU6SOk70McANtJI6AbHA0ACwkBBXlLbEAj4oKVpaEb+blHczJClzoETwKqlvE5
         It/JJqDNWobcY4X3yJl7MZT/Rkr5b9992DzJZhBJtO2TTv5bCwMWRJUrZk6Iscje0DZ3
         yOzdu52PQboT+KuFTSnfmMY+2qexgXeF7s6gr9bhkGIA/k1J3q/2BeErB8yQagxPLK3T
         iibFxwXIDIT1fo72KWtdp1/liPw8c62p2Xqp4cg0njKBcPTj0wenweOA944Iwsu7cuUy
         R/1F0KddLyQvC89ib6bwvS4WkdURYHRLpa21qUVN1hs31wnmCmSWRAZyC9R2eIAlMcfM
         5fuA==
X-Gm-Message-State: AOAM530qr6gJh0VvrmTBN3wP8RwUGQ93N/u3vspakTfbZP7B4grni/lg
        CmVY+SCZk4HY+IYu3WNdi7AvOH9kTYywmSA8s6t1Fw==
X-Google-Smtp-Source: ABdhPJymflNv4dkMyYsXdvUY4DwR+a5mMgidEtYfteoQMNoPxTx/9+ZbKKEmr/WePwaXUsC//VVo4hXcRmp4B9kffVA=
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr18646422wrx.352.1637995876927;
 Fri, 26 Nov 2021 22:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com> <20211127063904.102017-1-goldstein.w.n@gmail.com>
In-Reply-To: <20211127063904.102017-1-goldstein.w.n@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 Nov 2021 22:51:05 -0800
Message-ID: <CANn89i+AAx6dAFkUr9eOSxp6d47=y6oZox8DErGQdNyfjLipdg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, alexanderduyck@fb.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 10:39 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> Modify the 8x loop to that it uses two independent
> accumulators. Despite adding more instructions the latency and
> throughput of the loop is improved because the `adc` chains can now
> take advantage of multiple execution units.

Oh well, there was really no need to resend this, especially if you do
not add my ack.

Reviewed-by: Eric Dumazet <edumazet@google.com>
