Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6070319415
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhBKUOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhBKUOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:14:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1FE660231;
        Thu, 11 Feb 2021 20:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613074435;
        bh=ah3lCdwhw8KxMw2ZhgC37K5ooXbW8dUcQBF/IpwrnGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nEwirJqz/3s3qu68Ox1S/Twd0fTiwkrlyifKfR7peoaSYNccRdCP6uEUokrkaIMJ8
         8aQHzC8DpalZ1GGYH9D1lXRa2+mCCZINSK6SmP896s3ionKcYlrN89Qr15vnAAyyRb
         GbO7un6zf7CCw6G3JeQ7RaPOoZNfoljFvODVIvzbaw/BGxNGQNBbV2k8h4tauOvjsN
         wUT37Qt9Jxmwl18+BfAeKssbQY9rSRKc8TtS4x9mXxKqLk5Rew/1RqLkO/+WUROdPv
         okFyZ2i/3ibls9+mOdy4PouTIOJ4qhCXQY11lALnhcKn0soRmovu/oCpPBp0tOdWmK
         OgDwzK1D3XM9w==
Received: by mail-qt1-f175.google.com with SMTP id v3so5132527qtw.4;
        Thu, 11 Feb 2021 12:13:54 -0800 (PST)
X-Gm-Message-State: AOAM533g7gH5upWfWqm9PqYhSJLNiIPNZTi9SH2/UWhOv//pltFr4DUh
        LSK7zZXnztzlv/ad0yFcL/GgI4Rx7q/judOKEA==
X-Google-Smtp-Source: ABdhPJxPgHgoU2Yw0pheJzl2WIBriV1+z+4Au1lE1OSKXlJbyLgymw9x0x5JLnLa8i7DuHs2sO+AS/qjRCL2rdO2xx0=
X-Received: by 2002:ac8:7cb8:: with SMTP id z24mr2791819qtv.31.1613074433957;
 Thu, 11 Feb 2021 12:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20210208165806.25466-1-info@metux.net>
In-Reply-To: <20210208165806.25466-1-info@metux.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 11 Feb 2021 14:13:42 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+aWxmA_tXnhi5PfMieZ0KyKj45kr=OUa8h4mEmn7yLTA@mail.gmail.com>
Message-ID: <CAL_Jsq+aWxmA_tXnhi5PfMieZ0KyKj45kr=OUa8h4mEmn7yLTA@mail.gmail.com>
Subject: Re: [PATCH] of: base: improve error message in of_phandle_iterator_next()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 10:58 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Also print out the phandle ID on error message, as a debug aid.

I already have this patch applied in my tree. Why do you keep sending it?

Rob
