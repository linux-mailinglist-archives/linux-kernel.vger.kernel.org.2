Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9E83714FD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhECMDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbhECMCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:02:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1F5C061348
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 05:01:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a4so7466655ejk.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+RwNQE6LklMpMlC7/iRT4MHt+ceTv7XUchB/czKmcE=;
        b=VUYtUdRS35j5f7KzTo1RJ4Uj7c+3dSMRjwbG0AyH7ZkM50sTSaPdvp2+bzZiOyPSWl
         rhRxFlXD4HoWhP4hwvWgIcpNl9fkZtcIZKNxp1p0N1tj5/rNScaPUGLYE0SYHIyyxUQu
         pUv3QTuK8u7vm+sK5lByW77ACS8NFZMorBtWJs/EfMybCyAbSkxHpQmdpvm0jSXf/I/t
         zINpVQp9Zj5ObKftx7UObzdLfobOt11rhBp/0EZN0mhnEJVYKF9EskaKFmDtdkyvPO1+
         +YSMiISVQ78aZsas9vVSaf95PUK8nB+7md4miDj/doZhveTda3AZZTDCgkCI7zn78DQl
         OAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+RwNQE6LklMpMlC7/iRT4MHt+ceTv7XUchB/czKmcE=;
        b=KU22BRrAZfZC9JybaU+97r6IgY5bRCGeqAMuhW+54J4MapcllgYCgLu+8c8imC+AGf
         4/ZcRV11/kYbpQ/XyBTs+q8HsTmyA5hq0Lokl9P5asXtnlv+utD+kpURObJ26OSAlktU
         vw7/lwPJTb25HEXml7DeLrSVG7R+Y+30iXh9OQrSJm5aMQK+ccst69q0p40f4zvmQR7p
         ijP+rtjkHvC23xntuJmOtvs6uso93O65x0+8tKaWvYK0EnW/CsQuzSX3lJ0xYcK5AVav
         MFABR+99VTBlY9cnjeaFZ9pb3qJIj/GuTvtXOPQ5B/zARe/q2VZeU/RNPKubSEFnpPct
         qDvg==
X-Gm-Message-State: AOAM53140bSCsml87X7OTKIUNKOrqicJ2+09Rhz2bwrGpefkWZOR2T3c
        QIyZWntvMpt+rFQeIbddNt1yX8WUN8yeegSXSwB8rg==
X-Google-Smtp-Source: ABdhPJyfsrx1lO1Gmcy3xzc4ZJCS3yemIFD7d45fFN/YI+6TzJm6tvqq28FAOl1vfN35ZesI1bNKxs/D1Ifc2evZ7/Y=
X-Received: by 2002:a17:906:168d:: with SMTP id s13mr15971516ejd.81.1620043272065;
 Mon, 03 May 2021 05:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210429130510.1621665-1-jackmanb@google.com> <CAEf4BzY7sx0gW=o5rM8WDzW1J0U_Yep3MMuJScoMg-hBAeBPCg@mail.gmail.com>
In-Reply-To: <CAEf4BzY7sx0gW=o5rM8WDzW1J0U_Yep3MMuJScoMg-hBAeBPCg@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Mon, 3 May 2021 14:01:00 +0200
Message-ID: <CA+i-1C2+Lt7kmwsZOEw6D8B_Lc+aJdZoUmPDh08+7y_uMNW+kA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 at 18:31, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 29, 2021 at 6:05 AM Brendan Jackman <jackmanb@google.com> wrote:

> > Note: I feel a bit guilty about the fact that this makes the reader
> > think about implicit conversions. Nobody likes thinking about that.
> >
> > But explicit casts don't really help with clarity:
> >
> >   return (int)min(cnt, (int64_t)INT_MAX); // ugh
> >
>
> I'd go with
>
> if (cnt > INT_MAX)
>     return INT_MAX;
>
> return cnt;

Sure, it has all the same implicit casts/promotions but I guess it's
clearer anyway.

> If you don't mind, I can patch it up while applying?

Yes please do, thanks!
