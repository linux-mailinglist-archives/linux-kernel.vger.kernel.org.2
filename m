Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16753A078C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 01:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhFHXK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 19:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbhFHXKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:10:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E68EC061795
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 16:08:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q25so16910178pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tsOcayd7p5kwqaMZLuvyzUWjmMCtq6s6XW4ouQcpv3A=;
        b=QMsOr2yQt+lG5XNDYgmPFgMNQJAvua9p+XthSAPE+eIp8BKveU8h4RyuEA7ciOfD5d
         WDAite/miimuOfLX+uyImyaV5lmmPxMzbY5I5fr0A/R4E1newY8zeP6EJEhA+BGgtgIH
         +fD5lp0/HCXcUHXxIiI7AHmIbSQaNKlQ2AnRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tsOcayd7p5kwqaMZLuvyzUWjmMCtq6s6XW4ouQcpv3A=;
        b=VKblINxEvTK4GRsQnkO6Y1kGiBDENIahwhsTOwrkcAKI4TLvElg2GBws8M3hJRjWyg
         lFEVY2GBf8vj1W+8Q/8aIC5byd++MAY+SGYK8eFbrwY2znLDIjUTYE58y8wh2JQRpyLf
         mHoq/N7CY9S+Ke1RCvhnCSHW4CtuSDSGi0NOr24D5BPnDewvwYtgyIK9WzDMybgY6F6t
         vWd8JA38R383DPymObnBnrKq18U8RrtEVucOsCbQ0anSnScdwxIROLq1paMY1HGM/HtF
         zN+dHWsjwjfCY80q/FoBSphEvcTy4ZTnJb5otqE6oY+g3ZctPFhXDBQn9UN4WcwyTSP+
         W/dw==
X-Gm-Message-State: AOAM530tsGtKhKObCAvNQkPyQq2+lo0A3J6OdCw2VoTeOuTH5IoILosB
        VPmKyQyOj9nJHJkBNX/2V6J8Jw==
X-Google-Smtp-Source: ABdhPJxdn40QcfCA8eMkWU77J6EILIfV1TmIfUiG/sD+ni3fAblwXt+tWs27PX2+QOvKae8ApCvJxA==
X-Received: by 2002:a63:1a4f:: with SMTP id a15mr641484pgm.136.1623193695104;
        Tue, 08 Jun 2021 16:08:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h20sm11596260pfq.83.2021.06.08.16.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:08:14 -0700 (PDT)
Date:   Tue, 8 Jun 2021 16:08:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
        Christoph Lameter <cl@linux.com>,
        "Lin, Zhenpeng" <zplin@psu.edu>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/3] Actually fix freelist pointer vs redzoning
Message-ID: <202106081605.929AF37@keescook>
References: <20210608183955.280836-1-keescook@chromium.org>
 <20210608135327.be8a120ba3b1686bc62e6d7e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608135327.be8a120ba3b1686bc62e6d7e@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 01:53:27PM -0700, Andrew Morton wrote:
> On Tue,  8 Jun 2021 11:39:52 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > This fixes redzoning vs the freelist pointer (both for middle-position
> > and very small caches). Both are "theoretical" fixes, in that I see no
> > evidence of such small-sized caches actually be used in the kernel, but
> > that's no reason to let the bugs continue to exist, especially since
> > people doing local development keep tripping over it. :)
> 
> So I don't think this is suitable -stable material?

Yeah, I think it's -stable material, but I'd like some bake time in
-next just in case. zplin saw that there was a 2 * sizeof(void *) case
that existed in the kernel that would trip over the issue.

> It's a bit odd that patches 2&3 were cc:stable but #1 was not.  Makes
> one afraid that 2&3 might have had a dependency anyway.

#1 is entirely cosmetic. It should also be fine to put into -stable, but
since it had no operational impact, I figured it didn't need to be.

> So I'm thinking that the whole series can just be for 5.14-rc1, in the
> sent order.

Unless I'm missing something big, yeah, that would be my preference too.
(And -stable can pick it up then.)

-- 
Kees Cook
