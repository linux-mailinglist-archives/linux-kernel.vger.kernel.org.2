Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E3E3829D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbhEQKdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbhEQKdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:33:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D91C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:32:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a25so6213787edr.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o3PHrt9OnWYQ4pmyri9gi+eqTsu2aHBAA4k1sqajL94=;
        b=TN/2E4qAf5H2eY04svEUzPhzsxXWz+hCFjJgCpFBGgHNszkEG8/B5Dj2n9wO8+XcnT
         n9C9jYWdyJ1kqd+24O26R0eRvXp/ijIH8zdZXyQN9LP3NJ59RDpCfAznlfpud+lmQ4Ov
         xZcY5M28IUUh9XeyiqNxU71RHPXHuV8jPY1WtVVNKIG4fAAC9JDqHZbcz40JUZG9L8J0
         EtUGyjZ6Nmm48cjclUnagOpY+hS6UsQgF6WBabZx/j1FcDXt5n5GJbHWPQPSN96yXssF
         tg9vGbjGTR0sGxrDLC2zCnWsOsceV3NUXkothDpasExrMQ0Q+E3ObASfqs8sPEBLp0bp
         mSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3PHrt9OnWYQ4pmyri9gi+eqTsu2aHBAA4k1sqajL94=;
        b=j8OwNViE42pCffF2Zp7JXbzgmzRLo9bF7RAprwvzfgrSnizCg+Cniem+Cb/+eHG1hp
         GyzZrtYuQN8VdrH/8QeJ/N3GN9bQ1CNNhUZqQRgrpKtVMdRaDwpSFKlymYZFiaiV38QA
         QGQFboU5zfTpTu08ro9pbviRAhejb7EPwoc05XSRJJ5Ctv+fTjnxlA07s4wbcj28h7rJ
         3x6tIXZOfDLNu9pnwQtbC6a3KJfKkDa483DMAH/8xwXVOqPhH7gYPMHSQVJVRyms124p
         m2oCJfmgVAoPsKKAAxcYQ1ELg9dW7+wktCwn0yWST0ndgXH8jSvWoCTB9PIp2RBJ8VEm
         Hotg==
X-Gm-Message-State: AOAM533FPWjbIxH7OYy/NHX18y7mpFB2HkDljre3ABkz8TbM2Co0/cxW
        PMGJCromvqM/M4yToVPzKL/V+B3zSUbRiV77ZQNlhhCadg==
X-Google-Smtp-Source: ABdhPJyHdS/eLnCrE5Sk2uzSQ0KmKYA9aE3vrQTk2avVn1N79P3dfi+GDFY16zkW+js7/1HTTSa3uAKclstNxBm58P8=
X-Received: by 2002:aa7:cd55:: with SMTP id v21mr120416edw.344.1621247532679;
 Mon, 17 May 2021 03:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210517083557.172-1-xieyongji@bytedance.com> <YKI9gHMjbz8nAvYp@codewreck.org>
In-Reply-To: <YKI9gHMjbz8nAvYp@codewreck.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 17 May 2021 18:32:01 +0800
Message-ID: <CACycT3vayYaBhcui8889CDyrL_5DPezCkTA88SJ3e0Di021JEg@mail.gmail.com>
Subject: Re: Re: [PATCH] 9p/trans_virtio: Remove sysfs file on probe failure
To:     asmadeus@codewreck.org
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 5:55 PM <asmadeus@codewreck.org> wrote:
>
> Xie Yongji wrote on Mon, May 17, 2021 at 04:35:57PM +0800:
> > This ensures we don't leak the sysfs file if we failed to
> > allocate chan->vc_wq during probe.
>
> Right.
> I'll add a Fixed tag and take to -next shortly
>

Thanks!
