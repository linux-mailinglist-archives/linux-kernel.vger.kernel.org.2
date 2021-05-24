Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4BA38E0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 07:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhEXFW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 01:22:59 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:33687 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhEXFWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 01:22:44 -0400
Received: by mail-lf1-f47.google.com with SMTP id c10so17877724lfm.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 22:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=8NPVV69cMwlh8SI3FTmCYYI09tIcARUGTB+nBP4k3bk=;
        b=aPvWiVrifnGPgP9tTgfkhIxT1SDpkoL2Lqgm+5Z9I92YMuiSrlC1BXCr8SWWP59BoG
         JO2o/2M5Th55gREMkzNdfUEtCFZGd28HNN1tNcLLHvWsOUwwuSX2dBvzSuStD8lfd6cC
         LUAt/OM2P7jBEYht2m04h1fE87DZxph58DIUOZXQNNZRneE/bl6C8F1q5tuNdCV1AUq8
         m+sZsu7wkLLYcmDfU/2bp3WRnjmyfZ9ac5wW3XrjG5NEqx/g4a0Yy9vFC0nlUR7nf0Ni
         71klzYLFJXfZBeyL8I1grrgPgn1BFL9zfp2HHKRLX4nxKdORkFHV+JQ97pcX1JAyBRZk
         4/4Q==
X-Gm-Message-State: AOAM532TSRhtNbChCTCO2Mo3C+JcCrkUm5/Q0SpWyv8OGTsdbCz5dfKb
        pdHDYNlnemo7dWUmUuxq91M=
X-Google-Smtp-Source: ABdhPJwMUqlthPczlf0zGTtafSNxiKPrcc+oVfgUQgkscmjXZqrW5Kjd5pXowUB035OGZ+yTfbou3A==
X-Received: by 2002:a05:6512:b15:: with SMTP id w21mr9345311lfu.556.1621833675229;
        Sun, 23 May 2021 22:21:15 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id c9sm1594061ljb.22.2021.05.23.22.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 22:21:14 -0700 (PDT)
Message-ID: <32ad354611a35a55547377005ce3a70f6edd037c.camel@fi.rohmeurope.com>
Subject: Re: [PATCH] regulator: bd70528: Convert to use
 regulator_set_ramp_delay_regmap
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20210522124250.2121076-1-axel.lin@ingics.com>
References: <20210522124250.2121076-1-axel.lin@ingics.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Mon, 24 May 2021 08:21:09 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2021-05-22 at 20:42 +0800, Axel Lin wrote:
> Use regulator_set_ramp_delay_regmap instead of open-coded.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

As a side-note - yesterday I sent an email asking the fate/status of
BD70528. It may be we can drop whole BD70528 support and that's why I
have more or less neglected the updates (for example the binding docs
are still .txt) - but let's wait for a reply for a little while.
Dropping BD70528 would simplify the RTC driver used by BD71828 and
BD71815.

I won't in any ways object applying this patch though - it looks good
to me.

Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> 



