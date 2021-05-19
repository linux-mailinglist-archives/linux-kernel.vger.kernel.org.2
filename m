Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05135388EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353613AbhESN0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49988 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346776AbhESN0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621430695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=16KIXcLIzR+yi2apZnjd4cBLdoyY5/Ko/J5OyvcRvAA=;
        b=Mtg93eI6SlJp19sD8G1LbCPhc/vxfjT+i+/u4XdOhTBaO1s+Df4kio7KLNeVMzLjKuZeOr
        suQT7+HDcwWhHb8auEzfD2F4pPMOQaHm94BN8J1S7QyqVUlUzSFp+w3YBk1XhiF+hmXitG
        gIqV60pD7Z1q2oQ6S6mke4CUReVwMxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-igFhf4oYO8mtiQBoF2dp3A-1; Wed, 19 May 2021 09:24:53 -0400
X-MC-Unique: igFhf4oYO8mtiQBoF2dp3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CDE78015C6;
        Wed, 19 May 2021 13:24:52 +0000 (UTC)
Received: from krava (unknown [10.40.195.153])
        by smtp.corp.redhat.com (Postfix) with SMTP id B769E1A868;
        Wed, 19 May 2021 13:24:50 +0000 (UTC)
Date:   Wed, 19 May 2021 15:24:49 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Subject: Re: [PATCH v5 1/3] perf report: compile tips.txt in perf binary
Message-ID: <YKURoStYXwQ3FnxI@krava>
References: <20210517084604.2895-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517084604.2895-1-dzagorui@cisco.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 01:46:02AM -0700, Denys Zagorui wrote:

SNIP

>  	return hist_browser(rep->session->evlist, help, NULL, rep->min_percent);
>  }
>  
> +#define MAX_TIPS        60
> +
> +static const char *perf_tip(void)
> +{
> +	char *str[MAX_TIPS];
> +	int i = 0;
> +
> +	_binary_Documentation_tips_txt_start[_binary_Documentation_tips_txt_end -
> +		_binary_Documentation_tips_txt_start - 1] = 0;
> +
> +	str[i] = strtok(_binary_Documentation_tips_txt_start, "\n");
> +	if (!str[i])
> +		return "Tips cannot be found!";
> +
> +	i++;
> +
> +	while (i < MAX_TIPS) {
> +		str[i] = strtok(NULL, "\n");
> +		if (!str[i])
> +			break;
> +		i++;
> +	}
> +
> +	return str[random() % i];

that still does not solve that we set MAX_TIPS and have
no way of checking that's still valid

how about something like below (completely untested):


static const char *perf_tip(void)
{
       char *start = _binary_Documentation_tips_txt_start;
       char *tok, *tmp, *prev;
       int pick, size;

       size = _binary_Documentation_tips_txt_end - start;
       pick = random() % size;

       _binary_Documentation_tips_txt_start[size - 1] = 0;

       for (tok = strtok_r(start, "\n", &tmp); tok;
            tok = strtok_r(NULL, "\n", &tmp)) {
               if (pick < (tok - start))
                       return prev;
               prev = tok;
       }

       return prev;
}

this way you wouldn't need array with MAX_TIPS defined

jirka

