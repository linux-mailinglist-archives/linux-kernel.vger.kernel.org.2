Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC404539B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 20:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbhKPTEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 14:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239514AbhKPTEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 14:04:52 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73BD461AF7;
        Tue, 16 Nov 2021 19:01:54 +0000 (UTC)
Date:   Tue, 16 Nov 2021 14:01:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing/histogram: Do not copy the fixed-size char
 array field over the field size
Message-ID: <20211116140152.51433965@gandalf.local.home>
In-Reply-To: <20211116133431.12d21e67@gandalf.local.home>
References: <163673292822.195747.3696966210526410250.stgit@devnote2>
        <20211116175359.GA2126@kbox>
        <20211116133431.12d21e67@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resending to linux-kernel instead of ilinux-kernel ]

On Tue, 16 Nov 2021 13:34:31 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 16 Nov 2021 09:53:59 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > > @@ -3025,7 +3026,7 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
> > >  			char *str = elt_data->field_var_str[j++];
> > >  			char *val_str = (char *)(uintptr_t)var_val;
> > >  
> > > -			strscpy(str, val_str, STR_VAR_LEN_MAX);
> > > +			strscpy(str, val_str, val->size);    
> > 
> > Is it possible for val->size to be larger than STR_VAR_LEN_MAX?
> > field_var_str is alloc'd to be the size of STR_VAR_LEN_MAX (256).  
> 
> Yes.
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=938aa33f14657c9ed9deea348b7d6f14b6d69cb7
> 
>  ;-)
> 
> -- Steve
> 
> >   
> > >  			var_val = (u64)(uintptr_t)str;
> > >  		}
> > >  		tracing_map_set_var(elt, var_idx, var_val);
> > > @@ -4920,7 +4921,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
> > >  
> > >  				str = elt_data->field_var_str[idx];
> > >  				val_str = (char *)(uintptr_t)hist_val;
> > > -				strscpy(str, val_str, STR_VAR_LEN_MAX);
> > > +				strscpy(str, val_str, hist_field->size);    
> > 
> > Same as above.  
> 

