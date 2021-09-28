Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F56B41B947
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbhI1V3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242846AbhI1V3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:29:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631ABC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:27:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s75so445315pgs.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=br290Tj/mSC90lE7ySVxFB9stZwop7hbq88H7crcvgg=;
        b=e5HTGsZJi6fWGBM6AcacATHhN8c7bLc2anp+Y4oDB6okK2n79Hix9DKEYuNb4lOwxT
         Mstp/i2VVgVatfhTy8j7w/goxqiZvwPb7O5XciG371Guj9ch9f5u7V2V3TmlFelcJGhD
         S4TFG31sulRIwSfhxR9X3+dHIjcjHAYdpuwB23m37i+7rJYrfsfkWBb+V6dojiDvgp70
         itfhwHrLZGK3lHc4JMu3sU69gwCRj4t+35XzanzngwDIZMJwsocXi5L8XsJH7ALEjtE0
         Zz07wCM3dpQI8mPMvhL4gZdf0HeU5TGueulmypJBFrAKLBWa9f2M8AqdcPAzVfOHQ5By
         GCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=br290Tj/mSC90lE7ySVxFB9stZwop7hbq88H7crcvgg=;
        b=besJ3T+l+z+Yq1OvSRL/p/nW11Zu8hfFpLZ7SlcL1N20dUPeDMrZsLeZyCsadPLmmJ
         U9z2YNtqYwRua8bgMT4NOL9iiFdjNQWjjgKEdmJcPJG+snaWSRLjvSMvxhGr2EZMGufT
         FzWppddKm1Kx//RpTOZo6Z91LThco4U3I9vszG9G4U/4XVhnbl3ln/rMv/pkowFXkrPI
         jBwH7YI1NJWQsFCrOKD9SVlRo4A0lHmVJNpmOYlJkZ3sy9XbzsP4H1NwMRHFsatOJaOu
         2vep7bMonoxpd+mtM1Bfg4WwX5YSVKANxLCR5M+R+8JjizHI6XNZXMFC3iOiU7k6mOAc
         5xvQ==
X-Gm-Message-State: AOAM530VBWe3dEFIv3n49qREfN/c5dAYKdXYsnkHVYgNibsX/D+x/xOG
        hFB/pCnJ9a0kdPA/daGDsxGofw73YD53ZK/t2kyH7FYK2Bs=
X-Google-Smtp-Source: ABdhPJxHoUUGD6Zt1BOyA5p0v05lqpOjQkL2Ew5z+83KrKSa2vasHq17v12TTddQEdUMYE6JPJW/TBHPHITq8xq/qhg=
X-Received: by 2002:a63:1550:: with SMTP id 16mr6551694pgv.442.1632864461688;
 Tue, 28 Sep 2021 14:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <1631172276-82914-1-git-send-email-xiyuyang19@fudan.edu.cn>
In-Reply-To: <1631172276-82914-1-git-send-email-xiyuyang19@fudan.edu.cn>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 28 Sep 2021 14:27:30 -0700
Message-ID: <CAFd5g45mgi-bnTEiHshpyxnah74toncgCgmcQcHq=kP3L3r+Vw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: fix reference count leak in kfree_at_end
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 12:26 AM Xiyu Yang <xiyuyang19@fudan.edu.cn> wrote:
>
> The reference counting issue happens in the normal path of
> kfree_at_end(). When kunit_alloc_and_get_resource() is invoked, the
> function forgets to handle the returned resource object, whose refcount
> increased inside, causing a refcount leak.
>
> Fix this issue by calling kunit_alloc_resource() instead of
> kunit_alloc_and_get_resource().
>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
