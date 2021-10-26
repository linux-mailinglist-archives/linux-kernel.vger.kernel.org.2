Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9C643AA66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 04:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhJZCoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 22:44:19 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:40557 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhJZCoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 22:44:16 -0400
Received: by mail-qk1-f170.google.com with SMTP id x123so13809140qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 19:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NIMQhTSA9FAdcOXPvrauG7Z+Po3zyqmjnlqLeXJDFUw=;
        b=p1Bt4GccmF6lVcHqSEcyMQPFZ0bg90fm9W1WQm6nLnp6DnlKSpz7AenMe1D5Rn1bCf
         NMorX4pQZzKAEvVM57F3C9/TPl0TfXJPi37cwczjpIUl43M+WcyCLA92cwXym3QV36AC
         ZnDNMuCGU+FI5edgm1dEnoftcYlTQAMRsS3fU55b5fvBVeAcudXTzQ6SN6DqC6+QNMfC
         DnVLnJlpekaR2H/HiE7542sWOYP1s+a35kpfRLoMVrRR7d9XBB0+qa6Dh7JYhXCilvfS
         LEYZfn6xeZ38VXzF3uSBtXGQjuAv1OvpxJKmG7mm1DGi+Cf6A2B/1TBPywFnuOb9i2G7
         tO9A==
X-Gm-Message-State: AOAM531OumAODTkOpWkoaNBc+E67bp0P7LpaDUvemRT0Pyr09EDARXGq
        r0bYV2/IJFC+uaX3uhnwRPM=
X-Google-Smtp-Source: ABdhPJxJVgPz78GJZ1ef2Z+ptkjs7fvTeMbYL3OD4kSiMlssIJbRFWu6ZkVyfzuv1PtQYW2gYYa9wQ==
X-Received: by 2002:a05:620a:d93:: with SMTP id q19mr1536754qkl.9.1635216113331;
        Mon, 25 Oct 2021 19:41:53 -0700 (PDT)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id i21sm4318352qkn.15.2021.10.25.19.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 19:41:52 -0700 (PDT)
Date:   Mon, 25 Oct 2021 22:41:51 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Yuanzheng Song <songyuanzheng@huawei.com>, dennis@kernel.org,
        tj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/percpu: fix data-race with
 pcpu_nr_empty_pop_pages
Message-ID: <YXdq7+PJqGLCu4nH@fedora>
References: <20211025070015.553813-1-songyuanzheng@huawei.com>
 <alpine.DEB.2.22.394.2110250943310.2528@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2110250943310.2528@gentwo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Oct 25, 2021 at 09:50:48AM +0200, Christoph Lameter wrote:
> On Mon, 25 Oct 2021, Yuanzheng Song wrote:
> 
> > When reading the pcpu_nr_empty_pop_pages in pcpu_alloc()
> > and writing the pcpu_nr_empty_pop_pages in
> > pcpu_update_empty_pages() at the same time,
> > the data-race occurs.
> 
> Looks like a use case for the atomic RMV instructions.
> 

Yeah. I see 2 options. Switch the variable over to an atomic or we can
move the read behind pcpu_lock. All the writes are already behind it
othewise that would actually be problematic. In this particular case,
reading a wrong # of empty pages isn't a big deal as eventually the
background work will get scheduled.

Thanks,
Dennis

> > To fix this issue, use READ_ONCE() and WRITE_ONCE() to
> > read and write the pcpu_nr_empty_pop_pages.
> 
> Never thought that READ_ONCE and WRITE_ONCE can fix races like
> this. Really?
> 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 293009cc03ef..e8ef92e698ab 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -574,7 +574,9 @@ static void pcpu_isolate_chunk(struct pcpu_chunk *chunk)
> >
> >  	if (!chunk->isolated) {
> >  		chunk->isolated = true;
> > -		pcpu_nr_empty_pop_pages -= chunk->nr_empty_pop_pages;
> > +		WRITE_ONCE(pcpu_nr_empty_pop_pages,
> > +			   READ_ONCE(pcpu_nr_empty_pop_pages) -
> > +			   chunk->nr_empty_pop_pages);
> 
> atomic_sub()?
> 
> >  	}
> >  	list_move(&chunk->list, &pcpu_chunk_lists[pcpu_to_depopulate_slot]);
> >  }
> > @@ -585,7 +587,9 @@ static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
> >
> >  	if (chunk->isolated) {
> >  		chunk->isolated = false;
> > -		pcpu_nr_empty_pop_pages += chunk->nr_empty_pop_pages;
> > +		WRITE_ONCE(pcpu_nr_empty_pop_pages,
> > +			   READ_ONCE(pcpu_nr_empty_pop_pages) +
> > +			   chunk->nr_empty_pop_pages);
> 
> atomic_add()?
> 
