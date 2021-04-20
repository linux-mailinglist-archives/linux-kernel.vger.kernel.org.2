Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2932D365F85
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhDTSgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhDTSfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:35:16 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C822C06138C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:34:43 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id z1so44135977ybf.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vAOrCoyYrv8Lm0v4fykeO9V9jTibRdCXXAxqwXvAZpc=;
        b=HIrW8WT9mQHKJPBllBIAPKsWTumJ72st8Jhlxb6coBcFIu5v/yFCGicz6Q8YQEUT67
         vSml9cuPKhRqmq5HoBnwhjiHH6ITsUwzRbbSkdFTqFq0gN4EGVHYC8V57xNy64C6imdg
         z+DfqClwcZi4OhLXdzHT66ZnHqQbBSllmLDiiFuAhNyF/1O8xsWLI1Sq3FDFiglz8H1o
         Bl/p9NK1TYdhX1ievcaXEmGZkNEs9GeWKQUPlItFkTa1i3lr7D+G5rQnHK8gHPQ7fSH+
         Obn8aljmS1elPoWlrh8ysIFsTK5M4QYBsLrmGbm/Z2TGwFcn2WRHZAM/cUXbLBa2Cj8L
         DSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAOrCoyYrv8Lm0v4fykeO9V9jTibRdCXXAxqwXvAZpc=;
        b=U/6OuQqSXQVzj2FKALRm3bgOFSLId6qNh4tKW0CMYF92bmQRiAVOoCS8/HK0HV/gc2
         aufgp0+N/EiGx3qPzaNOfQjLIoey7SZheyz+92ihHEtGhJI+RB+RlZlE1yGmVR1+1x/5
         KYnyA2Th5YzXsqJIM8Hn1NMABNyDUsKm61Z3cyM3/HrtN9uOMK96CjqEJdQgsqghrqWq
         gaJwHIBfvmI8AR8LIA1C6WB0+T3YmaRWFxzrOqRM18/n7O7b/O6nzB/wLLBWu7MwXj1/
         yx+WGb+sfi1wBI0US+G6sQ8H2UII796Ddd6SXVyrZ6t8D5QnBsoT8aGkm7xKsZAm0Qm1
         aWWQ==
X-Gm-Message-State: AOAM5323f8gZimyORfIjp1J/vELiMmDTV7JvA2S/U8j41voT4Mf4OqoO
        qeclud/v01BC8FdHW+xq0H1X46VWkvWZSdz5VBQ=
X-Google-Smtp-Source: ABdhPJykLsBh8EHrMaEKAoX89i+Ci+kFzS5mmksxZ77n8wDBxEcllYxdWRrmBdR2azGDdx5qcyePBN1W8KkuCA1plKg=
X-Received: by 2002:a25:690d:: with SMTP id e13mr26615947ybc.90.1618943682929;
 Tue, 20 Apr 2021 11:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210322114730.71103-1-yuchao0@huawei.com> <CAFcO6XMak8GSRqQbZ3nPdGvV_eM6DL0+P0z1X2y0G9hkrccaCg@mail.gmail.com>
 <beff8953-d91a-c677-f50a-3aba27c15dde@huawei.com> <YH8SvK+OLSKAEYpJ@eldamar.lan>
 <YH8dJQCJm7iqsC+a@google.com>
In-Reply-To: <YH8dJQCJm7iqsC+a@google.com>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Wed, 21 Apr 2021 02:34:32 +0800
Message-ID: <CAFcO6XPM4hrHTh6-DKO8TOCYTsHW-n8QWJywvbvnhTECQTbZeQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid out-of-bounds memory access
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cool, thanks!

Regards,
 butt3rflyh4ck.

On Wed, Apr 21, 2021 at 2:27 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Hi,
>
> On 04/20, Salvatore Bonaccorso wrote:
> > Hi,
> >
> > On Tue, Mar 23, 2021 at 02:43:29PM +0800, Chao Yu wrote:
> > > Hi butt3rflyh4ck,
> > >
> > > On 2021/3/23 13:48, butt3rflyh4ck wrote:
> > > > Hi, I have tested the patch on 5.12.0-rc4+, it seems to fix the problem.
> > >
> > > Thanks for helping to test this patch.
> >
> > Was this patch applied? I do not see it in mainline (unless
> > miss-checked).
>
> Not yet. Queue for next merge window.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=b862676e371715456c9dade7990c8004996d0d9e
>
> >
> > Regards,
> > Salvatore
