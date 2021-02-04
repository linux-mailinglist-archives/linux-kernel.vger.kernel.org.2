Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4E93100AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 00:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhBDX3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 18:29:03 -0500
Received: from ms.lwn.net ([45.79.88.28]:32946 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhBDX26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 18:28:58 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A6C146166;
        Thu,  4 Feb 2021 23:28:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A6C146166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1612481294; bh=DQfQbIVMmZvbCrfAXHodKr+ICylkwNupB+PhosX7jjg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qiJ4hzNexBf3mOowT61yg20xcsa9V0xarP+XA4nvB3xEqQVJqtL2eOypbX+xWlXTr
         W2jXd0BLI3+BFs5H6xU8o8u6zjULpIsfgrYtbPHuMC8vH+kCa0zvQu9X/fhb41bNuG
         og6I97VL/UZXAPiyMRAe17i+7CmNR/ldSgsx7xIRezHrr8IqzexR8T1umuiyfEHvBd
         5WUTr//Ii+qKVmSxRKoatgEOVEOtC9c2OiMaMJs459xX4dRI/xpmpqp2evgKQ8tra+
         JwvVDKqln9pU0WjRHRfEHFzof9l7ckVPwTN0FoV1Ewil+DXIZppf9C8gyXIkhTPItb
         ev/WFVfr3JYig==
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Subject: Re: [PATCH 0/2] docs: Add support for relative paths in automarkup
In-Reply-To: <20210128010028.58541-1-nfraprado@protonmail.com>
References: <20210128010028.58541-1-nfraprado@protonmail.com>
Date:   Thu, 04 Feb 2021 16:28:14 -0700
Message-ID: <87o8gzxvjl.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com> writes:

> As Jon previously noted [1], it would be nice if automarkup supported rel=
ative
> paths as well when cross-referencing to other documents. This adds the su=
pport
> for it, and documents it.
>
> Jon, after applying this, 43bc3ed73639 ("docs: dt: Use full path to enable
> cross-reference") could be reverted without the link stopping to work.
>
> [1] https://lore.kernel.org/linux-doc/20201130142404.6ef6689e@lwn.net/
>
> N=C3=ADcolas F. R. A. Prado (2):
>   docs: Enable usage of relative paths to docs on automarkup
>   docs: Document cross-referencing using relative path
>
>  Documentation/doc-guide/sphinx.rst | 30 ++++++++++++++++++++----------
>  Documentation/sphinx/automarkup.py |  7 +++++--
>  2 files changed, 25 insertions(+), 12 deletions(-)

So I finally got around to playing with this set.  One thing I found is
that some of the references that were being caught before were not
now...  after far too much time, I figured out that the problem was
references to .txt files, of which we have quite a few in the docs.
admin-guide/kernel-parameters.txt in particular is quite popular.
Before this change, those were being turned into xrefs, afterward not.

To address that, I applied this little tweak:

-RE_doc =3D re.compile(r'(\bDocumentation/)?((\.\./)*[\w\-/]+)\.rst')
+RE_doc =3D re.compile(r'(\bDocumentation/)?((\.\./)*[\w\-/]+)\.(rst|txt)')

That seems to make things work properly again.

While tracking this down I put in a print for failing cross references,
and noted that we have quite a few; it's a useful way to see where the
stale references are.  Maybe I'll try to hack together something to make
those stand out so we can fix them.

Thanks,

jon
