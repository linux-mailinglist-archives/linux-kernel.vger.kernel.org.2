Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B5B3B161F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFWIrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFWIrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:47:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46772C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 01:45:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f30so2842046lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 01:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mnf/412BXT3SW6cMM4XrHUEIZkc2F6iPAGQOAC9hxkI=;
        b=HRe8ptDqAKO9fbUgdpEpgLH+fZ2WoPny5DL8SFLjklM1wPMdFyZ8rDTy5Zf6zytLuS
         yyW3HOR8JXPAcThdImno7gqL53pekgyvJAV+R0hQiNDQIQ1BNzjJDPX99dsjp6ueApbx
         S8iiesbcp2zi71iXH0Mdkm02Z96nIOuol/S3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mnf/412BXT3SW6cMM4XrHUEIZkc2F6iPAGQOAC9hxkI=;
        b=Y5Q3hW9nbOi2liGCCGJpF2l73iiYeRrVlGPJI4gJWb8mNER+sg7hBMuJArUOLEWCWA
         5y9yZFNlmTD2LtRTDTNPFhOjzhew7SIoYE/Q+g1vFG5vkLO/S/TXlqd2hiEu06eXWW9n
         euLD2qa5XklEiDzUVfcFb8qMBxYIgzBEB+4uVt78RdnZ4KKT4CqJw7NVEvs8LP98If6T
         BVr7lFPPgnXqQP4g8DexRrHagI6MdIq16MNTSJlSec4WooZ7IeYdhT7vtCm+HokeDnl9
         NZya0kWbYcpmyc4raTrU63ild0QCEYUSycdowwyTmRlSgvuP2yxogO7bs50jE82CE7IS
         kLFQ==
X-Gm-Message-State: AOAM5314gQgIi8X2fvqvn2BW2/V130dyl4oE1jx+AdWtVoAE65VkupT5
        cdZBw0ATgiz6w3ESEPGk1hdeY5l/XtVeckODKARUbOeZdHU=
X-Google-Smtp-Source: ABdhPJzixrwlbsgihe9DSf0fQWrERfgmVQa0QAoHiwkWYylAeOsi7OM1vaTkpZk9MirF+w40feaVLpI7dAXAZ3q1yY0=
X-Received: by 2002:ac2:4db6:: with SMTP id h22mr5928298lfe.171.1624437903317;
 Wed, 23 Jun 2021 01:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210618105526.265003-1-zenczykowski@gmail.com>
In-Reply-To: <20210618105526.265003-1-zenczykowski@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 23 Jun 2021 09:44:52 +0100
Message-ID: <CACAyw9-UnQODTf+=xEmexpWE6zhYUQfp7go76bEEc_A1rAyd7Q@mail.gmail.com>
Subject: Re: [PATCH bpf] Revert "bpf: program: Refuse non-O_RDWR flags in BPF_OBJ_GET"
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Greg Kroah-Hartman <gregkh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 at 11:55, Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> From: Maciej =C5=BBenczykowski <maze@google.com>
>
> This reverts commit d37300ed182131f1757895a62e556332857417e5.
>
> This breaks Android userspace which expects to be able to
> fetch programs with just read permissions.
>
> See: https://cs.android.com/android/platform/superproject/+/master:framew=
orks/libs/net/common/native/bpf_syscall_wrappers/include/BpfSyscallWrappers=
.h;drc=3D7005c764be23d31fa1d69e826b4a2f6689a8c81e;l=3D124

As a follow up, what does Android expect to be able to do with this
read only FD?

Lorenz

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
