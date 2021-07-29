Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643C33DB516
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhG3IhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:37:01 -0400
Received: from gw.cahan.az ([195.155.132.117]:52990 "EHLO gw.cahan.az"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhG3IhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:37:00 -0400
X-Greylist: delayed 22958 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jul 2021 04:37:00 EDT
Received: from gw.cahan.az (localhost.localdomain [127.0.0.1])
        by gw.cahan.az (Proxmox) with ESMTP id AAD0120994B;
        Fri, 30 Jul 2021 02:46:10 +0300 (+03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cahan.az; h=cc
        :content-description:content-transfer-encoding:content-type
        :content-type:date:from:from:message-id:mime-version:reply-to
        :reply-to:subject:subject:to:to; s=gw; bh=wQYgaREREFkvRA0lra2m8X
        5P90hB1/2xEWjFDoYX6/U=; b=UYz3aZP3FLR7H887uE6lZldpxkyQPDul176oZX
        8Gtv0i19F3RfWe4fyWneL7ek4JJEYRH91+5G86AW7xt/C4XHNUkCjAaP18PBdEDK
        EHn8YiB5SR5lGSEjvPJs2DK4bh7omaJpaDO6ySomu2bEAZrJBDHZiR2/DjfHIIKy
        QQ71+yqwJnWZBkZp54pKWLANF3Mtt3Q12jTScVULghNFmH1LDRluhEM9NnYO/i4N
        YE9wSh19gdnQCoQy9Lr8YhFN3hO6Bp3T1i96A6xZzAHIYhhS24X5TFgTfGJ8gf3z
        2zqCSrWCiJGGwRLFVmtTlCaZCBeXFXFacpQ2el52zfSXyLaA==
Received: from mail2.cahanholding.com (mail2.cahanholding.com [195.155.132.118])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gw.cahan.az (Proxmox) with ESMTPS id 45F9520A8AA;
        Fri, 30 Jul 2021 02:46:08 +0300 (+03)
Received: from localhost (localhost [127.0.0.1])
        by mail2.cahanholding.com (Postfix) with ESMTP id 78E5D164EC19;
        Fri, 30 Jul 2021 02:46:03 +0300 (+03)
Received: from mail2.cahanholding.com ([127.0.0.1])
        by localhost (mail2.cahanholding.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8htu-E82_sY7; Fri, 30 Jul 2021 02:46:02 +0300 (+03)
Received: from localhost (localhost [127.0.0.1])
        by mail2.cahanholding.com (Postfix) with ESMTP id 3E6D1164EC28;
        Fri, 30 Jul 2021 02:45:59 +0300 (+03)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail2.cahanholding.com 3E6D1164EC28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cahan.az;
        s=selector5; t=1627602359;
        bh=wQYgaREREFkvRA0lra2m8X5P90hB1/2xEWjFDoYX6/U=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=IL7nO1qXvB++cP202xDBOUqFt4s8urlA+hjCIusb7uFxKDwUdRJpiAbqF8XIg2Cmn
         XYy4wBheIYrb/p4Tg9SN1p9uXNDtB+ECLU909TCyhgTr6v7RRM+E+K2ZO4xibsT941
         JwTsED4N2Ivqm9g8twdxbQdMD/J+GLTm2O58UpxObtkRiuC/Xd1TIY3ukPzoRmKZgH
         /4lN94UpxauJmKEUbpWVZpgWIphd9+9igf9gmatJdpCdZVZbG53thSWXdqqI6TpG8/
         aSCTvBPBMcgxD4O/BBWSVeRUP/Txv5AckUyT7rmvUyxTx36AQ8T16fpk+y/XRYKu+f
         Hv5tJzaiafgvw==
X-Virus-Scanned: amavisd-new at mail2.cahanholding.com
Received: from mail2.cahanholding.com ([127.0.0.1])
        by localhost (mail2.cahanholding.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CHRLYMQiNetq; Fri, 30 Jul 2021 02:45:59 +0300 (+03)
Received: from fddfd.2lvrh5gmjoeedgv3k5wncq0iee.bx.internal.cloudapp.net (unknown [40.71.123.82])
        by mail2.cahanholding.com (Postfix) with ESMTPSA id 6EC20164EC0F;
        Fri, 30 Jul 2021 02:45:29 +0300 (+03)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: Business Proposal.
To:     Recipients <quba@cahan.az>
From:   "Kiyoshi Makoto" <quba@cahan.az>
Date:   Thu, 29 Jul 2021 23:45:06 +0000
Reply-To: kiyo.mako9@gmail.com
Message-Id: <20210729234529.6EC20164EC0F@mail2.cahanholding.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day my friend, My name is Kiyoshi Makoto, I have a lucrative business =
proposal for you which I would like to share with you in an email summary.

Although this idea is not new in banking circles, it can change our financi=
al lives forever if we work together. At your request I can send
you this summary Or write to me at: kiyo.mako9@gmail.com

Thank You

