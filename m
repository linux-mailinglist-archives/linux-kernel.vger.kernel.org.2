Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C833A2259
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 04:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFJCsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 22:48:15 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:53910 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229692AbhFJCsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 22:48:14 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 707D552C0;
        Thu, 10 Jun 2021 02:46:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 7CD792351F5;
        Thu, 10 Jun 2021 02:46:17 +0000 (UTC)
Message-ID: <8e163bf6c239ed519bbf754acac56f68897a3db3.camel@perches.com>
Subject: Re: [for-next][PATCH 11/11] treewide: Add missing semicolons to
 __assign_str uses
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Date:   Wed, 09 Jun 2021 19:46:16 -0700
In-Reply-To: <20210610010158.690158686@goodmis.org>
References: <20210610010130.069460694@goodmis.org>
         <20210610010158.690158686@goodmis.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7CD792351F5
X-Spam-Status: No, score=-2.90
X-Stat-Signature: c4n9g831mrgc3citiquny67jmsg8gues
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+a/3s4biv8HcNs8D/V+E7llICJKv5cYH4=
X-HE-Tag: 1623293177-605816
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-09 at 21:01 -0400, Steven Rostedt wrote:
> From: Joe Perches <joe@perches.com>
> 
> The __assign_str macro has an unusual ending semicolon but the vast
> majority of uses of the macro already have semicolon termination.
> 
> $ git grep -P '\b__assign_str\b' | wc -l
> 551
> $ git grep -P '\b__assign_str\b.*;' | wc -l
> 480
> 
> Add semicolons to the __assign_str() uses without semicolon termination
> and all the other uses without semicolon termination via additional defines
> that are equivalent to __assign_str() with the eventual goal of removing
> the semicolon from the __assign_str() macro definition.
[]
>  net/mac80211/trace.h                          |  2 +-
[]
> diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
[]
> @@ -33,7 +33,7 @@
>  			__string(vif_name, sdata->name)
>  #define VIF_ASSIGN	__entry->vif_type = sdata->vif.type; __entry->sdata = sdata;	\
>  			__entry->p2p = sdata->vif.p2p;					\
> -			__assign_str(vif_name, sdata->name)
> +			__assign_str(vif_name, sdata->name);

This one is unnecessary as every use of VIF_ASSIGN already has a semicolon
termination.


