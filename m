Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0054B4085A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbhIMHv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbhIMHvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:51:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA82AC061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:50:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g16so13174235wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fPafIR5GmwDQOIeAjrph5JtTlJL1DexsWySp1PYorGM=;
        b=S+qRBFcq9C0Q0rOkARye5DgHAfBxB8OhZHgTxMHft4U2fvby2nY0N2hbmBo7JpiykA
         ZmhNRR+ZCA6/8Z+46Bp4EvfW2UwS8cVvC8uts9WTdo4w2SmVk9j8w1ZhMfRA6uljObgI
         b6LB4pfhFHVcUkDDQPQtJOPTe0xrc3LYH5j1uqfia+/tgQAHnjb7QRo2H1NuIu3bk60B
         OgHAHeft+/uj2dbyBzLCQ1oImSAv8ZuoV67VA1hco2W/u6sKx0DJQKIwsZf+uG3Oz6OH
         DtOSsGFN6YdgUUKndHy5NJDLJdEl5mZoyaz4ky5Apvo7wGCVQjHQWMt7uDtZf5WJfpv8
         r9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fPafIR5GmwDQOIeAjrph5JtTlJL1DexsWySp1PYorGM=;
        b=v/lr2H4ZLnTSc2OJYE7CShVJ3kjSQkNBoMvcZc/vZb9XsedHDEKktzRIic+PwWvMU5
         ugVgTPdLQ07zlJ67p0P1jwLigXM8ztLto4qvotE+XYimh1gb7r5EH9Aq3hSnjtxlDqJE
         3D/S+joLGNjT+LpPzMWx8XlvzNIUmVwB0xwFSfWIZ8rngkPrpeWNczrWdX5gJZNFVQEi
         wavmePIrSbPvjIDv8HXBI9MA6rmg9V+1BA6qsB8XZfxOWx5Q/R0OnGl9o96n01J07qOk
         TqAKFmXmsX120d8i0zQ890/9y5+5ygfqnhivWJOyp7Tfs2iglb1T0Pxzd/RTs8tikyCM
         6kuA==
X-Gm-Message-State: AOAM532dKeklWqq724PcFXhI6+TRozzu6zJoDMN0Fgr0AZ2TaTx++WI2
        ieRi70yJvjlcKfVwupcGQ4K2vg==
X-Google-Smtp-Source: ABdhPJz7feFvVzwpu+DQXdUe0+VtjDu5w3ueyz6v3P4J1xMq93ZxWNI9bOq7iNCDZNIjPcD3+3MpOQ==
X-Received: by 2002:adf:f0c7:: with SMTP id x7mr10943386wro.432.1631519408352;
        Mon, 13 Sep 2021 00:50:08 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id l15sm5279692wme.42.2021.09.13.00.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:50:07 -0700 (PDT)
Date:   Mon, 13 Sep 2021 08:50:05 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Lukas Prediger <lumip@lumip.de>
Cc:     axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH v3] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YT8CrdhydoHy373z@equinox>
References: <YT5BO7bUMMkwNCTh@equinox>
 <20210912191207.74449-1-lumip@lumip.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912191207.74449-1-lumip@lumip.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 10:12:08PM +0300, Lukas Prediger wrote:
> > Dear Lukas,
> > 
> > This v3 patch does not apply to my tree, or the mainline one for that
> > matter. A few problems I've noticed that are the cause of this:
> >
> > [..] 
> >
> > Please advise, many thanks. As mentioned before, v2 applied perfectly
> > fine for me.
> >
> > Regards,
> > Phil
> 
> Hey Phil,
> it seems I had accidentally formated the patch off my v5.4 testing branch.
> Here's the proper version based on current master, that should apply cleanly.
> 
> I've also removed the continuation backslashes that Randy pointed out now.
> 
> Sorry for the troubles,
> Lukas
> 
Dear Lukas,

No apology necessary - I will check this over after work this evening
and then send onto Jens. Many thanks.

Regards,
Phil
