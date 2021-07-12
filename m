Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338483C6195
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhGLRNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 13:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhGLRNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 13:13:40 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0FAC0613DD;
        Mon, 12 Jul 2021 10:10:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6AD8D2ED;
        Mon, 12 Jul 2021 17:10:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6AD8D2ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1626109851; bh=FO/9eCNo9bewjjosT7RJ/KMCZhAMv6LghMJPAtQytAg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NKB1/uRbTuYBL3AvfPRwwQLQQdVo6ROQ5kO+IQi2b1eC1qZwhjxR4qf80LX8YwycR
         AlRInA8Zut40kF7vXoR5CRZUEDZ3Fm5mhJ488uYqdJRlgVsxpbntEaERUBaLWemnwY
         atBxaJApLNlqppOd3djUcrr7cG7wI2Jzm6i3XqoXgqvOYc1L6uIsl/8Cm8vOD4sn67
         GnuE+wRHtZABqN3UVUos2D7Ln8KulY5W+e1ec4fI1TfA/WxvbcCeClR+fNwXP1WTai
         Hit2c9ZyDMTiBJ6PK1S44v53+wI2sa/VDY1mTVustLzbgCCgIiZ386BCv5hYEmAuqG
         0wn0O625G+xkA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res@email.cn>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] docs/zh_TW: fix an issue while building
In-Reply-To: <20210703143130.18349-3-src.res@email.cn>
References: <20210703143130.18349-1-src.res@email.cn>
 <20210703143130.18349-3-src.res@email.cn>
Date:   Mon, 12 Jul 2021 11:10:50 -0600
Message-ID: <87r1g3pied.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res@email.cn> writes:

> When building the documentation, the following issue was reported:
>
>     /home/src-resources/Coding/Projects/Other-Projects/Linux/Documentatio=
n/
>     translations/zh_TW/admin-guide/reporting-issues.rst:712: WARNING:
>     duplicate label translations/zh_tw/admin-guide/reporting-issues:
>     =E6=AA=A2=E6=9F=A5=E3=80=8C=E6=B1=99=E6=9F=93=E3=80=8D=E6=A8=99=E8=AA=
=8C, other instance in /home/src-resources/Coding/Projects/
>     Other-Projects/Linux/Documentation/translations/zh_TW/admin-guide/
>     reporting-issues.rst
>
> Consequently, replace "=E6=AA=A2=E6=9F=A5=E3=80=8C=E6=B1=99=E6=9F=93=E3=
=80=8D=E6=A8=99=E8=AA=8C" with "=E6=AA=A2=E6=B8=AC=E3=80=8C=E6=B1=99=E6=9F=
=93=E3=80=8D=E6=A8=99=E8=AA=8C" to
> solve it.
>
> Signed-off-by: Hu Haowen <src.res@email.cn>

Please, just update the original patch to not introduce the error in the
first place.  While you are at it, add the SPDX headers when you first
add the files rather than fixing it up afterward.

This is a vast amount of material that I am absolutely incapable of
making any sort of informed decision on.  Is there any chance that
somebody can review this work?

Thanks,

jon
