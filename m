Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66413C8139
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbhGNJSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbhGNJSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:18:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC349C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:15:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso3431363wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QsvEVd+O3AeP9bFc1b9vU3D6n5a6m9JnHWCR1Xra61w=;
        b=PP5L6uhzpzmF1tECCfpvl+VjUbUtmtRh+Zxq/mxc/LmRpck9gMRbRb/nkVxTxoxX51
         wnK6T3iFd06nEgYZ8Njrg6zkdcYAwWcAGnKnSc+PWmiXLKa0j7TNmJBMLMZXOex5BGM0
         g9CRgi3KRbz084F2tFve9aylTYXsFkaqnM42D2M+iBcJ3XuP/E+wNnsEl93fzS9tOE0E
         cNwDqeyvlUPyhUw75Kew62O+jpta2kwZcy+7HK6oUNjCjgIkgnzI8YaVzLesic/7lVdA
         +rR4klVHonFhw1Ghg/AkzQ3P8mOLTqDMbbWaY3krhjRuGoiHGtxnMeNElOxU8/k9Qkzy
         UnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=QsvEVd+O3AeP9bFc1b9vU3D6n5a6m9JnHWCR1Xra61w=;
        b=cuNKm0lI6b1zcinvjkOO+19NMzmivdtjuDgh6WwhOUK4LFBMnNhVoLsRAuK50aGvho
         zdIm7Ryg96Jy1mOgkksi4ZObbpU+SFGX2M8l1X2B1z7qTaMi9TE/fpxogVL+6nGXVQSG
         dHpeDT76RwTnmXjLuIyIY0UC8WNJqo5IUMeRER3FJZ0evKy7qFQjfjYeAfouWA+4+9Oh
         EgIndDqItMebXcLVLjWiKYhfIyDVJHx7cHLSPeX3PACbOZ2PTJVsqmDr8fvc+P+VpBTR
         BXMrBnfeI+p6K4O/0pNq7infz2F5Av5YioWIPLrErB6c+dZjnz57IvVLPyM+PhN1ptXE
         h8wQ==
X-Gm-Message-State: AOAM531FVtsSL19xOlMVHjQLrlbd3WXz2ZLzoitn6nxAqhey4FYBIIa+
        EF8zICZdUfmhmsvr54Yj7+lP67UrPGTAOzrEwnw=
X-Google-Smtp-Source: ABdhPJyjKBl++0RwjmvseJC74RjbaE++ToMFmZ9w1Vh+bsc0dkuI9JtjZAXWGq+WzaCUbzcLn/ZGQkdKC/npdoJAO+U=
X-Received: by 2002:a1c:7715:: with SMTP id t21mr2900369wmi.121.1626254117382;
 Wed, 14 Jul 2021 02:15:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:48cb:0:0:0:0:0 with HTTP; Wed, 14 Jul 2021 02:15:17
 -0700 (PDT)
Reply-To: orlandomoris56@gmail.com
From:   orlando moris <op183945@gmail.com>
Date:   Wed, 14 Jul 2021 09:15:17 +0000
Message-ID: <CAKAyO-Z==qyBedWKgG3iWK1SYmykSDV0nG9Af_XQSmOc-wyUPA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hola, Le informamos que este correo electr=C3=B3nico que lleg=C3=B3 a su bu=
z=C3=B3n
no es un error, sino que fue dirigido espec=C3=ADficamente a usted para su
consideraci=C3=B3n. Tengo una propuesta de ($ 7.500.000.00) que me dej=C3=
=B3 mi
cliente fallecido, el ingeniero Carlos, que lleva el mismo nombre que
usted, que sol=C3=ADa trabajar y viv=C3=ADa aqu=C3=AD en Lom=C3=A9 Togo. Mi=
 cliente
fallecido y mi familia se vieron involucrados en un accidente
automovil=C3=ADstico que les quit=C3=B3 la vida. . Me estoy comunicando con
usted como familiar m=C3=A1s cercano del fallecido para que pueda recibir
los fondos en caso de reclamos. Tras su pronta respuesta, le informare
de los modos de
ejecuci=C3=B3n de este pacto., cont=C3=A1cteme en este correo electr=C3=B3n=
ico
(orlandomoris56@gmail.com)
