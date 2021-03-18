Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FAC34053B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhCRMMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:12:40 -0400
Received: from foss.arm.com ([217.140.110.172]:39294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhCRMMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:12:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B60031B;
        Thu, 18 Mar 2021 05:12:17 -0700 (PDT)
Received: from bogus (unknown [10.163.68.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBA333F718;
        Thu, 18 Mar 2021 05:12:12 -0700 (PDT)
Date:   Thu, 18 Mar 2021 12:12:02 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Guru Nagarajan <gurunagarajan@google.com>,
        Enrico Granata <egranata@google.com>
Subject: Re: [PATCH v7 25/38] iio/scmi: port driver to the new
 scmi_sensor_proto_ops interface
Message-ID: <20210318121202.6xf2lqm7udqvla24@bogus>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
 <20210316124903.35011-26-cristian.marussi@arm.com>
 <CA+=V6c08cVmsCV_sDn5CogzbyN5KyNKL=u+WkAE0cPz2fqPhjQ@mail.gmail.com>
 <20210316222132.GA6875@e120937-lin>
 <CA+=V6c1=hWbF1_5wL7nMDK_CXqDVmgDXWvJjUC-XqZRGGewafA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+=V6c1=hWbF1_5wL7nMDK_CXqDVmgDXWvJjUC-XqZRGGewafA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 10:38:43PM -0700, Jyoti Bhayana wrote:
> Hi Christian,
> 
> Thanks for the detailed explanation. Sounds good to me.
> 

Can I get official Reviewed-by or Acked-by please if you are fine with the
change ?

I definitely need one from Jonathan to merge this and one from Jyoti is
added bonus 😉.

-- 
Regards,
Sudeep
