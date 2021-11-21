Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD4A4586C0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 23:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhKUWfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 17:35:25 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:33904 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhKUWfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 17:35:21 -0500
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id A43F8CABF2F;
        Sun, 21 Nov 2021 23:32:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1637533934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCrlPvC0WGxM7eYrtDYCXvvxIBvtiK/+MSRZDk4ICxA=;
        b=DmsUaWr3xqSoMPQP+NTwYBGIFGrJN8oNwka1rXGb/ILx41IXaSe7oWUnydPj32im4jeqwB
        4sNmSyLpXEe0yKU+uXmSHgBMh6WZGQqnEQSbt0HnIJkjxQ68SNSQtqVOlGQAWeLEBQC+Eg
        gn+qwDfJ9/RkLZKkJ25BmMmx8tdv59I=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     akpm@linux-foundation.org, SeongJae Park <sj@kernel.org>,
        Jonathan.Cameron@huawei.com
Cc:     amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] Introduce DAMON-based Proactive Reclamation
Date:   Sun, 21 Nov 2021 23:32:12 +0100
Message-ID: <11868371.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20211019150731.16699-1-sj@kernel.org>
References: <20211019150731.16699-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C3=BAter=C3=BD 19. =C5=99=C3=ADjna 2021 17:07:16 CET SeongJae Park wrot=
e:
> In short, DAMON_RECLAIM with 50ms/s time quota and regions prioritization=
 on
> v5.15-rc5 Linux kernel with ZRAM swap device achieves 38.58% memory saving
> with only 1.94% runtime overhead.  For this, DAMON_RECLAIM consumes only
> 4.97% of single CPU time.

While it really consumes little CPU time, is it fine for `kdamond.0` to be =
in a=20
D (uninterruptible sleep) state all the time while active, pushing loadavg=
=20
over 1.0?

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


