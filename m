Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675EB32B715
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357183AbhCCKs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2361123AbhCBX3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 18:29:25 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D16C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 15:28:44 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l18so3101792pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 15:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ipzKgXeizt6BmN+OGsb44knynSvjjGK3CzazIKs9374=;
        b=zTamd4+L69irImZO916OGGfq4jArrhMgYX9K5mq290L8iRf1StKtUDB5oogfeORVXn
         oagt5Jzb0TMZWqGuvbQV/D49n0X2MRR5ky/bNhywHYq90Sc+A3jjOqWrLtqGXo6fMvZ5
         vXdNmUT94VAOs++442lf7JEI3DBSBnWApiV+icgTgX1+CIES5guufH3ox99CTo9+Q36M
         rMgD7D9hNr20Kc+4JH+0HhZOLsUmiqKZX3TRx9i6rl6poHSQ4hFiW+4sVyhxeGiESEm7
         QQHoqh79usBJFWppqgrXj9wn7aHfSEPF/GE0/ztMAVt4pSb9DE9E8dNTQ7g+mvZxxOXU
         lejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ipzKgXeizt6BmN+OGsb44knynSvjjGK3CzazIKs9374=;
        b=UEn5/zr5GMkn7vwvqQMEWwbf/cpbcZByguYjkP1p6Qn1945oox96OrAcxc4hSxTLoH
         L1sYmUtZFy44dNCzBO3gDkWvnxZbmJ86qfgGUglLIolIOuT4URgOnO7f9cqJHxzU1/Y9
         xZjtOa+6qnJAMh6VdpITFNCnyqspoIZxQoBN9Xx1o/pEkqmCUGSgOS5uBmM2u5krc1x+
         XzHTbfN2PHha2FTxs2xET1C2K+Ov4gY66YtODqURabACvL42ixT/7TySNgFaELreL+oP
         Ne1GjGMWwrds1rYYmvYcxSDttNbLnPy33x0r7qKXFE/RkQAPxAMa8WBPf75yFm2/dkMe
         LFZw==
X-Gm-Message-State: AOAM532S4VUBhQoUBp46KS/2YplCkNpoYlFLA+z3Hp9jyWauOj2Jq529
        +7WfTTm/8LsgMLaPCdmEDZSDMw==
X-Google-Smtp-Source: ABdhPJz4brOTtDCNQIzehAXWj1n5G/JaChhgAM6wmN3cU++9a0+DfYrF5rYFzhrvV3wEj6fdCuVCig==
X-Received: by 2002:a17:90a:ce0c:: with SMTP id f12mr6741028pju.11.1614727724307;
        Tue, 02 Mar 2021 15:28:44 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id j201sm23586612pfd.143.2021.03.02.15.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 15:28:43 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] Revert "arm64: dts: amlogic: add missing ethernet reset
 ID"
In-Reply-To: <20210126080951.2383740-1-narmstrong@baylibre.com>
References: <20210126080951.2383740-1-narmstrong@baylibre.com>
Date:   Tue, 02 Mar 2021 15:28:43 -0800
Message-ID: <7hczwh9luc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Neil Armstrong <narmstrong@baylibre.com> writes:

> It has been reported on IRC and in KernelCI boot tests, this change breaks
> internal PHY support on the Amlogic G12A/SM1 Based boards.
>
> We suspect the added signal to reset more than the Ethernet MAC but also
> the MDIO/(RG)MII mux used to redirect the MAC signals to the internal PHY.
>
> This reverts commit f3362f0c18174a1f334a419ab7d567a36bd1b3f3 while we find
> and acceptable solution to cleanly reset the Ethernet MAC.
>
> Reported-by: Corentin Labbe <clabbe@baylibre.com>
> Acked-by: J=C3=A9r=C3=B4me Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> Hi Kevin,
>
> This has been reported to also break on 5.10, when this lands on 5.11, I'=
ll send another
> patch for 5.10 because meson-axg.dtsi needs a conflict resolution on 5.11.

Looks like this never got submitted to v5.10.  I just discovered it that
v5.10 in SEI610 (internal PHY) is broken.

Could you submit this to v5.10 stable also please?

Thanks,

Kevin





