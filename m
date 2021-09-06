Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB3401EA0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244310AbhIFQlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241972AbhIFQlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:41:16 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8740C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:40:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m4so12190445ljq.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLGf+W5qZqIzs5xlBDQY6TASgcg+cDCU3+/hIp0WRSQ=;
        b=ZCv1Na58AgWFZ2iFATqhgehgaulyIV7J7ag0K8Y9oyChAGugX3AoStVPklc7w2OhPg
         W03/VpXx+xSMtO3MUalYb4qSLNbZUwmaR3J8n/O/fkWtK7HCB3hzAJVF5L9bMY1r5a5N
         giv5P0l+F0rwry5bA3jbyOOZV7JY1km7V1UkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLGf+W5qZqIzs5xlBDQY6TASgcg+cDCU3+/hIp0WRSQ=;
        b=iqgV5ETp24ahofp/xGNcSKLZZzb666/bUGS766++rmTGm44vgeDXLDm9sssMbvp9Do
         83MsVg/34OAIdznfh5mAxwZjv0DeTfU33W4opfU8omOl3K8zUcvC1FuRZQSbvI7Qtj1N
         fzuW1ZI13aymwW08mfkUKGM3ZH1+g0Mygb5Ry2khBJDr5NI5nSc9BuXzdwz8+P0jm5gi
         8SNHopN5W8kFXeGWXDrO+MqFFQZLucnQhytu3QDCmDfVSgCRqIRMaVU9VJhzlLFpGnOv
         kjb7CsMoFlQen6tSj3izM2zf4nwdkAwPWEYPF4f4ugadlVqsVgmmWUujA3GlTd4+hctd
         gDQw==
X-Gm-Message-State: AOAM531TriVqARWKBtFgkJ1CBGDSkAtv9fd4hHuV3zY9SxwES+El53Tw
        X+FNFOPnQlRTrL9ZqDRKT6CKXdFbZPVdf7Nh+HM=
X-Google-Smtp-Source: ABdhPJzfYMb8SSf72azxmDmiKl+4U9eJ2FthikKyuLMIknff80tlWcYTBFD/ujf2pkbJO6e6osbJtw==
X-Received: by 2002:a2e:b24f:: with SMTP id n15mr11099881ljm.124.1630946409553;
        Mon, 06 Sep 2021 09:40:09 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id f13sm782453lfs.193.2021.09.06.09.40.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 09:40:07 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id g14so12190476ljk.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:40:07 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr11178044ljp.494.1630946407467;
 Mon, 06 Sep 2021 09:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsV7sTfaefGj3bpkvVdRQUeiWCVRiu6ovjtM=qri-HJ8g@mail.gmail.com>
In-Reply-To: <CA+G9fYsV7sTfaefGj3bpkvVdRQUeiWCVRiu6ovjtM=qri-HJ8g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Sep 2021 09:39:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJ-nr87H_o8y=Gx=DJYPTkxtXz_c=pj_GNdL+XRUMNgQ@mail.gmail.com>
Message-ID: <CAHk-=wjJ-nr87H_o8y=Gx=DJYPTkxtXz_c=pj_GNdL+XRUMNgQ@mail.gmail.com>
Subject: Re: bridge.c:157:11: error: variable 'err' is used uninitialized
 whenever 'if' condition is false
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Vlad Buslov <vladbu@nvidia.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        lkft-triage@lists.linaro.org, Netdev <netdev@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 2:11 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c:157:11: error:
> variable 'err' is used uninitialized whenever 'if' condition is false

That compiler warning (now error) seems to be entirely valid.

That's a

    if (..)
    else if (..)

and if neither are valid then the code will return an uninitialized 'err'.

It's possible the two conditionals are guaranteed to cover all cases,
but as the compiler says, in that case the "if" in the else clause is
pointless and should be removed.

But it does look like 'ret' should probably just be initialized to 0.

              Linus
