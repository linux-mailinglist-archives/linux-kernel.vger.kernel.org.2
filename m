Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BC03BBE64
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhGEOvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhGEOvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:51:03 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADAAC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 07:48:26 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c13so12366886qtb.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2zmbjDFIaZtiyBVWKZoOJHJ00DjMnvggIa2QROg9R98=;
        b=KkTD4Dx7MKl6LNSDU0piJ68YMk+h9b9/3OGdqn+ig6m6S5bHtmUoIO/Q9E3zTXnP7r
         eUdW5hzpVFjDr2Ry+VyfXjwjL9oyAsb5Uc6brPZRR3Gw2rZ5Jx4fvnlKnYY/8xuY0lHn
         KhU96ebnlUuh1NqkyzaVLhXg5De4yJQUsRLVWZ4+WpPzeit8OjHSkZLDfLiArFE0Ot1D
         7lniL1GqD18yMPnQYSd8cXNQIaqMXkJheqTYRQLKv/w6LwsSj1wf6ca2nAWe07eqlwdo
         zfT+RuedS90VxOrZfkAGku8hxehgfeOwpmOCRtJMsJwZzNoM68rzEIoa5TBcJmBrNl+W
         tl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2zmbjDFIaZtiyBVWKZoOJHJ00DjMnvggIa2QROg9R98=;
        b=rxurWOhWAtA4lQ5yf1I5AoGGZDmB4J94U6EThowwDZoYKSHq0oH6MTrJjdFU5sY1/t
         y7mlTpeQGUbzF4YzeB2zeeBGAAanvfeG2wpHJaB4zfKHh9EJnXuN0yzozO+IeCgK0T/K
         CFjBCkw0pF/EAuNa522+CmB0/w69rzvg8H26cPrIuiTIvpTmDlXavhTiRscFnSIHHnzj
         QeXzHICnRUeWG6Csd48UD3I751/t+swwWL+La8aCysfo7xg4VIyNo9QeAxRFuLWFK8eg
         Ifja0k4K3KgSfCuxp4BzjkTcVddhR2pvnOGhWeImgxo5j0VoT0fmEWXb6JwJvpWfa+As
         MMXw==
X-Gm-Message-State: AOAM532SDzCYeYnlzh6lusAJmiKS8Seac7W+WTlxF8Dni78aAwsqkFZC
        LYlvBBjg6RBkJgNPsjX7+Vnz6Q==
X-Google-Smtp-Source: ABdhPJwTf0hicO7g+xx48R4psSASkNcG40bxjp266rE0H0pv0I9zV6b5hNu2WBDj1br05e9bwQb4lw==
X-Received: by 2002:ac8:451a:: with SMTP id q26mr13163488qtn.68.1625496505267;
        Mon, 05 Jul 2021 07:48:25 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
        by smtp.gmail.com with ESMTPSA id j3sm4579383qth.63.2021.07.05.07.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 07:48:24 -0700 (PDT)
Date:   Mon, 5 Jul 2021 10:48:23 -0400
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Marek Vasut <marex@denx.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: rawnand: denali: add more delays before latching
 incoming data
Message-ID: <20210705144823.GA1459782@maple.netwinder.org>
References: <20200317071821.9916-1-yamada.masahiro@socionext.com>
 <20210630184741.GA1037365@maple.netwinder.org>
 <CAK7LNASvYVyEQ4M_zEUdw9K9AB-RVErKoqFMQZ5OSKJF0AoBww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNASvYVyEQ4M_zEUdw9K9AB-RVErKoqFMQZ5OSKJF0AoBww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 01:00:43AM +0900, Masahiro Yamada wrote:
>
>I no longer have any hardware to test this driver.
>
>If you increase data_setup_on_host (the current value is 10000),
>will it solve your issue?

Yes, it does seem to work with this value increased to 10001.

Looking more closely, I compared timing parameters in struct 
denali_chip_sel, for the kernel 5.4 (which works), for 5.10 (which 
fails), and also for 5.10 with data_setup_host=10001 (which works).

                 5.4     5.10    5.10+10001
acc_clks        2       3       4
rdwr_en_lo_cnt  3       2       3
cs_setup_cnt    1       0       0

So it seems that on my hardware, rdwr_en_lo_cnt must be >= 3.

Regards,
Ralph
