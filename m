Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538673F3AB8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 15:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhHUNCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 09:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhHUNCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 09:02:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF83C061575;
        Sat, 21 Aug 2021 06:01:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso10837248wmb.2;
        Sat, 21 Aug 2021 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n/mrY+Fw4tkyYXg1XSmwKy3Qj/mLk2iv4AZLAJZUqnc=;
        b=BabYfIFnyyIN8h1KycGYsEMErP/3PYqb44WHfMvg7f3Q4l9JCwkcsrxpDemAH80e+D
         SGOEQGZ/QUW9atpBqtLZn+qpjOXgZBRKmoN/O732mVt4z8UN7MD5rvlr18CnYP/PtLQB
         VDjkc3ZrmAflHzan1oLNohT4Iy2aECm+dww0VXG0gV2EWMnO+05G+vHUetyjKt18CC56
         7AtbYHDLGVilCJCthRg0kfUHy9x09rh+pCXL2LcGPTpWwLXd5QM7xNZ9rf7RZqa1ixsf
         cqWtXQCXI3BHCm/50vTVIpbUx0M4y22MaPdq3U6DadIX7Aa/0HAANgNxDmdXKV3WCaLL
         P7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=n/mrY+Fw4tkyYXg1XSmwKy3Qj/mLk2iv4AZLAJZUqnc=;
        b=X5xAnWJMBZe3/ARkPLN/MWbiHT8buOf7gM9FAXJN+trMPjNAjhb8/48tI64ym4Jkww
         Fkg2XgLkCWm0DEA+n651wYFqRGpl3NMspX/EfVRxnbXro0yIE2sAj5DeUoZ1+YUt8xoL
         peazHTZ101fn1iXsR7F4AKZVKY6Fv8abFi+IZPt3qNWcTimDy2nauLsngfOxlFdlPR+D
         QdmNPDx8Iob3QYApF/4H8xfe7tbH5584houb0emFUZF0bTfr88EYQvDZTPUUnW5VQvmz
         /qDyxDwYFrjkhn442XeryDO6sUnPfWSTMsYQkKK6bEtFDvXhGkxjjDirxf6jKVP1/AIY
         SwjA==
X-Gm-Message-State: AOAM531NYk588jcPtds60ekE1aQ+CapVIahEAMJe3+sNzUkiSn7bhhYx
        FdFVNvgDOW9sbnhO5J+pqhk=
X-Google-Smtp-Source: ABdhPJxvUAGq5e5EyEndXMk9nmAgi6fUXNCaK1AXmFMOGSGveHDLXN/8sxG3FG9ebogDrsTMmXf7yA==
X-Received: by 2002:a05:600c:358c:: with SMTP id p12mr8058594wmq.173.1629550888465;
        Sat, 21 Aug 2021 06:01:28 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id c8sm8890359wrx.53.2021.08.21.06.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 06:01:27 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sat, 21 Aug 2021 15:01:26 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>,
        linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Benjamin Berg <bberg@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ian Turner <vectro@vectro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 0/2] UCSI race condition resulting in wrong port state
Message-ID: <YSD5JlFfAGyq5Fpk@eldamar.lan>
References: <20201009144047.505957-1-benjamin@sipsolutions.net>
 <20201028091043.GC1947336@kroah.com>
 <20201106104725.GC2785199@kroah.com>
 <YR+nwZtz9CQuyTn+@lorien.valinor.li>
 <YSDtCea3a9cuaEG3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSDtCea3a9cuaEG3@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sat, Aug 21, 2021 at 02:09:45PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 20, 2021 at 03:01:53PM +0200, Salvatore Bonaccorso wrote:
> > Hi Greg,
> > 
> > On Fri, Nov 06, 2020 at 11:47:25AM +0100, Greg Kroah-Hartman wrote:
> 
> Note, you are responding to an email from a very long time ago...

Yeah, was sort of purpose :) (to try to retain the original context of
the question of if the commits should be backported to stable series,
which back then had no need raised)
> 
> > > Due to the lack of response, I guess they don't need to go to any stable
> > > kernel, so will queue them up for 5.11-rc1.
> > 
> > At least one user in Debian (https://bugs.debian.org/992004) would be
> > happy to have those backported as well to the 5.10.y series (which we
> > will pick up).
> > 
> > So if Benjamin ack's this, this would be great to have in 5.10.y.
> 
> What are the git commit ids?  Just ask for them to be applied to stable
> like normal...

Right, aplogies. The two commits were
47ea2929d58c35598e681212311d35b240c373ce and
217504a055325fe76ec1142aa15f14d3db77f94f.

47ea2929d58c ("usb: typec: ucsi: acpi: Always decode connector change information")
217504a05532 ("usb: typec: ucsi: Work around PPM losing change information")

and in the followup Benjamin Berg mentioned to pick as well

8c9b3caab3ac26db1da00b8117901640c55a69dd

8c9b3caab3ac ("usb: typec: ucsi: Clear pending after acking connector change"

a related fix later on.

Regards,
Salvatore
