Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388A83A00F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhFHStg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:49:36 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:44999 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbhFHSoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:44:20 -0400
Received: by mail-pl1-f176.google.com with SMTP id b12so5182639plg.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SZp6uz2Ck8oIq6wxVt6GqttZt2gt5CtwcdeJ/a3AShI=;
        b=gxkzoJMIs1RdWPPYKkIoSxZbaqJWSHw2/p8KP+34Wz3lAHDzkQ+Yya+Tx7yyFMpbO/
         O1q58Qi0o1eZNGwTDeS7MCZ+NGjFyPBOw5WsI9MiMf3GNDW9RPsgWOJTQ95b9x3KHaYw
         nsAtbgZPb7IvINIcBabLPQeRQCQioxH7CCpEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SZp6uz2Ck8oIq6wxVt6GqttZt2gt5CtwcdeJ/a3AShI=;
        b=LIc8kI//FT2MIDcgpEF3kH+jLAXo38/cmIYF1i9OHUAIERgJzMPCyuY6+3l4e4QzMP
         CJ/VlA8Rt77b76DTp343r+Jwn7cGKFn7+KhZ5OQAfjRKbPLh7iq9WIqxCUHeGVfPxKlW
         8zzuSHnbthYKFwnReCi/9TymHr9aQlnUqSfR/0MMLZ0bYOYnvl+ECPEI3ff468xeCPAm
         BBHFJhnJDTsBbyXsNhfeouwM7yg21or7frgRz1L+2TnIutgyqD1D0y/xB1r8sUPqNl7c
         tqdR2IEKq3NAHThyMV4VV8iNdAemG6+S+mePRXXc0DHAUfU52oKhO7g+KGqnf1G8NGCa
         bB0g==
X-Gm-Message-State: AOAM530h4UT9w4ViXRaU7T0CHg7AyR1oud2faPULV6vqvtrNtsVhIgwy
        Fhuc+7vCEY/SsLIJQFmtZiEjug==
X-Google-Smtp-Source: ABdhPJzg4xbVxL+sJetdvwUdArunUtHsb9HqdCZTqZeAbHoy5EbCxi7M9F/X5M8IGoRayTZBUFiUZQ==
X-Received: by 2002:a17:90a:390d:: with SMTP id y13mr6165642pjb.133.1623177687587;
        Tue, 08 Jun 2021 11:41:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n129sm11194890pfn.167.2021.06.08.11.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 11:41:27 -0700 (PDT)
Date:   Tue, 8 Jun 2021 11:41:26 -0700
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
Message-ID: <202106081140.F73F91F@keescook>
References: <6746FEEA-FD69-4792-8DDA-C78F5FE7DA02@psu.edu>
 <202106081125.E2DA4DE8@keescook>
 <F9847E9B-5557-4FAC-AE80-829D0AD712A3@psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F9847E9B-5557-4FAC-AE80-829D0AD712A3@psu.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 06:33:01PM +0000, Lin, Zhenpeng wrote:
> There do exist objects whose size is smaller than 2*sizeof(void*). E.g. struct ccid in DCCP module.

Yes, sorry, I meant sizeof(void *). I've sent an updated v4 series and
CCed you. Are you able to test that and see if it fixes it for you too?

Thanks for the push to dust this series off again! :)

-Kees

-- 
Kees Cook
