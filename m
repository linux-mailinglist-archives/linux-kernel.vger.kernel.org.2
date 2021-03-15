Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B0033ABC1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhCOGnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCOGmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:42:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5020C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 23:42:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u4so55127715lfs.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r2M9f8RfUfrnvbW1v5aCju4D/s1ORvZJ17QHD/9c+f0=;
        b=UevwSocks09HSQkjL2icW2diItlT0wsGAaigQ59blbG9NFGL+hOuGp5JMEPHSNFsIC
         Ry8AGFm4fiNnuoMPj6zH1DHKU/hbHJdg2QTpn+GqsiKhIccSX85HFZYl/QDrODQlY8SR
         Er1AaLAejV8YaMb7ZfxSu7vFKzUviAU2GFGMlJqRyaiYzc6iaO008tv550JEe4av7Z/o
         xBucgFiOgkhjKCfPlsHHzYvuHfTd7wvbbSUmUBzo6/0A5sxUzlGgGjqKfMvvaOHco88H
         89hcGA+45ukVVVLIwvYg1/6gaBDzEcYh3RAJJzP5XVD5Lp6DGGGVFnlIRxKS/FTP6uN7
         RJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r2M9f8RfUfrnvbW1v5aCju4D/s1ORvZJ17QHD/9c+f0=;
        b=WDyDFU5OqSKTKLDLTJP8uHf/KS9Sgihq3we9AOXspPm+QVv+pHfB7jZ67mrlt333rp
         DwGYJDAg9ynZ9icF04e9iIAk+K0wKvABXTy0x6lWCBcwa4qPQk4Oc9wkh9aJXHmHSAEg
         Z5USdTYslrw8rlVZAvZm4vycKpdl6VPpzfgUxAh6JNIwEOpIbsYldvpmYM3CSORd1dHE
         Guy+5oXXEGYreN899xPjnVzToh+TePi6eqveZnDrep39CKtqqlYFSu2K6e9jgqa/zXg+
         qu/EJyHVXAMcrl5hYW41sIFnKs9CI4a2gqtG4srqKu5aJut2W8tuA992dDAOSam1/eOa
         P31A==
X-Gm-Message-State: AOAM5322ywBx7P4MNUl32ibvWH8RPqdRtT1Uvcmp6FGjffKwZpiUiW1P
        xymxoTCZurcufyuim181Q5M=
X-Google-Smtp-Source: ABdhPJy67mfQt+AslL4ioSK6YolrpCj5nm1dQcCsMhoHjFSnYQQNnvm0FoFgheCngICHEeS6sjLm3w==
X-Received: by 2002:a19:c792:: with SMTP id x140mr6949244lff.215.1615790569221;
        Sun, 14 Mar 2021 23:42:49 -0700 (PDT)
Received: from grain.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id y3sm2569064lfg.6.2021.03.14.23.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 23:42:48 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 614AA5601FC; Mon, 15 Mar 2021 09:42:47 +0300 (MSK)
Date:   Mon, 15 Mar 2021 09:42:47 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: auxv stuff (Re: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack
 leak)
Message-ID: <YE8B52ET790Y/6WO@grain>
References: <YE53QiJuxsCUeoiu@localhost.localdomain>
 <CAHk-=wgMm=PG3uxfpmYpkX-GaDAR09pej=t3nD6hHDNCYCyaRQ@mail.gmail.com>
 <YE734MgE40jTv9zJ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE734MgE40jTv9zJ@localhost.localdomain>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 09:00:00AM +0300, Alexey Dobriyan wrote:
> On Sun, Mar 14, 2021 at 02:40:05PM -0700, Linus Torvalds wrote:
> > [mm->saved_auxv]
> > 
> > That's a separate issue, and I can't find it in myself to care (and
> > nobody has ever complained), but I thought I'd mention it.
> 
> There is another (non-security) one. Compat 32-bit process will report
> 2 longs too many:

Good catch! Alexey, should I address it? Or you have fixed it already?
