Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9365B34AD03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhCZRAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230197AbhCZRAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616778008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zDI1NIJimYujCPbkiU9AZ+QP7d2Pl5mPSzE4i31Ne64=;
        b=bZTK/0dbqMQpzi3rYR8Y8DuCwlJ/oXa3Gr0L8MLRsvBLmFk57yhzBIsWZvuGy8+z52kUUj
        FrdLm9+81tN5z4nY1TKntapPhG4jvpRabt3X7M+RDcT+nZkr0Vf6n2iQD8IkvWPrLEuQqp
        gogdfML6MlPDcm3ODqgHxGCH/w+ha4E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-crML0KyYOGuLtOVESFxO0g-1; Fri, 26 Mar 2021 13:00:07 -0400
X-MC-Unique: crML0KyYOGuLtOVESFxO0g-1
Received: by mail-wm1-f71.google.com with SMTP id r65-20020a1c2b440000b029010f4ee06223so2621037wmr.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zDI1NIJimYujCPbkiU9AZ+QP7d2Pl5mPSzE4i31Ne64=;
        b=Dh0yVvCFOYMAbSrweTl4KI3QJ17OKCrgop0Lxg5+PPdCQ8TrSizaDo4QnUeq/IPmYH
         TCWpN5waBs3Cxf0KQsXOswGxQPy4sx59raEkDQ/XvjNWvq6zR6W6l5Z/pVp+xiZeLtvB
         QJmrmw0f/nKKE27sgXSihTBrcvqtnZTkmIMyBV8oW5lKfTQd1C+0B32sZsI4sCsHH5Av
         uEYB8SA6Y5bARWB4N3R3YD3ptWOu9x+oGowVkCPvgQORGURh+Ko5q2bNJh6bTQV3bMNP
         2Oi8pK98GA9jiQZxg3lEAae6Kpb3KEkkM1AQCbhDCTz0WGPvDAsDQkFtXFKhZAIA9xOD
         PMrw==
X-Gm-Message-State: AOAM532PbpzXAjkvG5hHPgCu5044c4lVQjBUBKJnDNxh+kUUqIGxnYSM
        ei02gTmWNwC5gtelMYwRTFq1grLLaerd2PBfFMp/Wk8G7YBxIMe9pRXBJW4rq0/afW0AjUJjk39
        +v5b3vTa2RyVkp9EwoBPeAIo=
X-Received: by 2002:a05:6000:2c8:: with SMTP id o8mr15591463wry.407.1616778005932;
        Fri, 26 Mar 2021 10:00:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfaEr3I/dLH/2y0YJ1ZgF2BxggRLlTouqN6WfZyBmabs7IMKC8CyqSUQPboNTSAzSaKjlwYA==
X-Received: by 2002:a05:6000:2c8:: with SMTP id o8mr15591450wry.407.1616778005758;
        Fri, 26 Mar 2021 10:00:05 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id m132sm11824941wmf.45.2021.03.26.10.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 10:00:05 -0700 (PDT)
Date:   Fri, 26 Mar 2021 17:00:04 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/page_alloc: try oom if reclaim is unable to make
 forward progress
Message-ID: <20210326170004.ahzt4xhe6msje7wl@ava.usersys.com>
References: <20210315165837.789593-1-atomlin@redhat.com>
 <YFN8wXwJA59w9twA@dhcp22.suse.cz>
 <20210319172901.cror2u53b7caws3a@ava.usersys.com>
 <YFh10eSTKY5lbE9u@dhcp22.suse.cz>
 <20210325210159.r565fvfitoqeuykp@ava.usersys.com>
 <YF2YTNnyzWNHfrEg@dhcp22.suse.cz>
 <20210326112254.jy5jkiwtgj3pqkt2@ava.usersys.com>
 <YF3/YZPd+iz/xGu6@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YF3/YZPd+iz/xGu6@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-03-26 16:36 +0100, Michal Hocko wrote:
> We should be focusing on the compaction retry logic and see whether we
> can have some "run away" scenarios there.

Fair enough.

> Seeing so many retries without compaction bailing out sounds like a bug
> in that retry logic.

Agreed - I will continue to look into this.



Kind regards,

-- 
Aaron Tomlin

