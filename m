Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD08440676D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 08:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhIJG5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 02:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhIJG5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 02:57:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD63C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 23:56:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kt8so2147858ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 23:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qe4YuiYO6FDy+8wy0Cuuh6ezcNY8ZPHO9nOpUPv7rJI=;
        b=wLdL2CtIobSHzFTi1orr6157r6AxMlSZOYeUcxBSBoCxfVQMcvC3r9zq8QxGSgm2dk
         aV4+xXpTZJ7LIPAgSYVKFpzdXnylig3r/tVHwOgEBF/sLuz/0EmMIBHrE0kfCQu0LugH
         p/fPKFWtmiGee83mFhX+2fy+uo4a257OAfhxM1BrlRrPU1qnTR0fapGLJuRPe+pslsNn
         VZVs/lTskp0aN677OfV10NoQadB+Nwsxu6R8qlfoxhoINGc3pi/sFXVdarIW/mOcslrc
         eLWJhfabHRpmWI1sPTMzP+6i7q4NhaolOo4BS3HamQMxcQOPnOrW9ETANXAnNxjsa2YC
         4S8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qe4YuiYO6FDy+8wy0Cuuh6ezcNY8ZPHO9nOpUPv7rJI=;
        b=f0+qyARcYX42uobXDzRXwy7VMeaTOEIRMVImm7Z9s6df+jIaCSub6LU2LPrWWcVqm4
         3naE50WU4XqNZnTxiwnQERV3A6G1hCu4uIFiTDchm5ZMh6O0Hrzf3EJODoqL2ZiAE2fA
         /eZ8Co/tqI2Kil6sNPAvXw9xnuI5q7PKCKYJ//GTvMuHiV86BMFIRNroSN89QPntqTzz
         QEA99cgJlFVJdvktFBuul3+zimSPiNp0F6CZEglV7cy7p/8vPJlkLZoKLSVhO8s8OEz9
         JH3ujZNaBDOufe4bAD9KMBMaeH7+dqc4UG/E+3iLavpfW+ewiejqZhWFU6c+2lu2ZVRt
         NWwA==
X-Gm-Message-State: AOAM533yzpouPQfXzQ78hHMJ2x4Hf/cMj5dVcxXYsNjX1GxaF8Yjjt4n
        0zwmvMpJbp0/H37K9YvaHvKjNWKecs/jKQ==
X-Google-Smtp-Source: ABdhPJwaE7mB7X2UQ4DAPK52lKus+Ck7UNwYLhd7APaKbaZX4iMC+SyixQr//QBW+89mH7/g8aairg==
X-Received: by 2002:a17:906:51d4:: with SMTP id v20mr7892059ejk.9.1631256993850;
        Thu, 09 Sep 2021 23:56:33 -0700 (PDT)
Received: from blmsp (dynamic-046-114-035-064.46.114.pool.telefonica.de. [46.114.35.64])
        by smtp.gmail.com with ESMTPSA id a5sm2252540edm.37.2021.09.09.23.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 23:56:33 -0700 (PDT)
Date:   Fri, 10 Sep 2021 08:56:32 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: info@cestasdeplastico.com spam
Message-ID: <20210910065632.uwp6bfwy6mrdxnkj@blmsp>
References: <20210809132751.kwmgd2movxgoc4v6@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210809132751.kwmgd2movxgoc4v6@skbuf>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 09, 2021 at 04:27:51PM +0300, Vladimir Oltean wrote:
> Every time I send an email to a few mailing lists, like
> linux-kernel@vger.kernel.org, and (I believe)
> linux-arm-kernel@lists.infradead.org, I get an auto-reply from said
> email address which says:
> 
> 	Hemos recibido correctamente su consulta, en breve le contestaremos. Gracias.
> 
> It is really annoying. Can we make it stop?

Same here. For me it is probably linux-arm-kernel, I didn't send to
linux-kernel.

Best,
Markus
