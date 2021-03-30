Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9A34E650
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhC3LXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:23:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2745 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhC3LXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:23:35 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F8n4v0dXXz684Tv;
        Tue, 30 Mar 2021 19:18:39 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 30 Mar 2021 13:23:33 +0200
Received: from localhost (10.47.27.39) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 30 Mar
 2021 12:23:32 +0100
Date:   Tue, 30 Mar 2021 12:22:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <lukasz.luba@arm.com>,
        <james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
        <etienne.carriere@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Guru Nagarajan <gurunagarajan@google.com>,
        Enrico Granata <egranata@google.com>
Subject: Re: [PATCH v7 25/38] iio/scmi: port driver to the new
 scmi_sensor_proto_ops interface
Message-ID: <20210330122213.000075d3@Huawei.com>
In-Reply-To: <20210323094828.ldtlzkgd3zc7rlml@bogus>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
        <20210316124903.35011-26-cristian.marussi@arm.com>
        <CA+=V6c08cVmsCV_sDn5CogzbyN5KyNKL=u+WkAE0cPz2fqPhjQ@mail.gmail.com>
        <20210316222132.GA6875@e120937-lin>
        <CA+=V6c1=hWbF1_5wL7nMDK_CXqDVmgDXWvJjUC-XqZRGGewafA@mail.gmail.com>
        <20210318121202.6xf2lqm7udqvla24@bogus>
        <20210323094828.ldtlzkgd3zc7rlml@bogus>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.39]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 09:48:28 +0000
Sudeep Holla <sudeep.holla@arm.com> wrote:

> Hi Jonathan,
> 
> On Thu, Mar 18, 2021 at 12:12:02PM +0000, Sudeep Holla wrote:
> > On Tue, Mar 16, 2021 at 10:38:43PM -0700, Jyoti Bhayana wrote:  
> > > Hi Christian,
> > > 
> > > Thanks for the detailed explanation. Sounds good to me.
> > >   
> > 
> > Can I get official Reviewed-by or Acked-by please if you are fine with the
> > change ?
> >   
> 
> I need your ack to this via arm-soc.
> 
Sorry, missed it until now as wasn't cc'd to linux-iio@vger.kernel.org so
my filters didn't sweep it to the right place and it got lost in the flood.

Will take a look now.

Jonathan

