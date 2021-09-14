Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4E240BBC6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhINWnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235464AbhINWnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631659309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sSbtSJ+PvQ6E93dXYQocVErZozE7Aq2559kRiUmchIE=;
        b=fapfXZwwIqP7bk84I5U3gGpD6K+LtWH0q4YE4ap+wRaobP8N7EnLjkc+AIjUqm9mQU5Mry
        i2O5KXoWDmw2KCMChz8a/1KZaBtLsXoy2qS//aQ/2SXf/hu6VeJMarS0LJiBdzJSP1H0Ru
        9OIYjct3hnT4otdxWvUROlguYSiE5YQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-uwsZMrKGMIec4yvo6PKccg-1; Tue, 14 Sep 2021 18:41:45 -0400
X-MC-Unique: uwsZMrKGMIec4yvo6PKccg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0614F835DE0;
        Tue, 14 Sep 2021 22:41:44 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E6505D9D3;
        Tue, 14 Sep 2021 22:41:43 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DED69220779; Tue, 14 Sep 2021 18:41:42 -0400 (EDT)
Date:   Tue, 14 Sep 2021 18:41:42 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     cgel.zte@gmail.com, hare@suse.de, axboe@kernel.dk, tj@kernel.org,
        viro@zeniv.linux.org.uk, xu.xin16@zte.com.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        zhang yunkai <zhang.yunkai@zte.com.cn>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH linux-next] init/do_mounts: fix potential memory out of
 bounds access
Message-ID: <YUElJqNI9VVL/SI/@redhat.com>
References: <20210913114336.83684-1-xu.xin16@zte.com.cn>
 <20210914202349.GB9406@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914202349.GB9406@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 10:23:49PM +0200, Jan Kara wrote:
> On Mon 13-09-21 11:43:36, cgel.zte@gmail.com wrote:
> > From: xu xin <xu.xin16@zte.com.cn>
> > 
> > Initially the pointer "p" points to the start of "pages".
> > In the loop "while(*p++) {...}", it ends when "*p" equals
> > to zero. Just after that, the pointer "p" moves forward
> > with "p++", so "p" may points ouf of "pages".
> > 
> > furthermore, it is no use to set *p = '\0', so we remove it.
> 
> Hum, I agree it is somewhat unclear that the assignment cannot go beyond
> the end of the page although I suspect it cannot happen in practice as that
> would mean parameter PAGE_SIZE long and I suspect parameter parsing code
> would refuse that earlier (but don't really know kernel cmdline parsing
> details).
> 
> But what I'm quite sure about is that the assignment is not useless. If you
> look at the loop below this assignment, you'll notice it terminates on
> 0-length string and the assignment creates exactly this string at the end
> of the split parameter. So your patch certainly breaks things.

Yes, that '\0' at the end is intentional so that we terminate the
loop right after this assignment and count number of strings and
return to caller.

Even before recent changes, get_fs_names() was doing same thing.
It was adding at '\0' at the end. So behavior has not changed.

Now question is, is it easily possible to pass root_fs_names big
enough that it can overflow the page we have assigned. If yes,
then we can think if putting some safeguards and truncate the
passed string and not overflow into next page.

Thanks
Vivek



> 
> 								Honza
> 
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Acked-by: zhang yunkai<zhang.yunkai@zte.com.cn>
> > Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> > ---
> >  init/do_mounts.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/init/do_mounts.c b/init/do_mounts.c
> > index 2ed30ff6c906..ee1172599249 100644
> > --- a/init/do_mounts.c
> > +++ b/init/do_mounts.c
> > @@ -348,7 +348,6 @@ static int __init split_fs_names(char *page, char *names)
> >  		if (p[-1] == ',')
> >  			p[-1] = '\0';
> >  	}
> > -	*p = '\0';
> >  
> >  	for (p = page; *p; p += strlen(p)+1)
> >  		count++;
> > -- 
> > 2.25.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

