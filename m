Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879693A07AB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 01:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhFHXQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 19:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbhFHXQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:16:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053D9C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 16:14:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso297662pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 16:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RFFQL6n+hnGPtnKc5HhDng2YxeFY2XdUGVqsGIdkEwg=;
        b=JjLzWV0ND3DgTXf3Yo5SSG2HEg3XqebK996+TPnhOArtMVha0MWNlsBLwZoHGFZ4PX
         bM4kc1XGjJ8gWp3NJiHcaHWJ4vhSlQdwLRk2YcITh6zE9qHuwrn15OreGdP8xfnV1Neq
         O9dbX52OCKVbXo77/sP6UCEX19b97yIUFIlx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RFFQL6n+hnGPtnKc5HhDng2YxeFY2XdUGVqsGIdkEwg=;
        b=gLoKJc23ftlhBMHU8SMlynk3f42ihAO4ybpcMZc3a69a5pPjrCJSSr8nbsUCs3XfGy
         j/GsGFjJCMpp2hs4jZ+K4K6MgParKePKCAMDZbTYXWBkaYVDZbIjBTlB4mZ3+YArIP8F
         zA87im4WuupHcp5McSUhKCew8OY6kWd/39bIRDQR7RjSEPzLQZuojWy+ljHYvz/VFW5q
         knSaw3a7uHutyKsSyYOYXZ9vyyRaWFInO9QRO6VlZAnADKoP2UsLFpAVZz3t2mg9AIb7
         cFGBoERvtSqp7fDnQWgbOr/b5vclt9GqzeFqNAi4XKyVF9/yEiCZloNEwe6FpEMSlOqr
         vY1Q==
X-Gm-Message-State: AOAM530EVo16EnAi+qQv+9pLQpYv0pUIJ33kvJPm02iAXoj2IB4qDWV9
        75ByrUbEvz6JCMo2OIRl/VdPdg==
X-Google-Smtp-Source: ABdhPJxmEQnRpYvM+ulXTRQ4pKEWJ3SalVqY0DxNLw/MuYNd02ARGI55mhRhh4IRJt6eJS+BnqOscw==
X-Received: by 2002:a17:90a:5995:: with SMTP id l21mr7143748pji.79.1623194079672;
        Tue, 08 Jun 2021 16:14:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n11sm10106373pfu.29.2021.06.08.16.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:14:39 -0700 (PDT)
Date:   Tue, 8 Jun 2021 16:14:38 -0700
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
Message-ID: <202106081614.E57675D17@keescook>
References: <6746FEEA-FD69-4792-8DDA-C78F5FE7DA02@psu.edu>
 <202106081125.E2DA4DE8@keescook>
 <F9847E9B-5557-4FAC-AE80-829D0AD712A3@psu.edu>
 <202106081140.F73F91F@keescook>
 <25AB8A72-B970-47C2-8688-48126075E72E@psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25AB8A72-B970-47C2-8688-48126075E72E@psu.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 07:06:45PM +0000, Lin, Zhenpeng wrote:
> No problem. Just took a look and tested the patch, it looks good to me!

Great; thank you! Sorry I dropped the ball on this series. I got
distracted. :) It looks like akpm took it into -mm now, so this should
be fixed in -next soon.

-- 
Kees Cook
