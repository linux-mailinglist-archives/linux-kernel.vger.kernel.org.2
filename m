Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7E314139
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhBHVF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhBHTzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:55:14 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41C7C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 11:54:33 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b2so24345891lfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 11:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=B42YBEHueO+TiKJPwlH3QcuzKXrvjRANaoetpGdPu2o=;
        b=TAdJ76BV23ICDbNuOmxCzgIwyG01RVgOooVctuSyzxPve0+yjhxuOHb7SHObee0bA5
         UgSup1pGvAJacNwApQM1iA9f733+NuWGjOQvETscOYP6mermhnZMdrTo2uIYX3Dx8GVH
         Kuag6SYhakFEd6dfW1Pf+0pS7HJIfaMtdXTzaFDtQbxLPqjKOb6JnamkVAUcgQGBYysz
         VyTLJMp+7WR4n753GsVdJLXDb5W7DTFTQUSnJF1goGFgrcUDz00frgna0Q7WuOO0MXEj
         q82NaczB25fvYUu/9YMyVRm5zkKU33+c+fF4cF4s7olAjz6Bu4E45JPY8ci7xmhgVLV/
         VY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=B42YBEHueO+TiKJPwlH3QcuzKXrvjRANaoetpGdPu2o=;
        b=U4c8Okj7FQMI1cRBRh2AMO5f9H52ZD8fucSb0/cEtUycH6eDZShp1CmUHkhuJot3mF
         +O7QkYCQlzUcl0te8QGZ/RfVoOjhI6FzCIiHqiWELaNlHyAoCU2sKgbx629Cyb63h1oo
         izXKpJsncisk0BWID2UP+BI8MFbjzq0exfK1eJtP0BgplNRGAsOXg0STeCXVBPxaZS0N
         EIC56oW+BKdthj9hjGJI/PjPBbDBQnaSlGfSqG3Ft/yGyktfqdH9ff2NPnaYVXRSm/q6
         HxSSqnt0z73A0hc/fpwMQD6l8F63eMUmSOxsZe7+FjKA3ULDlXfy4yO9Cnd3ZKr/Z0l1
         dsbQ==
X-Gm-Message-State: AOAM530rQI4IzmM47WSr21oxQ29IUKiuLdIoLys6Z+XXs9xbBQt9s+tq
        0UbKhHjxzN5nuS7FZGLYR0tb/0gQ6dzSKQ==
X-Google-Smtp-Source: ABdhPJx+spA+B0cAPzXN+ffMBE3Q6KnNRlfmZKbfTCXh5UJdBhIXpbUKgXN75/wvjG8156+ZsEiVhw==
X-Received: by 2002:a05:6512:228b:: with SMTP id f11mr11421158lfu.78.1612814071870;
        Mon, 08 Feb 2021 11:54:31 -0800 (PST)
Received: from wkz-x280 (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id w12sm634913ljo.20.2021.02.08.11.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:54:30 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Mickey Rachamim <mickeyr@marvell.com>,
        linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next 5/7] net: marvell: prestera: add LAG support
In-Reply-To: <20210204211647.7b9a8ebf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210203165458.28717-1-vadym.kochan@plvision.eu> <20210203165458.28717-6-vadym.kochan@plvision.eu> <20210204211647.7b9a8ebf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Date:   Mon, 08 Feb 2021 20:54:29 +0100
Message-ID: <87v9b249oq.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 21:16, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed,  3 Feb 2021 18:54:56 +0200 Vadym Kochan wrote:
>> From: Serhiy Boiko <serhiy.boiko@plvision.eu>
>> 
>> The following features are supported:
>> 
>>     - LAG basic operations
>>         - create/delete LAG
>>         - add/remove a member to LAG
>>         - enable/disable member in LAG
>>     - LAG Bridge support
>>     - LAG VLAN support
>>     - LAG FDB support
>> 
>> Limitations:
>> 
>>     - Only HASH lag tx type is supported
>>     - The Hash parameters are not configurable. They are applied
>>       during the LAG creation stage.
>>     - Enslaving a port to the LAG device that already has an
>>       upper device is not supported.
>
> Tobias, Vladimir, you worked on LAG support recently, would you mind
> taking a look at this one?

Hi Jakub,

I took a quick look at it, and what I found left me very puzzled. I hope
you do not mind me asking a generic question about the policy around
switchdev drivers. If someone published a driver using something similar
to the following configuration flow:

iproute2  daemon(SDK)
   |        ^    |
   :        :    : user/kernel boundary
   v        |    |
netlink     |    |
   |        |    |
   v        |    |
 driver     |    |
   |        |    |
   '--------'    |
                 : kernel/hardware boundary
                 v
                ASIC

My guess is that they would be (rightly IMO) told something along the
lines of "we do not accept drivers that are just shims for proprietary
SDKs".

But it seems like if that same someone has enough area to spare in their
ASIC to embed a CPU, it is perfectly fine to run that same SDK on it,
call it "firmware", and then push a shim driver into the kernel tree.

iproute2
   |
   :               user/kernel boundary
   v
netlink
   |
   v
 driver
   |
   |
   :               kernel/hardware boundary
   '-------------.
                 v
             daemon(SDK)
                 |
                 v
                ASIC

What have we, the community, gained by this? In the old world, the
vendor usually at least had to ship me the SDK in source form. Having
seen the inside of some of those sausage factories, they are not the
kinds of code bases that I want at the bottom of my stack; even less so
in binary form where I am entirely at the vendor's mercy for bugfixes.

We are talking about a pure Ethernet fabric here, so there is no fig
leaf of "regulatory requirements" to hide behind, in contrast to WiFi
for example.

Is it the opinion of the netdev community that it is OK for vendors to
use this model?
