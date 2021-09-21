Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186EE41396D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhIUSFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231897AbhIUSFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632247413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o2gyCGlUrboNcIiNieqE+IfjFr7udGGsuUiWMYUkrwc=;
        b=eqNExlImFOC7IvaOy4NfMdGeXMAax1qJO5Y/Z4cZjlg6iEda0JLDB5K7Foa076rlgCFSMY
        VOSDxEwbsXcRbbm3zCLBg5jAnC9e+MSboXGTNmi03Nsn+ncsTNCPwHpO0Q2ppW37tYmIyZ
        IStyvjjGSr8eH4j5IlDgTBAo6n6fc6Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-L4Q_xUlmM0meW48EXsaOug-1; Tue, 21 Sep 2021 14:03:31 -0400
X-MC-Unique: L4Q_xUlmM0meW48EXsaOug-1
Received: by mail-qv1-f72.google.com with SMTP id b17-20020a056214135100b0037eaf39cb1fso2473736qvw.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o2gyCGlUrboNcIiNieqE+IfjFr7udGGsuUiWMYUkrwc=;
        b=s62gb5HLKZEcCk5gJdCJ3j5sWENx9R8E/kx01ogiYTs7u2pSrPP5FinxJ6OAL5ACTi
         wrwpIgvMd7eznG4Erdbd1jDWQf+UhDovOd0WvToi1jpWIefQoxm8zu3fq20DlBF6yF5o
         uER+kxXQGQbBEWRzEQPKKRbHoBkegAENF3hqR8Likw+KuYvA+H+SOompQ5442JTWLGim
         2xd4VxTaUu3iB9+wsmR1L6MGccTgt5Cv1DC9KTCWvcAkTnHlj8Gv2RvQlC6J08FCCgQy
         pX4fXxSZnJRNSFJ0yFawhKv2PzZFD0oTYk1j8nTwO6y45nq5x399CL/+AIk4Bv23yuOZ
         X5Og==
X-Gm-Message-State: AOAM5303e3xfkIRV0k0+3yvzMIt5KeKnvsdL4MIt4fRvLZIG0edjqFfJ
        LBDjSq6Xrk1X3sG4asl2xR+pcgjecOkrMMCH2ZqEfT8SXHF5YgiOZV9NgoTulYO18DwmUCv7QCL
        ewbr8O8gh1fqpTjlEoGzxfDhk
X-Received: by 2002:ac8:4e11:: with SMTP id c17mr15690794qtw.400.1632247411185;
        Tue, 21 Sep 2021 11:03:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa0LEMQ/1ArgdueEZqR3M76Qxk5uPrMK6duFpGckfUHr9iZTOK6FREBkxU98G4YICtISCcfg==
X-Received: by 2002:ac8:4e11:: with SMTP id c17mr15690771qtw.400.1632247410936;
        Tue, 21 Sep 2021 11:03:30 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id d5sm3792039qtr.61.2021.09.21.11.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:03:30 -0700 (PDT)
Date:   Tue, 21 Sep 2021 14:03:29 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] userfaultfd/selftests: don't rely on GNU extensions
 for random numbers
Message-ID: <YUoecZdcYBPLeejz@t490s>
References: <20210921163323.944352-1-axelrasmussen@google.com>
 <20210921163323.944352-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921163323.944352-3-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:33:23AM -0700, Axel Rasmussen wrote:
> Two arguments for doing this:
> 
> First, and maybe most importantly, the resulting code is significantly
> shorter / simpler.
> 
> Then, we avoid using GNU libc extensions. Why does this matter? It makes
> testing userfaultfd with the selftest easier e.g. on distros which use
> something other than glibc (e.g., Alpine, which uses musl); basically,
> it makes the test more portable.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

