Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B048C387AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349763AbhEROHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244785AbhEROHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621346760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hwF9LeDBndbc4TKf08dL36rjBtWuzIAPQdyuiQwz9l0=;
        b=EIssXiAN5tS6NNyIZc2JG6IyyvrazfTOFL7w0fY2dFtysOAEWobhKtNv5ux92wa1Y+gEHn
        E27gbfcfKPL0PwWI8SzzfFuUB69ityR+ZWxJcHvFI7VTVXiWam3J1kBZ2+hhc4MBroOdX1
        7r9SdsFlQWZ2Nr5gSuOT4Ruc9jlz974=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-g1wRtwF3P3GgTgutta3mRQ-1; Tue, 18 May 2021 10:05:58 -0400
X-MC-Unique: g1wRtwF3P3GgTgutta3mRQ-1
Received: by mail-wm1-f72.google.com with SMTP id j128-20020a1c55860000b02901384b712094so585319wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hwF9LeDBndbc4TKf08dL36rjBtWuzIAPQdyuiQwz9l0=;
        b=sTJF0q8QVeXAXjt/ACRJ6mkZRrcobKqdQGyIqPcnIWyMKmS5ztwO3Wr1aLR0+0vYC0
         klAvnzzIuCJUjKytrtHTFHtJTAiriOtIzo81/2pjulXGy5z/O2ITu42zxSIM7QDFYo3+
         3CSclQ2zmXEzx6UJKh4ACnadcxFnXiSxCh2uZNJSTnEiPX4xubSmXp5QSwjXB45zSrOb
         yfMGREAQ9/JxCXb8XxRRlZvHb7JD1FBVAf2WhmQALXugIH+yQTqM3f4lD7joQyb/7QAS
         y6qn7dEQ3QInBbMaMJOIPGpsd4RFCT5TRm5tCuFg9hE0pNahYVPKCIDZY1m1wraJDEWQ
         xGIw==
X-Gm-Message-State: AOAM532rfGAsrp6urNUlTwyfj85/tzgF4VxBZTULG+v6tX0dGEySj+7h
        /d9wUCuDuHWm8lbnP0CuesUOyGFsQjqItnYnlJnhDhBumvd7WQKrzU9gQ4Lr/WwmtHqstIfWoJF
        Duvi++Rqrf5jGyrSoLxE1acQ=
X-Received: by 2002:a5d:4b08:: with SMTP id v8mr7352462wrq.122.1621346756525;
        Tue, 18 May 2021 07:05:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyThmqOZjeIy3KQ28wEzYYlXG8qZbWV69joGSKqboCqYIqvYg8Pr78tyqaPsFc5dn36E6BTsQ==
X-Received: by 2002:a5d:4b08:: with SMTP id v8mr7352437wrq.122.1621346756332;
        Tue, 18 May 2021 07:05:56 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id y14sm2729448wmj.37.2021.05.18.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:05:55 -0700 (PDT)
Date:   Tue, 18 May 2021 15:05:54 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/page_alloc: try oom if reclaim is unable to make
 forward progress
Message-ID: <20210518140554.dwan66i4ttmzw4hj@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210315165837.789593-1-atomlin@redhat.com>
 <YFN8wXwJA59w9twA@dhcp22.suse.cz>
 <20210319172901.cror2u53b7caws3a@ava.usersys.com>
 <YFh10eSTKY5lbE9u@dhcp22.suse.cz>
 <20210325210159.r565fvfitoqeuykp@ava.usersys.com>
 <YF2YTNnyzWNHfrEg@dhcp22.suse.cz>
 <20210326112254.jy5jkiwtgj3pqkt2@ava.usersys.com>
 <YF3/YZPd+iz/xGu6@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4oj4tq5xtvq4w6dd"
Content-Disposition: inline
In-Reply-To: <YF3/YZPd+iz/xGu6@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4oj4tq5xtvq4w6dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Michal,

On Fri 2021-03-26 16:36 +0100, Michal Hocko wrote:
> OK, I kinda expected this would be not easily reproducible.

Unfortunately, I'm still waiting for feedback on this.

> We should be focusing on the compaction retry logic and see whether we
> can have some "run away" scenarios there. Seeing so many retries without
> compaction bailing out sounds like a bug in that retry logic.

I suspect so.

This is indeed a case of excessive reclaim/compaction retries (i.e. the
last known value stored in the no_progress_loops variable was 31,611,688).

What might be particularly unique about this situation is that a fatal
signal was found pending. In this context, if I understand correctly, it
does not make sense to retry compaction when the last known compact result
was skipped and a fatal signal is pending.

Looking at try_to_compact_pages(), indeed COMPACT_SKIPPED can be returned;
albeit, not every zone, on the zone list, would be considered in the case
a fatal signal is found to be pending. Yet, in should_compact_retry(),
given the last known compaction result, each zone, on the zone list, can be
considered/or checked (see compaction_zonelist_suitable()). If a zone e.g.
was found to succeed then reclaim/compaction would be tried again
(notwithstanding the above).



--=20
Aaron Tomlin

--4oj4tq5xtvq4w6dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmCjybAACgkQ4t6WWBnM
d9a+MBAAmH76h+vl0MTKp+BW4YxqXL9f0lULDieShMJQys2khOOQSuRcnFIsuCM3
fg2AuDFB8SgKY++gws6+ardG9i6jtNRFEczsK0ZFwwvUzxo5TOZ78EE8/PaMeAcv
z5o2pAGdSBARUGgBzNVzur60uGekXjiq2nG3shuU1BtgUiki1M3xXfzHFofvbrM7
LPzIdnXUxmGVsMORH0raYkSdZNbP5xY2lKHCoUu/NpkVsqcRENNRwULgFIiDKexJ
tRG1eOjDuJ0R7j5jTOIlsDtIuSdg2YAUEE1YNqt+05LvF7RjuRcKedlaelirw3Wv
cuNTxFw0YBj8xLxcIBPzayzF0w480OAZg9jkC8RbRI/1scd5tp3GiEVPawiwFcHH
GLg9FP2Y7qRDCymy2kurpW5xHnAj5gX0WvrApBXmTUR1eowwy27iRu39lvqN4k8P
LAXSpk+YmQm231YuSv4qn9wGoIrzBwTWISMZL8vUW0oJ+TikSqEzenptOBm2HSQd
U++Jyv8+ChbiiZan+spabF8RsOzKip0afwMNqzaOfklJ8DMy7PiCw6AAwI304LGj
Bua6ba3UzY2/NXjJRqnNNWBUg2i50nm9YsuS4h5sLbWwaKimG6TAHnayeoBUdCgP
45lMlrofia3baPxitQfsPbc51N37T/y1uQLZU4ui42EhCKB8bw0=
=onqo
-----END PGP SIGNATURE-----

--4oj4tq5xtvq4w6dd--

