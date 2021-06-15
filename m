Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFD83A7429
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhFOCnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:43:31 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]:41820 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhFOCna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:43:30 -0400
Received: by mail-qv1-f54.google.com with SMTP id x2so20929783qvo.8;
        Mon, 14 Jun 2021 19:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hexPzKtUxoh96PWLYtGbhlTwpBpa0J1Kib8NXDcM0EU=;
        b=d+pAktYitRBUMwowZysyTJXcRzYWc8lkMv9tYEInmB0Am3gH0i6iFcqFdBsu7ZqYL9
         ulRZDBDZI7DE3JlX1+eXRBfuORRXKR8+U+xQpjFs0HqMjBkQAbuusHf0N1e9HIG7vE61
         j/+WNIRJkIioFaCqkdTt7Y3iP9m7ptT7BVCeOnAxjHAPwDsRSKeSots/T5XpRyeUm5I5
         yw/goFk3nV8hY1umh1MkEFOkjV28HU+y8UD3f1Ef3A+Z7oYGtEHIkmbBLss7h7LT4hc2
         ajoSnWRryM14uNsI+zZBYRHSmZM9Go7MZEe1B4qgKjyNt47d82Yh44pTzK+T3CMX7nKh
         7zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hexPzKtUxoh96PWLYtGbhlTwpBpa0J1Kib8NXDcM0EU=;
        b=Xk3T2mUCfot0zP3CyUQ9sCN+vS+/xJ1J0rN2sNvbiNdOLMoIV7PClt89GfdtqdCeK1
         T3C1TzaJWToL9qCt1neuWb7Q5e7w9jXN5FGnZftmur2isyRkbkgEQMq385RoS76I0Qa2
         FMazsyIK+g4GXAP4iMrepIM4amhlJdYI8VQMCmQydBekOTIN/gvfKTOd+xjX1U2X+DPW
         P4fy93lR2gXTYN8OpNY/PGKkp7N0qANwIuVeChpY6ESg1tQTq6wwRCR4Mbxw0Ub0ICyd
         ZbHQA0CB2ye65rgspRH8rjzEFS63KEEZE+ST70XIdgIT/PypHDSTc5pdrtcOGflG9uK9
         jvqg==
X-Gm-Message-State: AOAM530ueeJY08GnwHoDoy8UvZG8Q4ocOPFCKf7zmTvzB3AOlhQ4cFN1
        3XwzprAAtko0PjFsJrQ3obEHL8gDKyzF4qy2jtdCekYKlZrTInVG4Lo=
X-Google-Smtp-Source: ABdhPJwrpTwhqb1XHC2i0AgwMGf78XTJa7Oor8gMCZvSE7PQTzP/Y8QNP0xVP3Y9kw84FaUSauWH6Xsg9InreAcXe+s=
X-Received: by 2002:a17:902:b193:b029:11a:a179:453a with SMTP id
 s19-20020a170902b193b029011aa179453amr1507136plr.69.1623721015916; Mon, 14
 Jun 2021 18:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210522025545.57275-1-src.res@email.cn> <87im2g1589.fsf@meer.lwn.net>
In-Reply-To: <87im2g1589.fsf@meer.lwn.net>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Tue, 15 Jun 2021 09:36:47 +0800
Message-ID: <CAMU9jJpYU3j=52CPwOH9WMAJw7KEf0HoAQkKGnwD3QNYPEhjQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs/zh_CN: update a translation in zh_CN/dev-tools/gcov
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Hu Haowen <src.res@email.cn>, Alex Shi <alexs@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, Fangrui Song <maskray@google.com>,
        Bernard Zhao <bernard@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=885:56=E5=86=99=E9=81=93=EF=BC=9A

>
> Hu Haowen <src.res@email.cn> writes:
>
> > The original file has added some words in commit c797997a244cd2c58908
> > ("Documentation: dev-tools: Add Testing Overview"), hence update the
> > Chinese translation of them.
> >
> > Signed-off-by: Hu Haowen <src.res@email.cn>
> > ---
> >  Documentation/translations/zh_CN/dev-tools/index.rst | 3 +++
> >  1 file changed, 3 insertions(+)
>
> I have been holding onto this series in the hope that somebody would
> review it ... any takers?

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

Hao wen, next patch version, pick Xiangcheng's Acked-by tag and my
Reviewed-by tag, just like:

......
Signed-off-by: Hu Haowen <src.res@email.cn>
Acked-by: Wu XiangCheng <bobwxc@email.cn>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
---

Thanks,

Yanteng
