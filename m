Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B6A35E770
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhDMULC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbhDMUI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:08:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F76BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:08:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 18so20898446edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FxiwZS1ypRO0CPpMIgmz+1n36gXQuCqv0DCfrFyvXvE=;
        b=WFzCm2+96E3AicJ9cw/P49tSLgNUOuab+s4Tax+yEMToNezQn+4WBP7DRAdu08t8OA
         ops0vkEYfihzCABQvwehY/4Zcm+zdVSrylQgQ/aL7W00kLGC/UNwfjRj7b7EAZudqgBK
         ChYtZs0yX1Y1qeJqaP+TtBKDkqSp9u1TUuZTCad3uMc2lFVJ92fy+uyLJ5mYPWW71QRz
         /PYZ2I1uxJnMWCTcdGpwaySLuIdeXA2CqdEzXXCksCrgTPUxFAfG2rjCCm2xHFT1VsJR
         d+O9tDYdfnO24qMWxoJdsqlqR39zOyovSEGEJ5bZr3+u17CDwC4gfg2bFivIRTgReij5
         3xNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FxiwZS1ypRO0CPpMIgmz+1n36gXQuCqv0DCfrFyvXvE=;
        b=e/eZIRAiwWlhK9LwYMrmIDCnxCc/PatFHAzinhffcE8KhmhbD87Do7ClyGZGow6IBi
         pOoJpmv1kX54XmNKJdu4gGJBn/vFlVSFeaVYuy6HKwwJeHkttfj6OaWtmIlLq1dX9yS0
         6kTSicKrCjc3ppCJwRbut9dWylVULctQiQC02vhui0W8S9c64ByziXw1UCwzEf4s3nkr
         cBMFhM8IEefMh9ukyVV/sHZabgJfuWU2Ku2KIpm2vNw5lylWYgSvpyjKDlgdBgjDnPy6
         AysuJL5SOQAqWD5EWUqNuwMaMKN/J2yNhN9t0jtibhavCRPS4uBF9VCPrH8ORynVxSU9
         0zOA==
X-Gm-Message-State: AOAM533MAC4/o9187zavM3mL0m95Fd2RKD74k6xrMxU/gyaeOFaINoKa
        qFHqLhNidajOcxIlDfyVJew=
X-Google-Smtp-Source: ABdhPJykMu/ukwA7ubmUAgc8lcQfkw6PAN2aol05P4sYO6p3GvosDhkDnm1lOwVIyQGB839li64QCA==
X-Received: by 2002:a50:fd16:: with SMTP id i22mr36470144eds.239.1618344513898;
        Tue, 13 Apr 2021 13:08:33 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id t1sm10207562edy.6.2021.04.13.13.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:08:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless led_blink_hdl()
Date:   Tue, 13 Apr 2021 22:08:32 +0200
Message-ID: <3505455.GpAHCVcAZI@linux.local>
In-Reply-To: <20210413194844.GR2531743@casper.infradead.org>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com> <7008359.Jy8utYDuns@linux.local> <20210413194844.GR2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 13, 2021 9:48:44 PM CEST Matthew Wilcox wrote:
> On Tue, Apr 13, 2021 at 09:45:03PM +0200, Fabio M. De Francesco wrote:
> > 1) The driver doesn't call that function from anywhere else than the
> > macro. 2) You have explained that the macro add its symbol to a slot
> > in an array that would shift all the subsequent elements down if that
> > macro is not used exactly in the line where it is.
> > 3) Dan Carpenter said that that array is full of null functions (or
> > empty slots?).
> > 
> > Unless that function is called anonymously dereferencing its address
> > from the position it occupies in the array, I'm not able to see what
> > else means can any caller use.
> > 
> > I know I have much less experience than you with C: what can go wrong?
> 
> Here's where the driver calls that function:
> 
> $ git grep wlancmds drivers/staging/rtl8723bs/
> drivers/staging/rtl8723bs/core/rtw_cmd.c:static struct cmd_hdl wlancmds[]
> = { drivers/staging/rtl8723bs/core/rtw_cmd.c:               if
> (pcmd->cmdcode < ARRAY_SIZE(wlancmds)) {
> drivers/staging/rtl8723bs/core/rtw_cmd.c:                       cmd_hdl
> = wlancmds[pcmd->cmdcode].h2cfuns;
>
OK, I had imagined an anonymous call from its location in the array (as I 
wrote in the last phrase of my message). However, I thought that it could 
have been an improbable possibility, not a real one.

Linux uses a lot of interesting ideas that newcomers like me should learn. 
Things here are trickier than they appear at first sight.

Thanks,

Fabio



