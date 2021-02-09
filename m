Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE8B315BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhBJBJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbhBIWas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:30:48 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53802C0698DA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 13:33:10 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id e4so679202ote.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 13:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DubnR59jAY/eOT03jh9Sc1n0fr2f+9zEJ5dJmvj8mQo=;
        b=N0QEv+V+b8Pk7r/94W49Azdo5ySkDcPHHRLOkLJVEcPthpGjZDtBqoQ3yb3cfHB/se
         hxx4BDaK81wOCZLSXRB2Oe9UTvi/9sqRgRj3QqOnsxe2U5eV2CWsJHqe7AxFr3oSWWxI
         cR9A7EjQonGwJejyo1ibxBatzfL50pDSZHCooCZGkNX72uJRvji1qJpWNxT+UH1T+a1p
         2QeRY9MWem+0qOaBfXpmT77o6hvzg2v0C1kgIWftPdhDCab2NlBw63IQGrY9gRwXMUrf
         QGhg0sShE7sMV5d0qr3zvIrJg9IMB7J5+XSXJUZugphojqSlmSfqlrctQkpkx9pBaYZT
         zWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DubnR59jAY/eOT03jh9Sc1n0fr2f+9zEJ5dJmvj8mQo=;
        b=l5NNFApC3aWvFLaoXnFKkSQvVvVRQD1j0Bp4UQ0HLIwEPnuhaJ53FMReGB5eqT0cu6
         8WNYx8xefqeNgyiGouowVlWXeimY1WG16UmqA4B9ogRLW4QKzjbkqmQafCeWwG0+dnwg
         mWwteFACMTW43OYhgedlRXMQvJ87B4V5kRXJVdETsdqSGJOjw+SXp/iJpr18MrNSkPx1
         KtqrIrkovTyobf9uiO3w+XRjubRdR5OaQABAcqYLI5F9Wr/au8dh99ZAwTMi0InDItvI
         TM9T1vis5hX8Q2HdgxaBfsFPTwBSeG4IWedRfU1YNMgUckBRcVHxX111G7+GVl3ZrUZM
         IVbg==
X-Gm-Message-State: AOAM531rqPJWu8TV8oMXrRKXROX6SMn50gvEXBz7DxTdtSWpifCo2rqb
        r3baK2yr7PAzGqr2So32fXcAtfZ5/kJGd4CmR3CWBQ==
X-Google-Smtp-Source: ABdhPJzgsrqOvA5diVA1gUUZvIRYR0Xc8yzoxRR9IHuBSuq0Wdtj0vxIz3wjTSlEQ8NGpmadCS1vGVxOg/2NiSRMExE=
X-Received: by 2002:a9d:6016:: with SMTP id h22mr10236542otj.63.1612906389614;
 Tue, 09 Feb 2021 13:33:09 -0800 (PST)
MIME-Version: 1.0
References: <YBkT6175GmMWBvw3@google.com>
In-Reply-To: <YBkT6175GmMWBvw3@google.com>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Tue, 9 Feb 2021 13:32:58 -0800
Message-ID: <CAJmaN=miDwb4CvVDmLS4aBKsNOVp9XiDKB1Dp3s6cfrq4yXiQQ@mail.gmail.com>
Subject: Re: [page-reclaim] Augmented Page Reclaim
To:     Yu Zhao <yuzhao@google.com>, Sonny Rao <sonnyrao@google.com>,
        Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        page-reclaim@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ======================
> Augmented Page Reclaim
> ======================
> We would like to share a work with you and see if there is enough
> interest to warrant a run for the mainline. This work is a part of
> result from a decade of research and experimentation in memory
> overcommit at Google: an augmented page reclaim that, in our
> experience, is performant, versatile and, more importantly, simple.

Per discussion on IRC, maybe some additional background would help.

In looking at browser workloads on Chrome OS, we found that reclaim was:
1) too expensive in terms of CPU usage
2) often making poor decisions about what to reclaim

This work was mainly targeted toward improving those things, with an
eye toward interactive performance for browser workloads.

We have a few key tests we use for that, that measure tab switch times
and number of tab discards when under memory pressure, and this
approach significantly improves these (see Yu's data).

We do expect this approach will also be beneficial to cloud workloads,
and so are looking for people to try it out in their environments with
their favorite key tests or workloads.

Thanks,
Jesse
