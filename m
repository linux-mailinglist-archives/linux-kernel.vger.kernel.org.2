Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE6935EEF4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349791AbhDNIAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348275AbhDNIAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:00:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8CDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:59:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g5so23281382ejx.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ibSfaxMDOYRux13gOXyhDI45bjJWSQu1PLpiJt0t54=;
        b=UmyxIy5wFfRbbUFPuN/6V290dal5iiDuoS8ErA+IsGUckgkTvo8yvCc7Qja6C56ITF
         5vIUKRJFEkuXez2ffx/LCgtFuBEO9NtFzlUL/gjKvLrl8Bw9TyE6q1ZkHLdwaZaYqeGG
         eIKU5gKH5ugX0baV1nfqjaZvC+65O7t2Gq0hSMY9J5d65IFlXI45IkByMMujm+e+5g9J
         lQdaeAYroZxlyG3adiaENRRyRG/xN0aH2t5215Fbs2SU/jCitoT6+0bqUFzixDD6I7ab
         OG8SlO3hcTvk6DFyw5axaYE7QWb0H9zeNMiwuwMG3HAWbkc1vVYHnI51i322z1ZpgFvy
         x3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ibSfaxMDOYRux13gOXyhDI45bjJWSQu1PLpiJt0t54=;
        b=DBItXbvO4ZbPtxnkYBPpa/+hl4l+y50XciP5hcAUv5NyHHbu39Ms1agLaP9ItpOy3/
         RZSao9A19drmTivVlEdDw2z93eXaFlEjMCzSQcLJp8FNmY4TCcXQ7pU1sZR5Ki6PcXEN
         riOHQELJ9tzADMhGPnDKBDAE39+d2c6dgNtA3ps2E8cmcQtxp5itqvXHlJiLaLkxyOjG
         MvLuXB6P3JkEJNLfAsryZ+Ocwaxa/ppjjXenTtf6qFpVDfgjJP+Vm1IecRNiK74Va4nD
         CHnD88fvpK7yi+7DzfJGzqro9GfqwVJDYpgJBB+JaF4DLz9GBu2xk9zLdFaxi2i8qJsO
         7bYA==
X-Gm-Message-State: AOAM5307EX4iIKuSp1kpP880Ssikg8yVLUJHm7eh5Ug5n6IKqC5oae2b
        IqM7ctMKkadXf9T85kCmPHo=
X-Google-Smtp-Source: ABdhPJyx3maz7rv+J7z3LposHsKwETimi4fOaYFprPWQqu9x1sUSjHgMC9xdxHDflNAAmnpCFBQSHA==
X-Received: by 2002:a17:906:ca45:: with SMTP id jx5mr6306786ejb.417.1618387178169;
        Wed, 14 Apr 2021 00:59:38 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id 16sm322298ejw.0.2021.04.14.00.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 00:59:37 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless led_blink_hdl()
