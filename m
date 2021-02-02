Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1250730B8CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhBBHj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhBBHjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:39:49 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022DEC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 23:39:09 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id l12so22825397ljc.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 23:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=dTRjQ+0egap3dwc3aRiPsxX6146Q0qttVNyF0R9clM8=;
        b=DBwaRW/4YV/JpI+uFezShRL8g/lqANDb6+P9NRHbHoHRaUG3wn4cuk9eyQx5DVJ7AR
         uwQUTMNjXUoZ2yBRtJJ1Uifft7fENTFHmi0PJ7cJDRNR8qHmOqtpe4Tsaz5npKm6AWn0
         z6kv7pfIszA1GN4HmQOOAZhT7QFnI5YyqjqEZbNAF/E8YD1xSmKQQ8ar0hZSLw5qSGjN
         yDr2rXHxQE5/BCECyYjPAJ1S92+FEkVNsWS1pdW+RJ5v2A3wFnZnqKlZLxxhzLxuAsOR
         e6hBmf4tCCxYxW4WzUI+l9j2qCqPdxac5We0KMsDVqEpcAg0dcBPVGkT2dpLFNewbxG+
         s1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dTRjQ+0egap3dwc3aRiPsxX6146Q0qttVNyF0R9clM8=;
        b=X1LcvxXBtuXFt3AXGnMp/c/hQjxcAUvoQT8X+XgZU3P6QlnnYXU6SZM6C6hPMlBOg0
         j65tGbOd4v//8ehv4eREnQvYUavhG0LsPtWoJgq6csl30bnyViyowIlvnLI6yD/tNQaP
         ezu3A0y3VzkWXWNmIuE71xdpBPMIQ1AdgFeEogWdw5NpA2xlCBdeOGf53DiBb2kiHrwY
         JAPK+k070P2CPyTXCu1gq9qIxhvRPFJrtQtTRIl6nLU3MngU6szElLfNw6s/G8b7hc4y
         dEVL0Gbeiss61TLL+OPq0UUuJGNd/LQ6ZMxaXd66AMwzYCo8TY47cGKSw47tbjG2mqA+
         ZbBw==
X-Gm-Message-State: AOAM533TzKaWUxPUWYTg1hpyw+FnOa565zjAkoBl8Ti9XuguOWPQhDmm
        OAeDd/77+KEpwbPrsUsBaKrWrD52zuLeiw==
X-Google-Smtp-Source: ABdhPJx6XUYrDAsQOipkl+cjdiLSqmswRFTDchcyl9nRLTLIQrXdacXxvfJCo6qQICeVtyxzVpmNjA==
X-Received: by 2002:a2e:8116:: with SMTP id d22mr11959165ljg.48.1612251547073;
        Mon, 01 Feb 2021 23:39:07 -0800 (PST)
Received: from wkz-x280 (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id y15sm1812864ljn.97.2021.02.01.23.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 23:39:06 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     DENG Qingfang <dqfext@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: override existent unicast portvec in port_fdb_add
In-Reply-To: <CALW65jYF5jpm+wQQ9yPZPa_gCSwr4gWiPZ35rBXiACmzCbABLA@mail.gmail.com>
References: <20210130134334.10243-1-dqfext@gmail.com> <20210131003929.2rlr6pv5fu7vfldd@skbuf> <CALW65jYF5jpm+wQQ9yPZPa_gCSwr4gWiPZ35rBXiACmzCbABLA@mail.gmail.com>
Date:   Tue, 02 Feb 2021 08:39:02 +0100
Message-ID: <87a6sm6hrd.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 09:13, DENG Qingfang <dqfext@gmail.com> wrote:
> On Sun, Jan 31, 2021 at 8:39 AM Vladimir Oltean <olteanv@gmail.com> wrote:
>>
>> Tobias has a point in a way too, you should get used to adding the
>> 'master static' flags to your bridge fdb commands, otherwise weird
>> things like this could happen. The faulty code can only be triggered
>> when going through dsa_legacy_fdb_add, but it is still faulty
>> nonetheless.
>
> This bug is exposed when I try your patch series on kernel 5.4
> https://lore.kernel.org/netdev/20210106095136.224739-1-olteanv@gmail.com/
> https://lore.kernel.org/netdev/20210116012515.3152-1-tobias@waldekranz.com/
>
> Without this patch, DSA will add a new port bit to the existing
> portvec when a client moves to the software part of a bridge. When it
> moves away, DSA will clear the port bit but the existing one will
> remain static. This results in connection issues when the client moves
> to a different port of the switch, and the kernel log below.
>
> mv88e6085 f1072004.mdio-mii:00: ATU member violation for
> xx:xx:xx:xx:xx:xx portvec dc00 spid 0

So the bug is really that an automatically learned address is promoted
to a static entry, right?

     br0
   /  |   \
swp0 swp1 eth0

1. A station starts out connected to swp0. An ATU entry is added by the
   switch via normal SA learning.

2. The station moves to eth0.

3. DSA reacts to the event on the foreign interface, reading back the
   entry from (1), adds the CPU port and _crucially_ modifies the state
   from MV88E6XXX_G1_ATU_DATA_STATE_UC_AGE_[1-7] to static.

4. If the station now moves to swp1, you get the ATU violation.

IMO, the condition should be changed to:

    /* User-configured entries take precedence over learned entries. */
    if (is_unicast_ether_addr(addr) &&
        (entry.state >= MV88E6XXX_G1_ATU_DATA_STATE_UC_AGE_1_OLDEST) &&
        (entry.state <= MV88E6XXX_G1_ATU_DATA_STATE_UC_AGE_7_NEWEST))

This should solve the issue discussed here, and it makes sure to keep
the ATU in sync with the FDB config, no matter how crazy the setup is.
