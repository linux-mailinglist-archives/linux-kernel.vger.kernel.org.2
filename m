Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965E340B205
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhINOuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbhINOuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:50:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26730C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:48:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kt8so29506947ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tK8Q8Zn3GUpR+B8TZD+RLtrcGX5lqXW2LlnHskkgzQ=;
        b=n+EehvKhg5Sbr+8pktbyroiCnZ3okG02dx/mvQ5i8Dwuhk8eS/GIQT6xQGnIt5++an
         eCT7dsOzfXDeBiDHWLSShbarVdsKXSSKMEVTGYNPDbK4LjIin7YSt5C0HJlh12odjNNK
         YgMYfKJNO+isJ8HYE2YZ+utU2GtB9IXRG3RHOv4Su2CCDxnCPIzTolJIE/GrfjBIwvV0
         SJ7ZmgtkWZC/pKCrHIueR6/aeONApzbUPyVvmWaaSPcw8f8P4EQ053TkECV/OVluK0sx
         ydR9dlFrD/M3WWmE/D9rLVdQjgrhjpu28JfugGvqi2Dh1u2wyOWi53X1tZQ9Lfs7id2/
         HRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tK8Q8Zn3GUpR+B8TZD+RLtrcGX5lqXW2LlnHskkgzQ=;
        b=7gsIRQifaBaAdxWROjRdK1zVnx6HjCEGGFnbAolcj2oDN14rrFySRbDIYfR43V+xUh
         C25fhLTHcpFT2wvUj/kBfJ+jh+H6Chg32jh/ClzMi2NZeRs3+oG7w/CcRa3VZtgTYHMU
         s8XLpYC2WHHraIy7GG1iAgzZMyzuY2+zAJAHnBZ+/S7c6FORTsfHBBGrRnfDZwbQDNCb
         bQ+JcPuE090iU/vdbBQx0r7+bXENyVAfRi8qdMMlaQYFcj9dySZfZYiXsUAKsYeFEz4a
         4PK5eR1LM4dUvzBWoGtMg8gfEnlGdPRtfVxCha7W5GA4iRlyNUd4/B8n8Yhd2aWWIcvh
         ICUg==
X-Gm-Message-State: AOAM530xGxtREgfGYX23YDokwyyHrTvLMcug6+2yySu9Ep5OUOMTtTEJ
        7TFvgAFfmbYdjU3JmxHH6zi6R3F9ORAShRuPXacm
X-Google-Smtp-Source: ABdhPJyfWGvhuJMOM1Tejmpphkj2jtIUuDBTTyYcErbU0nkvy5jtFT/nbuZcqEeF3xISCyLvmp53DoKw93B0JcCfCrw=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr19112012eje.341.1631630929504;
 Tue, 14 Sep 2021 07:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210914033339.134-1-caihuoqing@baidu.com>
In-Reply-To: <20210914033339.134-1-caihuoqing@baidu.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Sep 2021 10:48:38 -0400
Message-ID: <CAHC9VhQz=ek+_hkbHpDNvaJ_GqZO3Rm+Erb31Vu0hxxc_F+jmw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Convert to SPDX identifier
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:33 PM Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> Use SPDX-License-Identifier instead of a verbose license text.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v1->v2: Change recommended token from "GPL-2.0+" to "GPL-2.0-or-later"
>
>  kernel/auditsc.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Merged into audit/next, thanks!

-- 
paul moore
www.paul-moore.com
