Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DA6378E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhEJNO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:14:59 -0400
Received: from foss.arm.com ([217.140.110.172]:58090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351653AbhEJNMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:12:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 364EC1688;
        Mon, 10 May 2021 06:11:18 -0700 (PDT)
Received: from [10.57.47.14] (unknown [10.57.47.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AE143F73B;
        Mon, 10 May 2021 06:11:16 -0700 (PDT)
Subject: Re: [PATCH v1 0/3] coresight: Support for building more coresight
 paths
To:     Tao Zhang <taozha@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>
References: <1620644727-29279-1-git-send-email-taozha@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <070d1c13-2b3e-2dfb-f51b-9d40f1b45a03@arm.com>
Date:   Mon, 10 May 2021 14:10:52 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1620644727-29279-1-git-send-email-taozha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao

On 10/05/2021 12:05, Tao Zhang wrote:
> We are trying to achieve more types of Coresight source devices.
> For example, we have a type of coresight source devic named TPDM.
> In the process of using, sometimes mulitiple TPDMs need to be
> connected to the different input ports on the same funnel.
> Meanwhile, these TPDMs also need to output from different
> ports on the funnel.
> But, at present the Coresight driver assumes
> a) Only support Coresight source type ETM, ETR and ETF

Did you mean ETM and STM here ? ETR & ETF are not source types, rather
they are SINK.


> b) Funnels only support mulitiple inputs and one output
> Which doesn't help to add the above feature for our new Coresight
> source device TPDM. So, in order to accommodate the new device,
> we develop the following patches.

Where is the TPDM driver ? Could you give us a rough idea of the 
behavior in terms of the input / output ?


> a) Add support more types of Coresight source devices.

Which ones ? where is the code ?

> b) Add support for multiple output ports on funnel and the output
> ports could be selected by Corsight source.

Does the "TPDM" require programming to switch these output or are these 
"static" ?

Is this something that can be avoided by having a "fake" 
static-replicator in the path ?

e.g,              TPDM
	 ________________________________________________
  In0	|						|  -> Out0
  In1	|   Static-Funnel   -> Static-Replicator	|  -> Out1
  In2	|						|  -> Out2
	 ________________________________________________


Is this something that can be solved ? Again, please give a brief
description of the TPDM device and the driver code in the series to
give us a complete picture of what you are trying to do.

Reviewing some changes without having the full picture is not going to 
be helpful.

Suzuki
