Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F2D33DC43
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhCPSLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239859AbhCPSJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:09:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E332C061762;
        Tue, 16 Mar 2021 11:09:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d23so14120708plq.2;
        Tue, 16 Mar 2021 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kwCYvOSg3Vly9TubKoJY2b4cxNmpRuA1nBAv4tTlja4=;
        b=FPK+AdOS9hUo62UOCNFXU2A1+K/CZd1fEjJIwqzy3sPoMF8jJ4EybgoVZSbkOlHq17
         tO0+hGlAf0jm4sqj9jSsNZzj0cPwYg/OVKe3uL1SNZDy3peUzNczwud9VF4BDlhpjYU9
         IIm/6P92q+IYe9C29DXSSXMODSCRphGRU2ZZjDTUTaW06pbzzTWWOWhT57U5ykm/OF1q
         ctHxBzl5UK1FELRGVXFM+mfi233z34v5tSNjB6E2cL0epNp6ykHM1kjJt2S8hv7brK1p
         Gdd8vquGvMMVx80J7niz/a9ReHe+hYw+xFkcLd3opC2txlbD+M3bE6+JrMVLgVCZYw8/
         bUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kwCYvOSg3Vly9TubKoJY2b4cxNmpRuA1nBAv4tTlja4=;
        b=Kb0MW4G26DVlcS8/K2EyF/NVJpTcZtaEMMTbPTz7OHmZotmA0q18pniQn6LEhhKrjF
         UA6Edjb4gZ2Pr0P5s6/wpuMvPSVplITBjWYr7JVqvglHg70fMYOCatNxHCsPwwhVIXM+
         GL+sFowYTTVVGT/OaOqHXRfTj1KpYg+ui62KINQCW3rB9tsXbT3J+uucAzq8H2WKKoKE
         t0CWaapsPvbsHx04qVM/8GvFUttvTFH0gnCWMqpL0X9QS6gmwLYJ0wTkBcFZvigNorAA
         aDq/gW5ftGyPAyA/3il/xuBN0jqy+C7KXB5GUsNpYWjHq8gT9Vr9xGEX4ZxWN2PbLTKi
         u1QQ==
X-Gm-Message-State: AOAM530ye0dkaAmVWY++P0cCSqxyzqrTOgWayp4qQXZuIpa6ibuvUvZW
        eJqwQbGKX/5Jeb/qxBh5HWc=
X-Google-Smtp-Source: ABdhPJyHF14TE1cHq52T3t9yf3fdJSczWgvfW7/XvhqjE1oB7I+QVsIy0czPHLhRM5ACUOJkZa5wEQ==
X-Received: by 2002:a17:90a:4498:: with SMTP id t24mr320936pjg.78.1615918159691;
        Tue, 16 Mar 2021 11:09:19 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:4160:1d48:d43e:7513])
        by smtp.gmail.com with ESMTPSA id p7sm6184768pgj.2.2021.03.16.11.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:09:17 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 16 Mar 2021 11:09:15 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: cma: Fix potential null dereference on pointer cma
Message-ID: <YFD0S7M96jVFVPe+@google.com>
References: <20210316100433.17665-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316100433.17665-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 10:04:33AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> At the start of the function there is a null pointer check on cma
> and then branch to error handling label 'out'.  The subsequent call
> to cma_sysfs_fail_pages_count dereferences cma, hence there is a
> potential null pointer deference issue.  Fix this by only calling
> cma_sysfs_fail_pages_count if cma is not null.
> 
> Addresses-Coverity: ("Dereference after null check")
> Fixes: dc4764f7e9ac ("mm: cma: support sysfs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Minchan Kim <minchan@kernel.org>

