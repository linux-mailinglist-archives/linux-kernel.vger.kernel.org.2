Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AD13FA746
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 21:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhH1TFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 15:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhH1TFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 15:05:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719AAC061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 12:04:17 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h1so17767918ljl.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rF+niFEeNmAV+2tj+c7lECcZy2HSYITvh/gs3s2nLnU=;
        b=Fy5vj23LmnfjAR7eMV5uM25f5wYV9TVspMK/lCPHMlANWwJGoxMOi2bxNCrGfV6JCp
         +hcWfsO+hue5OKZDnUiMxfVPazgkvLANk4IJ6rk/zsMdF+KLiGQ3SPYFV6lK3hDl0MRt
         MPwbdts1mdkJ2e1w085CwcQKRmvHByZ5plQ1OBkWkxJo/r9OnA7xEFoGSlGj6ninEkzl
         vMOVlxRriknZnLmGGhPM2jg9M7ILRkJdSxjNIC6NUyajQhupjgxxkJolR5NQrk95KiZE
         7jRpdl+yC1BjIgf1fhH4byry4TlVbobNSFqWa2OeDepKRaMea0aDiYs0Bf+Ahz8sdk9S
         dBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rF+niFEeNmAV+2tj+c7lECcZy2HSYITvh/gs3s2nLnU=;
        b=qr27FeLs2nKOD7fOID8FR1sMcN9AMirSA94+XEzf80Tuo1K1sH8Zd0T5XCpqz4U3y9
         RzoxNCHTX0mj3F8lHHzSgAbx0eAFXDOl4Oq7272ksCFdkxyeJLIm/9PoQwCt1mJAdsrl
         0ZUiRsk9SQOZv5CWDgQgcdb3sry9izq5ezwmuiQlUV6fX5Vvp0DQROYoEcqNB88qo0fm
         0PfRPHpoUwyjTdgF7vm43cU+3EXaF3VRESPN6XbfAvhHqItQQcWYrJQx4rgI90oNpu6c
         NLVJx3knL5MCNfnzUv4hqy1KJ6Ous5j+bZfAWG+O0MbxTTEmRe8uy47J/ZqZZimdGhrW
         mPjA==
X-Gm-Message-State: AOAM532odvxxqA9z36vXTS4Ks13v7PecMvW9sBd3G4hTdwKUWUUdh0fc
        EMnm8h/OC0gmGfIp/hm7hCfRJg+1jPA0S4sIijV/QvY8pSvBKA==
X-Google-Smtp-Source: ABdhPJwIRCN4WaBa0hXTNnzcvBTS77RrBLuC/T2BxDIN3ryKealLEdNSPcgUnIvvOyVifjIAj5xdWco3i/PdzOoBkUU=
X-Received: by 2002:a2e:2e12:: with SMTP id u18mr13079049lju.287.1630177455767;
 Sat, 28 Aug 2021 12:04:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:814a:0:0:0:0:0 with HTTP; Sat, 28 Aug 2021 12:04:14
 -0700 (PDT)
X-Originating-IP: [98.45.152.168]
In-Reply-To: <20210629171224.jhlqyyb3lus323o3@treble>
References: <20210509000103.11008-1-mforney@mforney.org> <CAGw6cBv2NBCDrZb7ZnmAhZOJ_EwgW6tR-8AfY2v=T9OkD=6O8g@mail.gmail.com>
 <YNmHRi+00RAAUmEt@hirez.programming.kicks-ass.net> <20210629171224.jhlqyyb3lus323o3@treble>
From:   Michael Forney <mforney@mforney.org>
Date:   Sat, 28 Aug 2021 12:04:14 -0700
Message-ID: <CAGw6cBs8qf-GWYS-LtrCm+ye-=K_vu1WxDPOROnya_PVod=TGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] objtool: Check for gelf_update_rel[a] failures
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-29, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> Looks ok to me.  Let me run them through some testing.

Just wanted to check: did the testing go well? I'd really like to see
these patches in 5.15 if possible.
