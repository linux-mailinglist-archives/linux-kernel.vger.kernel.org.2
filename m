Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E9035A049
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhDINtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232395AbhDINtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617976166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RAeyxYOACfEWPJhoR3sMxB9Qn3fM86CFgkp3lnp+k6Q=;
        b=WBqADTfLPfrb1NSLfSKp2LgVOiLRsOHR45Bz4TMoU6/QGilieRB4eq6vfV0HH6esHRIYov
        /S70kw8mnwedqOKOzbDWr/Ir1Da7mq0w9fkleMCDvbMp+iJh9FJrQBOVtaahsOGEJu+UP0
        UmmwVkY7jbe7x6XSkMi3iwzbJey/fLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-okoLqAISMTWOsbhYGgBjHA-1; Fri, 09 Apr 2021 09:49:13 -0400
X-MC-Unique: okoLqAISMTWOsbhYGgBjHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 058405B364;
        Fri,  9 Apr 2021 13:49:12 +0000 (UTC)
Received: from krava (unknown [10.40.195.216])
        by smtp.corp.redhat.com (Postfix) with SMTP id EA88060BE5;
        Fri,  9 Apr 2021 13:49:09 +0000 (UTC)
Date:   Fri, 9 Apr 2021 15:49:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 10/27] perf parse-events: Create two hybrid raw events
Message-ID: <YHBbVMNSCsu/bbii@krava>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-11-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329070046.8815-11-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 03:00:29PM +0800, Jin Yao wrote:

SNIP

> +					      name, config_terms, pmu);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
>  				     struct list_head *list,
>  				     struct perf_event_attr *attr,
> @@ -91,6 +126,9 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
>  	if (attr->type != PERF_TYPE_RAW) {
>  		return add_hw_hybrid(parse_state, list, attr, name,
>  				     config_terms);
> +	} else {
> +		return add_raw_hybrid(parse_state, list, attr, name,
> +				      config_terms);
>  	}
>  
>  	return -1;

no need for the return -1

jirka

> -- 
> 2.17.1
> 

