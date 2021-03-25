Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020AE349B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhCYVCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230140AbhCYVCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616706124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5uo0szkizrocSugHz9ejpS0qJiw6xbcngEnKme8A3w=;
        b=DRhp5GmgffsIEwdlJweR9xRAwq6jh+UoJOKaMeCa4XrhLmqtGFEpo6LcXbtpj+9gxYvrCF
        O21I1kLue9oqelhDJuHX5UiggkzehrJiWsKMnl8S9uLH03jpPrsNj5X7pJaVHDAwZI9Xht
        r0+T0VWv9tQxU/zm25twFMmCRn/Rgig=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-8LhBtzFWPTeLZYAc44j06w-1; Thu, 25 Mar 2021 17:02:02 -0400
X-MC-Unique: 8LhBtzFWPTeLZYAc44j06w-1
Received: by mail-wr1-f72.google.com with SMTP id v13so3185012wrs.21
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W5uo0szkizrocSugHz9ejpS0qJiw6xbcngEnKme8A3w=;
        b=GbcUKAO4YI8lxXYlBbPljZkjuSGhsu7kBZWG+9BDjTunQE16R+bV5MuzHWdrd0/OT0
         tdxORxBvgO6QJXWPhJRF68seKaOlStpylvjQzE+fTtfWKEMVY+7tSgow/HTpdf0AZmpI
         dP+GtkGYhbIYUX/+JxUK/l91PE9ervM7YuB2kRp9REu46LCVBcb3LwSOAZB+9xL9CGDk
         xthfaXFmbe3l3WsYDcHHXCSWc6mAqW2ONlngktzci85Eup7E76Mxi9AOCHqVWkoQMWG5
         IYWGZ2QAboV9wxmTBptelx2FrYI8Wla9nHIZ8S1kPEyzA2it6NsfYc/tN+/pVcukDo5q
         EGHQ==
X-Gm-Message-State: AOAM5326nI6j9Nd2UQFhcBl5/1UVvVgMBJwqSrOYxdpcUMK9QQs7abP/
        F06uVOGBg0UY0aPVvBUrsOaJZOy2szPYufG8LfL7jtxoBe9Q+3twrSfwuTxha61Zfq4GS9Ebgxq
        rRYJFtLA2XOJLGNCfSsDL/ec=
X-Received: by 2002:adf:c70b:: with SMTP id k11mr11186604wrg.165.1616706120988;
        Thu, 25 Mar 2021 14:02:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLIOZWDTO2f53ZXf39F2RPQwNxKCIq59rzuOc4rl/gYCdm9FJ9Aat7Jd5M4vlwVDQQ16tI+w==
X-Received: by 2002:adf:c70b:: with SMTP id k11mr11186585wrg.165.1616706120773;
        Thu, 25 Mar 2021 14:02:00 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l8sm9195914wrx.83.2021.03.25.14.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 14:02:00 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:01:59 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: try oom if reclaim is unable to make
 forward progress
Message-ID: <20210325210159.r565fvfitoqeuykp@ava.usersys.com>
References: <20210315165837.789593-1-atomlin@redhat.com>
 <YFN8wXwJA59w9twA@dhcp22.suse.cz>
 <20210319172901.cror2u53b7caws3a@ava.usersys.com>
 <YFh10eSTKY5lbE9u@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFh10eSTKY5lbE9u@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-03-22 11:47 +0100, Michal Hocko wrote:
> Costly orders already do have heuristics for the retry in place. Could
> you be more specific what kind of problem you see with those?

If I understand correctly, when the gfp_mask consists of
GFP_KERNEL | __GFP_RETRY_MAYFAIL in particular, an allocation request will
fail, if and only if reclaim is unable to make progress.

The costly order allocation retry logic is handled primarily in
should_reclaim_retry(). Looking at should_reclaim_retry() we see that the
no progress counter value is always incremented in the costly order case
even when "some" progress has been made which is represented by the value
stored in did_some_progress.

        if (costly_order && !(gfp_mask & __GFP_RETRY_MAYFAIL))
                goto nopage;

        if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
                                 did_some_progress > 0, &no_progress_loops))
                goto retry;

I think after we have tried MAX_RECLAIM_RETRIES in a row without success
and the last known compaction attempt was "skipped", perhaps it would be
better to try and use the OOM killer or fail the allocation attempt?

I encountered a situation when the value of no_progress_loops was found to
be 31,611,688 i.e. significantly over MAX_RECLAIM_RETRIES; the allocation
order was 5. The gfp_mask contained the following:

     #define ___GFP_HIGHMEM          0x02
     #define ___GFP_IO               0x40
     #define ___GFP_FS               0x80
     #define ___GFP_NOWARN           0x200
     #define ___GFP_RETRY_MAYFAIL    0x400
     #define ___GFP_COMP             0x4000
     #define ___GFP_HARDWALL         0x20000
     #define ___GFP_DIRECT_RECLAIM   0x200000
     #define ___GFP_KSWAPD_RECLAIM   0x400000



-- 
Aaron Tomlin

