Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C23380F63
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhENSGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhENSGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:06:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D40C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:04:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h16so334564pfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NidPUCUgpxhlJmFSoQiTlrvVc3ediNgl08rsd7mdBZo=;
        b=FHYmYSkjd7B0MovdrbAK5NoFWijOX6nZQv7QppAJiV97r2Bz9HHAwnn4HKRZkGUZ7i
         yu6185Kdyf/n0Ko4cIMfH2FPvKRutAFZx+9y3J56qPjsAbnEzaV3e84Jtx02zH7bdqco
         e1jvzpIToJr0n9jALa6feCsajd37bOT1HTsRLqPsnGmgBWDldy7hdEthLYFJi+KfGe0m
         Zhs/9s90ihOVdN1x5Rv8pCYeZkgf6ho6ojaVV2KhGNBvDr2Lo+9G4e+znNn71dfJJ5bd
         71bCoWhtqn6R6hDXnXqNpIy2lhImzdNZVyGXHbYpnvD1uxOd1Qv33Bk3CCzMTSiTZTm1
         Yn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NidPUCUgpxhlJmFSoQiTlrvVc3ediNgl08rsd7mdBZo=;
        b=bsvsXy22cSyHenqaYl52bV/1t+oMrwoNdG8AImrj7fkpNTsXqaHTJmqymKVOkZGc8E
         fjXy4YoISAVBaUFOGPvs5VjvCVqWQV5J/YT3d58niZnq1UsXmEnJcOHERR//9Uq39ecj
         Z6i8/FtI123H1MdfGULda5N2BA/IBbXViAG7g6GJt69m3opLeQg5e0PS+uO7GuFrSwxp
         5Ug1tz25lgFEElQ0BGX+7jklgOMOTYDFfT5SdE8SwEGdEhU+eMcySLZ1NIOFi997w8Wd
         G83vMXWugWyTXwyjdN9wM584nNnl5TDxHiSujCknGU0Re511i60hVIOPoD4uAx3mr0uV
         qdLQ==
X-Gm-Message-State: AOAM533uHqtP94IcQcE5Edl7wOToCY4jMJH9jfET+aXW+iRN34ntNUei
        KkzIsytNcGO7y15umQxi0No=
X-Google-Smtp-Source: ABdhPJwmB0kmfhZehu/YE85BQFDOZz9b2Ah6NEuJUNp/9i/wKInodznINo/8UvK1H3FC3rCdhVHIYA==
X-Received: by 2002:aa7:800a:0:b029:250:c8c5:64b3 with SMTP id j10-20020aa7800a0000b0290250c8c564b3mr46593179pfi.23.1621015494534;
        Fri, 14 May 2021 11:04:54 -0700 (PDT)
Received: from fedora ([2405:201:6008:61b4:4e16:5348:d963:c66d])
        by smtp.gmail.com with ESMTPSA id y13sm4473014pff.163.2021.05.14.11.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:04:53 -0700 (PDT)
Date:   Fri, 14 May 2021 23:34:48 +0530
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, pure.logic@nexus-software.ie,
        johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix gb_loopback_stats_attrs definition
Message-ID: <YJ67wCBVnI21YbUc@fedora>
References: <20210514133039.304760-1-chouhan.shreyansh630@gmail.com>
 <YJ582f3O9K9YD3QA@kroah.com>
 <YJ5/tqFfcjxOLsF0@fedora>
 <YJ6DrLiMsdkG5loA@kroah.com>
 <YJ6H/WsojYcN/bLO@fedora>
 <YJ6Jf+Z1ReVgDt64@kroah.com>
 <YJ6TUAowTI75h/sl@fedora>
 <YJ6XpUMliWQOS8MB@kroah.com>
 <bccbec1a0ffbf6c31b5e6a78cedd78cd64f2b8fe.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bccbec1a0ffbf6c31b5e6a78cedd78cd64f2b8fe.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 08:56:10AM -0700, Joe Perches wrote:
> On Fri, 2021-05-14 at 17:30 +0200, Greg KH wrote:
> > On Fri, May 14, 2021 at 08:42:16PM +0530, Shreyansh Chouhan wrote:
> []
> > > I didn't look at how/where was the macro called and missed a very
> > > obvious error. Now that I have looked at it, the only way I can think of
> > > fixing this is changing the macro to a (inline?) function. Will
> > > that be a desirable change?
> > 
> > No, it can't be a function, the code is fine as-is, checkpatch is just a
> > perl script and does not always know what needs to be done.
> 
> true.
> 
> perhaps better though to rename these declaring macros to start with declare_
> 
> Something like this:
> 

Can I mention you in the 'Suggested-by' tag for the commit? (Since you
suggested the idea for this patch.)

Regards,
Shreyansh Chouhan
