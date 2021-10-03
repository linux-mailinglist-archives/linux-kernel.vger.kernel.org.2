Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145A142019E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 15:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJCNCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 09:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhJCNCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 09:02:12 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4DAC0613EC;
        Sun,  3 Oct 2021 06:00:24 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id B6E79C1D24F;
        Sun,  3 Oct 2021 15:00:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1633266021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPzTwYopujT2A6hAl1cPoW+QpRztZyD+2JLQrYGXGuw=;
        b=u9b7DB9R73GlEpSY7OZpeaGIK8hxU/5cpSxB8gBiwCXpmFEbUy/8Y+EOX9f0ADWj62o7Ah
        AZzrkNxB9+ILz/MDDjoWtT5VfNFVHJC7tmVAquEpQQW8aBCEuRGlIxVwseS/PHP3fE/lB/
        lFwWb0ltl1BC8mMxkU9uA4XglPPcSxU=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
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
Date:   Sun, 03 Oct 2021 15:00:20 +0200
Message-ID: <12566205.cCQ2bOJNpD@natalenko.name>
In-Reply-To: <CAB95QAThT-LgWJg7s9=7i2X=jqXq2jbQ0j=XASPZxwo0pqrVGQ@mail.gmail.com>
References: <20211002210857.709956-1-pauk.denis@gmail.com> <3507481.XNmkIPAYGC@natalenko.name> <CAB95QAThT-LgWJg7s9=7i2X=jqXq2jbQ0j=XASPZxwo0pqrVGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On ned=C4=9Ble 3. =C5=99=C3=ADjna 2021 14:53:32 CEST Eugene Shalygin wrote:
> 216 =E2=81=B0C is a blank value. According to
> https://www.asus.com/Motherboards-Components/Motherboards/Workstation/Pro=
=2DWS
> -X570-ACE/techspec/ there is no T_Sensor header on this board.

Yup, I've just realized it's a separate header with a separate probe for it=
=2E=20
Thanks for confirming this!

I'll move `T_Sensor` into a separate `case` then.

=2D-=20
Oleksandr Natalenko (post-factum)


