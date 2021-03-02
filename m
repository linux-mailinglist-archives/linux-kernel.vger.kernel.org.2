Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1332A3FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349516AbhCBKE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379116AbhCBJsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:48:14 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45114C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 01:47:23 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id m11so22252707lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 01:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kcgL94+L1tIXT1R8vfU9UzdbVrMKYIDLcHvPGal+1A=;
        b=SurN3sWHWBPKkLlGNZc6rYyjJtp8AA/I2oXOTORAolb7hFvo7bfaUhEMmYnvL9t/eV
         lX70eBcFbTYDzPxYJFrDwpr1iGSt7PkyTCRxzAkSHJR8OMWI5IkYUuKCCG2ZTlt0f2kO
         IRqX8Vh8c1GRXIZ4HZUGAXxuD7wo4pek3aQ6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kcgL94+L1tIXT1R8vfU9UzdbVrMKYIDLcHvPGal+1A=;
        b=LPe6UsTyVb7GSDa+jIQ4XqPgCUHz8SzbszyRjRqtwJJTAOCjfr087G1jCFblfWrUfn
         MDskf2DRxHf6bW1JbPfYGNssXR/gNDvThJfbQnPeNWC1P1BzBAxZDiHnE2XeN3Y0j4J5
         npOf5u60RbtYSuW7vkf5fGhfLRYapLxFv9CdFhf64hPR3n/NkTezs+ZuG2Y0Bp1fw27p
         rV3BRLXQupR610EtQNbteZ5jy3feUHJL1l7DsMbqNxLCapOTP+ZyyZ2e4fBam8u85tiP
         ok11uaxzlHFS2dl8HDts9Jk4v9CiSWfoCieqBCI90sHLCHX7Iw5umzBMF2oABxgZPjn/
         yCcg==
X-Gm-Message-State: AOAM532FBeDeBDfEKUCvHWvNpCvIdl9LB7Zh18Q/kAS9TjAva9gwgoUA
        9qozAv2dzoHAp19touNyZy2aLEWxil7SyWe38jt7mA==
X-Google-Smtp-Source: ABdhPJwg1ssQ28iX2I+mijjOyb6szTErEc2v03CrScKzyn9CA47P04+7k072VSz5R/vYT31LV7LexBEMXka7Q6QXIJg=
X-Received: by 2002:a05:651c:1318:: with SMTP id u24mr11838773lja.426.1614678441745;
 Tue, 02 Mar 2021 01:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20210210120425.53438-1-lmb@cloudflare.com> <20210210120425.53438-3-lmb@cloudflare.com>
 <20210301100420.slnjvzql6el4jlfj@wittgenstein>
In-Reply-To: <20210301100420.slnjvzql6el4jlfj@wittgenstein>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 2 Mar 2021 09:47:10 +0000
Message-ID: <CACAyw9_P0o36edN9RiimJBQqBupMWwvq746+Mp1_a=YO3ctfgw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] nsfs: add an ioctl to discover the network
 namespace cookie
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 at 10:04, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Hey Lorenz,
>
> Just to make sure: is it intentional that any user can retrieve the
> cookie associated with any network namespace, i.e. you don't require any
> form of permission checking in the owning user namespace of the network
> namespace?
>
> Christian

Hi Christian,

I've decided to drop the patch set for now, but that was my intention, yes. Is
there a downside I'm not aware of?

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
