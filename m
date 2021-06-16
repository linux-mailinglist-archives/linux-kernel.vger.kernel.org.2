Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9063AA515
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 22:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhFPUUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 16:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233255AbhFPUUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 16:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623874717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBKuC/zd2SJTCQRB667Q79ZDQQx5aKnfehXLv1VuI/s=;
        b=GRy+kPdxSftzoHsuL/xf4KBisOYjsf0wnhdRWz0TQk+CUibdDcgqd7W/4lGpGLYgIMKH69
        D9RmYK8XPGhGpXeDWHEPyeEjS9xtZHSGMt7QSv4JrBzXGgdpl0RCHgZPxM6LqOvf/YkeZW
        THR1bg1qznrfr9MD2y0nCZHOzor1m+0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-9k_l1zucNyafWQl_MG1-zw-1; Wed, 16 Jun 2021 16:18:33 -0400
X-MC-Unique: 9k_l1zucNyafWQl_MG1-zw-1
Received: by mail-wr1-f70.google.com with SMTP id u16-20020a5d51500000b029011a6a17cf62so1535035wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eBKuC/zd2SJTCQRB667Q79ZDQQx5aKnfehXLv1VuI/s=;
        b=OjJG5F7h41S++qbcVU3xcmqTb/6mJKkIQmDho5zlkRjdcrhxsA/XGIgkXxaiwgdU7l
         nFAy3HUabNpqhMV33z0YbovgLn/IkuODLjY+mDiedUOrlJZOp+IlwptK0F/16P2TwjZ+
         iiSsR5xsGerUQbwenKvYnDjF2eIqJMmMgfETEgHOpf39NO5o+JjEegK4FbyUCpoAPnBt
         MQfhfH7xqcMcbZFUp/b64nKblbmHRgIglXNUkCnCj+f55v/BLrjHdY/0vxmRif0acfD8
         ZoaOY6ztUSz+O7nCTEtJZ+MWknHeuHhw3ywwFSVnJe6xg/bprtJHB8ceOm11hQA8aOd2
         xXRw==
X-Gm-Message-State: AOAM533vGnICP3XOANBS2X5LIl23kY0PTn6Wo2JM17ozbxS5CZiPUsNa
        tl/XnFPYNZmwxuVgpOIZpcAsL2AOpJOe/uDW+jWSNUbO8maF1oITYldwbV8zYoJFAyz+tTyRPeN
        m7+n05ub144rVrebv9bPYUxY=
X-Received: by 2002:a5d:494c:: with SMTP id r12mr995526wrs.421.1623874712276;
        Wed, 16 Jun 2021 13:18:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwW4mzta5FTJf37nehtWeygVdfqM8nj1F2j7zPoyJcBupxP3eI2OajOb0S3aHM109Cx9zLXBw==
X-Received: by 2002:a5d:494c:: with SMTP id r12mr995509wrs.421.1623874712100;
        Wed, 16 Jun 2021 13:18:32 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id z17sm3160152wrt.60.2021.06.16.13.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:18:31 -0700 (PDT)
Date:   Wed, 16 Jun 2021 21:18:31 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        penguin-kernel@i-love.sakura.ne.jp, llong@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/oom_kill: show oom eligibility when displaying the
 current memory state of all tasks
Message-ID: <20210616201831.m6el3lob3eizwd3t@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210612204634.1102472-1-atomlin@redhat.com>
 <YMb6w/bGdhJvOy6j@dhcp22.suse.cz>
 <20210615115147.gp3w5bcjoaarvyse@ava.usersys.com>
 <YMigO5N55QhnrB87@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cp2wvemzhtrrjjju"
Content-Disposition: inline
In-Reply-To: <YMigO5N55QhnrB87@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cp2wvemzhtrrjjju
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2021-06-15 14:42 +0200, Michal Hocko wrote:
> This is all true but it is not really clear why that is really a
> problem. Kernel log already contains information about reaped processes
> as they are reported to the log. I fully acknowledge that this is rather
> spartan but on the other hand from years of experience reading oom
> reports I have to say the dump_tasks is the least interesting part of
> the report (while being the most verbose one).

I understand. I suppose, in a situation whereby dump_tasks() output is only
available, for whatever reason, it can provide at least some
insight into what tasks were actually considered not OOM eligible and why.

> All that being said, I am not really opposing extending the information
> although I am a bit worried about leaking too much internal state to the
> log.

Fair enough. That said, I still feel highlighting such "ineligible" tasks
could be useful to the viewer for troubleshooting purposes; we already
display OOM_SCORE_ADJ_MIN. Consider a situation when only a few tasks in
a memcg are displayed as possibly OOM eligible but one had MMF_OOM_SKIP
applied.

In my opinion, perhaps it is better to just exclude such details
altogether. That being said, as you know, we only provide this facility
when one is interested in it anyway i.e., if oom_dump_tasks is enabled.

> What I am asking for here is a justification why this addition is a
> general improvement and how it helps uderstanding oom reports further.
> So please focus on that part.

Sure; albeit, thinking about this more, it does not provide much
understanding in simple isolation.



Kind regards,

--=20
Aaron Tomlin

--cp2wvemzhtrrjjju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmDKXI0ACgkQ4t6WWBnM
d9YqOg//ZJvwyHkB4rdF2yXUBIz2+Ud8O2L9hlvNQ4CpBQ83o/EKchB7cznvf3X7
s3w7As7WaLZJYt3JMWdHj4L+QLGS2Zf9QIBFYtcLrW/jo0fR2hia5bpms8FsPQxQ
BvA2RavUDTSPlyz/xkUF0vV5tf+c7YI6qAFu2HPw5IWwnYHQXjGwcgNeWsKnVAZs
nPh1VMUm0Xjw0NyQlgHqvQr1o85eVAyQGaO+ro+EgDZJCPrdeBsYHZErOXUnL2gd
HdaOItt5W1UKfDFbJ3i8wUr/SpvQxkWUmDzv2cchDV5nQ3RpkT1uwrw0egu7CbDZ
WBV/P8Ckodf03yIvmD5MQsKHGmcvf8/craWyOprb1Xl+hOC6QMT3pJz2LdmMiUvp
l8P0KuiFu1MwCytHbcPGhN1ZO0pg4hMg+gRl2xReu7X6DPFfi/BSkIDt/RcStzYS
829o4UY6rk0uobB1lHo8IQHKr6AarwLK0PcjxmpvrULgXDE9beFTN6ISJJMFZeWV
rmsKDluSHkZIRETs7XFvzJGetIMY1xjTQxFG0PzGWJJSsABgYf7+NZA7FqizNVUO
c35i6YTqs2yLbYv7kvkMvw72uTm441jlyw4M+LktxMOc/AfBdvWZUAI9NBBbzYpc
CXPhLrtTqGgcUV2WjHsYJIC2qWRZWldttmzEEuWCqbIzNXbAYzk=
=/GLJ
-----END PGP SIGNATURE-----

--cp2wvemzhtrrjjju--

