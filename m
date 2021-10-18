Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D797F4329C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 00:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhJRWbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 18:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJRWbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 18:31:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C02CC061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:29:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w19so4868430edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zuoZMKbiKNaH3XCwS1R+3sTXVzpWLyuoW871drFzkY=;
        b=vgTflpxrKVgoupN0TqS1G+MlxzzTMNQ4cy0i6FsdRsw2JtJSfFg9cyPkIzPXdjnvk4
         kYaOvVEPAq9oVlkU64zq8+aOqCBFgzp4uCbGvfWEVhNJ/thHuzmzVwnvx6urAjGprYvs
         9DlrONk1sQ8l0KykDCbCmLzAnDQbKpGLYisagMZOb0UdLsB0QhLrkbRsKGTJsYQ7ZC2W
         NLBrpyFFtv1+gzfIvdKnlshG+Bd/nVSwV9KIIE5NNAkYqKnbNLVP/wN0JpM5L0Z37v7n
         X01Xy156gkFDRedPZPwhB+D+3KplU494K102kmSLHmrDXIcRPp8GDx3FhFN3o14DY8IN
         0wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zuoZMKbiKNaH3XCwS1R+3sTXVzpWLyuoW871drFzkY=;
        b=ZEi+Qf4Wb4nNJIY9qYYizVNv8z2NazS364juojzpi5pg+gbV1dsRp8NwxKfoexlRHE
         HNCAQTemFAes+ss7hpUi+Ry0/SuYdXzw+D2ynVw1/f4Y/fOMPX5ny9QIeg49lPQOmU1C
         XH+P+yFNs+3llj1acrYmjOwefFJLz6Q/QggYh2jx/GePr2DGmZPqxIKmtsZD3AEZoJeu
         FY1Kul1qSUH8D4D3+QtqMg0NuAQ1geVw4z1aeVsdJ6QeSj2Dog0KbN+a72cPosdLhwBP
         MijFlAY+mjojwyrIr1ned4dUJ9WONgtwmzpmN/e+D36ZV+IfSy+iVepfdrvC48I85Lgt
         CiCA==
X-Gm-Message-State: AOAM530n9lj8sO8M+dFQfDUVXujNf0GdDPR52HH5KPccAVE7ABUOzhjE
        Jhjqdi56c2nGKvQzpi6wpsH+LtzDWts737x67K7w
X-Google-Smtp-Source: ABdhPJzbpf9mdL4XAObhLSgLto4FuDw6K0yFGOIT9nqJHNaTcdUyKFisd7iHJVnov0GR1iqXFMnlGG3k7/xdJN2c5uY=
X-Received: by 2002:a05:6402:5114:: with SMTP id m20mr47737847edd.256.1634596146578;
 Mon, 18 Oct 2021 15:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211016072351.237745-1-cuigaosheng1@huawei.com> <20211016072351.237745-2-cuigaosheng1@huawei.com>
In-Reply-To: <20211016072351.237745-2-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 18 Oct 2021 18:28:55 -0400
Message-ID: <CAHC9VhRrVoKn43F4KdWVp9_mJ8Kv9azvptiBkSTdBx+YcnW5ww@mail.gmail.com>
Subject: Re: [PATCH -next,v3 1/2] audit: fix possible null-pointer dereference
 in audit_filter_rules
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     Eric Paris <eparis@redhat.com>, rgb@redhat.com,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 3:21 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> Fix  possible null-pointer dereference in audit_filter_rules.
>
> audit_filter_rules() error: we previously assumed 'ctx' could be null
>
> Fixes: bf361231c295 ("audit: add saddr_fam filter field")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  kernel/auditsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you for the patch; I added a stable tag and merged it into
audit/stable-5.15, I'll send it up to Linus later this week once it
has gone through some additional testing.

-- 
paul moore
www.paul-moore.com
