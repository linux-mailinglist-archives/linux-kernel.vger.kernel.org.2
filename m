Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AABE388E50
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353446AbhESMqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbhESMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:46:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A1C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:44:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c14so12097543wrx.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ScinkFGOJoc8OlIzl9hdR3ylpAQjgnxUkerv31RVSCw=;
        b=ZQLHHA737m6BkJjTJ61c8UM3q3uVcQ5xNivXeYgsfQTYrDK+XVLC6BnAv8wWz3Qerz
         VezzD1d0C+ny8ZI4bUNS9BdibN3/2iKMXeccFmZmPD9X4qrG9OyoPlkciD+w7inFJYUU
         7HcOMHbPkgziceFimusw+CjQ27X6qGRqPMknkZteKh2XtsHq6YGn7WjtJekuV2/v+co3
         GJRlPbeSh16OiqO6HpZLBMzadXAUdPHbO2t43N23gCQQSjNM9xGbOEzbJismEopasb8q
         x/aSVPR92ciFr6tVS/liv44RUC3ltNu/DBv6cMb2N9e9kLN0fWG3Tq2lwKNYngrOEbI4
         /Ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ScinkFGOJoc8OlIzl9hdR3ylpAQjgnxUkerv31RVSCw=;
        b=ISVLJeIBqimB5MJZRu+EoNY4QiCeO/eRWfDjLqyXKakTcPkN3l7z7RZ+D9jOxgDG4M
         S0BUIrf1smFDNq/WxXcRamaXrdLuHUjGQTNFM+YCC2YFoIGsbI1OxYCm228f5O+TDR2v
         VylT/c15p5kDBmoduzITzOBj//T31uh7s9bdShO5xIDCOELXDbOgUSXh3CB574InPzQe
         DxcT0EX59pGlYGwly97HZlo3aOcBL9vZn8KsutOx96jwC0m7mNhW7RAO5y3JKMsKDzC/
         nhvH5TjzffMRGPqV3kd8wcn+/8kPhb9d1WLJ82tBqHxk7IcRn8/g6D2e75Al05b+vNXo
         qA5Q==
X-Gm-Message-State: AOAM532TVTuMGwWoLj9smmvAZ/AdIxHZdQXDsl3XWTRabh7TX++MQjgy
        lUDQvT2co1j7VEs4Ug8H1hU=
X-Google-Smtp-Source: ABdhPJzR3yfTJ3agrm7I7IPuHEFVUV+G567MXyJj0bbbRJm/v+J0DQHlQJ0SsSEtozdC5HSBYC6pGQ==
X-Received: by 2002:adf:ea82:: with SMTP id s2mr14264120wrm.397.1621428281538;
        Wed, 19 May 2021 05:44:41 -0700 (PDT)
Received: from agape.jhs ([5.171.80.197])
        by smtp.gmail.com with ESMTPSA id x2sm10905721wmj.3.2021.05.19.05.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:44:41 -0700 (PDT)
Date:   Wed, 19 May 2021 14:44:38 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove if (true) statement
Message-ID: <20210519124438.GA1417@agape.jhs>
References: <20210518144335.1677320-1-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518144335.1677320-1-hello@bryanbrattlof.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

On Tue, May 18, 2021 at 02:45:19PM +0000, Bryan Brattlof wrote:
> 'if (true) { ... }' will always evaluate to true. Remove it and
> save a few tabs for somewhere else.
> 
> Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 159 ++++++++++++------------
>  1 file changed, 78 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 9df4476b2e2d..98b1bec67999 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -59,112 +59,109 @@ static void update_BCNTIM(struct adapter *padapter)
>

I was wondering why are you using the first patch of a nine patch
series as a 'cover letter' of an eight patch patchset.

In other words, why putting the In-Reply-To field of all patches subsequent
to the first one ponting to the first patch itself as a cover letter,
is it a recommened practice?

thank you,

fabio
