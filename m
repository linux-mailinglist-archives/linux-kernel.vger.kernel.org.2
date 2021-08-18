Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA93F08E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhHRQSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:18:24 -0400
Received: from relay2.mymailcheap.com ([217.182.66.162]:44586 "EHLO
        relay2.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHRQSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:18:22 -0400
X-Greylist: delayed 7873 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Aug 2021 12:18:21 EDT
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 147043EDEC;
        Wed, 18 Aug 2021 18:17:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 5B3B22A0E2;
        Wed, 18 Aug 2021 12:17:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1629303464;
        bh=dXlIh5EcDgUrISWE28Be2K+p9CFZNPBwZmmKZa8jYUs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Dg/iAneMuRVZ1sj4oVuA2qBFuRkGDwGgmlbUZiKlyWcYetb5eipRsynxCIRYSNGhC
         ownDnaOkGFUmnkxWoVUWS99EtsqgEa4oW2K6cSYe3wa7Ey2dATpHdlprTLcoF0PALo
         giy5oqAnkOcq24Yi/5Smo55u4n4I/KIs7bzw8AVY=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xSOWq2qN6OZk; Wed, 18 Aug 2021 12:17:40 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 18 Aug 2021 12:17:35 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 32E624118B;
        Wed, 18 Aug 2021 16:17:34 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="oTLHwd1S";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.108])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id F12C74118B;
        Wed, 18 Aug 2021 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1629303448; bh=dXlIh5EcDgUrISWE28Be2K+p9CFZNPBwZmmKZa8jYUs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oTLHwd1ShtdiTmOPgoUw0/56MRCYPZ+UYd4VNrbierJiMtJVpggjSGcIcZ1JwRsb9
         0rAeOI0teJXUNziz2888Qa9T+NLa78G/3Fq6gQHVNtRvhHMZqN+v+EuqfYgkW2+ElL
         6paGOwXSEC959LsZ6Al4G7nfv859uHXmcRaMV7xQ=
Message-ID: <2d4fc6bac74691c4447ae33b99794389b089d42c.camel@aosc.io>
Subject: Re: [PATCH] usb: typec: tcpm: always rediscover when swapping DR
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Kyle Tso <kyletso@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 Aug 2021 00:17:19 +0800
In-Reply-To: <CAGZ6i=2a6ueLghhDTPCP_gumZ=HUYWRLCKkveyVnNQLgP+zyow@mail.gmail.com>
References: <20210813043131.833006-1-icenowy@aosc.io>
         <YRuDG78N2mB5w37p@kuha.fi.intel.com>
         <E91C97D0-7DB9-4455-AED2-4C25B7D2D22D@aosc.io>
         <YRuW0fENBEcIVkZb@kuha.fi.intel.com> <YR0Rlj+jk9dnoG6N@kroah.com>
         <E1804EE0-CBA1-4BE8-875B-57E82EDECDBE@aosc.io> <YR0bw+k0S94cmeDS@kroah.com>
         <CAGZ6i=2a6ueLghhDTPCP_gumZ=HUYWRLCKkveyVnNQLgP+zyow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 32E624118B
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [-0.10 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.108:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         RCPT_COUNT_FIVE(0.00)[6];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021-08-19星期四的 00:13 +0800，Kyle Tso写道：
> On Wed, Aug 18, 2021 at 10:40 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > 
> > On Wed, Aug 18, 2021 at 10:02:24PM +0800, Icenowy Zheng wrote:
> > > 
> > > 
> > > 于 2021年8月18日 GMT+08:00 下午9:56:38, Greg Kroah-Hartman < 
> > > gregkh@linuxfoundation.org> 写到:
> > > > On Tue, Aug 17, 2021 at 02:00:33PM +0300, Heikki Krogerus
> > > > wrote:
> > > > > > > Why is it necessary to do discovery with data role swap
> > > > > > > in general?
> > > > > > 
> > > > > > I think it could be possible for devices to expose
> > > > > > different altmode
> > > > > > with different role.
> > > > > 
> > > > > OK. FWIW:
> > > > > 
> > > > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > 
> > > > Is this conflicting with  
> > > > https://lore.kernel.org/r/20210816075449.2236547-1-kyletso@google.com
> > > >  ?
> > > > 
> > > > Which of these two should I take, both?  Neither?
> > > 
> > > Don't take this, it's against spec.
> > 
> > Ok, now dropped.  What about the linked patch above?  Does that
> > work for
> > you instead?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Icenowy,
> 
> Could you revisit the patch for the tcpm_unregister_altmodes part?
> I think that is still a problem.

Well I think it's okay, but I know none about PD3, and I have no PD3
device either.

So I prefer to continue on fix on dropping the discover sent on
snk_attach instead of working on this, because I know nothing about
this, and in my limited knowledge the code looks fine here.

> 
> thanks,
> Kyle

