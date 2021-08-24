Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2167D3F6A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 22:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhHXUS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 16:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHXUS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 16:18:26 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B79C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 13:17:42 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso28459375otv.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cTrpKt7ssoq5MU1N/SFjHGYYyQ2cJrI5wLd1aEf1FI4=;
        b=VVIHkuhZsoAL/OufQvFMKeLxIVUi7m7FcRBWD2fAJU/wpCiRJcdqH36XymLXT77auh
         mqhGuJFrj88MSPb+Y3C/ztxaWgcOTLq4SnQpCNbxlJ/25/4o3qXRxOTAZLiWAn+ghxP3
         OdoXK55NqSovj+FRJ8ug8jI36TiWMml8qDwZa10t8CIPWFXrko3UUj39HOe2FIcsq9Kc
         JSGCCwnPLK4jwW1hQq7Cvo5frRTRHwUHkVAAwtI2TiIW70iYSqeiukEsF3sTOpc0hfXF
         R47CGGOGsHXEMJoW7sf+ox/5Ec/mU6ScXt6oInbLuLMeoGixpntT96BOhFuReRYWiKsr
         6Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=cTrpKt7ssoq5MU1N/SFjHGYYyQ2cJrI5wLd1aEf1FI4=;
        b=L3yk8+6KJz+RHGAz/yLdjHl0LU3Bj5g67HIdV1sISKWwkosbPdfYtzFEuxG8SkA/Ou
         ke/9v1Dqvkgvtcrcp+Itjl6OmwIw+APuhSP0FxYH2j0fs8xG/AruH5vX6ykps4GJkcl7
         lAg1Qd9C27Ju2LK3mvHwSeqAUkUmWDtQ1yDv52zxDirIh60p15SaMqJZwYmifFHAWW+G
         NXTqGbCaYkYCcRtTO2r9/uG0WAjNFfgDpl/KV3Cb1UBlbv8pXYvoe7D4g9qIS0Ki8aRF
         ZDHn+y7u8eU/tB8qkP8lPma0/ARPYkIyWxO6xsTfhOIJegLed1sUzxsAfzIKmDN0SLHJ
         7hjQ==
X-Gm-Message-State: AOAM5308EvdYBxLRMghgp0wlGRSRUxE0IssRTIblN1GQ2EPPnKAHczSZ
        KiYtC0MmoDzh4N+9eFZp7qMOD6uT6lS4HkkAknE=
X-Google-Smtp-Source: ABdhPJy/z95MXE7D+ujGOR7UhVwJeCFpXOBvGEsnUDxiCXf8UriFOkjPSa6HmnPLVn4UpQE6eywdupIlhh6cGJSgQEw=
X-Received: by 2002:a05:6808:19a:: with SMTP id w26mr4284672oic.80.1629836261593;
 Tue, 24 Aug 2021 13:17:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:eacc:0:0:0:0:0 with HTTP; Tue, 24 Aug 2021 13:17:41
 -0700 (PDT)
Reply-To: mr.jeannasri@gmail.com
From:   jean nasri <feshayy795@gmail.com>
Date:   Tue, 24 Aug 2021 20:17:41 +0000
Message-ID: <CAH9KMQuXWOsJg7cqRGHQ+KTPZa+tYHqXvy4VWAiaDh8cuQf8yg@mail.gmail.com>
Subject: Meu amigo por favor confirme
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Le enviamos un correo electr=C3=B3nico, pero me sorprende que nunca se haya
molestado en responder. Por favor responda para m=C3=A1s explicaciones
