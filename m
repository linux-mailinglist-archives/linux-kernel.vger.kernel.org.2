Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC473F12A9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 07:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhHSFHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 01:07:51 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:33457 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHSFHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 01:07:50 -0400
Received: by mail-lj1-f170.google.com with SMTP id n7so9390154ljq.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=j+N1OWJ0Z25ZQ5VpkwxpHUv+Rux+GpKBQNztIo3aVhw=;
        b=V2x6VGwK75rDzy5zBkqf2tid1OsHBkSJAMORn4AmmsR+Klc/mbocl/za5hiztGIADd
         GkeLzM36PF5LHDrzc8HpJDRAOKWYj7OrdbXnonu8/dA/I/q+pR3qzDUSp3mK2UCTFrgf
         KJamOuzruK2ILr0X0GHEEyEkWhhPDmFwOHPkWiJov6bABcX5N9mI7xOGkabvTS5jBOvl
         s6h8Fe+wDhpQ+r/WDUQzbuO0z/0r5zNWMQz1gYr5HFR3qCmPqLLB55jN4kF3vERFeDEP
         UIbDcE2069QTGh49L+DOqK6GB3rBy95tPjeNU2/MUMv7McOo+J0rTEeXnqqRFJ8/b28s
         VGdA==
X-Gm-Message-State: AOAM5310TJBo0S17CIrbwC0Uhu31K70FJSARj8w6nmCohQCqy3Ojkb1P
        L6RIOavi4jtLuQU/UHlgxx0zwAMrNhIcNodL
X-Google-Smtp-Source: ABdhPJxDdWjp2VqYfgQjeKjBMf5m9d48ZLSQWgKYCa4/i1dXb54CRG8zyhmU0af/s8REmqmKlacUog==
X-Received: by 2002:a05:651c:382:: with SMTP id e2mr7488275ljp.401.1629349634326;
        Wed, 18 Aug 2021 22:07:14 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id e1sm180296lfs.307.2021.08.18.22.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 22:07:13 -0700 (PDT)
Message-ID: <67f6596f54fd2ea168d71d0747ea4a521dda5384.camel@fi.rohmeurope.com>
Subject: Re: [PATCH] regulator: Minor regulator documentation fixes.
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20210818121709.GD4177@sirena.org.uk>
References: <20210818041513.GA2408290@dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi>
         <20210818121709.GD4177@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 19 Aug 2021 08:06:48 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2021-08-18 at 13:17 +0100, Mark Brown wrote:
> On Wed, Aug 18, 2021 at 07:18:19AM +0300, Matti Vaittinen wrote:
> > The newly added regulator ramp-delay specifiers in regulator desc
> > lacked the documentation. Add some. Also fix a typo.
> 
> This should've been two patches.

I was thinking of that. I thought that it made less of a hassle with
single patch. After all, both changes were doc updates - and I didn't
think the typofix warranted backport or a Fixed tag.

Could you please educate me & explain why would you have preferred two
patches? (I see you any ways applied this so I guess there's no need to
split & resend - thanks).

Best Regards
	Matti

