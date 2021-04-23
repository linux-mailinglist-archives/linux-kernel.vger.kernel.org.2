Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F683369B66
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbhDWUjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhDWUjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:39:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BC9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 13:38:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g17so58136287edm.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 13:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfQYJoLyB6h5ZbM4eg6Kr44fOO/ylFVrCnfKWSRlupI=;
        b=XIrgS7eZvzhqFQGzaCw99zsTJou6Zmn6+qlQS+jLXwjE4/FMmqnjZuwoAcS2cOq9MJ
         YwLvedQjp6Xc7eib13/t2RHH1CRhgf4pLfr2ZnEmQ2s94gOCMX2a7ccCO4BrwX8ELRNz
         pratDifm/U3Qz0LPqF5zfi5UiRmLchv91hKIKYZ7Tcw1b1ngICuDWkuFMKnVbs+PI+lF
         Qx6B6YkP9fV1dUeP+TLUmymxhUAQdBr8fal4P+zCvMljDKJ2AR6ye99CxLvf1/n4xrTq
         ImhgPSL3EFPtqiQITgBoMcFVvYbf3yVITE8jWKMGK2GZw/bT+aB9l6F5n9ZAlNFWYzuE
         W3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfQYJoLyB6h5ZbM4eg6Kr44fOO/ylFVrCnfKWSRlupI=;
        b=scetHlPlKny8LFTpPQs1bfFUbF2Oj1TDz/TK5o/aCPJaOG9NCV6wnHB/eUnlDImx9i
         OB3KXB3sURlU/hemT5SL2s+oW40lw1O3obaX1iCCMK0PnFjDRNxhv5Ul+QxIFAVQCXEr
         qg4GPOM5fAN4yrmYb7dxDzdOdv17UkpDZcqD02DYMc9MhNcH7PC3gaeaj1lS6OMDIFzQ
         q069loHqtk5wk5mM4/r96cvItQCyP9lZPAOYA5xAxhUe32DOihv7uof6OaO6McIDIZTW
         laseKQNnxGthbS+qw5wOi+oCfPmcmJOElWwdFMD8m7VF76O83TT5Qtt20CigRoN4mVFN
         +FJg==
X-Gm-Message-State: AOAM533FpslfAO8KKPFgdy5KZuYd8SchkZbOjwnnRhntXcyW4Bz4xQLm
        iuRoVdnUmCbOp549pvxprOpW0mf7AtHHmM1zzAxHpA==
X-Google-Smtp-Source: ABdhPJyNoSkdooYSFcOxpyxKQDuiru1CJwem5bBb2pWMDB82inZWG0N72kKzPu9nUXH1iLB8MmvByOyiMsdyQh3mpBM=
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr6565480edd.348.1619210337492;
 Fri, 23 Apr 2021 13:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210423130723.1673919-1-vgoyal@redhat.com>
In-Reply-To: <20210423130723.1673919-1-vgoyal@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 23 Apr 2021 13:38:51 -0700
Message-ID: <CAPcyv4hz=nHYQ89-m-7yVJWpEP4gZBYTY6E4POAms9mYDb_N+g@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] dax: Fix missed wakeup in put_unlocked_entry()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Sergio Lopez <slp@redhat.com>, Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 6:07 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi,
>
> This is V4 of the patches. Posted V3 here.
>
> https://lore.kernel.org/linux-fsdevel/20210419213636.1514816-1-vgoyal@redhat.com/
>
> Changes since V3 are.
>
> - Renamed "enum dax_entry_wake_mode" to "enum dax_wake_mode" (Matthew Wilcox)
> - Changed description of WAKE_NEXT and WAKE_ALL (Jan Kara)
> - Got rid of a comment (Greg Kurz)

Looks good Vivek, thanks for the resend.
