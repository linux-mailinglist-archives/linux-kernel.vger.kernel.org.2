Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F200E35DEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhDMMhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229768AbhDMMhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618317401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gwchUegte3W91Yxn1yo6UjhBF5UF9fS3pz33NiRws2U=;
        b=QIOeRSLSNC1SpKCRSPPPjaX7vhGgZGTh16arqIxWSKJ4+zBtq8Vn9s5CAuXUyCJJDTQjz/
        e7ZIotjWrhOrwN3xSVc/VA9ricRlW8IkJfCv/8SdsueiR0h8CjBlfHHutTSNmgl11bIE1R
        Hg2NJGOku7Y/idsEt2p8ROYJrsmdQ84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-UjME8ZgzM9WhkA2IppKoAg-1; Tue, 13 Apr 2021 08:36:37 -0400
X-MC-Unique: UjME8ZgzM9WhkA2IppKoAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1C67BBEE4;
        Tue, 13 Apr 2021 12:36:35 +0000 (UTC)
Received: from krava (unknown [10.40.196.16])
        by smtp.corp.redhat.com (Postfix) with SMTP id AD04D2BFF1;
        Tue, 13 Apr 2021 12:36:33 +0000 (UTC)
Date:   Tue, 13 Apr 2021 14:36:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 12/27] perf parse-events: Support no alias assigned
 event inside hybrid PMU
Message-ID: <YHWQUMmj/7MqCfcs@krava>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-13-yao.jin@linux.intel.com>
 <YHBa15BWne4zgv/A@krava>
 <6a7ba97c-29e7-bc4d-57aa-18bc92af9738@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7ba97c-29e7-bc4d-57aa-18bc92af9738@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:51:14AM +0800, Jin, Yao wrote:

SNIP

> 
> Do you suggest we just use string comparison for doing the direct check?
> 
> e.g.
> 
> if (strstr(term->config, "L1-dcache"))
> 	...
> 
> Of course, we can define a string array first and use a loop for string comparison.
> 
> > > +	if (!parse_state->fake_pmu && head_config && !found &&
> > > +	    perf_pmu__is_hybrid(name)) {
> > > +		struct parse_events_term *term;
> > > +		int ret;
> > > +
> > > +		list_for_each_entry(term, head_config, list) {
> > > +			if (!term->config)
> > > +				continue;
> > > +
> > > +			ret = parse_events__with_hybrid_pmu(parse_state,
> > > +							    term->config,
> > > +							    name, &found,
> > > +							    list);
> > 
> > do we need to call the parsing again? could we just call
> > parse_events__add_cache_hybrid?
> > 
> > jirka
> > 
> > 
> 
> If we do the direct check for cache events, I think we don't need the parsing again.
> 
> As I mentioned above, we need to define a string array and compare with term->config one by one.
> 

maybe another way is to find a way to run just the lexer (without
parser) and check that it returns PE_NAME_CACHE_OP_RESULT

jirka

