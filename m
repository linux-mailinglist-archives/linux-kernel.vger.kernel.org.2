Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA03A2D30
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFJNir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230188AbhFJNip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623332208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QCFN6xw1XhKu17cxBm/bp2yIaEQKpdCYnoa1B+e0ICo=;
        b=TmVjF10j/BIxwsmdzpoMhYsuClvYHQJKg2WeLNtFcfzwAr8wzbFoz8YGHQuNA8SayaXdvH
        MOK0jTrkrZYuSL6t6k/28mHPRz/U+xTVbECLrrUl56qf7Bn9vdZeC6ZkBmzsylD3tKaD+L
        aHc2TMMW8jpeW/jpawDQPmjxSVhDQe0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-OfugLEr8NFeuu59bCpKjiQ-1; Thu, 10 Jun 2021 09:36:47 -0400
X-MC-Unique: OfugLEr8NFeuu59bCpKjiQ-1
Received: by mail-wr1-f70.google.com with SMTP id u20-20020a0560001614b02901115c8f2d89so911176wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 06:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QCFN6xw1XhKu17cxBm/bp2yIaEQKpdCYnoa1B+e0ICo=;
        b=gjBrVqAjF3HcmziNxpdw9EnNh/O8Nvbevd8TzC/Ze/i9drokBdZJRisJdz+gk8QUDL
         mD7rYGFc3hKw+x8Jhct448Ghn5dxG0HnM7lWUzLp10+ovxrjwDONZTPFvJCSNhLCcHTj
         WkVxiptsZ3SVSl99d635INLj8cylZxxw9KLuRbw/ghL/LoSwl+FncFaVcXHqXfa5DENy
         zyLf5yjmwNh5pjvAH9L0J80AuvwvXiyfLDzkykWKDC9nyS0939pKlze+2vUNCwnrYe8G
         pvDuGVEqpAs1SVCWOFLUqKENfvMHBI6ART9DNbDDTLhauCoGW5ONUryILsC8hPLDKYe6
         BJGg==
X-Gm-Message-State: AOAM532lJeQvqaS0svEKuVIWpJzbAU8CDQV67nhs0dTSnt1U+EWirVr5
        xyXwr5zHVWkeZQzyQrumBY9btD1LwV7bse9DCfLBFVjsYCi1gJ9THTgblXLBObiPKYhSKMteZBA
        Be14QrDj6lWYXaF7hgQUvmo0=
X-Received: by 2002:adf:f044:: with SMTP id t4mr5530147wro.73.1623332205982;
        Thu, 10 Jun 2021 06:36:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZjM243g9jivvFs3e5lMcygYwmD9msbpIi/7ZQNJiH6bT4ao2CZQ5c5WCj2GP1OnNtLv17Og==
X-Received: by 2002:adf:f044:: with SMTP id t4mr5530129wro.73.1623332205862;
        Thu, 10 Jun 2021 06:36:45 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f184sm2077569wmf.38.2021.06.10.06.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 06:36:45 -0700 (PDT)
Date:   Thu, 10 Jun 2021 14:36:44 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <llong@redhat.com>, Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <20210610133644.zpoqfvlchaey24za@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
 <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
 <353d012f-e8d4-c54c-b33e-54737e1a0115@redhat.com>
 <YL8MjSteKeO7w0il@dhcp22.suse.cz>
 <20210609143534.v65qknfihqimiivd@ava.usersys.com>
 <YMHivM+0DRYXzAD0@dhcp22.suse.cz>
 <20210610122323.6geriip66jjmdstj@ava.usersys.com>
 <YMII3OMPoZPuCe0r@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMII3OMPoZPuCe0r@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-10 14:43 +0200, Michal Hocko wrote:
> Well, I am not sure this is a good thing in general. We do not want to
> hide tasks. We already do display oom_score_adj_min even though they are
> not eligible and that can serve a good purpose from my experience. It
> gives us some picture at least. Maybe a flag to mark all uneligible
> tasks would be something useful but I wouldn't drop them from the list.

Fair enough.



-- 
Aaron Tomlin

