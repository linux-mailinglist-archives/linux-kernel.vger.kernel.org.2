Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77775425129
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbhJGKhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:37:24 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:40728 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbhJGKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:37:19 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id BF956C28BEC;
        Thu,  7 Oct 2021 12:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1633602921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ZOoCbKAPjDNrQy/OXhFF0+1/alnvKQYS65joiIyPbc=;
        b=FCBYYGdGG51IwgzWKihaUN4G1q0oqR5s5RiwQJjatiNBJ3YkJsQ9UdRP8jtypI6VFuHvrb
        It8f1aLgt8yR6x+vY63Z7GvbaJswxtu57q5JAO+7CvchAn5671PEKu3PGm8FHnrLzaozkX
        WxWMov3djeuai4zWx5iOPbY5qm0OV0E=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: (nct6775) Add additional ASUS motherboards
Date:   Thu, 07 Oct 2021 12:35:19 +0200
Message-ID: <9337468.ToWr0jQUh6@natalenko.name>
In-Reply-To: <20211006222502.645003-2-pauk.denis@gmail.com>
References: <20211006222502.645003-1-pauk.denis@gmail.com> <20211006222502.645003-2-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C4=8Dtvrtek 7. =C5=99=C3=ADjna 2021 0:24:59 CEST Denis Pauk wrote:
> Add support:
> * PRIME B360-PLUS
> * PRIME X570-PRO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX B550-I GAMING
> * ROG STRIX X570-F GAMING
> * ROG STRIX Z390-E GAMING
> * TUF GAMING B550-PRO
> * TUF GAMING Z490-PLUS
> * TUF GAMING Z490-PLUS (WI-FI)
>=20
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Tested-by: matt-testalltheway <sefoci9222@rerunway.com>
> Tested-by: Kamil Dudka <kdudka@redhat.com>
> Tested-by: Robert Swiecki <robert@swiecki.net>
> Tested-by: Kamil Pietrzak <kpietrzak@disroot.org>
> Tested-by: Igor <igor@svelig.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> Changes in v2:
>   - Without changes.
> ---
>  drivers/hwmon/nct6775.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index aa58ead0ad43..8eaf86ea2433 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -4986,20 +4986,29 @@ static int __init nct6775_find(int sioaddr, struct
> nct6775_sio_data *sio_data) static struct platform_device *pdev[2];
>=20
>  static const char * const asus_wmi_boards[] =3D {
> +	"PRIME B360-PLUS",
>  	"PRIME B460-PLUS",
> +	"PRIME X570-PRO",
>  	"ROG CROSSHAIR VIII DARK HERO",
> +	"ROG CROSSHAIR VIII FORMULA",
>  	"ROG CROSSHAIR VIII HERO",
>  	"ROG CROSSHAIR VIII IMPACT",
>  	"ROG STRIX B550-E GAMING",
>  	"ROG STRIX B550-F GAMING",
>  	"ROG STRIX B550-F GAMING (WI-FI)",
> +	"ROG STRIX B550-I GAMING",
> +	"ROG STRIX X570-F GAMING",
> +	"ROG STRIX Z390-E GAMING",
>  	"ROG STRIX Z490-I GAMING",
>  	"TUF GAMING B550M-PLUS",
>  	"TUF GAMING B550M-PLUS (WI-FI)",
>  	"TUF GAMING B550-PLUS",
> +	"TUF GAMING B550-PRO",
>  	"TUF GAMING X570-PLUS",
>  	"TUF GAMING X570-PLUS (WI-FI)",
>  	"TUF GAMING X570-PRO (WI-FI)",
> +	"TUF GAMING Z490-PLUS",
> +	"TUF GAMING Z490-PLUS (WI-FI)",
>  };
>=20
>  static int __init sensors_nct6775_init(void)

Please also add ASUS Pro WS X570-ACE as shown here [1].

Thanks.

[1] https://lore.kernel.org/lkml/20211003133344.9036-2-oleksandr@natalenko.=
name/

=2D-=20
Oleksandr Natalenko (post-factum)


