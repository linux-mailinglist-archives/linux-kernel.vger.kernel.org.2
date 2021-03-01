Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E27329FC1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574506AbhCBDrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243413AbhCAVRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:17:17 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DC2C061756;
        Mon,  1 Mar 2021 13:16:37 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0FF272BA;
        Mon,  1 Mar 2021 21:16:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0FF272BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614633397; bh=BOWU4MDyFiQdWXRrrAYTjnx7MFERL9dM25+L03zaDSs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=G9TjIVOv72Tjp95UywWF5oB5lRoL8UHnQo73OhMdPx8WBlss0uCCU6OU2ZQkByZ08
         Sy/BqyVSeGYFnXMSy13M1cI5+WmmIU4AorsePF99JGl9i7HfXSLe7FVSoLLZg+neBU
         2lbL65P+aWC8KBz6qJBglL6XfzTxyAI930oXQEiUQFFLC219nmgLFVwvQOGP828gul
         o9jISFsa/s98nm1aT3z+qZiobga/wUzhVKtqpEpxfoTPYzpvpFMFsXi4iHQMX6ijcF
         Q9QChpB0FX+TwynXD+mQF7v4knQpWAP38Y/uREOiv3wIKo7zpmrXKwULUHZEzVBfYG
         DiwUK78oEEAUg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     hjh <huangjianghui@uniontech.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PATCH Documentation translations:translate
 sound/hd-audio/controls to chinese
In-Reply-To: <20210301122019.80234-1-huangjianghui@uniontech.com>
References: <20210301122019.80234-1-huangjianghui@uniontech.com>
Date:   Mon, 01 Mar 2021 14:16:36 -0700
Message-ID: <8735xe4lsb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hjh <huangjianghui@uniontech.com> writes:

> Signed-off-by: hjh <huangjianghui@uniontech.com>
> ---
>  Documentation/translations/zh_CN/index.rst    |   1 +
>  .../zh_CN/sound/hd-audio/controls.rst         | 102 ++++++++++++++++++
>  .../zh_CN/sound/hd-audio/index.rst            |  17 +++
>  .../translations/zh_CN/sound/index.rst        |  26 +++++
>  4 files changed, 146 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/sound/hd-audio/contr=
ols.rst
>  create mode 100644 Documentation/translations/zh_CN/sound/hd-audio/index=
.rst
>  create mode 100644 Documentation/translations/zh_CN/sound/index.rst

So you have sent me two versions of this in the last 24 hours with no
indication of what has changed or why I should prefer one over the
other.  Always include that information (under the "---" line) when you
send updated versions.

It looks like you got a Reviewed-by tag from Alex on the other version,
but that doesn't appear here; why?

[...]

> diff --git a/Documentation/translations/zh_CN/sound/hd-audio/index.rst b/=
Documentation/translations/zh_CN/sound/hd-audio/index.rst
> new file mode 100644
> index 000000000000..c287aad51066
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/sound/hd-audio/index.rst
> @@ -0,0 +1,17 @@
> +.. include:: ../../disclaimer-zh_CN.rst
> +
> +:Original: :doc:`../../../../sound/hd-audio/index`
> +:Translator: Huang Jianghui <huangjianghui@uniontech.com>
> +
> +
> +=E9=AB=98=E6=B8=85=E9=9F=B3=E9=A2=91
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   notes
> +   models
> +   controls
> +   dp-mst
> +   realtek-pc-beep

So you list a bunch of files here, but most of them are not added in
your patch.  That will, of course, break the docs build.

> diff --git a/Documentation/translations/zh_CN/sound/index.rst b/Documenta=
tion/translations/zh_CN/sound/index.rst
> new file mode 100644
> index 000000000000..42d86b361e42
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/sound/index.rst
> @@ -0,0 +1,26 @@

Similarly, including the index.rst file at this level is good, but...

> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :doc:`../../../sound/index`
> +:Translator: Huang Jianghui <huangjianghui@uniontech.com>
> +
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Linux =E5=A3=B0=E9=9F=B3=E5=AD=90=E7=B3=BB=E7=BB=9F=E6=96=87=E6=A1=A3
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   kernel-api/index
> +   designs/index
> +   soc/index
> +   alsa-configuration
> +   hd-audio/index
> +   cards/index

What are all of these files?

Please fix these issues and make sure that the docs build runs correctly
before resubmitting.

Thanks,

jon
