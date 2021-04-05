Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46794354225
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 14:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbhDEMn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 08:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbhDEMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 08:43:26 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2856FC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 05:43:18 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id u3so3203437qvj.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 05:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=27LE2Ab+DwuXiCctANbrfB/R0MKC/0shhR8iWWbc1qw=;
        b=iYfmtsbUb2utwv4OERkYS3rcPIUtA6maeVENLlTMIHyWOwPLhiVsscFxbRss+7bgmU
         ybqymjgr+ZKuT07vNQD+A/qXCoIDsaVEweDYw7Z2BIgGVbEFdanY6q4qKkB+cax2Hnrg
         vJmt+e8MaISX/QuM+EyOzFU4sgayR8EBNcDLkW457cijLKuGBZa3W+7HOnsxGXvGY5Wl
         dUwtJXBpckYvQb2XuDl6qidg/Jqb/luIncyfC9MiCICM2gDgncinPNHjuraTOrRPGdSZ
         jHWE6rN9VjnBepF9OY8J+zpE2DI9ajarDWJh1S5uzkDsiatgIStkPcorNLoAn7s5nLeY
         3klQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=27LE2Ab+DwuXiCctANbrfB/R0MKC/0shhR8iWWbc1qw=;
        b=aq7iWVQp8PkgI6TIz5xR0j38n2fzzoQUXMGsdYeTY9EL30MJyPnuSFktgOzzxTKaXQ
         aMSSzKeyqqY63ZeiIZ7og9RRjiLxwYbW+NUx5UAr6YJ1CHyC5BCEZ0WzTYhSQrp01oUw
         ICk8Vglu+SuqDS87C8epnttRkEcheQ/a/wsL3KhSW1EAcWLOHqN/6tye35MzJhRG4Fpy
         q+AZfJIPsyZ+G01CQorsRshjbq3wRInHyE0tKcfqcqupU3anXePbXS7cycmelNsNtebY
         hgCPRkcj8W6gmBs+gmkEQO6v0/AzDkDTP8kistNOzUc+dlaQZ8lNfXwH2tGTUROLgP1v
         I+uQ==
X-Gm-Message-State: AOAM531sb84VrVOcd74GibCXiR2+NI6LXhV+oCKyJ4iL7/mKgoODiZyy
        O2g8xMvp/WhFVHn1wJ+Y41s=
X-Google-Smtp-Source: ABdhPJwKvm/UYnL6pBW3vZkg4yd1Zd3nttNg6BJUBM2CvLIXfnrmL5YVNASx0vb8Z6rnQeZcarl+EA==
X-Received: by 2002:a05:6214:164e:: with SMTP id f14mr9341356qvw.60.1617626597402;
        Mon, 05 Apr 2021 05:43:17 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8167:5000:d94c:b1e1:5a07:101c])
        by smtp.gmail.com with ESMTPSA id 184sm13452991qki.97.2021.04.05.05.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 05:43:17 -0700 (PDT)
Date:   Mon, 5 Apr 2021 09:44:01 -0300
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zbr@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 9/9] w1: ds2438: support for writing to offset register
Message-ID: <20210405124401.mvkoxs2girygv7f2@LuizSampaio-PC.localdomain>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
 <20210405105009.420924-10-sampaio.ime@gmail.com>
 <YGru2+hI6fgE/v3J@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGru2+hI6fgE/v3J@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 01:04:59PM +0200, Greg KH wrote:
> On Mon, Apr 05, 2021 at 07:50:09AM -0300, Luiz Sampaio wrote:
> > Added a sysfs entry to support writing to the offset register on page1.
> > This register is used to calibrate the chip canceling offset errors in the
> > current ADC. This means that, over time, reading the IAD register will not
> > return the correct current measurement, it will have an offset. Writing to
> > the offset register if the two's complement of the current register while
> > passing zero current to the load will calibrate the measurements. This
> > change was tested on real hardware and it was able to calibrate the chip
> > correctly.
> > 
> > Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
> > ---
> >  Documentation/w1/slaves/w1_ds2438.rst | 11 +++++-
> >  drivers/w1/slaves/w1_ds2438.c         | 49 +++++++++++++++++++++++++++
> >  2 files changed, 59 insertions(+), 1 deletion(-)
> 
> In this, and the previous patch, you added new sysfs files, but no
> update to Documentation/ABI/ for them.  Please fix that up.
> 
> thanks,
> 
> greg k-h

Hello! I'm sorry about some errors, this is my first patch and I'm not sure about some things in the documentation. I really appreciate the responses and guidance.
The file I need to add to Documentation/ABI/ is going to be in testing or stable? And the file I need to create can be called, for instance, sysfs-driver-w1_ds2438?

Thanks!
