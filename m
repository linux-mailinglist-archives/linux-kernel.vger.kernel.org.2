Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C42414163
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhIVF4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232467AbhIVF4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:56:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8006161100;
        Wed, 22 Sep 2021 05:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632290104;
        bh=fqOx+5HG3EUzbxzj2g+XQRB+FT+VPlXaUP3m8k56SZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFwh9TxAhbgi9duNeEa4Lp8jcJgXa+7P6Cv6zvupcAykSsSIVWS2f0dEtRq3ynewY
         Zsx34yCeIGbjTsb0e1qVYc6pG1AFUaoAjMJL4/dIGS1Y9Ii9ey0Z9/T2TW/QINATu6
         XI7GSLuyx9IbdkCctA7Y4rfplBKQ9IYKHFhSJY54=
Date:   Wed, 22 Sep 2021 07:55:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     "andraprs@amazon.com" <andraprs@amazon.com>,
        "lexnv@amazon.com" <lexnv@amazon.com>,
        "alcioa@amazon.com" <alcioa@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "kamal@canonical.com" <kamal@canonical.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "ne-devel-upstream@amazon.com" <ne-devel-upstream@amazon.com>
Subject: Re: [PATCH v2 3/4] nitro_enclaves: add test framework for the misc
 functionality
Message-ID: <YUrFNTQFnFMTVvnm@kroah.com>
References: <20210921151039.1502-1-longpeng2@huawei.com>
 <20210921151039.1502-4-longpeng2@huawei.com>
 <YUn4WTDbU72tcyNY@kroah.com>
 <511306b230ed4347a4ba3a2f4d5d4e64@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <511306b230ed4347a4ba3a2f4d5d4e64@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 12:33:19AM +0000, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Tuesday, September 21, 2021 11:21 PM
> > To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
> > <longpeng2@huawei.com>
> > Cc: andraprs@amazon.com; lexnv@amazon.com; alcioa@amazon.com;
> > linux-kernel@vger.kernel.org; Gonglei (Arei) <arei.gonglei@huawei.com>;
> > kamal@canonical.com; pbonzini@redhat.com; sgarzare@redhat.com;
> > stefanha@redhat.com; vkuznets@redhat.com; ne-devel-upstream@amazon.com
> > Subject: Re: [PATCH v2 3/4] nitro_enclaves: add test framework for the misc
> > functionality
> > 
> > On Tue, Sep 21, 2021 at 11:10:38PM +0800, Longpeng(Mike) wrote:
> > > Add test framework for the misc functionality.
> > 
> > What is "the misc functionality"?
> > 
> 
> The functionalities provided in the ne_misc_dev.c

You need to be more verbose here in this commit message please, so that
everyone can properly understand what is going on.

> 
> > >
> > > Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> > > ---
> > >  drivers/virt/nitro_enclaves/Kconfig        |  8 ++++++++
> > >  drivers/virt/nitro_enclaves/ne_misc_dev.c  | 27
> > +++++++++++++++++++++++++++
> > >  drivers/virt/nitro_enclaves/ne_misc_test.c | 17 +++++++++++++++++
> > >  3 files changed, 52 insertions(+)
> > >  create mode 100644 drivers/virt/nitro_enclaves/ne_misc_test.c
> > 
> > What changed from v1?
> > 
> 
> The unit tests are new added in v2, described in the cover letter.

Ah, the cover letter showed up _after_ these commits did :(

thanks,

greg k-h
