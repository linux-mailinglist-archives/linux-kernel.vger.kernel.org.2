Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E086F419D15
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhI0Rle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237484AbhI0Rk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632764359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NdtzMn+WC7NxHhaIPrEy29/cG597R32mr5hQD2dXXIU=;
        b=dR0xSXmcS1zTUrJwNGBUkQ0Buk3RaWT8VyPmC+zU5bpeCojA2G1hwKpz1eZcWXpdu91Du2
        MuLDyxfr9li4UhEl/bZ/4RtdUAAMCWJtwUDQZImORU83vfyyapaIa4+xHi78kpFmtQtG+Y
        lV5c2U1oDr9iPV13AnCDkYk9kB97fbQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-cYS6GCbqMxmX442qO73yAw-1; Mon, 27 Sep 2021 13:39:18 -0400
X-MC-Unique: cYS6GCbqMxmX442qO73yAw-1
Received: by mail-io1-f69.google.com with SMTP id m19-20020a6bea13000000b005d751644a6eso10810700ioc.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NdtzMn+WC7NxHhaIPrEy29/cG597R32mr5hQD2dXXIU=;
        b=q15wFvR/r0u+2UzrqKA8OsIev8sAfWFdLXQOPMMksdDj0TWBJLtmK9u4yqoHer7E55
         Dk+cRQihuTS74TIonlZXFDrA/kBMsHjPBZbp9NOJwxvN33mT2WnUTCRWYNPG00SsFcct
         OngrgTWQLpFQd1MbEa4hM9qZ1JsQLxXrtRLYgrgCHR3u2zpe0pQSctnoV8s6P6SxgOUC
         oumf5Y+GxnNVAW7+to8i/iZxbY/fYpnk5ChyoH7UVRNQCZlAPiayslD4wXJfrcPKLQ5u
         IOZHTHlfZ0GkfLKOj7uPDcgpIfG9SVGcstVMY0l48c6VreuuswgMqxpD0unebHs2QK9z
         uh6g==
X-Gm-Message-State: AOAM530ws7C3HSB81PeMT+whKbjBtzjok2HVgiV+W/bQuLuaEBz0jB0U
        +bVGmnM7cafNBUL83poyDA6tPQiXkHK8P/8J6pmtFzGnBQRq4/ZW057GpdQ3DNfmIoep8ESS5NF
        KsDlux+V2efTrzYOkpamRroJ/
X-Received: by 2002:a05:6e02:1065:: with SMTP id q5mr956314ilj.14.1632764357703;
        Mon, 27 Sep 2021 10:39:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtzhiDWx+2ieyECJ0B7kImxGF2XnYiIelB+sXILXn1t4biruYRD/P0iUhweS3xhyS1ZKLjqQ==
X-Received: by 2002:a05:6e02:1065:: with SMTP id q5mr956305ilj.14.1632764357534;
        Mon, 27 Sep 2021 10:39:17 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id z4sm205924ilp.64.2021.09.27.10.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 10:39:16 -0700 (PDT)
Date:   Mon, 27 Sep 2021 13:39:15 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, Li Wang <liwan@redhat.com>
Subject: Re: [PATCH] mm/userfaultfd: selftests: Fix memory corruption with
 thp enabled
Message-ID: <YVIBw8ATbCIAbd2d@t490s>
References: <20210923232512.210092-1-peterx@redhat.com>
 <CAJHvVci8ig4WCY2aK-GvmHP=Uw3s8DrGahk-Yh37GX2kR35kww@mail.gmail.com>
 <YU4uJLJHsHLVsS2w@t490s>
 <CAJHvVcjniq3TS=69O2tkAVD02tRCnRtw1Xf5Hu2Me4deQbq9sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcjniq3TS=69O2tkAVD02tRCnRtw1Xf5Hu2Me4deQbq9sQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:34:06AM -0700, Axel Rasmussen wrote:
> One possibility would be to MADV_NOHUGEPAGE the regions, which at
> least would fix the immediate flakiness. Then we could spend some time
> adding a test case which specifically targets THP interactions? (I do
> think we want test coverage of that in the end, but with the current
> tests it's kind of "accidental".)

If we can't reproduce it with khugepaged yet, I'd think we can also consider
keep torturing thp with this patch and at the meantime look for a clean
approach?

Now it's only the event test failing, if we apply NOHUGEPAGE we give up thp for
all.

-- 
Peter Xu

