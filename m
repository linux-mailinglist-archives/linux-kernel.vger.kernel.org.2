Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D90F3FE5E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344783AbhIAWzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344242AbhIAWzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:55:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F96BC061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 15:54:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so87413pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ys/Eh677oj62PecdD9ZwHONFeLZtbqRPJaW3J3Ece1o=;
        b=vg3yTpngZs5HZQiRkVifcObEQTpyAyvzA/zZ8yp2Gulgdj9IScHSSc4wGvYo60cEzX
         7sGDundDojYj9nHGzthxHQPtPRA+8cWwBHDqnSMHAMjnmqOFdR1DhIQKIIEd20gxRNcG
         m+EcbwIyLmbjMTTyP3RKe5ifKTJ0uzek3ZKUOmV+OsR0sPQvnCh5OjvUpWOPcpzLQK26
         QAiA1NtrfC6inBG4uMQiXJsAnQPg1uz2PDdLvKV/FP/WX4G6+q9ra/anUUINlJ4osb6e
         f4tW8vJpHl9qUNWFCSxFclS2hyCm4z7R5ND2U/JLwKUD3QFk6HdtdtkNnXeKqR0sPIeU
         XSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ys/Eh677oj62PecdD9ZwHONFeLZtbqRPJaW3J3Ece1o=;
        b=L5yPyR/V5PZn6DOAFnC66qW9oF7/sKlx3rYqfexiGKQTh6pxrU1QgQ4ehmRBFgsdzl
         t4xtcICDf+UsMlFT8VZUrlvCJDulAETocaivkgdRAcQYpeSs7+jqCVZLI68Of6caPSDs
         PMoAZgeafIkEeMkbSk/8TQDt8wc8J81PwRH+C02/NLOWAiVgYdArM91l8BGtVcjtMnVk
         Rfi5EcyA+9P/DSZLHorVkzF/qAeYOug9Y/EspZ120gaq5gWxw2j7NGpp/dFFFMmyCm4a
         7ao2yzFsB8NI/v0lyr+NeVKQWdXRXgCfR5CoP28Kr3V62NqOkKZwpMK01QT4MHALGTpl
         t5KA==
X-Gm-Message-State: AOAM533juskaKP2KVmGz2YJ2U+RNCZRrnG7xHJ8XkuyHMZU+Yl+nk6/0
        GsQxikyHXK3pq1j4xmIp/k+Jig==
X-Google-Smtp-Source: ABdhPJyAPr/zoXFcDNJA2ksI5bqpIYOTqFRLqamhMlC069ipW6fK2GVTQ1+MqZc4KH6L2RGmfHANmw==
X-Received: by 2002:a17:902:e8ce:b0:132:b140:9540 with SMTP id v14-20020a170902e8ce00b00132b1409540mr75234plg.28.1630536877155;
        Wed, 01 Sep 2021 15:54:37 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e14sm2895pjg.40.2021.09.01.15.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 15:54:36 -0700 (PDT)
Date:   Wed, 1 Sep 2021 22:54:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        isaku.yamahata@intel.com, David Matlack <dmatlack@google.com>,
        peterx@redhat.com
Subject: Re: [PATCH 01/16] KVM: MMU: pass unadulterated gpa to
 direct_page_fault
Message-ID: <YTAEqXlvNOgY5hII@google.com>
References: <20210807134936.3083984-1-pbonzini@redhat.com>
 <20210807134936.3083984-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807134936.3083984-2-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2021, Paolo Bonzini wrote:
> Do not bother removing the low bits of the gpa.  This masking dates back
> to the very first commit of KVM but it is unnecessary---or even
> problematic, because the gpa is later used to fill in the MMIO page cache.

I don't disagree with the code change, but I don't see how stripping the offset
can be problematic for the MMIO page cache.  I assume you're referring to
handle_abnormal_pfn() -> vcpu_cache_mmio_info().  The "gva" is masked with
PAGE_MASK, i.e. the offset is stripped anyways.  And fundamentally, that cache
is tied to the granularity of the memslots, tracking the offset would be wrong.
