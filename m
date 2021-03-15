Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BB433C9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhCOXTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229995AbhCOXSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615850324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/etmbsJvEZM1gH5LxhcUF9EBSBfjTJ2W2V26uLuorFI=;
        b=aWBGbE79iSPzA3D6uPUGV9XY6LHB6xjD0/DkMtVZ6oRGG0hWgBMpPLgKge98pn4sdEHFsq
        gmUYLs1B3lMOp74NpbsLD7VBudjLENu/qZfTIZ3G9Ggx1drIV3NQehE5+r9agBgEg8KTot
        hyg1J7G07XGwcftVLPq6JU8zhFPyKFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-WG_tzQXgMfORg1YNpVn6og-1; Mon, 15 Mar 2021 19:18:40 -0400
X-MC-Unique: WG_tzQXgMfORg1YNpVn6og-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE28F814270;
        Mon, 15 Mar 2021 23:18:38 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5EC555C3E6;
        Mon, 15 Mar 2021 23:18:36 +0000 (UTC)
Date:   Tue, 16 Mar 2021 00:18:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org, jolsa@kernel.org,
        kjain@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kan.liang@linux.intel.com
Subject: Re: [PATCH 4/4] tools/perf: Support pipeline stage cycles for powerpc
Message-ID: <YE/rS5jZLA0RHYZG@krava>
References: <1615298640-1529-1-git-send-email-atrajeev@linux.vnet.ibm.com>
 <1615298640-1529-5-git-send-email-atrajeev@linux.vnet.ibm.com>
 <YEtlEyb2z33qHhvO@krava>
 <FD9505E3-8CDE-4073-88A0-BCA4B92F276E@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FD9505E3-8CDE-4073-88A0-BCA4B92F276E@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 01:22:09PM +0530, Athira Rajeev wrote:

SNIP

> +
> +static char *setup_dynamic_sort_keys(char *str)
> +{
> +	unsigned int j;
> +
> +	if (sort__mode == SORT_MODE__MEMORY)
> +		for (j = 0; j < ARRAY_SIZE(dynamic_sort_keys_mem); j++)
> +			if (arch_support_dynamic_key(dynamic_sort_keys_mem[j])) {
> +				str = suffix_if_not_in(dynamic_sort_keys_mem[j], str);
> +				if (str == NULL)
> +					return str;
> +			}
> +
> +	return str;
> +}
> +
>  static int __setup_sorting(struct evlist *evlist)
>  {
>  	char *str;
> @@ -3050,6 +3085,12 @@ static int __setup_sorting(struct evlist *evlist)
>  		}
>  	}
>  
> +	str = setup_dynamic_sort_keys(str);
> +	if (str == NULL) {
> +		pr_err("Not enough memory to setup dynamic sort keys");
> +		return -ENOMEM;
> +	}

hum, so this is basicaly overloading the default_mem_sort_order for
architecture, right?

then I think it'd be easier just overload default_mem_sort_order directly

I was thinking more about adding extra (arch specific) loop to
sort_dimension__add or somehow add arch's specific stuff to
memory_sort_dimensions

jirka

