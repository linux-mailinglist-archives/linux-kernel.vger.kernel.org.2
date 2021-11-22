Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E686645893D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 07:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhKVGRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 01:17:05 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:59072 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhKVGRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 01:17:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637561638; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=/bsLM/NBHYY06E3w1+785ylgRc2IKYk7J+lS7xVJB0E=; b=qtnJjAMnnRteV1qCwR2bbAlc/BSzJ/n33jsmovDXoX6iEy90yN99IubB7hIjFQsoYnSLEcRf
 V+SHfzUmZRvNowNrFLAX+rgn/zFSI4jWzn3NO1HCPR7ht770Kr0kFGqUq6HA8xkN5ISVb3gf
 zMHyWJl/ApGoL+QOSZzyGW1T1ts=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 619b3526b920912d5715a9e6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 06:13:58
 GMT
Sender: akhilpo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5CACFC43616; Mon, 22 Nov 2021 06:13:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.5] (unknown [59.88.236.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83E87C4338F;
        Mon, 22 Nov 2021 06:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 83E87C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <4b529a1e-a138-3a0b-b3e0-1217e113c3f7@codeaurora.org>
Date:   Mon, 22 Nov 2021 11:43:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: mailmap: add and update email addresses
Content-Language: en-US
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org
Cc:     freedreno@lists.freedesktop.org, gregkh@linuxfoundation.org,
        robdclark@gmail.com, seanpaul@chromium.org, swboyd@chromium.org,
        nganji@codeaurora.org, aravindh@codeaurora.org,
        dmitry.baryshkov@linaro.org
References: <1637363725-17732-1-git-send-email-quic_abhinavk@quicinc.com>
From:   Akhil P Oommen <akhilpo@codeaurora.org>
In-Reply-To: <1637363725-17732-1-git-send-email-quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2021 4:45 AM, Abhinav Kumar wrote:
> Add and also update the email addresses to prepare for
> the transition to the new ones.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   .mailmap | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 6e84911..92f4cd7 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -10,10 +10,12 @@
>   # Please keep this list dictionary sorted.
>   #
>   Aaron Durbin <adurbin@google.com>
> +Abhinav Kumar <quic_abhinavk@quicinc.com> <abhinavk@codeaurora.org>
>   Adam Oldham <oldhamca@gmail.com>
>   Adam Radford <aradford@gmail.com>
>   Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
>   Adrian Bunk <bunk@stusta.de>
> +Akhil P Oommen <quic_akhilpo@quicinc.com> <akhilpo@codeaurora.org>
>   Alan Cox <alan@lxorguk.ukuu.org.uk>
>   Alan Cox <root@hraefn.swansea.linux.org.uk>
>   Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@imgtec.com>
> @@ -162,6 +164,7 @@ Jeff Layton <jlayton@kernel.org> <jlayton@redhat.com>
>   Jens Axboe <axboe@suse.de>
>   Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
>   Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
> +Jessica Zhang <quic_jesszhan@quicinc.com> <jesszhan@codeaurora.org>
>   Jiri Slaby <jirislaby@kernel.org> <jirislaby@gmail.com>
>   Jiri Slaby <jirislaby@kernel.org> <jslaby@novell.com>
>   Jiri Slaby <jirislaby@kernel.org> <jslaby@suse.com>
> @@ -181,6 +184,7 @@ Juha Yrjola <at solidboot.com>
>   Juha Yrjola <juha.yrjola@nokia.com>
>   Juha Yrjola <juha.yrjola@solidboot.com>
>   Julien Thierry <julien.thierry.kdev@gmail.com> <julien.thierry@arm.com>
> +Kalyan Thota <quic_kalyant@quicinc.com> <kalyan_t@codeaurora.org>
>   Kay Sievers <kay.sievers@vrfy.org>
>   Kees Cook <keescook@chromium.org> <kees.cook@canonical.com>
>   Kees Cook <keescook@chromium.org> <keescook@google.com>
> @@ -192,9 +196,11 @@ Kenneth W Chen <kenneth.w.chen@intel.com>
>   Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>
>   Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
>   Koushik <raghavendra.koushik@neterion.com>
> +Krishna Manikandan <quic_mkrishn@quicinc.com> <mkrishn@codeaurora.org>
>   Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
>   Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
>   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +Kuogee Hsieh <quic_khsieh@quicinc.com> <khsieh@codeaurora.org>
>   Leonardo Bras <leobras.c@gmail.com> <leonardo@linux.ibm.com>
>   Leonid I Ananiev <leonid.i.ananiev@intel.com>
>   Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
> @@ -300,6 +306,7 @@ Qais Yousef <qsyousef@gmail.com> <qais.yousef@imgtec.com>
>   Quentin Monnet <quentin@isovalent.com> <quentin.monnet@netronome.com>
>   Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
>   Rafael J. Wysocki <rjw@rjwysocki.net> <rjw@sisk.pl>
> +Rajeev Nandan <quic_rajeevny@quicinc.com> <rajeevny@codeaurora.org>
>   Rajesh Shah <rajesh.shah@intel.com>
>   Ralf Baechle <ralf@linux-mips.org>
>   Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
> @@ -314,6 +321,7 @@ Rui Saraiva <rmps@joel.ist.utl.pt>
>   Sachin P Sant <ssant@in.ibm.com>
>   Sakari Ailus <sakari.ailus@linux.intel.com> <sakari.ailus@iki.fi>
>   Sam Ravnborg <sam@mars.ravnborg.org>
> +Sankeerth Billakanti <quic_sbillaka@quicinc.com> <sbillaka@codeaurora.org>
>   Santosh Shilimkar <santosh.shilimkar@oracle.org>
>   Santosh Shilimkar <ssantosh@kernel.org>
>   Sarangdhar Joshi <spjoshi@codeaurora.org>
> 

Thanks, Abhinav.

Acked-by: Akhil P Oommen <akhilpo@codeaurora.org>

-Akhil.
