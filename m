Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE33954A1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 06:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhEaEb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 00:31:59 -0400
Received: from ni.piap.pl ([195.187.100.5]:37872 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhEaEby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 00:31:54 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id 67CBC4441AA;
        Mon, 31 May 2021 06:30:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 67CBC4441AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1622435411; bh=l4NPvVhYwcCMSvsz+fATcKqeBrkYke26i4Qu64Bnbw8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ck8rmuk1u2sqYDwFInX8OlXhOPW+/tfZY0HhLdclfnCwdpYo+3B4J/eGu3kfBKruT
         36bLdfAE5uWq3BpJs7JnTtXMqoCfw00tklJC6ARLEoRAIZn+safgRUNa09+nOfjDG5
         uY9PTFbKSQvxXsWi9FKKZmXqZhuRZKu0sygnXm+E=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Data corruption on i.MX6 IPU in arm_copy_from_user()
References: <m3y2c1uchh.fsf@t19.piap.pl>
        <20210526100843.GD30436@shell.armlinux.org.uk>
        <m3r1htu19o.fsf@t19.piap.pl>
        <20210526131853.GE30436@shell.armlinux.org.uk>
        <m3h7intbub.fsf@t19.piap.pl>
        <20210528143544.GQ30436@shell.armlinux.org.uk>
Sender: khalasa@piap.pl
Date:   Mon, 31 May 2021 06:30:10 +0200
In-Reply-To: <20210528143544.GQ30436@shell.armlinux.org.uk> (Russell King's
        message of "Fri, 28 May 2021 15:35:44 +0100")
Message-ID: <m35yyzttil.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 4
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:

>> LDM12: 1 3 4 5 6 7 8 9 A B C D
>
> That's rather sad, and does look very much like a hardware bug.
>
> The question is what to do about it... there's Linus' "do not break
> userspace" edict and that's exactly what this change has done. So I
> suppose we're going to have to revert the change and put up with
> everything being slightly slower on arm32 than it otherwise would
> have been. That probably means we'll end up with almost every kernel
> tree out there carrying a revert of the revert to work around the
> fact that seemingly NXP broke their hardware - which itself is not
> a good idea. I guess we're just going to have to put up with that.

For userspace, it's quite a corner case, basically development-only -
and I guess there are very few people who will do things like this.

The same problem can manifest itself without any kernel involvement -
it's enough to mmap /dev/mem and use LDM on in completely in userspace.
This can't be fixed - unless we disallow IPU mmap.

Perhaps making sure the bug is clearly documented is better than doing
a partial fix. Ideally NXP should document it in their papers, and we
should add notes to IPU driver code.

The last one - I guess I can do.
--=20
Krzysztof Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
