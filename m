Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FF8388505
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 04:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352920AbhESC5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 22:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbhESC53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 22:57:29 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAABC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 19:56:10 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i5so4224993qkf.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 19:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=p2KS9oBF+dk1/NmsQ5/iLX5xiPyoZKrTSQ2zGl7OHZY=;
        b=N8vvpJ8e+RhH6IOJ3lFaJHs0nWUNxm8ZkrJlOsjhlKdweEkvT6koqqSFikI2usFVN3
         SgstegirAMJthQeKVOvLnj9VIeaLe+iXM3fBLUegs0FH8MQI95R8Ph1J+ywg8grIg2/h
         4muD0bwy5q+IdgrQfJY7FZO78oOrv/vOu2A3e8HZkbYrWtenDA1JZu8WgejpvY+DKtZR
         Y7qHN6I5iA6hBM0TUPSy+Apa+v4TxAoseJfwLWifDBuJ1QZQV96Lk9hmdIrzRo6Lgb5T
         GGVQDf3vvYwEfhJLiJVEE6uPCOGisIfoSkFr5jQoPkw/P5Y5xr+xHo97a1dAlGK99Dgc
         mdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=p2KS9oBF+dk1/NmsQ5/iLX5xiPyoZKrTSQ2zGl7OHZY=;
        b=ESizBfbwCT4djbSdwD8w5Bv4/kAy9Fpql64nCeVPkIbFycEUOBiaNa6JzXi8a2N/Qq
         wx8exu+M8/HjGzoFjKqwteeOFobj3TuJqloXT+HGw0A/bEH9NK4U0jPWLu2fPoD1ZCaE
         yCqmr2RRDounHykYDEkCmxZj+Wu7bQmVLRFrR5PJpV9rRPf/YlzFewqKp9cOtY16fP8g
         y9f3HUpfzvneYNZg7cQm+XnhkXTI/k3igCLciDBj8GYmi0eVdhmtwz0/R8X+YTY5742G
         3BecOUrdWap7RJEY7W/XBvdbG1Xbb8datnbhnLqk6Za7sO+kg880pj/j0i3mn/amJ3bh
         otrw==
X-Gm-Message-State: AOAM532DqXdjO8niEqVVqTBBODXJ+vnq5PWvM5O9tMX0rOP8GwI3oYde
        aKOWXyZvI9Ek3S4KloWInr2a2nzcxZsLpQ==
X-Google-Smtp-Source: ABdhPJxcIPjSNkBq4H8Ka88Y9K4c+ysVPL1lxRsd2ytPfCWKuRJ7EUrw8yCQ6y0do4T7ygrRkj/jbA==
X-Received: by 2002:a37:4484:: with SMTP id r126mr9458035qka.18.1621392969013;
        Tue, 18 May 2021 19:56:09 -0700 (PDT)
Received: from ArchLinux ([37.19.198.113])
        by smtp.gmail.com with ESMTPSA id y13sm14096357qkj.84.2021.05.18.19.56.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 19:56:07 -0700 (PDT)
Date:   Wed, 19 May 2021 08:25:52 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Am I the only one seeing LKML is lagging badly? Delivering the mail
 ..wondering
Message-ID: <YKR+OFOPDBc4LMtH@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WR2wLKJfjuXQGING"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WR2wLKJfjuXQGING
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

  Hey,

  The mail delivery is happening in snail space. Or is it just me experiencing
  it??

  Almost a day behind in terms of mail delivery!

  Thanks,
  Bhaskar

--WR2wLKJfjuXQGING
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmCkfjQACgkQsjqdtxFL
KRVNiwgAh/MmWeJcwYkCnUCw8An77D+6yQ0EYA10vNWWZ3jfwSGnozwOWMOn8QuR
8qIFlURn4V/SZT+XxlJq3GXSc73BsgpUTz85Yhl6QaIXtoI3G5Y04aXx3eKXLaj2
lIIUptFiGBoyaatuHPADv0A5NsqthkjS/lD6rCaNPGDhdH0UJNisa1w7hf1k972n
9+6OFOYugzpuzD3s6dsUT8ZPK8wyoPuMXBbTO7eB7vJXIFswH9cFwEOeRWwvUp9F
pYkZW0qPzEaNhTs/j5ayW7xBSBUCW1I3Jug797zBi2go/G3EXilzVvKNv5+iTlB7
OBoDc6uLe4E8NsvoKAmX2NI3GXcj+Q==
=YrFt
-----END PGP SIGNATURE-----

--WR2wLKJfjuXQGING--
