Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33758420163
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 13:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhJCLwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 07:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhJCLwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 07:52:07 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9193CC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 04:50:19 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id B6F18C1CF19;
        Sun,  3 Oct 2021 13:50:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1633261813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53ZERQv7zMU+x8S9Zu7/z/fDX7OMssKxmy5sBN16hRY=;
        b=ruX1rti+FtFS0w4WCjpEZ04u6WM3hVkgoASvqZAJNJov/PL/MZ3MMZ0lAknc+M9G6tzEr/
        wrKHw2IbxhX4Cj4Ve5jhseS6JiUdVmBom0Bs4OAJH5w96M5gzIlTeWmGQ3lDEfcbNmWQup
        IEDcbuRCq5YMLi/5NtIzHHM6dsWwwFk=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, Eugene Shalygin <eugene.shalygin@gmail.com>,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 0/3] Update ASUS WMI supported boards.
Date:   Sun, 03 Oct 2021 13:50:12 +0200
Message-ID: <6096864.rdmfHhMOLH@natalenko.name>
In-Reply-To: <20211002210857.709956-1-pauk.denis@gmail.com>
References: <20211002210857.709956-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On sobota 2. =C5=99=C3=ADjna 2021 23:08:53 CEST Denis Pauk wrote:
> Add support to nct6775:
> * PRIME B360-PLUS
> * PRIME X570-PRO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX B550-I GAMING
> * ROG STRIX X570-F GAMING
> * ROG STRIX Z390-E GAMING
> * TUF GAMING B550-PRO
> * TUF GAMING Z490-PLUS
> * TUF GAMING Z490-PLUS (WI-FI)

Thank you for this submission.

Do you happen to know whether it can be extended with another ASUS board wh=
ich=20
is:

```
Manufacturer: ASUSTeK COMPUTER INC.
Product Name: Pro WS X570-ACE
```

?

I've got one, and in case any info or testing is needed, I'd be happy to=20
contribute.

Currently, this board is kinda working after adding=20
`acpi_enforce_resources=3Dlax`, but I assume a proper support is needed ins=
tead.

Thanks.

> Add sensors driver for ASUS motherboards to read sensors from the embedded
> controller. Based on https://github.com/zeule/asus-wmi-ec-sensors.
>=20
> Could you please review?
>=20
> @Andy Shevchenko, @Guenter Roeck should I split last patch in some way?
> Should I add to MAINTAINERS:
> --
> ASUS WMI HARDWARE MONITOR DRIVER
> M:     Eugene Shalygin <eugene.shalygin@gmail.com>
> M:     Denis Pauk <pauk.denis@gmail.com>
> L:     linux-hwmon@vger.kernel.org
> S:     Maintained
> F:     drivers/hwmon/asus_wmi_sensors.c
> --
>=20
>=20
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Co-developed-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Tested-by: matt-testalltheway <sefoci9222@rerunway.com>
> Tested-by: Kamil Dudka <kdudka@redhat.com>
> Tested-by: Robert Swiecki <robert@swiecki.net>
> Tested-by: Kamil Pietrzak <kpietrzak@disroot.org>
> Tested-by: Igor <igor@svelig.com>
> Tested-by: Tor Vic <torvic9@mailbox.org>
> Tested-by: Poezevara <nephartyz@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
>=20
> ---
> Denis Pauk (3):
>   hwmon: (nct6775) Add additional ASUS motherboards.
>   hwmon: (nct6775) Use custom scale for ASUS motherboards.
>   hwmon: (asus_wmi_sensors) Support access via Asus WMI.
>=20
>  drivers/hwmon/Kconfig            |  12 +
>  drivers/hwmon/Makefile           |   1 +
>  drivers/hwmon/asus_wmi_sensors.c | 595 +++++++++++++++++++++++++++++++
>  drivers/hwmon/nct6775.c          |  41 ++-
>  4 files changed, 643 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/hwmon/asus_wmi_sensors.c


=2D-=20
Oleksandr Natalenko (post-factum)


