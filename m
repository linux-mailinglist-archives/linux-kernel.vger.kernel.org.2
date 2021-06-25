Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96ADA3B413E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFYKPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhFYKPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:15:20 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33E2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:12:59 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id DEB38AF9EAF;
        Fri, 25 Jun 2021 12:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1624615976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5350MyimUBV0Ybn7v5TdRN+smme+PAxrF157fZFu+E=;
        b=JkzxTEFOtAUN7+j/PDq4vJT3hThjoaahJpvPlfhkyvnEcs1fddBqW2it+9sKafqU8RB2KO
        KfM9X2GhKy9+XQegKZlFyXQ97Bz3TRTSpm+NS/TSV9K2/oPFNradGGAzw6k+Xf61vIf+/I
        4wG8i9ozVr5HHPx0xwm3KlLuhZTlvSY=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org, "R.F. Burns" <burnsrf@gmail.com>
Subject: Re: PC speaker
Date:   Fri, 25 Jun 2021 12:12:55 +0200
Message-ID: <18351070.JLIgeDRian@spock>
In-Reply-To: <3050675.vmiHnzoCQa@spock>
References: <CABG1boMsJ+8OaLPmFcNZPRVPRRxd9gasxjZNwUy_3FD07XXO8A@mail.gmail.com> <3050675.vmiHnzoCQa@spock>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On =C4=8Dtvrtek 24. =C4=8Dervna 2021 16:21:17 CEST Oleksandr Natalenko wrot=
e:
> On =C3=BAter=C3=BD 15. =C4=8Dervna 2021 5:32:32 CEST R.F. Burns wrote:
> > Is it possible to write a kernel module which, when loaded, will blow
> > the PC speaker?
>=20
> Yes. Wanna help with that?

Also, this should be yours:

https://metrics.torproject.org/rs.html#details/
0E833719031D4E0BE04786F7907B9F4A70BE1C4F

So probably you are a real person after all.

=2D-=20
Oleksandr Natalenko (post-factum)


