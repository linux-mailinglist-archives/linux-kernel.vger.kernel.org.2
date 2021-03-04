Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60A032D851
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbhCDRHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:07:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238917AbhCDRGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:06:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1797664F5E;
        Thu,  4 Mar 2021 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614877557;
        bh=+miftCaE54k4McOWlGmXVgdffLZUj87wPGLclc/pQbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qP73tpsQlrltFfk+mEKW51CArPEnk+33zoSHRELC+7uihLZHaQ9/hf8fNjXTKfp/h
         jsEcMkJ3ZBZv/RbtmfQ0AeFKilhf6bfVn4TZVg1WJjV//KHXtebzlY0qBAXwQlL31M
         qGSNWnIxGxr0ku9P4rOH0FVAYuK9NY6JZpCM/RlJACx0OBIHzqxH57Es7/ZnZTVtLF
         4SDA3hN0ucsy3RQPwfUPJLPJlCPPwEIKCfW/tKnQn3gD5Fp7DCTnxDka2/6EjKJUDf
         6VJ/r0IST2ul7gg3OO0hJr0Jcm9FjbgU764pQ+bvU408RZumhruaF1nI9Go7wfRGJN
         5YJJmLJNzhqAg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2B4B44038F; Thu,  4 Mar 2021 14:05:54 -0300 (-03)
Date:   Thu, 4 Mar 2021 14:05:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>, namhyung@kernel.org,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Fix -F for branch & mem modes
Message-ID: <YEETcjPREqLp0mWZ@kernel.org>
References: <20210304062958.85465-1-ravi.bangoria@linux.ibm.com>
 <B8831E43-992C-44BC-9CF7-BABAE8C0F5BB@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8831E43-992C-44BC-9CF7-BABAE8C0F5BB@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 04, 2021 at 12:15:58PM +0530, Athira Rajeev escreveu:
> > On 04-Mar-2021, at 11:59 AM, Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:
> > 
> > perf report fails to add valid additional fields with -F when
> > used with branch or mem modes. Fix it.
> > 
> > Before patch:
> > 
> >  $ ./perf record -b
> >  $ ./perf report -b -F +srcline_from --stdio
> >  Error:
> >  Invalid --fields key: `srcline_from'
> > 
> > After patch:
> > 
> >  $ ./perf report -b -F +srcline_from --stdio
> >  # Samples: 8K of event 'cycles'
> >  # Event count (approx.): 8784
> >  ...
> > 
> > Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Fixes: aa6b3c99236b ("perf report: Make -F more strict like -s")
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> Thanks for the fix Ravi.
> 
> Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks, applied.

- Arnaldo

 
> > ---
> > tools/perf/util/sort.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index 0d5ad42812b9..552b590485bf 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -3140,7 +3140,7 @@ int output_field_add(struct perf_hpp_list *list, char *tok)
> > 		if (strncasecmp(tok, sd->name, strlen(tok)))
> > 			continue;
> > 
> > -		if (sort__mode != SORT_MODE__MEMORY)
> > +		if (sort__mode != SORT_MODE__BRANCH)
> > 			return -EINVAL;
> > 
> > 		return __sort_dimension__add_output(list, sd);
> > @@ -3152,7 +3152,7 @@ int output_field_add(struct perf_hpp_list *list, char *tok)
> > 		if (strncasecmp(tok, sd->name, strlen(tok)))
> > 			continue;
> > 
> > -		if (sort__mode != SORT_MODE__BRANCH)
> > +		if (sort__mode != SORT_MODE__MEMORY)
> > 			return -EINVAL;
> > 
> > 		return __sort_dimension__add_output(list, sd);
> > -- 
> > 2.29.2
> > 
> 

-- 

- Arnaldo
