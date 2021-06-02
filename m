Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1967B397F4E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 05:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhFBDFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 23:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229541AbhFBDFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 23:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622603045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pfb3/XreVqFVNMLi7DKOXN/l9kZ+q5QcC5gJlzdZ+/0=;
        b=gS3hvZNeaqOBXAG6ib1yTmVXS228TrCNc8hPdGruviLKF32FrxNbJgRlMS65eDsp9ROQdk
        wjo8CPtJ0TQwi2cXkADrcKhv+aKWWkPG8WLtFxbaJRRZoo2dRE8KEESaKp9dh6bK2cW/Jo
        S48yicPDvx/YrH0pv/3bD0gPuEsbH1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-x4cRLKwLPL2Uxmuvdvs2xA-1; Tue, 01 Jun 2021 23:04:04 -0400
X-MC-Unique: x4cRLKwLPL2Uxmuvdvs2xA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AE6F501E3;
        Wed,  2 Jun 2021 03:04:03 +0000 (UTC)
Received: from localhost (ovpn-13-33.pek2.redhat.com [10.72.13.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9BAE5D764;
        Wed,  2 Jun 2021 03:03:55 +0000 (UTC)
Date:   Wed, 2 Jun 2021 11:03:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= 
        <k-hagio-ab@nec.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH V2 4/6] mm: rename the global section array to
 mem_sections
Message-ID: <20210602030353.GA409140@MiWiFi-R3L-srv>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-5-aisheng.dong@nxp.com>
 <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
 <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
 <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
 <20210601165246.99d7374d07661b7e91e49cb6@linux-foundation.org>
 <TYYPR01MB67775E2EC60DEE1195A49577DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYYPR01MB67775E2EC60DEE1195A49577DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/21 at 01:11am, HAGIO KAZUHITO(萩尾 一仁) wrote:
> -----Original Message-----
> > On Tue, 1 Jun 2021 10:40:09 +0200 David Hildenbrand <david@redhat.com> wrote:
> > 
> > > > Thanks, i explained the reason during my last reply.
> > > > Andrew has already picked this patch to -mm tree.
> > >
> > > Just because it's in Andrews tree doesn't mean it will end up upstream. ;)
> > >
> > > Anyhow, no really strong opinion, it's simply unnecessary code churn
> > > that makes bisecting harder without real value IMHO.
> > 
> > I think it's a good change - mem_sections refers to multiple instances
> > of a mem_section.  Churn is a pain, but that's the price we pay for more
> > readable code.  And for having screwed it up originally ;)
> 
> From a makedumpfile/crash-utility viewpoint, I don't deny kernel improvement
> and probably the change will not be hard for them to support, but I'd like
> you to remember that the tool users will need to update them for the change.

As VIM user, I can understand Aisheng's feeling on the mem_section
variable which has the same symbol name as its type. Meanwhile it does
cause makedumpfile/crash having to be changed accordingly.

Maybe we can carry it when any essential change is needed in both kernel
and makedumpfile/crash around it.

> 
> The situation where we need to update the tools for new kernels is usual, but
> there are not many cases that they cannot even start session, and this change

By the way, Kazu, about a case starting session, could you be more specific
or rephrase? I may not get it clearly. Thanks.

> will cause it.  Personally I wonder the change is worth forcing users to update
> them.
> 
> Thanks,
> Kazu
> 

