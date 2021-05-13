Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC77937F2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhEMGEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:04:35 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:17487 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhEMGE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:04:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620885797; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Nj5Be3kK1D2msgTgYt8nbcU3bMVB86DVrEruQIQ9nEk=;
 b=Y7jjJunty+Oo78Q5+GBnA23ysHrqKYShmEky4Xgo+DrAdNtyPxZ13PhjJuBfIyv1DjOjCBIX
 t3HTucdCyGSYPDgp22QP1Gh2pKlbnye2WAM4GJbfq1kpIsmQC6HaOIazjYjRdsQdapFE61Jt
 QG1gJFLJtta66ybJ4gaUyF5XtnY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 609cc121938a1a6b8fd4f743 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 May 2021 06:03:13
 GMT
Sender: taozha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80B95C433F1; Thu, 13 May 2021 06:03:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: taozha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46C7FC433D3;
        Thu, 13 May 2021 06:03:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 13 May 2021 14:03:10 +0800
From:   taozha@codeaurora.org
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>
Subject: Re: [PATCH v1 0/3] coresight: Support for building more coresight
 paths
In-Reply-To: <070d1c13-2b3e-2dfb-f51b-9d40f1b45a03@arm.com>
References: <1620644727-29279-1-git-send-email-taozha@codeaurora.org>
 <070d1c13-2b3e-2dfb-f51b-9d40f1b45a03@arm.com>
Message-ID: <1cd71b1323e3d635b76c4785f60413a9@codeaurora.org>
X-Sender: taozha@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-10 21:10, Suzuki K Poulose wrote:
> Hi Tao
> 
> On 10/05/2021 12:05, Tao Zhang wrote:
>> We are trying to achieve more types of Coresight source devices.
>> For example, we have a type of coresight source devic named TPDM.
>> In the process of using, sometimes mulitiple TPDMs need to be
>> connected to the different input ports on the same funnel.
>> Meanwhile, these TPDMs also need to output from different
>> ports on the funnel.
>> But, at present the Coresight driver assumes
>> a) Only support Coresight source type ETM, ETR and ETF
> 
> Did you mean ETM and STM here ? ETR & ETF are not source types, rather
> they are SINK.
> 
> 
Yes, I mean ETM and STM here.
>> b) Funnels only support mulitiple inputs and one output
>> Which doesn't help to add the above feature for our new Coresight
>> source device TPDM. So, in order to accommodate the new device,
>> we develop the following patches.
> 
> Where is the TPDM driver ? Could you give us a rough idea of the
> behavior in terms of the input / output ?
> 
> 
We have plans to upload the TPDM driver in the feature. TPDM is a type 
of
hardware component for debugging and monitoring on Qualcomm targets.
The primary use case of the TPDM is to collect data from different data
source and send it to a TPDA for packetization, timestamping and 
funneling.
And the output of TPDA is a regular AMBA ATB stream and can be thought 
of as
any other trace source in the system.
You can get a general understanding of the TPDM and TPDA driver through 
the
following patch.
https://source.codeaurora.org/quic/la/kernel/msm-5.4/commit/?h=LV.AU.0.2.0.r1&id=a47c3313965c1101f2224e55da2c54d9e5c388dd
>> a) Add support more types of Coresight source devices.
> 
> Which ones ? where is the code ?
> 
In the patch 
"0001-coresight-add-support-to-enable-more-coresight-paths.patch",
we replaced the original path save method with the funcation 
"coresight_store_path".
In the original method, "coresight_enable" only can store the tracer 
path for ETM
and STM. In the function "coresight_store_path", it can store the tracer 
path for
more types of Coresight sources.
>> b) Add support for multiple output ports on funnel and the output
>> ports could be selected by Corsight source.
> 
> Does the "TPDM" require programming to switch these output or are
> these "static" ?
> 
> Is this something that can be avoided by having a "fake"
> static-replicator in the path ?
> 
> e.g,              TPDM
> 	 ________________________________________________
>  In0	|						|  -> Out0
>  In1	|   Static-Funnel   -> Static-Replicator	|  -> Out1
>  In2	|						|  -> Out2
> 	 ________________________________________________
> 
> 
> Is this something that can be solved ? Again, please give a brief
> description of the TPDM device and the driver code in the series to
> give us a complete picture of what you are trying to do.
> 
> Reviewing some changes without having the full picture is not going to
> be helpful.
> 
> Suzuki
Now the link can support multiple out ports, but there are no entries 
from
the link's device tree can figure out from which input port to which 
output
port.
This patch provide the entry "source" in device tree, which can 
associate
the input port of the link with the output port.
e.g, if we want to achieve the following link connection.
-------------------------------------------------------------------------
Source0 -> In0 |		| Out0 ->
Source1 -> In1 |Funnel 0| Out1 ->
Source2 -> In2 |		| Out2 ->
-------------------------------------------------------------------------
We can configure the "source" entries as the following device tree.
Funnel 0 {
	out-ports {
		port@0 {
			reg = <0>
			Out0: endpoint {
				remote-endpoint = <... ...>;
				source = <Source0>
			}

		}
		port@1 {
			reg = <1>
			Out1: endpoint {
				remote-endpoint = <... ...>;
				source = <Source1>
			}

		}
		port@2 {
			reg = <0>
			Out2: endpoint {
				remote-endpoint = <... ...>;
				source = <Source2>
			}

		}
	}

	in-ports {
		port@0 {
			reg = <0>
			In0: endpoint {
				remote-endpoint = <... ...>;
			}

		}
		port@1 {
			reg = <1>
			Out1: endpoint {
				remote-endpoint = <... ...>;
			}

		}
		port@2 {
			reg = <0>
			Out2: endpoint {
				remote-endpoint = <... ...>;
			}

		}
	}
}

Best,
Tao
