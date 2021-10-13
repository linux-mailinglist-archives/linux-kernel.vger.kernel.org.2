Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78E742C0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhJMM6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:58:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234452AbhJMM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634129807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CkJpH3DgOJL3jwDbLBu0PEHYw2VVuRmqEfiPi5X44AA=;
        b=DVqa1jFVPrWhrwbHIGq92pN/h7wfplrE5zjj5RyNS8BenPOYDgyYKo4N4PoyC9vQgAm48A
        XRRWAifkNxh0VgbQo+6A8/lLkVzQ6VyBWjeIrA+lpHi19QYfkW9/3D7gMnnAsc8402uhOs
        22wD40qvZfgaC085b0+8+AC7Lfa6/Pw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-Df_uBI5ePjWQTCX74WeCkg-1; Wed, 13 Oct 2021 08:56:46 -0400
X-MC-Unique: Df_uBI5ePjWQTCX74WeCkg-1
Received: by mail-il1-f197.google.com with SMTP id s8-20020a056e02216800b002593ad87094so1506416ilv.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CkJpH3DgOJL3jwDbLBu0PEHYw2VVuRmqEfiPi5X44AA=;
        b=KViwyzvfen7JaMpIYmyfgmT74lJ7Htarrd16TjMoylDrl2UHiFMmo8X7RQrxIF/16U
         0Q5DSbX9fBzP05f6wqtDiG90pHY5w/JPPKjIjXhPbE3zCaP9exziC8o3DMa7Cfc2ekCY
         8AP3BI4OEa4qpptFbJlUmkkGHkS6ZgbUd7lH5yCYuW/vllYymRYBAO5XY4yJwH6wzHeX
         mIcmrSOOzmG/kmiGLi0SXzdHB9N5HghV0Hnra+T8CW07CtrwmOcoyET8THowJ0iwGerA
         bCvKlDK/Zg7zATEILjA65/mM2KUyvuKsUrE5jSVlZFDWASVA/d1z6QnwoKohTctDSyVp
         YX9Q==
X-Gm-Message-State: AOAM531o3bv5O6qBBouCUJCE1FE6MBVjAYE1LzAueJAq6C49V1ML+QR6
        /k90fVd8H7kiRHHEzxbYBWXxiQholVTEvdDd9O1XWW+/cekmbncKCNi91cZLFlZU6Rv0mpQ8ciF
        T6FDcIu7bMJGoYURrrYE1Aiao
X-Received: by 2002:a05:6e02:1909:: with SMTP id w9mr30332824ilu.34.1634129805435;
        Wed, 13 Oct 2021 05:56:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwamTB8fvGG9rXJbVv2Ztg+M9X2Z1B0WdlXpPI7aycJycLAGn4sy/delupn/k2w5vVY/HbAAw==
X-Received: by 2002:a05:6e02:1909:: with SMTP id w9mr30332809ilu.34.1634129805239;
        Wed, 13 Oct 2021 05:56:45 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id z5sm6760050ile.42.2021.10.13.05.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:56:40 -0700 (PDT)
Date:   Wed, 13 Oct 2021 07:56:38 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, akpm@linux-foundation.org,
        bp@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Make unknown command line param message clearer
Message-ID: <20211013125638.4nc4bnbzbeixfrii@halaneylaptop>
References: <20211012213523.39801-1-ahalaney@redhat.com>
 <20211012200106.1afdbb0b@gandalf.local.home>
 <87853d4f-d6f8-1d58-1a07-c8232dae87fd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87853d4f-d6f8-1d58-1a07-c8232dae87fd@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 05:18:32PM -0700, Randy Dunlap wrote:
> On 10/12/21 5:01 PM, Steven Rostedt wrote:
> > On Tue, 12 Oct 2021 16:35:23 -0500
> > Andrew Halaney <ahalaney@redhat.com> wrote:
> > 
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -925,6 +925,10 @@ static void __init print_unknown_bootoptions(void)
> > >   	for (p = &envp_init[2]; *p; p++)
> > >   		end += sprintf(end, " %s", *p);
> > > +	pr_notice("The kernel command line has unknown parameters. They are either\n");
> > > +	pr_notice("misspelled, not valid for the current kernel configuration,\n");
> > > +	pr_notice("or are meant for init but are not after the '--' delineator. They will\n");
> > > +	pr_notice("be passed to init along with those after '--' on the command line.\n");
> > >   	pr_notice("Unknown command line parameters:%s\n", unknown_options);
> > >   	memblock_free(unknown_options, len);
> > 
> > What about just changing it to simply say:
> > 
> > 	pr_notice("Unknown kernel command line parameters "%s", will be	passed to user space.\n",
> > 		  unknown_options);
> > 
> 
> Yes, that's much more palatable.
> 
> thanks.
> -- 
> ~Randy
> 

Heh, that's basically what the users suggested too but I wasn't the
biggest fan since I didn't think it highlighted the points I tried to
make. I guess I'm just too verbose :P

I'll spin a v2 with that considering everyone likes that form more.

Thanks,
Andrew

