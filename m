Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287794453A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhKDNPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhKDNPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:15:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A01C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 06:13:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v127so4464276wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=wi0ybQ44ot52sKq2jFsx7XZVC4t2Gjor9blRN6dEgFY=;
        b=Hw6HBysJmfDczFQ3QrAOEqao3w2x4wWiHJ5aYAVmjYR9GwSwankBu9AcJtYOoUzMlL
         PHs2Kp/3EIXxYWbCX78x55EOTS38+Dhvpp9tbZq5Lch8/gxHFb2LK5znxHH/nfde5HeP
         CVDPgTeK6MAB4sF7o8ZLjPwE+RyhMK8NwwrcGwupkZe5ud4Cq9uMjIk7bHCtoJv44l30
         FlMBcQhBrUOEevUGzjYXIPiiQUZxiefh7zItZAHHFGobFnJ7dBqJ24jYFUEaox/lVy9O
         XHnMC1nDDVx6It43orSBJp3hfHcpVnhA3roo8Y95CuzEWmJgRjnBWkJ83O+2f7VM7s9h
         SBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wi0ybQ44ot52sKq2jFsx7XZVC4t2Gjor9blRN6dEgFY=;
        b=Yko3sh8OVBzBbNjUI2it+wPWZF0YN5cTDHCXI0ve6l+7J9s2M0rhyo/frZjcQHkUcF
         9fU2ilJL7zADIXa6B5WNVBxFF41ilWmKry2xC4j5AAKpmvbyO4MLWaLy3xGIiMJFJv78
         GaSA3wZXrRNSinZQnYgy6OfjPbqFi9kfhHkim5O8OgHlXdiusKhIvvT7DM7h5/ZgIrAP
         M0w2jHtEWzkODmpelsQFzQu4gARjKpHHMYSz1SCmFFjk9pG/Pzcdu7NnT+K1dyoQym3h
         p6UCmSeYFXM9bM/Ljq9JHgEKLdxWNvWUwnckTJrjsNIvI1Za+NvxsgDBLzO0NfuLRw+i
         KoFA==
X-Gm-Message-State: AOAM530zeE8KCD1NeZ4dtZtyuRkEboSkXLV2JS66nR6UTqCtyTNCM7a7
        cC/8jXT9x5sDiY0or+RNW1fGjA==
X-Google-Smtp-Source: ABdhPJyMOXwDrTl/v76ZjZi0iLmPaHAjdbaWPf6DrKm+32Css04z0z6knM43Wcq7WW50xKD+HmsyLA==
X-Received: by 2002:a05:600c:4fc3:: with SMTP id o3mr19395874wmq.74.1636031591668;
        Thu, 04 Nov 2021 06:13:11 -0700 (PDT)
Received: from wkz-x280 (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id m21sm4920902wrb.2.2021.11.04.06.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 06:13:11 -0700 (PDT)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: Re: [RFC PATCH] net: phy/mdio: enable mmd indirect access through
 phy_mii_ioctl()
In-Reply-To: <YYPU1gOvUPa00JWg@shell.armlinux.org.uk>
References: <YYF4ZQHqc1jJsE/+@shell.armlinux.org.uk>
 <e18f17bd-9e77-d3ef-cc1e-30adccb7cdd5@ti.com>
 <828e2d69-be15-fe69-48d8-9cfc29c4e76e@ti.com> <YYGxvomL/0tiPzvV@lunn.ch>
 <8d24c421-064c-9fee-577a-cbbf089cdf33@ti.com> <YYHXcyCOPiUkk8Tz@lunn.ch>
 <01a0ebf9-5d3f-e886-4072-acb9bf418b12@ti.com> <YYLk0dEKX2Jlq0Se@lunn.ch>
 <87pmrgjhk4.fsf@waldekranz.com> <YYPThd7aX+TBWslz@shell.armlinux.org.uk>
 <YYPU1gOvUPa00JWg@shell.armlinux.org.uk>
Date:   Thu, 04 Nov 2021 14:13:08 +0100
Message-ID: <87h7csjc7v.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 12:40, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> On Thu, Nov 04, 2021 at 12:35:17PM +0000, Russell King (Oracle) wrote:
>> On Thu, Nov 04, 2021 at 12:17:47PM +0100, Tobias Waldekranz wrote:
>> > Except that there is a way: https://github.com/wkz/mdio-tools
>> 
>> I'm guessing that this hasn't had much in the way of review, as it has
>> a nice exploitable bug - you really want "pc" to be unsigned in
>> mdio_nl_eval(), otherwise one can write a branch instruction that makes
>> "pc" negative.
>> 
>> Also it looks like one can easily exploit this to trigger any of your
>> BUG_ON()/BUG() statements, thereby crashing while holding the MDIO bus
>> lock causing a denial of service attack.
>> 
>> I also see nothing that protects against any user on a system being
>> able to use this interface, so the exploits above can be triggered by
>> any user. Moreover, this lack of protection means any user on the
>> system can use this interface to write to a PHY.
>> 
>> Given that some PHYs today contain firmware, this gives anyone access
>> to reprogram the PHY firmware, possibly introducing malicious firmware.
>> 
>> I hope no one is using this module in a production environment.
>
> It also leaks the reference count on the MDIO bus class device.
> mdio_find_bus(), rather class_find_device_by_name() takes a reference
> on the struct device that you never drop. See the documentation for
> class_find_device() for the statement about this:
>
>  * Note, you will need to drop the reference with put_device() after use.

Ahh interesting. Thanks!

> Of course, mdio_find_bus() documentation should _really_ have mentioned
> this fact too.

Yeah, that would have been helpful.
