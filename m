Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACABA3F3F90
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 15:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhHVNu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 09:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhHVNu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 09:50:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA65C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:50:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h9so31002973ejs.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQIUFuaVnDeSqO5NxIP0mR+YO1SRXJL+8IshgCg+5aI=;
        b=TvnjKkmP8IaRHcpgeQ1T1hA7eRiZUfz23jqoMrjw2VX9wHqcdzxPC1V8lMu7onSv/s
         JN0EoUEGmpDCHPDonPwYROz2zSc7MbeGMl4HtsZpUygEF6cElVBBl65UkrxUd9N6/56V
         5BFEKi9n1+lhDHNU5DMKckfCGkmzzY2vB6djZUXgBIO6ZMFkjKSw8vwCDnciruiN/3Aq
         nzPgH30jLWre3KPLW6DY/zZXtsla/XLp+mqieS/sji0oVQWaaWn4XwI3Y9JwIc9bxUVF
         KTIQvqeW+6MKe6cNUcFZom2N7k0Tot7p7OFUXxD7plUR1pXsKiFDSndRD9ycI71vWx/2
         74vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQIUFuaVnDeSqO5NxIP0mR+YO1SRXJL+8IshgCg+5aI=;
        b=eaeOHA2VhQoAnfABvZ3VuxtaMqiBMJdz1DfPDGLCGbU7iFKUFLGvDGb2rSrFLpgHJv
         3y+gspbxEC5+7SCeL3vdz+G3aFwczlROoFZBFSDNDd22Cgo5mYd6w1rg5nYo38rHCqmG
         VcI/TptMwPo2xUdj8lfL11WAWypzjhQDyz0UrU6hqxRM+1mpcSGjooQwBtiV3pvG5nxZ
         +rb/agD070zAc/v34f0ppKZRlG4QNploTPwjQRY0WL8C+L2ZsjZjBSx98I6aXJCKcF4P
         ryIqp57mVaL7Qxk9irD7gCkPM7Ojlm+lmF+m67fTPwAy1OKMBSXqKZNOSue8EnDfvXhF
         8B+w==
X-Gm-Message-State: AOAM533sutnMJjW8xnV79qx9un3NTQzh5i4FWyqA1WlUBe2Qn6NXrnFp
        0UbzgrFMKOKvcjsV2/nRLVg=
X-Google-Smtp-Source: ABdhPJyizlZ8ZfPmcwFhcRXR0KO/lufiQd0oKfblYOYqFB8aFAWm/dbIQsEWRhBFvNgWAwwW4DtsYg==
X-Received: by 2002:a17:906:70b:: with SMTP id y11mr8123986ejb.274.1629640215918;
        Sun, 22 Aug 2021 06:50:15 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id n16sm7283360edv.73.2021.08.22.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 06:50:15 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: TODO list for staging/r8188eu
Date:   Sun, 22 Aug 2021 15:50:14 +0200
Message-ID: <2099975.VbY6Rib6K3@localhost.localdomain>
In-Reply-To: <YSJE6aoH96kh777R@kroah.com>
References: <1897566.d8lQ4HMSh1@localhost.localdomain> <YSJE6aoH96kh777R@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 22, 2021 2:36:57 PM CEST Greg Kroah-Hartman wrote:
> On Sun, Aug 22, 2021 at 09:41:20AM +0200, Fabio M. De Francesco wrote:
> > Dear Larry, Philip,
> > 
> > >From what I understand how the development process works, drivers in 
staging
> > 
> > should have a to-do list in the TODO file. Please read https://
www.kernel.org/
> > doc/html/latest/process/2.Process.html?highlight=todo#staging-trees.
> > 
> > Could you (as the maintainers of the r8188eu driver) please compile and
> > provide the above mentioned list?
> 
> Why don't you provide an initial list for people to work off of if you
> feel it is needed here?
> 
> thanks,
> 
> greg k-h

Unfortunately I'm not able to tell what is needed to do to have a driver 
improved so that it can be moved off staging. This work should be better 
addressed by someone who is much more experienced.

For example, I read from other drivers TODO lists that cfg80211 and lib80211 
are required but I don't know what they are.

Regards,

Fabio



