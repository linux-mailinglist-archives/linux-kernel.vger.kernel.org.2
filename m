Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97693355542
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbhDFNen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbhDFNef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:34:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C21C06174A;
        Tue,  6 Apr 2021 06:34:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d12so22761744lfv.11;
        Tue, 06 Apr 2021 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jfELxhLa2jf8lj10pbubktTMfsQTY9avlQlTjAXXxHY=;
        b=knu2bNyKEuX1p5cvPzyMd3Ye7+sj1nuJ8dISCbzkJI5VnRKk4KzE2qF6GFI5+tgzKX
         0aoUntjS3KMf7MvPqwxGOKSPyn+gc49YEzGciDRsrAS2+CvBTueFLux9sUbMdbeuGpsU
         J53UYJOtAm3unB1WBl+jdNoCiConqRZiLHhwbjkJBzQUdRj97HbbpQMz7oAja/eocWoN
         T8DJJfOqLxsI/UE1rnfSEUBg5puPG11MdnTp/WeU984J2drSmkXbeewXogMNRpbbrQyH
         caF/93QoOkijk52Ij7iwMTpUk48YeaLSy60QUvlWfRnMVxoYeh07jQ438pw/Zmdye1Bx
         F6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jfELxhLa2jf8lj10pbubktTMfsQTY9avlQlTjAXXxHY=;
        b=iz2ux30yRY1qtpFxFoBhqX26Q4hfSjowoLak7hdQ940ZQuAF/Y7SVjYR24TYFmaQ5S
         gittbANVffCJxau2FDHbGJQHgmev7piFOUHQqn1q1xwMh6xkgWb1aeAQ9/eP3jeDiodE
         hx7j/tPsKReoGURIAxIjbXa6LeGrUapgJvzuuTtPUb3sVvUfyTuyT0KKvEecUMUUEMke
         AVS+8oL4JHWH0h+JFnoUYumS9aP8h9Uow98og94tKa3itdyxdJuG7jcspTy1IkcDUdxl
         f1SkkyD9en14JTbIRie5iS73oJmVlyighSvyTElxz3P7JEGzVV2WR9MT6loNexs803sC
         uFhA==
X-Gm-Message-State: AOAM531cENAZ/mZJ3PvkI+epl8u3yDmCNCr0Jbk2eYcGov5PP+a/wj45
        S2sCUEfzcSHhFNS+NmgRqubhU+DzGlA=
X-Google-Smtp-Source: ABdhPJyNNQx3yirCwBmkU20PgUiOqZScDo3PpPbHCSporh2uMB/Ym14zYpDJ/0Obk4uMEDdOh5HrPg==
X-Received: by 2002:a05:6512:3484:: with SMTP id v4mr20736878lfr.137.1617716064777;
        Tue, 06 Apr 2021 06:34:24 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id h10sm2157220lfc.266.2021.04.06.06.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 06:34:24 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 136DYLgT032012;
        Tue, 6 Apr 2021 16:34:22 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 136DYLZu032011;
        Tue, 6 Apr 2021 16:34:21 +0300
Date:   Tue, 6 Apr 2021 16:34:20 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Ernesto Corona <ernesto.corona@intel.com>,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v29 0/6] JTAG driver introduction
Message-ID: <20210406133420.GY10267@home.paul.comp>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
 <20210115104635.GA2971@home.paul.comp>
 <YGxgfFBUr6eHJ1Qi@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGxgfFBUr6eHJ1Qi@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy, 

On Tue, Apr 06, 2021 at 04:22:04PM +0300, Andy Shevchenko wrote:
> On Fri, Jan 15, 2021 at 01:46:35PM +0300, Paul Fertser wrote:
> > I have to note that the current v29 version of the series is broken in
> > several aspects:
> 
> Is it correct that this series is actually abandoned so far?

I have an e-mail from Ernesto sent on 10 Feb 2021 stating they're
going to continue the work.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
