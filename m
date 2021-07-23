Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845A03D38AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhGWJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhGWJtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:49:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F68DC061575;
        Fri, 23 Jul 2021 03:30:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b7so1163893edu.3;
        Fri, 23 Jul 2021 03:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCTcORAv1g4ZQcCl45BbfbmRXduUC1LuQuWshBTXAcU=;
        b=QpURZJKeVutsL2qJCbTXmluDt838EfpKWZvDZVTk/VltnTaXidaJZ/FAEi8B33O8TY
         I2wTTYGIcQ80aCU49Xqu982fgV/ActDLwyeSGS7G1NXGmeKUtCtJxr9LMDp34R0rHjyy
         HUfI4i8yeuJ3mEfcB2x1ecWDHfKySTGkI3S/PbjUYAd1CwW/CCk8YDAvUB6ZNG/qqmxs
         RTT63hyrxitUbdwHXfmRCPWzlEzpspfDIB0SR7cJjWAsKoTir8XbMT1odgjMepzl/clm
         6Gp+PrHmnSRQKt35syaxFWK40NSXj1Mf/GNL9Y7AT51zq+Boi6rNKCEuyBHxzr+0ZGKy
         RG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCTcORAv1g4ZQcCl45BbfbmRXduUC1LuQuWshBTXAcU=;
        b=G0Uu/VNWaIv7YK4lEl8fNkLXQ11enX/0jjWzpPeOvsnQ+DZM5efClyYCLk3cqo46dj
         CTfMR6VNph5kZaE7uD/jr0SF3aQ/84Anemo+C78mjjOaaDWiE/LMMFKrNItpxCzuoZXb
         OTUktvOn2RRpRa9NxZwLavAR8k3T38pDSCSvcjWGFDrm2hBLI4XF43FabfrDi66whbiX
         lvTwfkOoBQW+5gbk8RsqPGGDOzf62KIHVZCXXrPt0zwCs+gnayUBNQoITE+g7ZA41053
         qZREsbo3XMEtWvNz+JF6qmWr/4+E/wV1re/QmHN0erhs4bp2JvSeficd+H8nmfGomiYn
         Gt7g==
X-Gm-Message-State: AOAM533NHaarKmzh6oxALNdMktRQfqi7vRxf3OfhIBTQxrQ6LCg37KjM
        NWarQxaWHZ+sYJo5ceHIA2pq7HGlmyq7wg15zfY=
X-Google-Smtp-Source: ABdhPJyTUYZnNcIhqtcdl/GULEIgUzuWe2DKhVxIgGx3Z7dURnN5tnskvOXZC3jcCDbpRDPN6T9OTl5wkfRk1c2+aTs=
X-Received: by 2002:a05:6402:18c4:: with SMTP id x4mr4770170edy.350.1627036219141;
 Fri, 23 Jul 2021 03:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210723074317.32690-1-jslaby@suse.cz> <20210723074317.32690-5-jslaby@suse.cz>
In-Reply-To: <20210723074317.32690-5-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 23 Jul 2021 03:30:07 -0700
Message-ID: <CAMo8Bf+oAgVeihx_Ca0v69=nFYWJSsgTuUab3fe3ZWXRNi4-pA@mail.gmail.com>
Subject: Re: [PATCH 4/8] tty: stop using alloc_tty_driver
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 12:43 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> alloc_tty_driver was deprecated by tty_alloc_driver in commit
> 7f0bc6a68ed9 (TTY: pass flags to alloc_tty_driver) in 2012.
>
> I never got into eliminating alloc_tty_driver until now. So we still
> have two functions for allocating drivers which might be confusing. So
> get rid of alloc_tty_driver uses to eliminate it for good in the next
> patch.
>
> Note we need to switch return value checking as tty_alloc_driver uses
> ERR_PTR. And flags are now a parameter of tty_alloc_driver.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

>  arch/xtensa/platforms/iss/console.c    |  7 +++----

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
