Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F843FEFB9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345681AbhIBOxQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Sep 2021 10:53:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:43819 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345637AbhIBOxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:53:14 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-35-e_78ceilNiO6G38l3rSPfg-1; Thu, 02 Sep 2021 15:52:13 +0100
X-MC-Unique: e_78ceilNiO6G38l3rSPfg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 2 Sep 2021 15:52:12 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 2 Sep 2021 15:52:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michal Hocko' <mhocko@suse.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: RE: [RFC PATCH 1/1] mm: provide one common K(x) macro
Thread-Topic: [RFC PATCH 1/1] mm: provide one common K(x) macro
Thread-Index: AQHXnyIP1W4iwzBh3EWPGmS1HjslO6uQ1R3w
Date:   Thu, 2 Sep 2021 14:52:12 +0000
Message-ID: <986271f68d114a7daeacae620e3a6fdf@AcuMS.aculab.com>
References: <20210901092149.994791-1-oleksandr@natalenko.name>
 <20210901092149.994791-2-oleksandr@natalenko.name>
 <YS9WiF6enhSo8sYc@dhcp22.suse.cz> <5529272.KFOknHQvy8@natalenko.name>
 <YS9fxXSl5vhs5a+X@dhcp22.suse.cz>
In-Reply-To: <YS9fxXSl5vhs5a+X@dhcp22.suse.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko
> Sent: 01 September 2021 12:11
> 
> On Wed 01-09-21 12:50:40, Oleksandr Natalenko wrote:
> [...]
> > ```
> > 31 files changed, 104 insertions(+), 90 deletions(-)
> > ```
> >
> > which is not that horrible.
> 
> Still a lot of churn to my taste for something that is likely a matter
> of personal preferences and taste. Consider additional costs as well.
> E.g. go over additional git blame steps to learn why the code has been
> introduced, review bandwith etc...

Not to mention the time taken by someone scan-reading the
code who has to go and find the definition of K() just
to see what it does.

A more descriptive name (eg PAGES_TO_KB) might save that.
but is it worth it?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

