Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1673E978A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhHKSU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhHKSUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:20:20 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860E2C061765;
        Wed, 11 Aug 2021 11:19:55 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f23so3347413qkk.13;
        Wed, 11 Aug 2021 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nXzVpyij1ZNQ2Jytic1y9iKjfHsLQUQIKsqqIrPJxhA=;
        b=rnHu4E+PQlPlVp0uMPW/pul3vdmZh78miXqPsl2EBz8w7MC/5V4b0vcsE+dkG/0g0T
         hi1h8KcBxq+Jl6x/NChwUoMnTWWHNdz6e9ervTXmX0Q0IG0k8RzRKumXRtPK19/87CPV
         Kr437NrIxuIpeVXiDEBtKizCD97pmkkN37S+pTLwmP3guEcnbhCfMbQ7ey4/8A7pGKkb
         y6yVPdJVahNIROaAj41K8ZzxBAvLsDj4Px2aEXdo0AY6z69AZEyB1vqaOM2T4ntuwnCA
         lltgoWS0bU7xviD8HMhxROC9mSdDjmZtk1FDQKXYXAFL/nZ9SqebFv6dbvctA1C2XGAh
         rZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nXzVpyij1ZNQ2Jytic1y9iKjfHsLQUQIKsqqIrPJxhA=;
        b=BayeF3PC6PXZjPz6zPQdeW/AM9d/xodUfmOBVy+6MbeeH+/VGa2mbeQw1ifhvdpSim
         BII+iT1heK415RhCZ3SWxczy8YDbx1ms3EPgiTwMhCV792lX+gtm/B6STe+tydjwKiCF
         Rs4dtkPnL3746lmKCoROZNOsU17LXu40xhr21IZ+TZxY9r47Iqhep9ggvzf86fnCmmpB
         QRYZrTGFnQqLtSrS4wovmb6p1LoCXknXQ4aBBNnVZbx7cNzKZ9buQ9NHRLbO8f9Mz192
         BjGfhJ3BIWfKFzdp7Zz5urW3h2pjLhh8z+CbAzsthsm1CxfmJEGGEniOSf7qQP68esC4
         2ZSg==
X-Gm-Message-State: AOAM530E3E5uDdHcv6uCNWE3p5TriceLxYXPEfSJC6iOgE4l8h30dIsy
        3YLZ5Vju9SIFocmQ0hfgQAI=
X-Google-Smtp-Source: ABdhPJw+btSMcpcGz2MbjdsBF3HMosEM+0Kb2NIXpBzeNZx9IKkq3p9OthkgmZ/wWHqUpmxpCjvNig==
X-Received: by 2002:a37:9401:: with SMTP id w1mr353500qkd.166.1628705994692;
        Wed, 11 Aug 2021 11:19:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y199sm13474573qkb.36.2021.08.11.11.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:19:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Aug 2021 11:19:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nadezda Lutovinova <lutovinova@ispras.ru>
Cc:     Marc Hulsman <m.hulsman@tudelft.nl>,
        Jean Delvare <jdelvare@suse.com>,
        Rudolf Marek <r.marek@assembler.cz>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: hwmon: Error handling in w83793.c, w83791d.c, w83792d.c
Message-ID: <20210811181952.GA3833613@roeck-us.net>
References: <20210811161515.17842-1-lutovinova@ispras.ru>
 <20210811175120.GA3138792@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811175120.GA3138792@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 10:52:03AM -0700, Guenter Roeck wrote:
> On Wed, Aug 11, 2021 at 07:15:14PM +0300, Nadezda Lutovinova wrote:
> > In w83793_detect_subclients(): if driver read tmp value sufficient for 
> > (tmp & 0x08) && (!(tmp & 0x80)) && ((tmp & 0x7) == ((tmp >> 4) & 0x7))
> > from device then Null pointer dereference occurs.
> > (It is possible if tmp = 0b0xyz1xyz, where same chars mean same numbers).
> > 
> > It can be fixed just by adding a checking for null pointer, patch for 
> > this is in the next letter. But a question arised:
> > The array w83793_data->lm75 is used once in this function after switching 
> > to devm_i2c_new_dummy_device() instead of i2c_new_dummy(). And this 
> > function is called once (from w83793_probe()). Maybe this array should be 
> > deleted from struct w83793_data?
> > 
> 
> That is part of it. However, the entire code is wrong. There is no need
> to check for I2C address overlap in the first place, and the i2c address
> for the second 'virtual' chip should start with 0x4c, not with 0x48.
> See w83793g/w83793ag datasheet, section 8.3.2.2.

Wait, that is wrong. Those are just the initial register values.
Forget the noise above; sorry for the confusion.

Guenter

> I assume the code was copied from w83791d and w83792d, where the addresses
> can indeed overlap.
> 
> Guenter
> 
> > The same situation in w83791d.c and in w83792d.
> > 
> > Found by Linux Driver Verification project (linuxtesting.org).
> > 
> > Signed-off-by: Nadezda Lutovinova <lutovinova@ispras.ru>
