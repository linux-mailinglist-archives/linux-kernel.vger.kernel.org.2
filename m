Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292FA379DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhEKDde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:33:34 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:37517 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhEKDdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:33:32 -0400
Received: by mail-lj1-f170.google.com with SMTP id b7so23372647ljr.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 20:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=hwCrR3c0tccGbW56M/TTp5VwewXJzihLenrd3Qjv2XQ=;
        b=WHu8xNLeSNm3B+DH3/6qqQ+iswr3UmjdtLVQWeA7CxIsRORnneyIpSDnCc/ArJwRRw
         1ZdC5vxsjmFYLpPT6lSgIuELvy3coruP27CCfgX8iHKSY9JA8mZlsWfabGTEsJP/0blb
         5G9mfLcOKN12wgdosxEQldpY67/azMEZCPO0LmI00I4j4rS6NF+bgqpDAGIM0XlG2RHc
         sLANOJ6Yq8aZnF0EjeuhliNY2hPsE0HUMk7QTl3PFTOeZ5+m9U7lR8e4zRvC8gqzQY4r
         ZrtSh0HOFHvQyY1+rLsJqpZbwWWqi/CUYLjsGjXHKFRDxIParufMzdYOX/4RXYA07TNl
         tfBg==
X-Gm-Message-State: AOAM533sGwnt8hVE6GMNFSrzOLZSceo91nV52pKnUfjtrLiE9BdHNYmA
        qjZuHNjTwS2i6JclR2yp/mg=
X-Google-Smtp-Source: ABdhPJzB2BYNa0UqhjCRB+s4HZOe2xeGWd4g3CP/2p94P2b095FjNQeupWEDc3EnQfml8EjEeKFTJA==
X-Received: by 2002:a2e:90c2:: with SMTP id o2mr10967012ljg.314.1620703945310;
        Mon, 10 May 2021 20:32:25 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id z28sm3515577ljn.31.2021.05.10.20.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 20:32:25 -0700 (PDT)
Message-ID: <978a829103c768a01ed8a1b37ea607ea5fb0ddb0.camel@fi.rohmeurope.com>
Subject: Re: [PATCH 4/4] extcon: extcon-max8997: Fix IRQ freeing at error
 path
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <edf3ff4d-8bd7-17cf-0d7c-96b4f704dddd@canonical.com>
References: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
         <9047a741b4c4d97e721ed8b48cc4b434a46acba3.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
         <edf3ff4d-8bd7-17cf-0d7c-96b4f704dddd@canonical.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 11 May 2021 06:32:20 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, 2021-05-10 at 10:21 -0400, Krzysztof Kozlowski wrote:
> On 10/05/2021 04:12, Matti Vaittinen wrote:
> > If reading MAX8997_MUIC_REG_STATUS1 fails at probe the driver exits
> > without freeing the requested IRQs.
> 
> The driver frees IRQ on probe failure, so maybe you meant missing IRQ
> mapping dispose?

No. The commit 3e34c8198960 ("extcon: max8997: Avoid forcing UART path
on drive probe") introduced a return w/o IRQ freeing if reading the
MAX8997_MUIC_REG_STATUS1 fails at the end of the probe. This is not
visible in the patch though - as the return is Ok after the IRQs and
work-queue cancellation are managed by devm.

Best Regards
	--Matti Vaittinen

