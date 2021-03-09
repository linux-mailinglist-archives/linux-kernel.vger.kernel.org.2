Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A53331BE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhCIAp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCIApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:45:14 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82166C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 16:45:14 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p8so24102560ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 16:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQe1AbiZhxgjMUYYGXlYzpJ40d5EmgWOr56kHx2VkgA=;
        b=kvefS7LytgcL5mOrqW9KkUyo6D+WmvTdbuG5uk5Q98GrqstXZ2L3y5SzNRaQO+GDYQ
         9UelCieNXwKcDfOKYH7R5T82w/mvZgoGnV2615ThR+sJM4DOIwi/aDhGA7HIFUdIjTLn
         Ac0fTnJr1NYpDatykpCgjJVXbLyMM8wuieRiPv0vFwoOGnwhF+G5ItYV2mC54nm+2MH+
         Qrd/5rYfDpE5dhB06qyZfg4XpVhOeYHtbvVd/MgUt5vw9XmgMcA5PaDcNzn3Qr9J30TW
         eL/RAlY0mDgQEYrLiitrSuJucLOUP/hRLd/V1uhF3++o0XzegPqYIcQ3Oe9xvYk8HAHT
         dA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQe1AbiZhxgjMUYYGXlYzpJ40d5EmgWOr56kHx2VkgA=;
        b=OP+RS7ZBM4kPHf+VWny3npk0uCzd3YUmM667wJ+BOKMvwBATLJMopZmDXfZkcJszDo
         efy0j0czlGwOWqCcy4EtMv6JsIuELH3Ol8KUemkr/OWio1Jub7bOwu5XZaVIZy0WKuio
         zQ933D+db3fBJPtjzgNzgssMIO6e9qZAi78ZFXjvlDzuZd+0Vi3Nbb/rIIbAq9WZZJhn
         ndOjbPp9bCh0mYchgGeJMMLgrqeqVFK5RTvWANvYPE3sZZ/6q/nlA5aADJgjhyMRtL8q
         Ptra6nGrE0xObeWoT5HS97DJrCADbYOXXuz+fOR2Ln94EXtt99u+h+u26oZBZ0Wv8tKV
         bv6g==
X-Gm-Message-State: AOAM532N0euWzxhR3YvhvLMV8heJI7T1Kp6swB/dkj8tNWtf0zpcArvo
        8MvjWnTUDkoJMsAnNx/0sLvZEJaUlJ+4ElQO5uRj
X-Google-Smtp-Source: ABdhPJzDPSLT5v0CWN+7wPUx3EFHHng+i6xxLMNsRHv2Dzj+PYBE9FtYWEltECxLGB7vqix+CzY1DxMAv3yAiTYjLy8=
X-Received: by 2002:a17:906:a443:: with SMTP id cb3mr17286079ejb.542.1615250713261;
 Mon, 08 Mar 2021 16:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20210308110338.259868-1-xiong.zhenwu@zte.com.cn>
In-Reply-To: <20210308110338.259868-1-xiong.zhenwu@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Mar 2021 19:45:02 -0500
Message-ID: <CAHC9VhTJCMc16j5XTb8cEkgvaLCao0C5s7eT4tp4u6o0Kx6eQQ@mail.gmail.com>
Subject: Re: [PATCH] security/selinux/ss: fix misspellings using codespell tool
To:     menglong8.dong@gmail.com
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, xiong.zhenwu@zte.com.cn,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 6:03 AM <menglong8.dong@gmail.com> wrote:
>
> From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
>
> A typo is found out by codespell tool in 16th line of hashtab.c
>
> $ codespell ./security/selinux/ss/
> ./hashtab.c:16: rouding  ==> rounding
>
> Fix a typo found by codespell.
>
> Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
> ---
>  security/selinux/ss/hashtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

-- 
paul moore
www.paul-moore.com
