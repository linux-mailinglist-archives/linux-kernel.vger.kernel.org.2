Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172F8345B54
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhCWJs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:48:58 -0400
Received: from foss.arm.com ([217.140.110.172]:43022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhCWJsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:48:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81BB91042;
        Tue, 23 Mar 2021 02:48:32 -0700 (PDT)
Received: from bogus (unknown [10.57.54.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8204F3F719;
        Tue, 23 Mar 2021 02:48:30 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:48:28 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Guru Nagarajan <gurunagarajan@google.com>,
        Enrico Granata <egranata@google.com>
Subject: Re: [PATCH v7 25/38] iio/scmi: port driver to the new
 scmi_sensor_proto_ops interface
Message-ID: <20210323094828.ldtlzkgd3zc7rlml@bogus>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
 <20210316124903.35011-26-cristian.marussi@arm.com>
 <CA+=V6c08cVmsCV_sDn5CogzbyN5KyNKL=u+WkAE0cPz2fqPhjQ@mail.gmail.com>
 <20210316222132.GA6875@e120937-lin>
 <CA+=V6c1=hWbF1_5wL7nMDK_CXqDVmgDXWvJjUC-XqZRGGewafA@mail.gmail.com>
 <20210318121202.6xf2lqm7udqvla24@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318121202.6xf2lqm7udqvla24@bogus>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Thu, Mar 18, 2021 at 12:12:02PM +0000, Sudeep Holla wrote:
> On Tue, Mar 16, 2021 at 10:38:43PM -0700, Jyoti Bhayana wrote:
> > Hi Christian,
> > 
> > Thanks for the detailed explanation. Sounds good to me.
> > 
> 
> Can I get official Reviewed-by or Acked-by please if you are fine with the
> change ?
> 

I need your ack to this via arm-soc.

-- 
Regards,
Sudeep
