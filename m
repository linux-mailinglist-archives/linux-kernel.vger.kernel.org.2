Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF273A378B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFJXDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhFJXDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:03:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A20C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 16:01:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id go18-20020a17090b03d2b029016e4ae973f7so3718604pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H5c4wPtxJ4irmL/5t82UsuY3LS4vd3rmssVb2xf2eHY=;
        b=MeNKHjv+cbmFb/892w/ue0qm5oQAgWr1JUrlO+UnhF3F7gx/DE/XUKL9zhe8EEVGbB
         EqFNgff80GDDzKdGoFe+gK1TEOPEEmFh7kqTdVyQhtA6nD3BFlkBwUphWYpYsbnJ6hgu
         Jkb6ZhlK6ZzHSrj6Emm4WAgB8BnmiQw72t1Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H5c4wPtxJ4irmL/5t82UsuY3LS4vd3rmssVb2xf2eHY=;
        b=qTkq9A5Lz+lK+8IL2OBd4CvBzoGYJDW+jJh4SKMuGr/Y6kyX3u/JC2P9Qe/pdv1OtQ
         Lejatix9sJW1EV9oHONRia++45JLyJw9L+ic3PqVyBkWDZH6QK7Vzh6LJNaHDnQ+y9zC
         Zxh6LEdI+0xM+nhUu3tqHjtYIV6rz1quf5jMJmSNUEUjzh71u0UH+DY6EHeCp4qXdYhn
         FlpiSWtXXwWHUcQBa5JzSfh4FOjS53cCtGG0nQphQnwR69+DUZZGl1/ueeAAdowPKXCm
         F553iaVzn+VMUWHM4xUTWkWkb0w9zYUDcyeYnjjdQPOtJCpaCsBDseDlPvRHmtS0doU1
         H4UA==
X-Gm-Message-State: AOAM533n+qdMYklsocQ3rdkXnCcMgJ+TMaAK8MUuBTh94mEyLBR1vH+G
        Df9j6KXhFsRdEG225Z9SBpj7gA==
X-Google-Smtp-Source: ABdhPJzZ1Ekn9usvShs9+OF2hMkEFfpxWfgC9twP8DwMLvgr68CyHfFiKexonCRkxjyek5VxnsaQBg==
X-Received: by 2002:a17:902:eb52:b029:106:50e3:b2d8 with SMTP id i18-20020a170902eb52b029010650e3b2d8mr991118pli.51.1623366097712;
        Thu, 10 Jun 2021 16:01:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i16sm3281367pji.30.2021.06.10.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 16:01:36 -0700 (PDT)
Date:   Thu, 10 Jun 2021 16:01:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Lin, Zhenpeng" <zplin@psu.edu>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slub: choose the right freelist pointer location when
 creating small caches
Message-ID: <202106101601.E9273DD34@keescook>
References: <6746FEEA-FD69-4792-8DDA-C78F5FE7DA02@psu.edu>
 <202106081125.E2DA4DE8@keescook>
 <F9847E9B-5557-4FAC-AE80-829D0AD712A3@psu.edu>
 <202106081140.F73F91F@keescook>
 <25AB8A72-B970-47C2-8688-48126075E72E@psu.edu>
 <202106081614.E57675D17@keescook>
 <C7AC6780-9DCE-4CE5-90B1-9AA0731341BF@psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7AC6780-9DCE-4CE5-90B1-9AA0731341BF@psu.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 08:20:31PM +0000, Lin, Zhenpeng wrote:
> Sounds good. But I would suggest this to go to -stable as soon as possible. Because this bug is affecting the basic functionality of DCCP. It crashes kernel whenever a new socket in this module is created.

But only when redzoning is enabled, yes?

-- 
Kees Cook
