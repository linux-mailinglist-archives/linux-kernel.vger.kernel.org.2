Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42604138F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhIURqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231224AbhIURqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632246290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6N8VBe8svoga5drgehLwNuhZWfQ1ETQys67yELw2/Tg=;
        b=KZDyWpp7mILh/P9knM218+b1XphrWmsrWhPHyZf9Y0rlWPNAqB0BLyoYat6rvlzjYVk4XW
        DzkthntFhZ4JlU2dCyPxwp+PF+hEKZ4YRNg/4pmwow+nolnrv0alRdCGbSE32uNOpYXsl4
        oPktlPPaBftd+Em0/U7YIBlFAm1vjuk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-SM617vWSP--MGrnr5-jR9w-1; Tue, 21 Sep 2021 13:44:49 -0400
X-MC-Unique: SM617vWSP--MGrnr5-jR9w-1
Received: by mail-qv1-f72.google.com with SMTP id a15-20020a0ce34f000000b0037a944f655dso2396846qvm.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6N8VBe8svoga5drgehLwNuhZWfQ1ETQys67yELw2/Tg=;
        b=jyqrSYYtCFmOaNbkB4Tr/ARAsGesvPgISvRzJTBHpbu/E1qMra0Vj2AwT7fGoo2Uxf
         oFZ68gAsLxixJz9VsDXZIOjpTlTjlx91k+5ECkauCFxQFMB8COJMp6YKla5Td7SQQbS3
         0rSSt/ux0LQwsXTM3uLMWq4pwORFbef5qdOI8t2r7ZhApm37vWlqZRHKqNdpmGFBJy7Q
         HrcOsFQlv9yCWGShdfNlNGaOLFaM+vPNrckFkM0NHBbt9gPHPuVJaEhMNHUqVKGVV+Qb
         dy0BINKhmGGkpV8zPq+NbYNRMXHYeo4unxcpGozmrfeMOta0Q2/EBCOyjtfGoXX0hGxj
         4mjQ==
X-Gm-Message-State: AOAM532Rz5wbMqIKG/xubwpo6ZgRLeoHbvPj8l7JWxthgxfhpqlJRUri
        JyPsJ9Y0wver/O+PLfjjr4gacXkIk2OyWFfE1eqqQrtaK9fRvwIz1jS3gt15XN8LeZ14tYE+xKL
        47/Pmh2lnipPiHK62XwFAI+TA
X-Received: by 2002:ac8:c82:: with SMTP id n2mr28687282qti.207.1632246288972;
        Tue, 21 Sep 2021 10:44:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgQa6neroe9CMH682piLnpJaVS6v7I40G1JveuyTUzPPf5Wna6pHN4DAOUOCXGJxiczKobow==
X-Received: by 2002:ac8:c82:: with SMTP id n2mr28687257qti.207.1632246288683;
        Tue, 21 Sep 2021 10:44:48 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id z10sm4827915qtv.6.2021.09.21.10.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:44:48 -0700 (PDT)
Date:   Tue, 21 Sep 2021 13:44:46 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
Message-ID: <YUoaDr2wsW8wtk5Z@t490s>
References: <20210921163323.944352-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921163323.944352-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Axel,

On Tue, Sep 21, 2021 at 09:33:21AM -0700, Axel Rasmussen wrote:
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 10ab56c2484a..2366caf90435 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -79,10 +79,6 @@ static int test_type;
>  #define ALARM_INTERVAL_SECS 10
>  static volatile bool test_uffdio_copy_eexist = true;
>  static volatile bool test_uffdio_zeropage_eexist = true;
> -/* Whether to test uffd write-protection */
> -static bool test_uffdio_wp = false;
> -/* Whether to test uffd minor faults */
> -static bool test_uffdio_minor = false;

IMHO it's not a fault to have these variables; they're still the fastest way to
do branching.  It's just that in some cases we should set them to "false"
rather than "true", am I right?

How about we just set them properly in set_test_type?  Say, we can fetch the
feature bits in set_test_type rather than assuming it's only related to the
type of memory.

Thanks,

-- 
Peter Xu