Date:   Wed, 14 Apr 2021 09:59:36 +0200
Message-ID: <17405149.YoMEP5XZXy@linux.local>
In-Reply-To: <20210414070025.GB6048@kadam>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com> <2418632.vfNx7fMs9o@linux.local> <20210414070025.GB6048@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 14, 2021 9:00:25 AM CEST Dan Carpenter wrote:
> On Wed, Apr 14, 2021 at 08:33:48AM +0200, Fabio M. De Francesco wrote:
> > On Wednesday, April 14, 2021 7:21:50 AM CEST Dan Carpenter wrote:
> > > On Tue, Apr 13, 2021 at 10:08:32PM +0200, Fabio M. De Francesco 
wrote:
> > > > On Tuesday, April 13, 2021 9:48:44 PM CEST Matthew Wilcox wrote:
> > > > > On Tue, Apr 13, 2021 at 09:45:03PM +0200, Fabio M. De Francesco
> > 
> > wrote:
> > > > > > 1) The driver doesn't call that function from anywhere else
> > > > > > than
> > > > > > the
> > > > > > macro. 2) You have explained that the macro add its symbol to a
> > > > > > slot
> > > > > > in an array that would shift all the subsequent elements down
> > > > > > if
> > > > > > that
> > > > > > macro is not used exactly in the line where it is.
> > > > > > 3) Dan Carpenter said that that array is full of null functions
> > > > > > (or
> > > > > > empty slots?).
> > > > > > 
> > > > > > Unless that function is called anonymously dereferencing its
> > > > > > address
> > > > > > from the position it occupies in the array, I'm not able to see
> > > > > > what
> > > > > > else means can any caller use.
> > > > > > 
> > > > > > I know I have much less experience than you with C: what can go
> > > > > > wrong?
> > > > > 
> > > > > Here's where the driver calls that function:
> > > > > 
> > > > > $ git grep wlancmds drivers/staging/rtl8723bs/
> > > > > drivers/staging/rtl8723bs/core/rtw_cmd.c:static struct cmd_hdl
> > > > > 
> > > > > wlancmds[] = { drivers/staging/rtl8723bs/core/rtw_cmd.c:
> > > > >   if
> > > > > 
> > > > > (pcmd->cmdcode < ARRAY_SIZE(wlancmds)) {
> > > > > drivers/staging/rtl8723bs/core/rtw_cmd.c:
> > > > > cmd_hdl
> > > > > = wlancmds[pcmd->cmdcode].h2cfuns;
> > > > 
> > > > OK, I had imagined an anonymous call from its location in the array
> > > > (as
> > > > I wrote in the last phrase of my message). However, I thought that
> > > > it
> > > > could have been an improbable possibility, not a real one.
> > > > 
> > > > Linux uses a lot of interesting ideas that newcomers like me should
> > > > learn. Things here are trickier than they appear at first sight.
> > > 
> > > One trick would be to build the Smatch cross function database.
> > > 
> > > https://www.spinics.net/lists/smatch/msg00568.html
> > > 
> > > Then you could do:
> > > 
> > > $ ~/path/to/smatch_data/db/smdb.py led_blink_hdl
> > > file | caller | function | type | parameter | key | value |
> > > drivers/staging/rtl8723bs/core/rtw_cmd.c |       rtw_cmd_thread |
> > > rtw_cmd_thread ptr cmd_hdl |           INTERNAL | -1 |               
> > >  |
> > > uchar(*)(struct adapter*, uchar*)
> > > drivers/staging/rtl8188eu/core/rtw_cmd.c |       rtw_cmd_thread |
> > > rtw_cmd_thread ptr cmd_hdl |           INTERNAL | -1 |               
> > >  |
> > > uchar(*)(struct adapter*, uchar*)
> > > drivers/staging/rtl8188eu/core/rtw_cmd.c |       rtw_cmd_thread |
> > > rtw_cmd_thread ptr cmd_hdl |           BUF_SIZE |  1 |           
> > > pbuf |
> > > 1,4,6,8,12,14,16,19-20,23-24,48,740,884,892,900,960
> > > 
> > > 
> > > Which says that led_blink_hdl() is called as a function pointer
> > > called
> > > "cmd_hdl" from rtw_cmd_thread().
> > > 
> > > Hm...  It says it can be called from either rtw_cmd_thread() function
> > > (the rtl8723bs or rtl8188eu version) which is not ideal.  But also
> > > basically harmless so whatever...
> > > 
> > > regards,
> > > dan carpenter
> > 
> > Nice tool, thanks. I'll surely use it when it is needed to find out
> > which callers use a function pointer.
> > 
> > However I cannot see how it can help in this context. That function
> > *does* something, even if I cannot understand why someone needs a
> > function to test the initialization of a pointer. Furthermore it is
> > actually called by rtw_cmd_thread() (as you found out by using smatch)
> > that expect one of the two possible values that led_blink_hdl()
> > returns.
> > 
> > That said, what trick could I use for the purpose of getting rid of
> > that
> > function? At this point I'm not sure it could be made.
> 
> If you look at how this is called:
> 
> drivers/staging/rtl8723bs/core/rtw_cmd.c
>    449                  memcpy(pcmdbuf, pcmd->parmbuf, pcmd->cmdsz);
>    450
>    451                  if (pcmd->cmdcode < ARRAY_SIZE(wlancmds)) {
>    452                          cmd_hdl =
> wlancmds[pcmd->cmdcode].h2cfuns; 453
>    454                          if (cmd_hdl) {
>    455                                  ret = cmd_hdl(pcmd->padapter,
> pcmdbuf); ^^^^^^^
> 
>    456                                  pcmd->res = ret;
>    457                          }
>    458
>    459                          pcmdpriv->cmd_seq++;
>    460                  } else {
>    461                          pcmd->res = H2C_PARAMETERS_ERROR;
>    462                  }
>    463
>    464                  cmd_hdl = NULL;
> 
> The led_blink_hdl() function returns success if "pcmdbuf" is non-NULL
> and fail if it's NULL.  "pcmdbuf" is never supposed to be NULL.  (The
> "supposed" caveat is because there may be a race in rtw_sdio_if1_init()
> which briefly allows a NULL "pcmdbuf", but that is an unrelated bug).
> 
> Anyway, there is no point to the led_blink_hdl() function.  Likely
> they intended it to do something but never got around to implementing
> it.  Just delete it.
> 
> regards,
> dan carpenter
>
Fine. I'm about to submit a patch.

Is there any formal means to acknowledge (in the patch) your contribution 
to the resolution of this problem?

Regards,

Fabio



