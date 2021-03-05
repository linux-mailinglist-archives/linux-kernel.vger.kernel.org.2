Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C194E32F48D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 21:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCEUUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 15:20:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhCEUUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 15:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614975638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6kfaPIrcXICdVUx4xgT8XV75O39JIzm2F/AcXHjBkpo=;
        b=VuYUUOApuZMhepgwYYIhnBv+rn9YRotHMB0hxAw+/uhR0SL52akJ3RsJT6D6Jsx7mm5cNH
        uOiC5bJGVhPjnIa7i17eeBfwc32D3FNDpIKy123zoQjtP5jkse3NBKFSBN1dNze/nTXpKX
        OuBtS5JQCAu+oTxcPa4/REBPhq6Z7Pg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-8UGHnAXRNqaBaE0USPVNIg-1; Fri, 05 Mar 2021 15:20:28 -0500
X-MC-Unique: 8UGHnAXRNqaBaE0USPVNIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A003C108BD06;
        Fri,  5 Mar 2021 20:20:27 +0000 (UTC)
Received: from krava (unknown [10.40.196.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 440D35C1BD;
        Fri,  5 Mar 2021 20:20:26 +0000 (UTC)
Date:   Fri, 5 Mar 2021 21:20:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf tests: Remove duplicate bitmap test
Message-ID: <YEKSia0KeptG7dzX@krava>
References: <20210305154158.384017-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305154158.384017-1-efremov@linux.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 06:41:57PM +0300, Denis Efremov wrote:
> test_bitmap("1,3-6,8-10,24,35-37") called twice in a row.
> Remove the second test.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

for both patches

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka


> ---
>  tools/perf/tests/bitmap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
> index 96c137360918..3320613400eb 100644
> --- a/tools/perf/tests/bitmap.c
> +++ b/tools/perf/tests/bitmap.c
> @@ -47,7 +47,6 @@ int test__bitmap_print(struct test *test __maybe_unused, int subtest __maybe_unu
>  	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1,3,5,7,9,11,13,15,17,19,21-40"));
>  	TEST_ASSERT_VAL("failed to convert map", test_bitmap("2-5"));
>  	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1,3-6,8-10,24,35-37"));
> -	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1,3-6,8-10,24,35-37"));
>  	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1-10,12-20,22-30,32-40"));
>  	return 0;
>  }
> -- 
> 2.26.2
> 

