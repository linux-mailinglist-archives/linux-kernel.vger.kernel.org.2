Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38F331729C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhBJVpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhBJVpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:45:41 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E90C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:45:01 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a22so4847721ljp.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=z5+mLr09/ZcQ2ixDK2/FUPzqKUSruq8IBNnw73cTyjo=;
        b=K9OOPNmLrBjwfDgzAVd8pxC2qIu5I5fB6zhDxlUkgCpdN/mTN3fHikMx9whkuHsc01
         /mQlE0gRlaqDd33dewHIVddxh42N+MTpeQaYBStfy8iB0xoMJP7HTN/ahQmsf2Lrd58w
         SqqitPaZgB/oUNSMp7izaS7cqLPJAsOCOscgz/74QpGJS+K8G4VWlSKM+puKbj37eZZ4
         /S/fyyKTQ8FSy7zmGfdvDpoZUuxVlmIXBh4IpZ8ofgffRCYpTMPcqYH1LUWplfl21oAr
         6E6dv4CYmShx+B2JU1xfkx2DD9AXeBHVHoYhrr1K0nxu9YZknu4BiRELDY5RRTfRiviI
         1ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=z5+mLr09/ZcQ2ixDK2/FUPzqKUSruq8IBNnw73cTyjo=;
        b=ueHVgfFvqcWRsXwtMF7Bx0VecBgC8G0zJ8Bq5AE6veAujfI7EVhptUNxaqUCUokIj3
         tUJsZVJNx17Rfks8ObnoPbam3+5FceNCquQ+sKURrVxiVwzDqqIo03NNajhRr8W9/9Y8
         tpm+YEMlRRrkMHRPhCgOTszl5qz5ZeediirQFUxDo0nz2s9qBH4jSm7HApHl7EkPxFX5
         tMGSf471KXIac2F7lvMOvvdyq7ow6lZqtnIUe+Bh4n7P0q7aFU8QiXx9pq0ujYFM9VHJ
         ej7FaotwCl8VtDcQCB7ZVpZAEpMXkcALiJvdS9HFKgjlJOxeHQt6GoFGkCoRhPj4CyeB
         gDdg==
X-Gm-Message-State: AOAM531uH1kE88oMsHHj8FMxtoWCf4dwBgNj8LdTI3/ziEZFerI/mpKO
        d4WZJcHeYme7QRztn+wPV9vsUw==
X-Google-Smtp-Source: ABdhPJzofo44pV49Ak6w9CB7GU0DXDFWz03+jTOwR86jxmh8IUYSJEMA0Bm/wjCJRyypMJIwz95gKA==
X-Received: by 2002:a2e:834e:: with SMTP id l14mr3220913ljh.394.1612993499836;
        Wed, 10 Feb 2021 13:44:59 -0800 (PST)
Received: from wkz-x280 (h-236-82.A259.priv.bahnhof.se. [98.128.236.82])
        by smtp.gmail.com with ESMTPSA id b7sm671300ljk.52.2021.02.10.13.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 13:44:59 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Mickey Rachamim <mickeyr@marvell.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: RE: [EXT] Re: [PATCH net-next 5/7] net: marvell: prestera: add LAG support
In-Reply-To: <BN6PR18MB15879B93E3B3BC4F1E92103BBA8D9@BN6PR18MB1587.namprd18.prod.outlook.com>
References: <20210203165458.28717-1-vadym.kochan@plvision.eu> <20210203165458.28717-6-vadym.kochan@plvision.eu> <20210204211647.7b9a8ebf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <87v9b249oq.fsf@waldekranz.com> <20210208130557.56b14429@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <YCKVAtu2Y8DAInI+@lunn.ch> <20210209093500.53b55ca8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <BN6PR18MB158781B17E633670912AEED6BA8E9@BN6PR18MB1587.namprd18.prod.outlook.com> <87h7ml3oz4.fsf@waldekranz.com> <BN6PR18MB15879B93E3B3BC4F1E92103BBA8D9@BN6PR18MB1587.namprd18.prod.outlook.com>
Date:   Wed, 10 Feb 2021 22:44:58 +0100
Message-ID: <87blcr4mxx.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 10:41, Mickey Rachamim <mickeyr@marvell.com> wrote:
>> Until that day arrives, are there any chances of Marvell opening up CPSS in the same way DSDT was re-licensed some years back?
> The CPSS code is available to everyone on Marvell Extranet (Requires simple registration process)

Right, but "available" is not the same as "open" unfortunately. Being
able to study the source is better than nothing, but it is a far cry
from having the ability to modify it and, most importantly, publish
those changes.

So, to restate my question more precisely: Can we expect that Marvell
will provide CPSS under a license that is compatible with the Linux
kernel?

If that is not possible, will Marvell at least commit to allow the
publishing of drivers developed from functional specifications and other
chip documentation?

> Anyway, as the transition process will progress - it will be less required.

Yes, but it makes it hard for smaller players to get on the ride early.

>> Being able to clone github.com/Marvell-switching/prestera-firmware (or
>> whatever) and build the firmware from source would go a long way to alleviate my fears at least.
> I understand your concerns but at this stage - we also concerned about others that might build not reliable FW images.

Totally fair. That problem should be solvable by some kind of taint
concept though. Presumably you have this problem already with the
existing SDK model? Customers can build things on top of CPSS that are
broken in a million ways.

> I also agree that at some point we should ensure most of the concerns are being addressed.
>
> Mickey.
