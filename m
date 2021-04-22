Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E2C368821
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbhDVUjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236992AbhDVUjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619123952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNpLvi6EdAaudYQUjNEEJ6bmi8/lRMsChihQZX3u/nI=;
        b=THey2O8FKxkdsYJm8XVkVJ/okMJNlEuCeBq7dYJzFlfB3CtQEKnKV+BCj5agkN/vryKJ9x
        Yo/e+gGzCw0kX3X8k8hTyrpxcSv50OCPO0RSjF1V9MpruX/5eA/0HZU17ZhqFp2yY8HgU1
        zwJPHE2zPr9WChN1VT2s5371d/pf8E8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-2ATVN6IENzKRVDNiTR_ZLw-1; Thu, 22 Apr 2021 16:39:10 -0400
X-MC-Unique: 2ATVN6IENzKRVDNiTR_ZLw-1
Received: by mail-qv1-f71.google.com with SMTP id o7-20020a0cf4c70000b02901a53a28706fso11458985qvm.19
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cNpLvi6EdAaudYQUjNEEJ6bmi8/lRMsChihQZX3u/nI=;
        b=CA39oR6jTKjJN7VKt04WbQpCfFIhhQWw2mlsGtOdUCKKvaLewVKlS2Vh8YCKa5tU8v
         hXT01lYd0kXxPSNKs15Q5RARVP7oIqIi3ZzLkdC5V4csaODYhdoV4zgBcPODpWF1bzja
         KrAEFwCctcLCjkqEg+pNoHOvcafs+IrNofXyFQVxnbw+q1PLaf+9LAN9r+ogec4eLu+8
         TQysI5G6WKn7shZ8NZOXos4sm12/WO5eY3nmp/YOLMMeq1dPEJzlAh7HuMEcy3hleOyp
         5IK5RPmdSJA2Cc82dLY4Mzy3OPVnhr1ud59qiKWUm44r0/zyBIQ16az9WSdOelXUCovP
         yAjQ==
X-Gm-Message-State: AOAM533Ite7WvYs4KF8ef/jUNdP1YKRYuHZsx5qMIbBWXUJ1hIFDx2ZA
        AUo2foobv0oKTM9s5t/aJypk++bXkGg2lKThZJXflxxDqsgnTSy8UFIs5AG08agFy9o7gG5uIPS
        cxVD3oSbJkCsB9r49s8dx22xh
X-Received: by 2002:a0c:e14e:: with SMTP id c14mr617271qvl.36.1619123949709;
        Thu, 22 Apr 2021 13:39:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcGeYSvpo24gXWSguEVi9JQ7kiE7Jqh/3hwJUN+VQ7PimQTarKqFfkP4TIFwc1yNxophk9lw==
X-Received: by 2002:a0c:e14e:: with SMTP id c14mr617245qvl.36.1619123949525;
        Thu, 22 Apr 2021 13:39:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:184:417f:70c0::42e6])
        by smtp.gmail.com with ESMTPSA id x20sm2989311qkf.42.2021.04.22.13.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 13:39:09 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] kunit: Fix formatting of KUNIT tests to meet the
 standard
To:     Theodore Ts'o <tytso@mit.edu>, brendanhiggins@google.com,
        davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-ext4@vger.kernel.org, netdev@vger.kernel.org,
        rafael@kernel.org, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, mathew.j.martineau@linux.intel.com,
        davem@davemloft.net, broonie@kernel.org, skhan@linuxfoundation.org,
        mptcp@lists.linux.dev
References: <cover.1618388989.git.npache@redhat.com>
 <YHyK+5xJEMcDDhVy@mit.edu>
From:   Nico Pache <npache@redhat.com>
Message-ID: <dbe6abeb-0082-e309-1208-9c43c6f127ae@redhat.com>
Date:   Thu, 22 Apr 2021 16:39:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHyK+5xJEMcDDhVy@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/21 3:39 PM, Theodore Ts'o wrote:

> On Wed, Apr 14, 2021 at 04:58:03AM -0400, Nico Pache wrote:
>> There are few instances of KUNIT tests that are not properly defined.
>> This commit focuses on correcting these issues to match the standard
>> defined in the Documentation.
> The word "standard" seems to be over-stating things.  The
> documentation currently states, "they _usually_ have config options
> ending in ``_KUNIT_TEST'' (emphasis mine).  I can imagine that there
> might be some useful things we can do from a tooling perspective if we
> do standardize things, but if you really want to make it a "standard",
> we should first update the manpage to say so, 

KUNIT Maintainers, should we go ahead and make this the "standard"?

As Ted has stated...  consistency with 'grep' is my desired outcome.

> and explain why (e.g.,
> so that we can easily extract out all of the kunit test modules, and
> perhaps paint a vision of what tools might be able to do with such a
> standard).
>
> Alternatively, the word "standard" could perhaps be changed to
> "convention", which I think more accurately defines how things work at
> the moment.Nico Pache (6):
>   kunit: ASoC: topology: adhear to KUNIT formatting standard
>   kunit: software node: adhear to KUNIT formatting standard
>   kunit: ext4: adhear to KUNIT formatting standard
>   kunit: lib: adhear to KUNIT formatting standard
>   kunit: mptcp: adhear to KUNIT formatting standard
>   m68k: update configs to match the proper KUNIT syntax
>
> Also, "adhear" is not the correct spelling; the correct spelling is
> "adhere" (from the Latin verb "adhaerere", "to stick", as in "to hold
> fast or stick by as if by gluing", which then became "to bind oneself
> to the observance of a set of rules or standards or practices").
>
>        		       	      	       		 - Ted

Whoops... Made that mistake in my v1 and inadvertently copied it over

to all the patches.


Cheers!

-- Nico

