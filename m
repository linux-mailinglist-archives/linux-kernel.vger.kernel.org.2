Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBBE3B88B2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhF3SuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhF3SuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:50:12 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AF2C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 11:47:43 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id u2so1618044qvp.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=60fGwYuMLeZ3w6f/QlUbAzK/Tjn7WY3lrVIKtdFV0vE=;
        b=LzgLnsFE+DhrGM/j/IN7YopN6o3LeoGE9g0yyE3qnyBrqwWfJVE2uapkEGiR02s3ef
         vTEkjreUeYXuenawNTbMqFlrh2c8SVWGRMsMdvOL+jeQPirX5Kth+6O1oK2HjUrEqeVk
         v5ctK0HFUwkXlre0Tx5aARDYO7zeCBx45Q1Etx/p5Mxg44M/OvAMxWsLzE5yqUjBmIDb
         ub3lQ+jgLCxOq2koDxpcwx9QwisHZ+VLaPqE5XuQiLkT4VTycWyn8QKiEq2drikZhDLW
         0t2n5TDC+mtKpItTs5tQefsSh8XiQ6XMu4H6qlJG05097NwX/iLm7QpdHVu3uzXfOxhP
         ySmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=60fGwYuMLeZ3w6f/QlUbAzK/Tjn7WY3lrVIKtdFV0vE=;
        b=iHG0rP/NZ9M17FBRfc5xm8CdvVOhCZ4rb+wqP/GhxMSot7y+lt9BNLLiq/mBp1sEo6
         Gj5ujMhBn89vcSaLTkLujk9YqLt89Raz++Lxks0YRbk4K5VriZU5YVbpEOdSlfTqPxti
         AQd3XA9ykl1RQl9Vc/f/19fsW+E2XJ3fntKjpqogunxA11OFCxi5auEvB0ojEGhjskXc
         0Ca2eIK4tkFmWg+8b8sjZnZi2sdwzh98toRqUQixwMUN2O739CMDcsenqpgKSR/eNdf9
         vWXDPv7HgtkBT0nV3vIsYlOy7a9FwtCUcZLSyZBPVUGVkrrc/duVoaSpZLa8r9ik/cLp
         47ig==
X-Gm-Message-State: AOAM5330ps4OmHs+z2uTGRosrFYBhuQzOTI8aADp4eDLccC1COHE/im5
        1ycMeY9r9dsmWghfctevi76nK2dhWzNAaw==
X-Google-Smtp-Source: ABdhPJySaixmMF28wbxHFLTNG5QwoLBZMlZqqSpQpvgNC1zV/DlGQX5TKq247Pv5skCWrOtnTOgEYA==
X-Received: by 2002:a0c:be85:: with SMTP id n5mr23634306qvi.59.1625078862845;
        Wed, 30 Jun 2021 11:47:42 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
        by smtp.gmail.com with ESMTPSA id c22sm3842608qka.95.2021.06.30.11.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 11:47:42 -0700 (PDT)
Date:   Wed, 30 Jun 2021 14:47:41 -0400
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org, Marek Vasut <marex@denx.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: denali: add more delays before latching
 incoming data
Message-ID: <20210630184741.GA1037365@maple.netwinder.org>
References: <20200317071821.9916-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200317071821.9916-1-yamada.masahiro@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 04:18:21PM +0900, Masahiro Yamada wrote:
>
>Marek Vasut reported this driver in the latest kernel does not work
>on his SOCFPGA board. (The on-board NAND chip is mode 5)

In a bit of an ironic twist, this change seems to cause a regression for 
me. I'm also using a Cyclone V SoC system, similar but not the same as 
the SOCFPGA eval board. The NAND device in my case is S34ML04G2.

It worked fine in 4.9, 4.19 and 5.4 kernels. However after upgrading to 
5.10 the NAND driver fails with "timeout while waiting for irq 0x4", 
just as was reported back in 2018:
https://lore.kernel.org/linux-mtd/737ejrj81y.fsf@pengutronix.de/

Reverting commit 5756f2e8dad46eba6e2d3e530243b8eff4dd5a42 restores the 
behaviour in my case, but that would presumably break the SOCFPGA board.

Any thoughts on how we could make it work for everybody?

Ralph
