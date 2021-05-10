Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E3137990D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 23:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhEJVTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 17:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbhEJVTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 17:19:09 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7817C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 14:18:03 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 69-20020aed304b0000b02901c6d87aed7fso11276359qte.21
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 14:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=fOUt7jyxTxQWRxk0PzBiNaOdQXs8xFEX4FJ9XZ8V9KU=;
        b=KXcO5M1/TzhY6MkN5ziAmFFZjOF3kdv5d97DKFANugusD9l2y6ZCsaCPKqDZXIOD83
         83egjYQreuHUbCv4Co6WM6ymwAeHXslL6jlyThyqPEjVUoPr+Bb2LooXNJo+VyUKaz24
         IC5sWgKgPWBg8PW5IP40onVJmbQbswXSo7+Ni7dvmg66525SvG6gKRQ8VyvrEeBW1HkA
         snhJQKXXBxGTkPSX9x4WmUdklWWiUYNvM3cdeQj/TgbywQ2RFXECJRyTgTzn6NCRkB05
         dJUmLX+Bf5YpXd56o7nCVX/7fw4sVkeA2cwkNs1+AWHG+8cyOKcl4xi4Lw51xYhAKYUf
         yWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=fOUt7jyxTxQWRxk0PzBiNaOdQXs8xFEX4FJ9XZ8V9KU=;
        b=Jc5BHiW4IEBROpy92YBeTq8a+kzVU3aCu/bZVR4venl73fhFwpdPfMSrfkUseOksUV
         ohW+CDsKrbx1RGGwnhjjIs4okvnaNMVxazvqqh4ZneD5OSjZJE4C/MJiiZ2gPg042x26
         wk8rA5aWJTvxpMD2KwR6RCkEcoApCI22CTKXjPKF3orkFG2u5t+bYn8x0FQs041+qF2n
         Negy2l/wdOaXU2ugt/9xqRZvskHEmsqMwrBhBi2DidqiWqwejJMlSR5TixJ8WqMq30AM
         He+GZoz6BIfvu/wGOsaSMIwjROmHHT4LzhJRJbMvs9W2jWWPeXVJ5K/VOSx5Q8FzLePj
         WwWg==
X-Gm-Message-State: AOAM533IJKLvKmcCXD3RTRMTBoJXl/Ihd1soZ9riFOGtQaSe0Xv0wmG/
        3KD5dXWwvztaDs321W51Lx+LwGykeRc=
X-Google-Smtp-Source: ABdhPJznNuZy7AUuSXEZjpFtBSuWKM5IczrU2g8EH4/ODXPTH36XAVX1NVz6KRKdSxiSDSI9hA30iHg08DM=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:9a43:a71b:9ef5:f219])
 (user=badhri job=sendgmr) by 2002:a0c:ef06:: with SMTP id t6mr25422265qvr.17.1620681482498;
 Mon, 10 May 2021 14:18:02 -0700 (PDT)
Date:   Mon, 10 May 2021 14:17:56 -0700
Message-Id: <20210510211756.3346954-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH] usb: typec: tcpm: Fix SINK_DISCOVERY current limit for Rp-default
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a regression introduced by
<1373fefc6243cc96b3565f0ffffadfac4ccfb977>
"Allow slow charging loops to comply to pSnkStby".

When Source advertises Rp-default, tcpm would request 500mA when in
SINK_DISCOVERY, Type-C spec advises the sink to follow BC1.2 current
limits when Rp-default is advertised.
[12750.503381] Requesting mux state 1, usb-role 2, orientation 1
[12750.503837] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
[12751.003891] state change SNK_STARTUP -> SNK_DISCOVERY
[12751.003900] Setting voltage/current limit 5000 mV 500 mA

This patch restores the behavior where the tcpm would request 0mA when
Rp-default is advertised by the source.
[ =C2=A0 73.174252] Requesting mux state 1, usb-role 2, orientation 1
[ =C2=A0 73.174749] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS=
]
[ =C2=A0 73.674800] state change SNK_STARTUP -> SNK_DISCOVERY
[ =C2=A0 73.674808] Setting voltage/current limit 5000 mV 0 mA

During SNK_DISCOVERY, Cap the current limit to PD_P_SNK_STDBY_MW / 5 only
for slow_charger_loop case.

Fixes: 1373fefc6243 ("Allow slow charging loops to comply to pSnkStby")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c4fdc00a3bc8..a73299a08ef7 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4055,7 +4055,7 @@ static void run_state_machine(struct tcpm_port *port)
 		if (port->vbus_present) {
 			u32 current_lim =3D tcpm_get_current_limit(port);
=20
-			if (port->slow_charger_loop || (current_lim > PD_P_SNK_STDBY_MW / 5))
+			if (port->slow_charger_loop && (current_lim > PD_P_SNK_STDBY_MW / 5))
 				current_lim =3D PD_P_SNK_STDBY_MW / 5;
 			tcpm_set_current_limit(port, current_lim, 5000);
 			tcpm_set_charge(port, true);
--=20
2.31.1.607.g51e8a6a459-goog

