Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF53EAA72
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 20:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhHLSrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 14:47:21 -0400
Received: from ms.lwn.net ([45.79.88.28]:51950 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhHLSrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:47:19 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A85966E2;
        Thu, 12 Aug 2021 18:46:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A85966E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1628794013; bh=AS3ZXY9uEEpmndvTSSwUgG0OFUEKXjMLPrBwasBdFfo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bWRcDmxPO/ffhtEeZBebJoafRfcT0WI/G8Wz8VIBWEGRr25YhzO39SZM1+gDE8tR+
         2/v0rkpmNM3GUgRMTd/YdULUt2ycq+UJSwoEnTPoh4eOQJMeBZqS1cqo148W6Uumgj
         o8QHkfRjH6vSPME+jO4YjdI5DCY+9ls2/ayUMDDOlF4aDj5bQ0tiVAN4JbCHoGWaKx
         OHg3yhGM7sqAoNU9l19oXha33ZvcTf43IKhY+/L/EdmJfJdD3y98+2b+dwECjTih4w
         QdHuEX4SHSggDZwAQ9tK0d9A0LJYtnM3uIvZ+ouB1cb2I5U3CPjo2ntLVoFr8VZXP/
         ACLYerGzAyCow==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res@email.cn>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] docs: zh_TW translation fixes
In-Reply-To: <b19c4d3f-9a36-c217-c4ad-0f818f8e864a@email.cn>
References: <b19c4d3f-9a36-c217-c4ad-0f818f8e864a@email.cn>
Date:   Thu, 12 Aug 2021 12:46:52 -0600
Message-ID: <877dgqzejn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res@email.cn> writes:

> The following changes since commit ff17578e267c74db1619b6643a98e8a83ff6b9=
96:
>
> =C2=A0 docs/zh_TW: add translations for zh_TW/process (2021-07-27 23:08:5=
0 +0800)
>
> are available in the Git repository at:
>
> =C2=A0 https://github.com/srcres258/linux-doc.git doc-zh-tw
>
> for you to fetch changes up to d9b28270985fdc551cf4aaae3d8a5b3e9ae2ee9e:
>
> =C2=A0 docs/zh_TW: add translations for zh_TW/filesystems (2021-08-12 22:=
54:51 +0800)
>
> ----------------------------------------------------------------
> Hu Haowen (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 docs/zh_TW: add translations for zh_TW/arm=
64
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 docs/zh_TW: add translations for zh_TW/cpu=
-freq
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 docs/zh_TW: add translations for zh_TW/fil=
esystems

I'm sorry, but I can't take patches that have never seen the light of
day through pull requests.  Please post them to the lists in the usual
way.

Thanks,

jon
