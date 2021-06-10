Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6B3A2E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhFJOfp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Jun 2021 10:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhFJOfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:35:43 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC3E3613C6;
        Thu, 10 Jun 2021 14:33:46 +0000 (UTC)
Date:   Thu, 10 Jun 2021 10:33:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [for-next][PATCH 11/11] treewide: Add missing semicolons to
 __assign_str uses
Message-ID: <20210610103344.55f6cf51@oasis.local.home>
In-Reply-To: <8e163bf6c239ed519bbf754acac56f68897a3db3.camel@perches.com>
References: <20210610010130.069460694@goodmis.org>
        <20210610010158.690158686@goodmis.org>
        <8e163bf6c239ed519bbf754acac56f68897a3db3.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jun 2021 19:46:16 -0700
Joe Perches <joe@perches.com> wrote:

> > diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h  
> []
> > @@ -33,7 +33,7 @@
> >  			__string(vif_name, sdata->name)
> >  #define VIF_ASSIGN	__entry->vif_type = sdata->vif.type; __entry->sdata = sdata;	\
> >  			__entry->p2p = sdata->vif.p2p;					\
> > -			__assign_str(vif_name, sdata->name)
> > +			__assign_str(vif_name, sdata->name);  
> 
> This one is unnecessary as every use of VIF_ASSIGN already has a semicolon
> termination.
> 

Care to send me a v2 of your patch then?

-- Steve
