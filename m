Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569403C5DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhGLN7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhGLN7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:59:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3D7C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:56:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a127so16456393pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sd9Wcz/QMtZE0mm9Z+JsQ4znaJrnaPqRYCaJddEDaYo=;
        b=odfjbn5GCbGSlPqua3Ful+3k9w4wUiOERTrPn1KBK9B+zP546xqFkJ7QuXOx+k+Wua
         a2gR0nhdFbw5dL3pnP/diggI4Cze9/23cGTxQKQLp2r/gi+PNqgAmorpbfBvpzIPnJLZ
         iAReBzJLy7nL6/M/Lrno7/9SCZO9pRto0tXvdzNm8IqrhKdPOisFGY6VX2pq8e+75NjS
         Iof3JiUvmHgS0v9+1erm/RgtpM/3vMudAxHGf9x/7Pkom20zq+nQNbT3YP+8dN0I9sMC
         tD05JA3b3o2kKE3vO8M4rcCtBNTAw+TrDtc/PKWMH7TNtikiB03GpnYX+s+wV7A0ch2B
         Ryog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sd9Wcz/QMtZE0mm9Z+JsQ4znaJrnaPqRYCaJddEDaYo=;
        b=g/bRay8vdb+M8+V0Il7Wh+SuemLoCNwE6tcPyNzHGx7GMS24n0N5hyBoH/kj1/qr7/
         WtNpo1XRg5PdmIOYbQXwj3vM6Eu/9cRfN7saSpL9fHhoPMjlaAQAUgyvnUJIGUCOxVVX
         esvK7QIHFfwLBj3UxvOBxG0E1BAOZNSx04ZISai8p6RQs4hqmn4ED84dzImeTYU1qm7k
         qw7yyun0U2IjXqKsFaVPClW9P+VQAqlpW4/6s1xZK+LhwZ8bS+2Ae6xqmkN2eo9F4vEg
         /e7Rwjw6/o079BVJsaqGzFOPsMISFLACT4/ix3HQD42X1MGvVZhjtlZlKcq3t2Pu5zpp
         GafQ==
X-Gm-Message-State: AOAM5329N/0uESJ8Vt+PN6G1b+FI+zze6spEfwSU8x7VvVHOMPgqgE/c
        wwEvgcYHsCRPfHnzRj4B9kg=
X-Google-Smtp-Source: ABdhPJw+bxLPYpFGfbVfkZwV4WNgdaUHDKOOQQT+7KBo65MZwoNrSErLqfBH04o8KrOlw8AEGB8JEA==
X-Received: by 2002:a63:da04:: with SMTP id c4mr53548344pgh.348.1626098213184;
        Mon, 12 Jul 2021 06:56:53 -0700 (PDT)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id 133sm16973141pfx.39.2021.07.12.06.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 06:56:52 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id 7C1F79008F9;
        Mon, 12 Jul 2021 13:56:50 +0000 (GMT)
Date:   Mon, 12 Jul 2021 13:56:49 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] regulator: da9063: Add support for full-current
 mode.
Message-ID: <20210712135649.45983c5f@gmail.com>
In-Reply-To: <DB9PR10MB46522678869990E32D9F00EB80159@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <9d5decc6d5b15702d0e1039f8c9bda51d9a4d630.1625740324.git.plr.vincent@gmail.com>
        <DB9PR10MB46522678869990E32D9F00EB80159@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for the review.

On Mon, 12 Jul 2021 10:42:26 +0000, Adam Thomson <Adam.Thomson.Opensource@diasemi.com> wrote:
> On 08 July 2021 11:33, Vincent Pelletier wrote:
> > +	if (ret < 0)
> > +		/* attempt to restore original overdrive state, ignore failure-
> > +		 * on-failure
> > +		 */
> > +		regmap_update_bits(regl->hw->regmap,
> > DA9063_REG_CONFIG_H,
> > +				   overdrive_mask, orig_overdrive);  
> 
> If I2C is failing here I'm not sure this is going to go through and you have
> bigger problems. Not sure if it's really worth trying to roll-back at this point
> but maybe Mark has another view. Personally I'd be tempted to just ditch this
> and just always set the OD bit in this function, rather than trying an roll-back.
> Will be much simpler code.

What I have in mind here is regulator_set_current_limit_regmap
rejecting the change not because of a bus issue, but rather because of
an unusable min_uA..max_uA range.
I add this to the error handling path comment to make the intent
clearer.

But your remark indeed fully applies in the case of
da9063_buck_set_limit_clear_overdrive. I will keep the roll-back
codepath for the next patch iteration, but I will drop it if the
consensus is against its presence.

Regards,
-- 
Vincent Pelletier
GPG fingerprint 983A E8B7 3B91 1598 7A92 3845 CAC9 3691 4257 B0C1
