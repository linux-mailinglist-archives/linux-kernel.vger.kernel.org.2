Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98CF366218
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 00:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhDTWOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 18:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234224AbhDTWOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618956809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QHpVgVIqlHGDvRlPmlmnlx8k/YvIdZkYRQ1Z0QDjGXc=;
        b=MSt5uXSh9TNrrFPs8+czcFVLDysoaHqmjiBLXhXY6afni/qndaC16CD4zN7X+YcI8LB6iU
        SwWVbeXtPu090n7E52eTN7Lz3AbqB9l4wIsVkJrgEXnpn6fqSVewYOyfmS+/K4jG7h6l5h
        g9ZEYAK6CqiKnOxtyda5vGod1f0h2Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-JaoNB8FAPZm9Kx7iOtOj5g-1; Tue, 20 Apr 2021 18:13:24 -0400
X-MC-Unique: JaoNB8FAPZm9Kx7iOtOj5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3AF983DAA3;
        Tue, 20 Apr 2021 22:13:23 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFEF519D9B;
        Tue, 20 Apr 2021 22:13:23 +0000 (UTC)
Date:   Tue, 20 Apr 2021 18:13:23 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 077/141] dm raid: Fix fall-through warnings for Clang
Message-ID: <20210420221322.GA16676@redhat.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <d17978db8a2bae019d2c858a51e9f6abf8ea8947.1605896059.git.gustavoars@kernel.org>
 <02133499-e619-77e6-7ec0-79a238258f81@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02133499-e619-77e6-7ec0-79a238258f81@embeddedor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20 2021 at  4:15pm -0400,
Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:

> Hi all,
> 
> Friendly ping: who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 11/20/20 12:35, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/md/dm-raid.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> > index 9c1f7c4de65b..e98af0b9d00c 100644
> > --- a/drivers/md/dm-raid.c
> > +++ b/drivers/md/dm-raid.c
> > @@ -1854,6 +1854,7 @@ static int rs_check_takeover(struct raid_set *rs)
> >  		    ((mddev->layout == ALGORITHM_PARITY_N && mddev->new_layout == ALGORITHM_PARITY_N) ||
> >  		     __within_range(mddev->new_layout, ALGORITHM_LEFT_ASYMMETRIC, ALGORITHM_RIGHT_SYMMETRIC)))
> >  			return 0;
> > +		break;
> >  
> >  	default:
> >  		break;
> > 
> 

I've picked it up for 5.13, thanks.

Mike

