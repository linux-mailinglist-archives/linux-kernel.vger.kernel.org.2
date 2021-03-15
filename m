Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8D733B2BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhCOM3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhCOM2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:28:31 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED4AC061762
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DQvAj/yl6UAl8GAQItRfRYZ5avwLz7eHHia2AQnO3yI=; b=kCm9LyxLuXrgNdPzbjvtz2JUVu
        Yi2Dy5nmsmnt2jCBz1iU1J0oAc2OS8ReQZx12590sqHqr1uI8wMGT4WtO+2wgF0M4jTfMYRQLNk5s
        qF11lHC6fOG/DywyM+YKH+LoqX8frLacyF1+cdbQBbetQAZ8ZaMrgw8bgk+kNmbxPk4k=;
Received: from p200300ccff0cb7001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:b700:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lLmKg-0001vB-W2; Mon, 15 Mar 2021 13:28:27 +0100
Date:   Mon, 15 Mar 2021 13:28:25 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210315132819.0970d493@aktux>
In-Reply-To: <20210315081231.GX701493@dell>
References: <20210313104258.17111-1-andreas@kemnade.info>
        <20210315081231.GX701493@dell>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 08:12:31 +0000
Lee Jones <lee.jones@linaro.org> wrote:

[...]
> >  static int ntxec_probe(struct i2c_client *client)
> >  {
> >  	struct ntxec *ec;
> >  	unsigned int version;
> >  	int res;
> > +	const struct mfd_cell *subdevs = ntxec_subdev;
> > +	size_t n_subdevs = ARRAY_SIZE(ntxec_subdev);  
> 
> This is a little confusing.  I had to re-read to figure it out.
> 
> In my mind, it would be clearer to explicitly set these in the
> switch, rather than have a default which can be over-written.
> 
yes, it is clearer. I was just afraid that your compiler cannot
figure it out that things get initialized and getting comments like
"This code has never seen a compiler."
But I will throw it against several ones.

Regards,
Andreas
