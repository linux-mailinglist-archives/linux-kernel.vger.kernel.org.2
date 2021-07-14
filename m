Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2AE3C7C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbhGNDMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 23:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbhGNDMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:12:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C11C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 20:09:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ec55so1095733edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 20:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HHLkfYTeK70IAwoCOTSHW8TwkWo/J6YHybx6B4avFDY=;
        b=wDFyIwwRsp/RsqhgkWsggb4bX/lx206ZEeDdxnt41FEv9kD1U/qh8AU+wiPQK+z2vh
         QkkFBSQFesX0xWIf8hCVMsGrCub1/iQ1l6pVRbqxkiD7mEqnwgcfB7GhMa0BHmJgvn7J
         qvNnuxMBt6RmumTbIOeDIcVC6MTCr9dGFMMESOPcu3jszLjtqjEYei93BooA7vp/Y3vk
         fONu8XPqdTRMhUlu93dvF8HyPx4LzdMA2tOZs4vNwgEikiLBj78BBUxIZhLkvsEW3kcR
         AOooqyx7AXmKukQkkm1eMiXTEOk2UPJ8rAH/NQp+gQXbN8HSL2w0Ep4Fy2iXEnWoo1J8
         kqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HHLkfYTeK70IAwoCOTSHW8TwkWo/J6YHybx6B4avFDY=;
        b=hHrm/VGu1bKwTpB40o1bkyEcg2rNMC+ggiRiWmItO2r4K4ZHgu9XDOagKJSRZb/33m
         z8QxoC/AKCSkrb0+X2mczwQpcvLiuDILh83SY0flFMjEr7/gcEplauwUlsdTblkBN/f4
         oOSYzPrmh5DE5lv+YXeiqkxETBvGQV0La3r7VGj3EZYI1f/uINglR8a9Co/6pEljt8k6
         ieF6+IapefdLbOCsgSDDHiJ50krDhhD4S3LBfBVHnN2TdyuGbl+uxxI0ETwqVKzFEQ2l
         VjWbC5nbO55whwmpKfuzFhpxltPcyn+qfKW9EseuEd5OOH8xaZ+uVjV122jXSfyH10ho
         mRNQ==
X-Gm-Message-State: AOAM530NJFs5zAguTBJZx03V52no7j1Xwro0XrLhQ/CBA09fbJRDbJ6d
        zFtvnG1bBvu+ZeYCJcVIWyJPa1XApUDh/qMbt9tOKg==
X-Google-Smtp-Source: ABdhPJx/rsf5ynCgOi4SXAcIgDGEn5n0NlSpuyJurlRXAuKJKxvreIvsMpUfrShQke11lgYvvwuxoGWHLN9LzlWZS1w=
X-Received: by 2002:a50:fb04:: with SMTP id d4mr10107754edq.143.1626232164352;
 Tue, 13 Jul 2021 20:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <1626230170-13648-1-git-send-email-u0084500@gmail.com>
In-Reply-To: <1626230170-13648-1-git-send-email-u0084500@gmail.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Wed, 14 Jul 2021 11:08:48 +0800
Message-ID: <CAFRkauD4eMQ7ywZ4jdfNzvUuWaPYU6=pAOO2rgzts6dcVsZhOg@mail.gmail.com>
Subject: Re: [PATCH] regulator: rtq6752: Fix the typo for reg define and
 author name
To:     cy_huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cy_huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=8814=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8810:36=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Fix the typo for reg define and author name.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reported-by: Axel Lin <axel.lin@ingics.com>
