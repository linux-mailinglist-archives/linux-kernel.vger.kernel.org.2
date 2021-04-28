Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66AC36E0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 23:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhD1VZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 17:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229589AbhD1VZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 17:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619645075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFCzP5qJK5eGZax8gq5U3Ft3JKE+J1wlXK63qQnyBD8=;
        b=Qk3zEfxrGJJqHn97B8V1k2eZwPXSlgsdHP28KXdPXglGO91WT06kNogR7jRFp/eE23MVa9
        WpLcoTwQFqRMZEGxJj3AO7hKb5aMoUO1kxOOrMOBpYH9ARdgk1ypxCcW6kClPJ2h1ibaM9
        BpfvvBWi06GOr+k3l8zMBfInRowJQDQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-fU0aMV52McWlPoSlfGUcPQ-1; Wed, 28 Apr 2021 17:24:33 -0400
X-MC-Unique: fU0aMV52McWlPoSlfGUcPQ-1
Received: by mail-qk1-f198.google.com with SMTP id 81-20020a370c540000b02902e4d7b9e448so4673680qkm.16
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 14:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EFCzP5qJK5eGZax8gq5U3Ft3JKE+J1wlXK63qQnyBD8=;
        b=W2oT8qQX7A/dXlNSG0XpRb1aNktWI3Q+mYiE5/0kYUiyqnHMpqPOMDy1PmmsshJYh3
         CnvdzcJc6huqh8sBvPp/7y/+rrzMP8C2e4v4muD9VrjkuJUIpvPwb/C0mRuCjMFYwYkQ
         MNl6QNX0QWkWNW9YHFb2WSzBAlTjzSntyU1o2c4kGAoF7pP6R2H+IYKdycKbhw+cx/hd
         H8z9ZrNW9tlAgu/IAfYcmifoJcR+j4y0QS67sxOpSWeQW8lgLHOrDeHC53tD1MVQlrpG
         +DQw0Ao4e8NydQgJXoaClqNMYrqJCUcX1+Xr3M10tInlKV3gqu6h8+5jyCNQc1ifg09G
         VyfA==
X-Gm-Message-State: AOAM533FSFZGV/c6xa+PLUtEpr7yWApD7heKIe29BHMr/zW9myxJ3DrD
        U+4RPdxuQDmzW5EbD7a0/lojQrIdhIvuVkr8CMHpLJwOP66Ky5LW+JNZe5HVV6PdQDuhRXfW93j
        J6KDBQVsKQ864c735tQXQs8be
X-Received: by 2002:ac8:7686:: with SMTP id g6mr27970068qtr.388.1619645071814;
        Wed, 28 Apr 2021 14:24:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcVlR7RdzQyf2t9nA1CIAlFPd/APgjYBzJiXMmSCDjh9XCboX300S+/b3vZCnyxgfeaXSWPQ==
X-Received: by 2002:ac8:7686:: with SMTP id g6mr27970050qtr.388.1619645071537;
        Wed, 28 Apr 2021 14:24:31 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id i23sm842088qtp.61.2021.04.28.14.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 14:24:31 -0700 (PDT)
Date:   Wed, 28 Apr 2021 17:24:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: release page in error path to avoid BUG_ON
Message-ID: <20210428212430.GA6462@xz-x1>
References: <20210428180109.293606-1-axelrasmussen@google.com>
 <20210428183943.GH6584@xz-x1>
 <alpine.LSU.2.11.2104281338380.9009@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2104281338380.9009@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 02:03:05PM -0700, Hugh Dickins wrote:

[...]

> > > +			put_page(*pagep);
> > > +			*pagep = NULL;
> > > +		}
> > >  		goto out;
> > 
> > All "goto out" in this functions looks weird as it returns directly... so if
> > you're touching this after all, I suggest we do "return -ENOMEM" directly and
> > drop the "ret = -ENOMEM".
> 
> No strong feeling either way from me on that: whichever looks best
> to you.  But I suspect the "ret = -ENOMEM" cannot be dropped,
> because it's relied on further down too?

Ah sorry I just noticed Axel didn't really touch that line.. :) So yeah please
also feel free to keep it as is.

If to drop it, "ret = -ENOMEM" can go as well, I think.. since all later errors
should always reset variable "ret".

Thanks,

-- 
Peter Xu

