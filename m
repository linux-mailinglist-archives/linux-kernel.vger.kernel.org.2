Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEADE3B4A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 23:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFYVyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 17:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYVyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:54:38 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288B1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:52:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C7B3F1280628;
        Fri, 25 Jun 2021 14:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1624657935;
        bh=iSPvQ9PAdf4qiRHNLyPjzuZP7EMRERPpy7Em/wYsrIA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=c4DdtP2GL+4SaGffgxiOO9WZMa53QJaSbZBeGHvOM8pH4fiXsfJ9JM/aO/7M8rJcZ
         2+LeJAgI6kJo9USlmjTyctw3M8mn8C5f+I629Hc2xihBqERLzBi9XS2jQF2y+nLEVZ
         s/S3yVWARBeyyuID/uOpispHWAbC3OmFKLBT9I8s=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pvschF1YvNIG; Fri, 25 Jun 2021 14:52:15 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 731731280627;
        Fri, 25 Jun 2021 14:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1624657935;
        bh=iSPvQ9PAdf4qiRHNLyPjzuZP7EMRERPpy7Em/wYsrIA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=c4DdtP2GL+4SaGffgxiOO9WZMa53QJaSbZBeGHvOM8pH4fiXsfJ9JM/aO/7M8rJcZ
         2+LeJAgI6kJo9USlmjTyctw3M8mn8C5f+I629Hc2xihBqERLzBi9XS2jQF2y+nLEVZ
         s/S3yVWARBeyyuID/uOpispHWAbC3OmFKLBT9I8s=
Message-ID: <4d515a65c6ce9ef182cab4f2dff08979d58cf7e6.camel@HansenPartnership.com>
Subject: Re: linux-mm@kvack.org - limping on a backup
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Benjamin LaHaise <ben@communityfibre.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Jun 2021 14:52:13 -0700
In-Reply-To: <20210625192607.GH4058@kvack.org>
References: <20210622145954.GA4058@kvack.org>
         <214c41fae1f1b148e5b04a58c1b018fb091d7e83.camel@HansenPartnership.com>
         <20210625171259.GG4058@kvack.org>
         <6f309c63f5b7be968ae679e81ab959db05681e8a.camel@HansenPartnership.com>
         <20210625192607.GH4058@kvack.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-06-25 at 15:26 -0400, Benjamin LaHaise wrote:
> On Fri, Jun 25, 2021 at 12:21:24PM -0700, James Bottomley wrote:
> > On Fri, 2021-06-25 at 13:12 -0400, Benjamin LaHaise wrote:
> > > On Fri, Jun 25, 2021 at 10:00:15AM -0700, James Bottomley wrote:
> > > > Perhaps it's time to move this list over to vger or the
> > > > linux.dev infrastructure now that it's being brought up?  We
> > > > already migrated the containers list without too much pain.
> > > 
> > > Maybe the btrfs bugs should get fixed.
> > 
> > I believe we can do both.
> 
> If I were unresponsive at fixing issues, I would understand the need
> to migrate services, but steps to address the failures have already
> been taken and additional mitigations are planned.  If we migrated
> services every time a piece of hardware failed or we hit a kernel
> bug, then we wouldn't have any infrastructure left.

It's not about response time, it's about the fact that we finally got
kerne.org funded via the LF to pay for someone to run our mailing list 
infrastructure so we no longer have to do it ourselves.  We've already
transferred the containers mailman list and vger is going to be
migrated to it soon.  The new infrastructure comes with HA and a whole
host of backend CDN data centres in various geographies and public
inbox backing, so it should be quite slick.

James


