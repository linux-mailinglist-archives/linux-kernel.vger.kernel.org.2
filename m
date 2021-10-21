Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C4F4368B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhJURIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbhJURIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:08:19 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC96C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:06:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w17so853661plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=AA/Vk7i32hp+TW57K1Sm4eATQ0xdRmx7/VZFp+nxsoc=;
        b=V0HizoaTjOwJiGRph9Oi6djZcOz/i0VafvXBQGVd3nbW7n+UWtdBAcbMQM86+BVj2V
         x7mqTnWZJ2jMLVTg7+fwy+eVheb/w13T3iegOI+X8JmyVbJMZK+i4zhAr6kUdWq5K8jz
         I078wMPwn9yw2UzOUPKkq1M/rhlvGrAjSRkgj9KMtkcLNmNfsoenu+HIk9mtsS9HSrWx
         3ijJ2rrmrVzX/s7YPew1HBZNxgxTTL2weoaSymXgRkCHyUEWY9R5qUsODNwIz9guzolv
         Uy8z5M2KnAjU/A4GDSsKI69TFRE5xevM8x8Jv+EIY6000YOmYTh28eY1Uk2/inQEygb0
         i5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=AA/Vk7i32hp+TW57K1Sm4eATQ0xdRmx7/VZFp+nxsoc=;
        b=eNrAcY9N3sXWg2ly/KKgP4isxLZrtBb4q70sS91Sz/4JW7LDnZkMgAN0RJ4LRobpyD
         oiIBvz0qEShMN2dLgB1F1t+NvfF1W5q4C/tVk4yilAgf7nS0maoTXGkDimbwK++vRuyb
         c8JNpjd5WDnAHUOrPY+AJ7TjAiCW9Oyp6a9V43NTehr4btHcsRhS2m9GRk16UzMtHqWT
         EkfO8TCNKABgEqaE/B2sQJRRhgbbIZP/yrGaMWlLYpdeTt8o94odgECES3cG9uq6vE6a
         C7EHkZH28e89Iq1HdfUtVCOOdmPF8WNaK3yRrzCvIgVWSATIviPhWi1yiTQT9m29kiQD
         qs1w==
X-Gm-Message-State: AOAM530KS5+3AGWoqJ/s7yk09+B1OkEctm/XDdkdChxxwg182nndQfb9
        rD60Pi09/EBGYWR+DGdl/GHbNQ==
X-Google-Smtp-Source: ABdhPJxWGl58swwpDoI1+zivKSJ+lOtRSNZDKQxqvTYLkUgMT2GfURhRhxv+daFc8nXZRRUJZH3pfw==
X-Received: by 2002:a17:90a:bd04:: with SMTP id y4mr7938487pjr.99.1634835962783;
        Thu, 21 Oct 2021 10:06:02 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:503e:d6fd:1031:9e1d])
        by smtp.gmail.com with ESMTPSA id qe17sm7714602pjb.39.2021.10.21.10.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:05:58 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:05:38 -0700
From:   Benson Leung <bleung@google.com>
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Guenter Roeck <groeck@chromium.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Chrome: Drop Enric Balletbo i Serra
Message-ID: <163483586450.864918.7076572503984591478.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="knFqIAD4SNA+zxIj"
Content-Disposition: inline
In-Reply-To: <20211021063210.52503-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--knFqIAD4SNA+zxIj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Oct 2021 08:32:10 +0200, Uwe Kleine-K=F6nig wrote:
> Sending a patch to the chrome people resulted in a message by
> Collabora's mailer daemon:
>=20
> 	550 5.1.1 <enric.balletbo@collabora.com>: Recipient address rejected: Us=
er unknown in local recipient table (in reply to RCPT TO command)
>=20
> So remove Eric from all maintainer entries.

Applied, thanks!

[1/1] MAINTAINERS: Chrome: Drop Enric Balletbo i Serra
      commit: 3119c28634ddc6ee3813778d9d17741baceef19d

Best regards,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--knFqIAD4SNA+zxIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYXGd4gAKCRBzbaomhzOw
woJlAP4wGZ66WvIbIFezMoI/eYRTFVNIn47bcHQrphUoin9OdgD/Ud6edW6vrg9u
U26iiJUf1uwQBXY9uwn5iTiAao7gYA4=
=nTsD
-----END PGP SIGNATURE-----

--knFqIAD4SNA+zxIj--
