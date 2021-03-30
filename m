Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9028B34E2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhC3IRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:17:52 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:34325 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhC3IRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:17:46 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 7C61B167;
        Tue, 30 Mar 2021 01:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617092264;
        bh=VvcznrS1rjWpiKZiP+i/h/lLrJJWsyYrC/wQiX5Rzo4=;
        h=Date:From:To:Cc:Subject:From;
        b=BvQQY0nhA/SRfdxkuOha5Hqtzy/xI4EkYwYD4wGb6h1Mnr36FErF3EKR87j1QcKEE
         OfjIjzj2mchfpXLz3sFDwclz/oC+MrmjuSG2o+lST0qzZNW514NiyHEKO27ZUjDkEP
         KC2XR1G41bxVQLgDZW+0MzAhJN2yShvPd2ig/Re0=
Date:   Tue, 30 Mar 2021 03:17:41 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Enabling pmbus power control
Message-ID: <YGLepYLvtlO6Ikzs@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm working on a board that has a handful of LM25066 PMICs controlling
the power supply to various devices, and I'd like to have both the
existing hwmon sensor functionality as well as userspace power on/off
control, which does not currently seem to be available (other than via
'i2cset -f', which I'd of course prefer to avoid).  I've drafted up a
couple possible versions of this, and was hoping to get some opinions
on the appropriate overall approach.

One option is to add a read-write sysfs attribute to the existing
hwmon directory (current incarnation of the patch:
https://thorn.bewilderbeest.net/~zev/patches/pmbus-statectl.patch).
This bears a vague resemblance to a patch that was rejected a couple
years ago
(https://lore.kernel.org/linux-hwmon/20190417161817.GA13109@roeck-us.net/),
but is different enough that I wonder if it might potentially be
tolerable?  (It exposes significantly less, for one thing.)

The other approach involves layering a regulator device over the pmbus
device as is done in the LTC2978 driver, and then putting a
reg-userspace-consumer on top of that (current patch:
https://thorn.bewilderbeest.net/~zev/patches/pmbus-ureg.patch).  My
first attempt at this ran into problems with all the
reg-userspace-consumer instances getting attached to the first
regulator device, I think due to all of the regulators ending up under
the same name in the global namespace of regulator_map_list.  I worked
around that by adding an ID counter to produce a unique name for each,
though that changes device names in userspace-visible ways that I'm
not sure would be considered OK for backwards compatibility.  (I'm not
familiar enough with the regulator code to know if there's a better
way of fixing that problem.)  The #if-ing to keep it behind a Kconfig
option is also kind of ugly as it stands.

The first version seems simpler to me (and avoids the rather more
cumbersome sysfs paths the second one produces, for what that's
worth).  I think the second is (at least structurally) perhaps more
aligned with what Guenter was saying in the previous discussion linked
above, though.  Does anyone have any advice on the best way to proceed
with this?  If the reg-userspace-consumer approach is the preferred
route, suggestions on a better fix for the name collision problem
would be welcome.


Thanks,
Zev

