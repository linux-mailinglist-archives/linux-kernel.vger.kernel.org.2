Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047A331A18E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhBLPXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhBLPTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:19:17 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D213C061574;
        Fri, 12 Feb 2021 07:18:37 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id k10so8688710otl.2;
        Fri, 12 Feb 2021 07:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJSi3uIsnP1NF42ZthmkocG9MIg4snJ5/E3aqfDTg1A=;
        b=rcTg62QsOh0ugTinJH4hnbb6mVvib2Ml/lugUiAAutipD9hT57AxzYFOtyeNQRieoT
         HMn2hKofvwUesEwrt2jmHV3yQJWRXqCPQOkIDfy0V9wkgQQocqDsW2enRStt6Sx9ADIt
         xgA8+R7q0pGT6o+iCHFElv306/UHjy1uJESOc9fvzXFX1TOcmWnSPzwh3dtD2tNUq9ul
         rjOxaQIOLDByOyAAYp7ssiIkFi8KBj/5o+2hMaRoRuPF+Z6N3mhyfUqF4yAXP6msDpHI
         lSPDBuFCiTDO1PhR6f9JphdZm0NHcIKBaZdBgr4y2fNNwtni863lm4vsHGPLrHBP6isI
         RkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJSi3uIsnP1NF42ZthmkocG9MIg4snJ5/E3aqfDTg1A=;
        b=Hc5dSYE2QCItENEdQmoG/HAoD+DW/JU602SgOy5d0FZ1PlPf0qJfg1V/L2xL+4ZeCr
         HGeCZU6ekSxsYYL+nH4IfAu0BhOlVVe7KMahF21GSgBHQRuYNJtJllZ+ZZhxJaBuafPc
         C+h9sPreN9uCJthfjuVVegUGAaIVFDPA9qhEIgX29nVuiq8At9bjeeUdIigPMw1O8Bn4
         +L2Nal59SsHl+DiI6kKBdm4ntfKQk7zhPGFQE6lH2wu1xn+aN6SD19/J9cDjbXIfTXMf
         rAPX+23FsA/8S6jNw01H01Wfv4IqpOidQ9EvVOJc9rTWo/9K6fLS8fVnNFkpEXAAwDI9
         ewVw==
X-Gm-Message-State: AOAM530hxxx2SS4tPclCKocmboisxMCtBpr2y4sx9hYLaDdqQe/I6fE4
        f8vI/xVrlj0BmnvGlVcE9b5yASO/Vg8=
X-Google-Smtp-Source: ABdhPJy+Y0ggbcrV3wUSoSBHWRffKWs2pgL6hiw9x07TjoqMcsXl3yfTOMvcmv6SiSjsXovUikGNKw==
X-Received: by 2002:a9d:7dd3:: with SMTP id k19mr2310986otn.162.1613143116996;
        Fri, 12 Feb 2021 07:18:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p20sm1577429oos.46.2021.02.12.07.18.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Feb 2021 07:18:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 12 Feb 2021 07:18:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 3/7] usb: typec: tcpm: Determine common SVDM Version
Message-ID: <20210212151835.GB57042@roeck-us.net>
References: <20210205033415.3320439-1-kyletso@google.com>
 <20210205033415.3320439-4-kyletso@google.com>
 <20210212041756.GC103223@roeck-us.net>
 <CAGZ6i=2LfU16K7HHVOwVsHvxpL3rQtVhnabScAReqT9cY3HWyw@mail.gmail.com>
 <CAGZ6i=1BWi+9KiBJrEmOTin-yLhgDCVuksZNiFoxHM24bwnqSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ6i=1BWi+9KiBJrEmOTin-yLhgDCVuksZNiFoxHM24bwnqSA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 03:24:22PM +0800, Kyle Tso wrote:
> On Fri, Feb 12, 2021 at 3:10 PM Kyle Tso <kyletso@google.com> wrote:
> 
> > Unless every time the local variable "svdm_version" is updated when
> > "typec_partner_set_svdm_version" is called.
> >
> 
> I can do that if it is clearer to do so.
> It just needs two additional lines.
> 

Don't bother; I don't want to hold up that series any further.

Guenter
