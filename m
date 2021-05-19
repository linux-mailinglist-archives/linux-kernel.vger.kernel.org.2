Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746813896FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhESTtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232212AbhESTtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621453713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l8/USwElDF6oj5/aVhPUN8/jUy5vgh63dDs+ZspH7HI=;
        b=glVi1EL0p49Uv73zTyAciufUO18VszD5dRU1NYq9q+beOTj603FWUR2G7Da3EJirBuOVMo
        YydgbwkU0Tr7F8oUAFfYmPzndchcfJbYfxiK9j9abGB2EXPSlE8JtAq/5OleY5+slsvgVK
        nH1SIG2uErmtfeE/hxSv1nIsRcGX0Go=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-kDviJu_KOeC7lGiQF49XVA-1; Wed, 19 May 2021 15:48:31 -0400
X-MC-Unique: kDviJu_KOeC7lGiQF49XVA-1
Received: by mail-wr1-f70.google.com with SMTP id 93-20020adf80e60000b0290106fab45006so7602224wrl.20
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l8/USwElDF6oj5/aVhPUN8/jUy5vgh63dDs+ZspH7HI=;
        b=qA0BAtcu1sjd2jAuqmZmPV7/RGKftQe8cpZ2f8HEFh1feN7f+2SlDjboCDFHXcDJbb
         mypeLkcGRpfxog1iqyEirtdxPdQc1KueBWAdeGSgZwnWRvbgvMbGNBRAMVyYRPGtEEl3
         bBIkZ6D/47/8OR3CQyjIwv/60gwyShApn4IwZIg4nmoAex//S2gjuP/J9P7mp6TXDbP2
         mDttgQHBdwPGQeheGLzSXHR3o6/D/Vw6jnUJoCSHkBerH94AonL21EwMNlWGP1TCFXFo
         LAQL3rQRGcyqXXsqKa7IgNKbXM9KaLnvn1fCxDn2u+GHCw6ugz5F0/IiN635EugRq0Fz
         dBzg==
X-Gm-Message-State: AOAM53014ZIoxEoTvsJPDwm06vXVdRrSccpRBNokIQf9UMhNRwfz6zv5
        3V9R5/cpwwFHUIJL9OosFFQlNfQkWdmzt6J3MpFsufihKQTnmBlOuKEHvZGcFtqW6v4h+4Di/sF
        vNKqNu64P5XeT2zYrQL1dDvk=
X-Received: by 2002:a1c:e156:: with SMTP id y83mr722847wmg.89.1621453710316;
        Wed, 19 May 2021 12:48:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3ab8RbkH5w4sabhmqxCp0dpZ3QX7ubr6x9WwGVuiP/WtqOKaUqk1cpJRCsR9S4Dvrp4ch8w==
X-Received: by 2002:a1c:e156:: with SMTP id y83mr722841wmg.89.1621453710154;
        Wed, 19 May 2021 12:48:30 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id r11sm440744wrp.46.2021.05.19.12.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:48:29 -0700 (PDT)
Date:   Wed, 19 May 2021 20:48:29 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
Message-ID: <20210519194829.sess6lhfzlmccpdu@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210519192321.3247175-1-atomlin@redhat.com>
 <YKVn69o1UizH0kJD@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKVn69o1UizH0kJD@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-05-19 20:32 +0100, Matthew Wilcox wrote:
> On Wed, May 19, 2021 at 08:23:21PM +0100, Aaron Tomlin wrote:
> > +++ b/mm/page_alloc.c
> > @@ -4252,6 +4252,9 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
> >  	if (!order)
> >  		return false;
> >  
> > +	if (fatal_signal_pending(current))
> > +		goto out;
> 
> I think 'goto out' will be confusing.  It'll output a tracepoint, which
> isn't going to record that a fatal signal is pending, so it'll cause
> some head scratching for someone looking through the traces.  I
> think we should just return false here and skip the tracepoint.

I agree. Having said this, I do plan to send a patch to illustrate why
compaction should not retry to avoid possible confusion. Nevertheless, I am
happy to modify as per your request.


Kind regards,

-- 
Aaron Tomlin

