Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746BA3B5F52
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhF1Nsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhF1Nsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:48:35 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3933BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 06:46:10 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id u8so5971975qvg.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YLjY2HPeHrW2AKKrzNFmn/uaX9GaI20ZwyzSp42lS6s=;
        b=WhnETFkZEy536EROapbDeZ0LxFDmr6KqUtSf3i6EgTImmRRktXTOU1Nal+CdnaVLC3
         9EVr6ygNYti8N6fpwAmBttT/uPPc6nZSqUOzAadU9/5/UAg95O7LcG49wSP5iBHS8dL1
         VMbfKw3qW0i933PFMs7H6gvYyiTqYdG722wkTGvmDhgv5uDHG838RwBQSWnW22qXzy/2
         qNw/Re1rKO2TegynSkV4mLQXzjUF3pys4OoaYZfMQ5c+6HnYBQ7Kak7iOLpz9e1fAo5o
         LuZMXnttoXT/CrZgWXgTsVOKfWmmfxDUriJ+0UgQ9777m0+lQoUe1he6wQELFC/nKozW
         nIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YLjY2HPeHrW2AKKrzNFmn/uaX9GaI20ZwyzSp42lS6s=;
        b=gcUAKRxEhzWktQARDpIiWtnl0J3CiMMn5e1K2oQlLv2U8QdOd8hwKo9+jbbHc0vynU
         NgCAMd3GRVMeUNyPsWTtLIE1KnEOpoj403SYT/xIJWxJQWMJ2KheACBwAQHS7TOcSEWc
         FlJ9zIk9igodD+uPnOKEPe3zmwQoyHs49D5uAe7tkSE6KV2rAsUFVC62RXbczeJyv4NV
         uHqAId3jGhYohYHEOTQ9xM1f3+b7ajLrbsxQjXsQKQXWFoeXKX/7EZ+k0UIBBK6iCUlT
         IPF8uQxZHKXOzJwN4xuhaPdDAezVJ3+MKXcXkHrBXgUtOP3qRK1PNpJXqatjOp3yK/TM
         zSIA==
X-Gm-Message-State: AOAM532hMIEeMikMnk44Rh7O1Uaxfj8kXOD6GCj4MuCPhxfPCPPHC54m
        WQGuvr38HNwqFI3Vf3s5E150sg==
X-Google-Smtp-Source: ABdhPJxpo1d1kF6W2aJ57QMxWFbsY6oSI2iiZLxvCaCK1Bp1R43XGmUnrB8/a+WrByJtBCFFrb/ZXQ==
X-Received: by 2002:a0c:f446:: with SMTP id h6mr25693593qvm.56.1624887969316;
        Mon, 28 Jun 2021 06:46:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id f203sm6150289qke.1.2021.06.28.06.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 06:46:08 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lxraR-000cFh-QA; Mon, 28 Jun 2021 10:46:07 -0300
Date:   Mon, 28 Jun 2021 10:46:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Benjamin LaHaise <ben@communityfibre.ca>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: linux-mm@kvack.org - limping on a backup
Message-ID: <20210628134607.GA4604@ziepe.ca>
References: <20210622145954.GA4058@kvack.org>
 <214c41fae1f1b148e5b04a58c1b018fb091d7e83.camel@HansenPartnership.com>
 <20210625171259.GG4058@kvack.org>
 <6f309c63f5b7be968ae679e81ab959db05681e8a.camel@HansenPartnership.com>
 <20210625192607.GH4058@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625192607.GH4058@kvack.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 03:26:07PM -0400, Benjamin LaHaise wrote:
> On Fri, Jun 25, 2021 at 12:21:24PM -0700, James Bottomley wrote:
> > On Fri, 2021-06-25 at 13:12 -0400, Benjamin LaHaise wrote:
> > > On Fri, Jun 25, 2021 at 10:00:15AM -0700, James Bottomley wrote:
> > > > Perhaps it's time to move this list over to vger or the linux.dev
> > > > infrastructure now that it's being brought up?  We already migrated
> > > > the containers list without too much pain.
> > > 
> > > Maybe the btrfs bugs should get fixed.
> > 
> > I believe we can do both.
> 
> If I were unresponsive at fixing issues, I would understand the need to
> migrate services, 

Well, the DKIM issue has been left unresolved for a long time.

I saw on the bug conversation there seems to be no clear path to fix
it?

The LF/vger lists don't have this problem. The amount of email
impacted via recipient spam filtering seems to be increasing every
month, and tools like b4 don't work as intended.

It is not some minor complaint.

Jason
